From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 11/15] Define strncasecmp and ftruncate for MSVC
Date: Wed, 16 Sep 2009 10:20:27 +0200
Message-ID: <e9ffbe6e71d7f27c4ee5d31f59f860827c5a2f94.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com> <28e3400f29353cf8f93b4ca054b87f083f9e33e1.1253088099.git.mstormo@gmail.com> <8f578bb08bf5663a8ce5b02e3e4f77727692c501.1253088099.git.mstormo@gmail.com> <7afd55f9b2f0f7859f757c715034cc3520e07f0e.1253088099.git.mstormo@gmail.com> <489a0e7c6c41985a5208e85e9b24900c97dcacdb.1253088099.git.mstormo@gmail.com> <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstorm
 o@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:20 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplP-0004oA-S8
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:19 +0200
Received: by mail-yw0-f140.google.com with SMTP id 4so12827760ywh.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ieh8hE+NKhG3BoqwJvQXmbwHIuv4Vz3Kp3xDZQVGUyk=;
        b=tkY63dboMjM/XA3gxNhoHNUzer6DaE4RpUjJLFqbSjWMby6TCPdNRXMDvBoY9PF38G
         QjnT6yTtS21JbMaRt2aX3p4RYx3SeUc3lOgbv9nXlyVh6VSs65RtA1T+br3ZDDi3FGVi
         LoV13+krdKic7mr+ORdOUYb6qIoGw58JtMnEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=OeBJLcruyZsVSLmp4v1W7g44WoutyeYhhn0LzE47yiOWPZ4IkSCZ/UM94xx7+3Q/av
         kX+0x+IokejI8uKvrwVtaLZdpEv7p8VZa4DP5++lV1/KnoLYD/8FahRIRgBeg2gL5SQa
         ptv7isHtrCkPzLql4T5ERTi6SmW9z6jKBJotc=
Received: by 10.100.172.1 with SMTP id u1mr1936436ane.18.1253089273510;
        Wed, 16 Sep 2009 01:21:13 -0700 (PDT)
Received: by 10.177.111.12 with SMTP id o12gr7046yqm.0;
	Wed, 16 Sep 2009 01:21:08 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.21 with SMTP id 21mr241891ebf.9.1253089266658; Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr241890ebf.9.1253089266634; Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215]) by gmr-mx.google.com with ESMTP id 15si1683167ewy.4.2009.09.16.01.21.05; Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.215 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f215.google.com with SMTP id 11so4248232ewy.11 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=0wPtbNap1i35jbqpufYOO6VeUM+8nKCaRfvLntymFGc=; b=Lzufj67sIOkGMFkVVvCJhUUmHeS+Ep8XUEJNzFQScqf4d0zlAuwKpLFu9z5ACJ4LaK iAHa3VpFbbaC4jVXo7p5DYfyAfJEOP0qIP3dR6h762f5jLYMZCabUne+Byw/6RGWpz5T o5pcxqbN7bzMfAQottvsX8JrdWtaL8NWXSne0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=LPBd5rcMj9d1llayrJTfWM6Tzw+gKBAXAZhfj6pNK8WbOxmfsXBXJWTnQ8Ge0S25Mw 0Wq6vm5MxLId1bpUYwqsxqqy6NOZrliUOKuErMKbrCVNVSEG+2/DVelvrpQxASgk9fcg 53e2XIqKdSFgX3nZJt/CjQG0ntSw/84CpehRo=
Received: by 10.210.9.13 with SMTP id 13mr1987507ebi.3.1253089265510; Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.21.04 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:21:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <38f180f3899d1f7a6acc8cf8c65f5f0ffb61699a.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128623>


Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/msvc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.h b/compat/msvc.h
index 53a6d30..9c753a5 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -10,6 +10,8 @@
 #define __inline__ __inline
 #define __attribute__(x)
 #define va_copy(dst, src)     ((dst) = (src))
+#define strncasecmp  _strnicmp
+#define ftruncate    _chsize
 
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
-- 
1.6.2.1.418.g33d56.dirty
