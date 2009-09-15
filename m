From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 11/14] Define strncasecmp and ftruncate for MSVC
Date: Tue, 15 Sep 2009 15:44:14 +0200
Message-ID: <65347d022ba857d57d3c081f28b239b9b665c587.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com> <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com> <8368a0b347c01e7ddb5e5b514a46e55dd6f0daf7.1253021728.git.mstormo@gmail.com> <ffd7cfd6114f08c6502b21140d56d9bcd5d2a554.1253021728.git.mstormo@gmail.com> <4924c3de4fa490d1f41b75d18864f0a57fbd0eda.1253021728.git.mstormo@gmail.com> <88c817f030cfcc1e3b9e08f80d7ccfbcdfad7ecb.1253021728.git.mstormo@gmail.com> <8bcd4b022f59a5f55b63f87c9cf6a4dadc71cc44.1253021728.git.mstormo@gmail.com> <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstorm
 o@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:31 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLZ-0007FY-GY
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:29 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so7426652yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ieh8hE+NKhG3BoqwJvQXmbwHIuv4Vz3Kp3xDZQVGUyk=;
        b=tFW4nUhhaVoEKyHdMxR3rVq5KAHU3mnNI42xdY5+dO2gZF/KqNkZDyN39feCT6L8R5
         rCCngosu0YAtFFnUKq8JxtoaGzfc5Wd3TmGOjst6p9ml3crQxr6f5VUxenHgQ4PN09yi
         UuRZ0F+SshN2Vtp73APJ8TV7c6OMPn/Zj8mp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=vzdFGQFu206X+eg0B2DanGtJodYUuIVzPwOn/l3x5BSE2W1kVMKLh7A+yms4tqZErN
         pKjG2r7NQojvoFwGM8tzztcoDudfbKIrIhok0kmlNK1NFWy0sx3S5usFqbc3Q8akloE9
         HRg7gX6gWZeJHabLSRSAkcUYeNT4pst1oWpP8=
Received: by 10.150.106.5 with SMTP id e5mr2173875ybc.13.1253022307404;
        Tue, 15 Sep 2009 06:45:07 -0700 (PDT)
Received: by 10.177.112.39 with SMTP id p39gr7018yqm.0;
	Tue, 15 Sep 2009 06:44:54 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.3.25 with SMTP id 25mr1424762ebc.14.1253022293502; Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
Received: by 10.210.3.25 with SMTP id 25mr1424761ebc.14.1253022293395; Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 16si1530745ewy.7.2009.09.15.06.44.52; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.214 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f214.google.com with SMTP id 10so4211179ewy.13 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=0wPtbNap1i35jbqpufYOO6VeUM+8nKCaRfvLntymFGc=; b=PBX0sAPmI66mN8xCI6BwD/KKQijHOxN0VjYiUkUNmgcg4e8pKrbxENx9x/AN+7JbHk VCC6uTsTuiSkFq+S7d0ZONO6ixtt6FP31+Wd1VUz1a3TJL7KhC2kzZH7jRwXpfUZyDIE dxkp2DQdPSRNeWtYW0jvDsm7eu0Ea8/alBb1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=agx0CxxQE8qWvF6J03WECMa3EGFTDFYMpo/5Mwo8YPd/Is0STdv9bGb07lJ622PIkh gKSU4OJ/KnizxcBWxxQPegyzIxJj/Esz22B9HGSsn1Y2EsPO/P55b6jFRN9eEBckAzy7 wWzbj1gy7XZ8Ffw7ZFNBjuESdhGuyITt9Jgg4=
Received: by 10.210.9.17 with SMTP id 17mr7629070ebi.23.1253022292307; Tue, 15 Sep 2009 06:44:52 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.51 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <606db5a89cc49818fa225312a3bb6dbda18867a6.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128558>


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
