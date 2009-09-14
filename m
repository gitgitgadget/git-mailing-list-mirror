From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 13/17] Define strncasecmp as _strnicmp for MSVC
Date: Mon, 14 Sep 2009 15:11:26 +0200
Message-ID: <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com> <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:28 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f157.google.com ([209.85.210.157])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBN1-0004Ql-0m
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:27 +0200
Received: by mail-yx0-f157.google.com with SMTP id 29so6077722yxe.16
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=2lwfVdCtpNCk/HTXX8yxVvojloNmDdgYm/YNL6T0G6M=;
        b=elm4F4KhSkeuP+nRUG+SZqra/FI9L9jsrn5tWFsEocmP1IZkyaRoPpTbTvZmAKWul+
         Zgha2S9HL+YZfas/ouQz7v0KvCpSIf+q1QOVT+Hzi7ykugVJQKtKCe5xZaC169FRiR9v
         onk7olrnM4h0NlCfdIimO19LbI7eCRa48s07M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=51Qpm/joNV5NXlvarc2GiRiLVVqvzjw9mN7gOzoZMomCMG7uYdkD2uZquP+46gMdsN
         DnZsoJ4tJ9ThWVf0KvPyyPlock4LPKWNDQWSQGRMqQ3FRUNfn0pFta3l4mhoCMJOlBQ+
         tA9d3kdsbp+eSAN2DN4X2M7bDUXy309LqBEV8=
Received: by 10.90.11.17 with SMTP id 17mr1045166agk.12.1252934000791;
        Mon, 14 Sep 2009 06:13:20 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr6974yqn.0;
	Mon, 14 Sep 2009 06:13:15 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.155.15 with SMTP id h15mr1143324ebo.0.1252933993514; Mon, 14 Sep 2009 06:13:13 -0700 (PDT)
Received: by 10.211.155.15 with SMTP id h15mr1143308ebo.0.1252933985913; Mon, 14 Sep 2009 06:13:05 -0700 (PDT)
Received: from mail-ew0-f207.google.com (mail-ew0-f207.google.com [209.85.219.207]) by gmr-mx.google.com with ESMTP id 15si1278800ewy.0.2009.09.14.06.13.04; Mon, 14 Sep 2009 06:13:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.207 as permitted sender) client-ip=209.85.219.207;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.207 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy3 with SMTP id 3so2572128ewy.42 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=IYROoQJSEQuPJGHFbx+VuvPoyx6sWkuLeKs3Q9UQWKI=; b=bPx8y4nQ3dwW40P3kCg2DbTvgx2aY6Ct6PJ3v5AFCtlbJOXvYWMZs7GitTtrBJPxFU yM2h0vSxnemXd2hGbnXoRDGCCXerB22LSsKywvP+AAzm3Y9q9bQNpocQHAr/X08naila E3AUrW7G1xyqgFSWVCxbGt2+T649kiBy2sTJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=ez9of16IRZSHOWji4TAq7l3jtK5ugNvRxIzvZ4Qx7PgRQ++w4P35GL/uvfHBULP3F1 RV0RNbQ3PKUYPgRueES5rtNkFlVEAIG1V8KBE+ffjre2RSCwPrGMBut7wlOLWuYQBuWR JpxIoMNk1jh4wmy28TFXxW1Sof0BLPUo+sBEk=
Received: by 10.211.147.25 with SMTP id z25mr3149931ebn.84.1252933984819; Mon, 14 Sep 2009 06:13:04 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.54 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128473>


Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/msvc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index 53a6d30..a62507f 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -10,6 +10,7 @@
 #define __inline__ __inline
 #define __attribute__(x)
 #define va_copy(dst, src)     ((dst) = (src))
+#define strncasecmp(s1, s2, n) _strnicmp(s1, s2, n)
 
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
-- 
1.6.2.1.418.g33d56.dirty
