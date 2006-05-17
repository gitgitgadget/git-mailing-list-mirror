From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 02:03:32 -0700
Message-ID: <7vejythvkr.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 11:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHwV-0003zz-5c
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWEQJDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWEQJDe
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:03:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47332 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750910AbWEQJDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:03:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517090333.ONES27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 05:03:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 16 May 2006 19:20:30 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20174>

Linus Torvalds <torvalds@osdl.org> writes:

> [ Junio - see the "grep" issue ]
> ...
> Of course, I don't think anybody tried the new "git grep" on Solaris,...

I haven't tried the new grep on Solaris myself, as the Solaris
box I have easy access is badly maintained (unmaintained is
probably a better wording).

> ...and 
> I think the solaris "grep" lacks the "-H" flag, for example. But that 
> should be easy to fix (for example, replace the use of "--" and "-H" with 
> putting a "/dev/null" as the first filename).

You mean like this, I presume.

But I think this approach breaks -L; I do not think Solaris
supports -L, so it does not matter there, but on platforms that
knows how to do -L it does.

-- >8 --
[PATCH] builtin-grep: give /dev/null at the beginning instead of -H

---
diff --git a/builtin-grep.c b/builtin-grep.c
index 66111de..ff3c1f7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -453,7 +453,6 @@ static int external_grep(struct grep_opt
 
 	len = nr = 0;
 	push_arg("grep");
-	push_arg("-H");
 	if (opt->fixed)
 		push_arg("-F");
 	if (opt->linenum)
@@ -503,7 +502,7 @@ static int external_grep(struct grep_opt
 		push_arg("-e");
 		push_arg(p->pattern);
 	}
-	push_arg("--");
+	push_arg("/dev/null");
 
 	hit = 0;
 	argc = nr;
