From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 07/12] Fixed text file auto-detection: treat EOF
 character 032 at the end of file as printable
Date: Wed,  2 Jul 2008 10:32:07 +0200
Message-ID: <1214987532-23640-7-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:35 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmH-0001Gq-OJ
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:26 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058184yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=gf1Ed2dzM0d4H/Ug/uhwxUNsMygXJDNCE46m/N+We9U=;
        b=Oy2X/e9FyRyo5RNVZXRo/gPJpZV3M+cnICpMtupVN4vI8k5nBz6qFFihyxHUkFbR/v
         DVN0VVbk3LrW17ohY+YnBRHlzvDemFZl3i3mHnQ2i+ba3yX3jbL0QlX77fiXk2eaF8VO
         lWGKuT5NuKa/HD9qOitOuvF5CDctWpI2c10Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=NKYBsVgj90ppDepYLAdsIUQKZn/+tgHl8XjQ58FPy8qCkuSZB5W+AF7I+Gvni+xFBl
         6+R3i9GzvEwCe0Kjb0DP4XCP9sF0/EohEgu1XMKVhloeZDIdj586w8yagrmNzY09tEoe
         ZSn7nI7Ttxtr97jEY1VNcavBUS5X3oW0RJ8JQ=
Received: by 10.142.210.4 with SMTP id i4mr270916wfg.14.1214987543074;
        Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2552prh.0;
	Wed, 02 Jul 2008 01:32:23 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.96.1 with SMTP id t1mr8830742agb.16.1214987541577; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si7857873yxd.0.2008.07.02.01.32.20; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEqK019117; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0O017527; Wed, 2 Jul 2008 10:32:13 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-6-git-send-email-prohaska@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87113>


From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>

Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 convert.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/convert.c b/convert.c
index 1c66844..f24ac25 100644
--- a/convert.c
+++ b/convert.c
@@ -61,6 +61,10 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 		else
 			stats->printable++;
 	}
+
+	// If file ends with EOF then don't count this EOF as non-printable
+	if ( size >= 1 && buf[size-1] == '\032' )
+		stats->nonprintable--;
 }
 
 /*
-- 
1.5.6.1.255.g32571
