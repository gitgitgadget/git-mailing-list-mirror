From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 15:27:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610101524050.3952@g5.osdl.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz>
 <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org> <452BF8B3.5090305@tromer.org>
 <Pine.LNX.4.64.0610101423561.3952@g5.osdl.org> <452C19FC.7030001@tromer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXQ4I-0000Ze-3l
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbWJJW1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbWJJW1S
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:27:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030579AbWJJW1R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 18:27:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9AMREaX024684
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 15:27:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9AMRD7K027718;
	Tue, 10 Oct 2006 15:27:13 -0700
To: Eran Tromer <git2eran@tromer.org>
In-Reply-To: <452C19FC.7030001@tromer.org>
X-Spam-Status: No, hits=-2.468 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28681>



On Wed, 11 Oct 2006, Eran Tromer wrote:
> 
> How so? This process loses the unreferenced objects from the old packs,
> where "referenced" is determined in a racy way. Same problem.

No.

Those unreferenced objects are old history that won't be part of any new 
history.

If you create new history, they won't be in the pack.

It's obviously possible that you create new history that has a blob that 
is equal to some old history (and no loose object will be created), but by 
then we're _really_ reaching. 

> But "git prune" does not GC packs, only loose objects.

Right. And you'd want to repack _and_ prune, but they should be kept 
separate, because one is safe, the other is not.

Of course, if the code were to check that no references have changed over 
the operation, then I wouldn't have any objections.

		Linus
