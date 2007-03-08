From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 18:10:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPM9E-00020m-FS
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXCHRK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXCHRK6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:10:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:59356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752581AbXCHRK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:10:57 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:10:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 08 Mar 2007 18:10:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vzBJ+SrsvEKBviRaqp+YuLNm/f0gPBgm+YCdcVF
	AUJtWrf5gOAHBo
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41758>

Hi,

On Thu, 8 Mar 2007, Linus Torvalds wrote:

> On Thu, 8 Mar 2007, Junio C Hamano wrote:
> > 
> > Not so.  "git shortlog" acts as a filter when no revs are given, 
> > unlike "git log" which defaults to HEAD.  It was reading from its 
> > standard input.
> 
> Could we just change that?
>
> [...]
> 
> Yeah, as a filter it *can* stil lbe useful, of course, but I suspect the 
> usefullness is limited.

How about something totally different: "git log --shortlog". I.e.

diff --git a/builtin-log.c b/builtin-log.c
index 865832c..ad1dafd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -216,7 +216,11 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	int i;
 
+	for (i = 1; i < argc; i++)
+		if (!strcmp(argv[i], "--shortlog"))
+			return cmd_shortlog(argc, argv, prefix);
 	git_config(git_log_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 29b1636..952a475 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -289,7 +289,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			summary = 1;
 		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
 			usage(shortlog_usage);
-		else
+		else if (strcmp(argv[1], "--shortlog"))
 			break;
 		argv++;
 		argc--;

Ciao,
Dscho
