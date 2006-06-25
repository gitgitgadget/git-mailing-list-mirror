From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 07/12] Git.pm: Better error handling
Date: Sun, 25 Jun 2006 03:13:47 +0200
Message-ID: <20060625011347.GY21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <20060624023442.32751.28342.stgit@machine.or.cz> <7vmzc3ymnu.fsf@assigned-by-dhcp.cox.net> <20060624131731.GU21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:14:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJCK-0000c7-CI
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWFYBNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWFYBNt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:13:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58793 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751282AbWFYBNt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:13:49 -0400
Received: (qmail 21461 invoked by uid 2001); 25 Jun 2006 03:13:47 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060624131731.GU21864@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22556>

Dear diary, on Sat, Jun 24, 2006 at 03:17:31PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Sat, Jun 24, 2006 at 10:37:25AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > +int
> > > +error_xs(const char *err, va_list params)
> > > +{
> > 
> > You said in git-compat-util.h that set_error_routine takes a
> > function that returns void, so this gives unnecessary type
> > clash.
> > 
> > --------------------------------
> > In file included from /usr/lib/perl/5.8/CORE/perl.h:756,
> >                  from Git.xs:15:
> > /usr/lib/perl/5.8/CORE/embed.h:4193:1: warning: "die" redefined
> > Git.xs:11:1: warning: this is the location of the previous definition
> > Git.xs: In function 'boot_Git':
> > Git.xs:57: warning: passing argument 1 of 'set_error_routine' from incompatible pointer type
> > Git.xs:58: warning: passing argument 1 of 'set_die_routine' makes qualified function pointer from unqualified
> > --------------------------------
> 
> Oh, I forgot to fix it in the .xs. :-(

---
[PATCH] Git.pm: Squash some annoying warnings in Git.xs

From: Petr Baudis <pasky@suse.cz>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.xs |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/perl/Git.xs b/perl/Git.xs
index e841e4a..d7a2b75 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -29,21 +29,18 @@ report_xs(const char *prefix, const char
 	return buf;
 }
 
-void
+void NORETURN
 die_xs(const char *err, va_list params)
 {
-	char *str;
-	str = report_xs("fatal: ", err, params);
+	char *str = report_xs("fatal: ", err, params);
 	croak(str);
 }
 
-int
+void
 error_xs(const char *err, va_list params)
 {
-	char *str;
-	str = report_xs("error: ", err, params);
+	char *str = report_xs("error: ", err, params);
 	warn(str);
-	return -1;
 }
 
 

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
