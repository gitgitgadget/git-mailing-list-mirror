From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 15:14:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221503270.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
 <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
 <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org>
 <7vbr867ecy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:09:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6KN-0006rQ-IG
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDVWMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDVWMs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:12:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:13263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261197AbVDVWM1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:12:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MMCIs4009746
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 15:12:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MMCGN6015786;
	Fri, 22 Apr 2005 15:12:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr867ecy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Junio C Hamano wrote:
> 
> Almost, with a counter-example.  Please try this yourself:

I agree that what git outputs is always "based on the archive base". But 
that's an independent issue from "where is the working directory". That's 
the issue of "how do you want me to print out the results".

To see just how independent that is, think about how git-pasky (and,
indeed, standard "show-diff") already prints out the results in a
_different_ base than the working directory _or_ the base. Ie the way we 
already do

	--- a/Makefile
	+++ b/Makefile
	... patch ...

for a patch to "Makefile" in the top-level directory.

IOW, showing pathnames is different from _using_ them. And if you were 
planning on using the same logic for both, you'd have been making a 
mistake in the first place.

To _use_ pathnames, you use "pwd". To _show_ them, you use some other
mechanism. You must not mix up those two issues, or you'd always get
"show-diff" wrong.

I actually think that showing the pathnames is up to the wrapper scripts. 
Git core really always just works on the "canonical" format.

(And I personally think that "show-diff" is really part of the "wrapper
scripts" around git. I wrote it originally just because I needed something
to verify the index file handling, not because it's "core" like the other
programs. I do _not_ consider "show-diff" to be part of the core git code,
really. Same goes for "git-export", btw - for the same reasons. It's not
"fundamental").

		Linus
