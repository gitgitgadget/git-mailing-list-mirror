From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Tue, 17 May 2005 12:32:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505171227260.18337@ppc970.osdl.org>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz>
 <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
 <20050517070158.GA10031@pasky.ji.cz> <Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org>
 <7vu0l1fz6p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:33:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7mq-0000nS-9g
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEQTbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEQTbk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:31:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:18049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVEQTa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 15:30:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HJUmU3022752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 12:30:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HJUlxl017312;
	Tue, 17 May 2005 12:30:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0l1fz6p.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Junio C Hamano wrote:
> 
> I've been thinking about doing some rename detection in
> diff-helper for some time.  Here is what that would produce in
> your proposed file format (BTW, wouldn't the earlier patch ready
> for merge already?), if you move file frotz to file nitfol and
> at the same time do some edits:

This has the advantage of working with any old "patch" version, but it has 
the disadvantage of being human-unreadable, and big. 

To me, there really are only two reasons to do rename diffs:
 - smaller diffs
 - human readability (you can actually see what changed)

and if you want to have compatibility with a "patch" program that doesn't
support the feature (like your example), you basically lose both of those
advantages. You have _some_ human-readability, but it basically boils down
to "ignore all those deletes/creates".

So I'd really suggest having just a flag that says "pure old diff format"  
or "new diff format with renames", and if the latter is selected, then do
_just_ the changes, ie the rename+change case would really boil down to
getting just

>     diff -git a/nitfol b/nitfol
>     rename old frotz
>     rename new nitfol
>     --- a/nitfol
>     +++ b/nitfol
>     @@ -1,2 +1,3 @@
>      xyzzy
>      rezrov
>     +gnusto

(except I think it would be nice to have the renamed names show up in the 
"diff" and "---/+++" lines too)

		Linus
