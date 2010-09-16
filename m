From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCH 1/2] dir.c: fix uninitialized memory warning
Date: Thu, 16 Sep 2010 14:53:22 -0600
Message-ID: <1284670403-90716-2-git-send-email-patnotz@gmail.com>
References: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 22:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwLSp-0000xa-5F
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0IPUxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 16:53:40 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:51384 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab0IPUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 16:53:37 -0400
X-WSS-ID: 0L8UY18-0C-47X-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 17A544C7C7E
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 14:53:32 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 16 Sep 2010 14:53:29 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8GKrHaw009417 for
 <git@vger.kernel.org>; Thu, 16 Sep 2010 14:53:19 -0600
Received: from sacv8030ib.sandia.gov (134.253.116.6) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 16 Sep 2010 14:53:26 -0600
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1284670403-90716-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.16.203914
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0,
 BODY_SIZE_2000_LESS 0, BODY_SIZE_400_499 0, BODY_SIZE_5000_LESS 0,
 BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0,
 __FRAUD_BODY_WEBMAIL 0, __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0,
 __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0,
 __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0,
 __URI_NS '
X-TMWD-Spam-Summary: TS=20100916205331; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230342E34433932383343412E303044463A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 608C5C4329K4117612-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156353>

GCC 4.4.4 on MacOS warns about potential use of uninitialized memory.

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 133f472..d1e5e5e 100644
--- a/dir.c
+++ b/dir.c
@@ -232,7 +232,7 @@ int add_excludes_from_file_to_list(const char *fname,
 {
 	struct stat st;
 	int fd, i;
-	size_t size;
+	size_t size = 0;
 	char *buf, *entry;
 
 	fd = open(fname, O_RDONLY);
-- 
1.7.2.3
