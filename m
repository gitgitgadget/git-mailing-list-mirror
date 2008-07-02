From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 04/12] Avoid calling signal(SIGPIPE, ..) for MinGW
 builds.
Date: Wed,  2 Jul 2008 10:32:04 +0200
Message-ID: <1214987532-23640-4-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Marius Storm-Olsen <mstormo_git@storm-olsen.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmE-0001FM-Vf
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:23 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058146yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=KMraf6EHZcyKpVWwzDkzEndN6Iou4mvjusmrxX6G87o=;
        b=6RxA7ZG1fTa5G2NCmyVV4Hsh6/8q39FMhrvBVU8R88SbvTph0RFCl1zvrLKeXa45Ky
         WFso0Gbs3aLTywrtqQTcyfGc+Jqervg1H55UVYuVLmxVcEudYM53B8sdeZNqg7dpOhZK
         G1vgB0tknvrGNyIuxCQp2w6R4ElmPP405GJLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=Ies7YFwerongUTupgifxUQeizcXHTgDIIgCFZ3btSV80wKhV/wxExvv+v1uZ9jskYO
         MKcgumMC/P6Zwy5RAQOlF2Wa1wleY4QdrGlg2vrwanMpU7CgbVlovKYtQEQgjrUeWf0u
         MMojuYNKMWK/HwyAxZFB+lfFm4Qvqgj4o/bqU=
Received: by 10.114.166.1 with SMTP id o1mr544222wae.18.1214987544217;
        Wed, 02 Jul 2008 01:32:24 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2554pri.0;
	Wed, 02 Jul 2008 01:32:24 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.49.3 with SMTP id w3mr8852398agw.9.1214987543860; Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si7857925yxd.0.2008.07.02.01.32.23; Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WDgV019113; Wed, 2 Jul 2008 10:32:22 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0L017527; Wed, 2 Jul 2008 10:32:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-3-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87104>


From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>

SIGPIPE isn't supported in MinGW.

Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-verify-tag.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 92eaa89..540e3b9 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -100,9 +100,11 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		i++;
 	}
 
+#ifndef __MINGW32__
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
+#endif	
 	while (i < argc)
 		if (verify_tag(argv[i++], verbose))
 			had_error = 1;
-- 
1.5.6.1.255.g32571
