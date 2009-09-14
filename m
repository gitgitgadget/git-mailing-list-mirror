From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 14/17] Add ftruncate implementation for MSVC
Date: Mon, 14 Sep 2009 15:11:27 +0200
Message-ID: <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com> <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com> <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:18 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMr-0004G0-DM
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:17 +0200
Received: by mail-vw0-f140.google.com with SMTP id 4so1239080vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=xlwOkkRMi+3BIobM3gDhQtSoqWfpDh2znw+9zxJjE5o=;
        b=QKIGpvOtCOldD7Wt/oYY7GFauttkapoA+08gjEl4f71lF4SNyOx9khBIcr/tq2x1Jr
         3rzojkor0yhrMGTaZofRqA3zRg597BxEqzrCQHnAGPeqEki1KPJbye0V4Wv8z4wuTtzO
         3B+mvp2SQTU3OWwdErQ6w9QsA4MRyG2qKClTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=00lbvO2X/wpdS1lpfqkU2ozGkhctjvIKfJvv80H/CCriEcw+DZnd1encTw+XLWjt3I
         fXJ/WS+bK15HuLwJFam7EK4F3Ui0zN/idXJyosNHvtvmFFnlkNG+vvXkxGc5lhTyEY3b
         Tc/x8OG2GUbeRO38N/toQuvPPuDZmfViAeys4=
Received: by 10.150.45.42 with SMTP id s42mr1955807ybs.23.1252933991084;
        Mon, 14 Sep 2009 06:13:11 -0700 (PDT)
Received: by 10.177.112.39 with SMTP id p39gr6971yqm.0;
	Mon, 14 Sep 2009 06:13:09 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.131.2 with SMTP id i2mr662770ebn.22.1252933988580; Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
Received: by 10.211.131.2 with SMTP id i2mr662769ebn.22.1252933988533; Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149]) by gmr-mx.google.com with ESMTP id 15si1275206ewy.4.2009.09.14.06.13.07; Mon, 14 Sep 2009 06:13:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.149 as permitted sender) client-ip=74.125.78.149;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.149 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 3so607720eyh.32 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=JwK/TI8JpiBQwZEZqnx8N05p9ryJJjQDqyc37K0Rqno=; b=IedFcUjHb1BBgxPXJ8yCTd6gsz4KOsD3Bp/QyRKSY6OcrzgBqAAuX9NMgtiQze2VXc oIg4LydElW2fli5IA2z3VKoVqFZpl3drBLiZvD03zEQL76uReJKkQ12DSy9J3l+Bb8sk pSIZ3QmyY/p4XbIL69ezjJTMBAa5Kcxawp0Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=dfA3+KioPKMOTA+OC0y/lNv8FWWkRae/K1Ilv2JljkjjX4s8oDzdobQCNIWU+oV6ZR hvmzpTzR/GRu2xRVdcC0YzD1Qc+JVN1YDrZZiuR8i8zuuxVM3JFtJMVqY4C57n2x0qQW wXCjAmUWcjLVnmdNHrMDXiH0pmzFVoSSEY5uc=
Received: by 10.210.6.8 with SMTP id 8mr3158295ebf.41.1252933987439; Mon, 14 Sep 2009 06:13:07 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.13.04 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:13:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128470>


The MSVC Posix implementation doesn't contain ftruncate, so add our own
which can handle large files (64bit offsets).

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/msvc.c |    8 ++++++++
 compat/msvc.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index ac04a4c..b96b045 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -32,4 +32,12 @@ int closedir(DIR *dir)
 	return 0;
 }
 
+int ftruncate(int fd, __int64 length)
+{
+	HANDLE fh = (HANDLE)_get_osfhandle(fd);
+	if (!fh || _lseeki64(fd, length, SEEK_SET))
+		return -1;
+	return SetEndOfFile(fh) ? 0 : -1;
+}
+
 #include "mingw.c"
diff --git a/compat/msvc.h b/compat/msvc.h
index a62507f..d9fc04b 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -46,4 +46,6 @@ struct _stati64 {
 	time_t  st_mtime;
 	time_t  st_ctime;
 };
+
+int ftruncate(int fd, __int64 length);
 #endif
-- 
1.6.2.1.418.g33d56.dirty
