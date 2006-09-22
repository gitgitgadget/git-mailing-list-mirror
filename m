From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix buggy ref recording
Date: Sat, 23 Sep 2006 01:08:45 +0200
Message-ID: <20060922230845.GB8259@pasky.or.cz>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org> <20060919205554.GA8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 01:09:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQu8a-0001VQ-SN
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWIVXIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWIVXIt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:08:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60324 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964901AbWIVXIs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:08:48 -0400
Received: (qmail 5047 invoked by uid 2001); 23 Sep 2006 01:08:45 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060919205554.GA8259@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27539>

Dear diary, on Tue, Sep 19, 2006 at 10:55:54PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Thu, Sep 14, 2006 at 07:14:47PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > +	ref_file = git_path(ref);
> 
> You slip...
> You fall...
> *BLAMMMM!!!*
> 
> Cloning a repository with '%s' tag over HTTP now dumps core nicely, and
> I guess this kind of bugs tends to be exploitable.

And since just reporting it did not magically result in a fix... ;-)

-8<-

There is a format string vulnerability introduced with the packed refs
file format.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 40f16af..5fdf9c4 100644
--- a/refs.c
+++ b/refs.c
@@ -472,7 +472,7 @@ static struct ref_lock *lock_ref_sha1_ba

 	lock->ref_name = xstrdup(ref);
 	lock->log_file = xstrdup(git_path("logs/%s", ref));
-	ref_file = git_path(ref);
+	ref_file = git_path("%s", ref);
 	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;

 	if (safe_create_leading_directories(ref_file))


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
