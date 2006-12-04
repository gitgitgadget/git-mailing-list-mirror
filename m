X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 4 Dec 2006 07:42:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
References: <87odqm2ppv.wl%cworth@cworth.org> <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
 <4571DB40.6020800@vilain.net> <Pine.LNX.4.64.0612022246310.2630@xanadu.home>
 <7vd570q888.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 15:43:03 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd570q888.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33198>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrFxy-000597-AW for gcvg-git@gmane.org; Mon, 04 Dec
 2006 16:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937035AbWLDPmr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 10:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937040AbWLDPmr
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 10:42:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60654 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937035AbWLDPmq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 10:42:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4FgRjQ020017
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 07:42:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4FgQDE023871; Mon, 4 Dec
 2006 07:42:27 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Junio C Hamano wrote:
> 
> FWIW, I too am in favor of the proposed fix to "git rm" as Linus
> outlined.

Note that somebody (sorry, forget who) correctly pointed out that in order 
to be "safe", the file that you "rm" has to match not only the index, but 
it should match the HEAD tree too.

If it matches both the index and the HEAD tree, a "git rm filename" is 
totally safe, since you can always get it back by just doing a

	git checkout HEAD filename

so the "git rm" really didn't lose any info, and as such, we can _happily_ 
remove the working tree copy without any concern at all.

If it doesn't match HEAD, we can't get it back as easily, so maybe that's 
the case when we want to have "git rm -f filename".

(And obviously, for all the normal reasons, if the index or HEAD doesn't 
match, the error message should be helpful and also explicitly mention the 
"-f" flag. Somehing like

	file 'x' does not match HEAD or has been staged for changes.
	Will not remove. Use '-f' to force removal.

("has been staged for changes" is just a long way of saying "index". See? 
I _can_ learn.)

