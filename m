X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Minor documentation problems [RFC PATCH]
Date: Thu, 2 Nov 2006 09:30:14 -0500
Message-ID: <BAYC1-PASMTP042F05A3C71EDC671552FFAEFF0@CEZ.ICE>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
	<Pine.LNX.4.63.0611021448100.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 14:30:55 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061102093014.9f049a24.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0611021448100.1670@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Nov 2006 14:30:16.0417 (UTC) FILETIME=[6A4FED10:01C6FE8B]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfdaR-0006if-Hm for gcvg-git@gmane.org; Thu, 02 Nov
 2006 15:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750820AbWKBOaS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 09:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWKBOaS
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 09:30:18 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:26365 "EHLO
 BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1750820AbWKBOaQ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 09:30:16 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 2 Nov 2006 06:30:16 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gfce6-0001kz-Bg; Thu, 02 Nov 2006 08:30:14 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Thu, 2 Nov 2006 14:54:24 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Your patch would be loads shorter and easier to read if you'd just 
> override the GIT_CONFIG environment variable (like --git-dir sets 
> GIT_DIR).
> 

Indeed. Thanks...  How 'bout this:

diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index f60cee1..dcdae81 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -139,7 +139,16 @@ int cmd_repo_config(int argc, const char
 			type = T_BOOL;
 		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
 			return git_config(show_all_config);
-		else
+		else if (!strcmp(argv[1], "--global")) {
+			char *home = getenv("HOME");
+			if (home) {
+				char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+				setenv("GIT_CONFIG", user_config, 1);
+				free(user_config);
+			} else {
+				return -1;
+			}
+		} else
 			break;
 		argc--;
 		argv++;
