From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Cogito] Various bugs
Date: Tue, 07 Feb 2006 12:49:34 -0800
Message-ID: <7v8xsmvqqp.fsf@assigned-by-dhcp.cox.net>
References: <20060131041318.GC30744@diku.dk>
	<20060207003643.GJ31278@pasky.or.cz>
	<7vfymw3oym.fsf@assigned-by-dhcp.cox.net>
	<20060207021006.GM31278@pasky.or.cz>
	<7v8xsn50rf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602070751410.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 21:51:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ZmR-0003UQ-Ff
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 21:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWBGUth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWBGUth
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 15:49:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61094 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932391AbWBGUtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 15:49:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207204647.LXKE17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 15:46:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602070751410.3854@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 7 Feb 2006 07:53:57 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15713>

Linus Torvalds <torvalds@osdl.org> writes:

> An empty GIT_AUTHOR_NAME should _not_ mean that we use the default name 
> (which is usually the committer), because rather than meaning "default", 
> it most likely means "buggy import script". 
>
> I'd rather have an email import of mine say that it cannot commit, than 
> have it put "Linus Torvalds" in the author line (and some random email).

I am inclined to agree.  Something like this?

This would also make 'git-var GIT_COMMITTER_IDENT' to barf,
which I think is a good thing.

---
diff --git a/ident.c b/ident.c
index 0461b8b..23b8cfc 100644
--- a/ident.c
+++ b/ident.c
@@ -167,6 +167,11 @@ static const char *get_ident(const char 
 		name = git_default_name;
 	if (!email)
 		email = git_default_email;
+
+	if (!*name || !*email)
+		die("empty ident %s <%s> not allowed",
+		    name, email);
+
 	strcpy(date, git_default_date);
 	if (date_str)
 		parse_date(date_str, date, sizeof(date));
