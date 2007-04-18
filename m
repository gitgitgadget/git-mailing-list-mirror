From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:51:38 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org>
References: <11768880622402-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704181247410.12094@racer.site> <20070418153445.GC12888@admingilde.org>
 <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
 <7vslaxhamd.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org>
 <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 21:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGC5-0008UR-IR
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 21:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993096AbXDRTvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 15:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbXDRTvy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 15:51:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:44290 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754211AbXDRTvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 15:51:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IJpdYC026171
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 12:51:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IJpcsp001424;
	Wed, 18 Apr 2007 12:51:39 -0700
In-Reply-To: <7vzm55fqyv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.968 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44936>



On Wed, 18 Apr 2007, Junio C Hamano wrote:
> 
> But I think that is a separate issue.
> 
> The logic I said I wanted to override in the message you are
> responding to is the big toplevel if () else if () ... chain in
> process_entry(), and the nested if () else if () ... logic in
> merge_file().  They roughly implement what git-merge-one-file
> does.

Ahh. 

Ok, in that case, I kind of disagree with you. I think the hardcoded 
merging rules (ie when two of the SHA1's match etc) are the only sane 
things to do _regardless_ of any merge strategy.

So yeah, we'll always do one level of merging at the pure SHA1 stage, and 
pick that without actually doing any file-level merging at all. I don't 
think that's wrong. Maybe it means that people cannot pick some really 
strange merge that they want on a file-by-file basis, but I think that's 
simply how "merge-recursive" is defined.

IOW, I don't think you should be able to turn

	git merge -s recursive

into

	git merge -s ours

by making attributes say something like

	*: merge=ours

because I think the attributes are really about what we do WHEN we hit 
file-level conflicts, while the "merge strategy" is a much higher-level 
thing. They are independent.

But maybe there is some real-world and sane usage that shows me wrong. 

		Linus
