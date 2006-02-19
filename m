From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-rev-list --help anywhere
Date: Sun, 19 Feb 2006 19:39:30 +0100
Message-ID: <20060219183930.GB10010@steel.home>
References: <20060219112627.18989.qmail@science.horizon.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 19:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAtTD-00042Q-LT
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 19:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWBSSjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWBSSjk
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 13:39:40 -0500
Received: from devrace.com ([198.63.210.113]:24334 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932203AbWBSSjk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 13:39:40 -0500
Received: from tigra.home (p54A07517.dip.t-dialin.net [84.160.117.23])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1JIdVwb096485;
	Sun, 19 Feb 2006 12:39:32 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FAtT0-0001WB-00; Sun, 19 Feb 2006 19:39:30 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FAtT0-0004Nb-FC; Sun, 19 Feb 2006 19:39:30 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060219112627.18989.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16443>

linux@horizon.com, Sun, Feb 19, 2006 12:26:27 +0100:
> >+	for (i = 1 ; i < argc; i++)
> >+	    if ( !strcmp(argv[i], "--help") )
> >+		usage(rev_list_usage);
> 
> You might want to try something more like:
> 
> +	for (i = 1 ; i < argc; i++) {
> +	    if ( !strcmp(argv[i], "--help") )
> +		usage(rev_list_usage);
> +	    if ( !strcmp(argv[i], "--") )
> +		break;
> +	}
> 
> So that you don't break in the perverse but legal case of
> having a file named "--help".

Of course. Thanks!

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

diff --git a/rev-list.c b/rev-list.c
index f2d1105..bcb492e 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -755,11 +755,20 @@ static void handle_all(struct commit_lis
 
 int main(int argc, const char **argv)
 {
-	const char *prefix = setup_git_directory();
+	const char *prefix;
 	struct commit_list *list = NULL;
 	int i, limited = 0;
 
 	for (i = 1 ; i < argc; i++) {
+	    if ( !strcmp(argv[i], "--help") )
+		usage(rev_list_usage);
+	    if ( !strcmp(argv[i], "--") )
+		break;
+	}
+
+	prefix = setup_git_directory();
+
+	for (i = 1 ; i < argc; i++) {
 		int flags;
 		const char *arg = argv[i];
 		char *dotdot;
--
1.2.2.gbc57
