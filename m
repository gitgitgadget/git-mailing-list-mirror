From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Nice error message for empty idents
Date: Sat, 18 Feb 2006 18:27:31 +0100
Message-ID: <20060218172731.GV31278@pasky.or.cz>
References: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 18:27:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAVrw-0003Pl-7J
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 18:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBRR1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 12:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWBRR1a
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 12:27:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15266 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932088AbWBRR1a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 12:27:30 -0500
Received: (qmail 22652 invoked by uid 2001); 18 Feb 2006 18:27:31 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmkpqco1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16418>

Dear diary, on Sat, Feb 18, 2006 at 09:44:14AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> It appears that some people who did not care about having bogus
> names in their own commit messages are bitten by the recent
> change to require a sane environment [*1*].
> 
> While it was a good idea to prevent people from using bogus
> names to create commits and doing sign-offs, the error message
> is not very informative.  This patch attempts to warn things
> upfront and hint people how to fix their environments.
> 
> Likes, dislikes, don't cares?

One dislike from me - you shouldn't care if you ain't gonna do it - it
makes no sense to require valid gecos if you are never committing
anything. Note that this "premature requirement" plague has already hit
GIT - come on:

	$ git-rev-list --help
	fatal: Not a git repository

That's worse than CVS (which allows cvs --help cmd but not cvs cmd
--help outside of a repository).

I agree that the error message itself is bad.

---

[PATCH] Nice error message for empty idents

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit 19b5bda8f0301ed4b856c5cd9137637b89d95d30
tree 8f91bfd101c32f258c3d8cca467eb7be26d62b91
parent 8dcc626cd144b2c6eae2a299242bbbe905cb0059
author Petr Baudis <pasky@suse.cz> Sat, 18 Feb 2006 18:26:32 +0100
committer Petr Baudis <xpasky@machine.or.cz> Sat, 18 Feb 2006 18:26:32 +0100

 ident.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index 23b8cfc..c57ba5c 100644
--- a/ident.c
+++ b/ident.c
@@ -168,9 +168,10 @@ static const char *get_ident(const char 
 	if (!email)
 		email = git_default_email;
 
-	if (!*name || !*email)
-		die("empty ident %s <%s> not allowed",
-		    name, email);
+	if (!*name)
+		die("empty realname not allowed - please set a realname for your login or use GIT_AUTHOR_NAME");
+	if (!*email)
+		die("empty email not allowed - please set your GIT_AUTHOR_EMAIL to a non-empty value");
 
 	strcpy(date, git_default_date);
 	if (date_str)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
