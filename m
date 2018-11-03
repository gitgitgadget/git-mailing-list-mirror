Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CFA1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeKCR7m (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39843 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so532222ljh.6
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ewvVqGtNQTgW7o15Xejp+IrBT4QbCBPgLeCwuYv68M=;
        b=PuWMrjzzUaK/2aeeTFKyQZN/iQ5c2X3grP4+Zm+d80rexXJ5tsPrhap03CvyuYnWgC
         Q6s13EJfgYDTFIRvr7kG6l2+JQO2Xaz8bVqBp9hf2EFnOpyW0CIUnrPPN89M3/W28mA4
         c346BwnfUhOFmfkgDn1YSuwDzMxWHu2GZsywoFodI6Uin16X0b+1mBBszBO4ODosvcs7
         fPrFi6fzDxgvTrvGLbpeDEoddQY4CVIp+dtECo6kKV1Y/rfiH3Nqsu0oQZOWwj+kn2GW
         RBXaREdln391OOjGC/I23Lxg4PPCJgG7TzdsPUnpGz2lFJ8hHKgnv04aCxdCHmI3dv4L
         gZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ewvVqGtNQTgW7o15Xejp+IrBT4QbCBPgLeCwuYv68M=;
        b=s5JV9jtHRQx3c5/pQfMG47RZpIpR3nMiHULLTh0KlvWGFw9WxHxa/RjUG5FSnMlYNO
         ozaWDsNebCcLwZeo25f+g4MWjZI6lguNUViKzf0v4eCNbudI1PB6PtqXW5coFpwIlNFF
         iKzF1M8aauKwcrbI7vPM7K6Ozsg6EKMTRLd8qXOEPJHU0vZVBZ/YMMyJ7WeYjpo7GbEp
         RLYrICCok37ap5Y59D5xc4uW7fJX5+vBLXhZ9uvnPMBGOJxwcTKBY9+7J/CLE0EVSBl8
         Xa30IQWMPXonVu/NSKCx1b5fXgMZLG0OQRu3aAYru4krcr511KarvX8pF4NfPlQXKRm4
         FF2Q==
X-Gm-Message-State: AGRZ1gLNPUluCW+5cfSRmRM3F3WSA13kF92qNIaBSQfDCpetApSxy3BI
        MqBF80dyV9bwdZpmVP4KSqA=
X-Google-Smtp-Source: AJdET5c+3FYxyO2BCXUug/oWEojg+xuBtBG+QN7ZG5U/IFy0lN/IAanCScsYebh7eHkamD4RwVy59g==
X-Received: by 2002:a2e:2a46:: with SMTP id q67-v6mr2988840ljq.38.1541234944695;
        Sat, 03 Nov 2018 01:49:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 03/14] send-pack.c: move async's #ifdef NO_PTHREADS back to run-command.c
Date:   Sat,  3 Nov 2018 09:48:39 +0100
Message-Id: <20181103084850.9584-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On systems that do not support multithread, start_async() is
implemented with fork(). This implementation details unfortunately
leak out at least in send-pack.c [1].

To keep the code base clean of NO_PTHREADS, move the this #ifdef back
to run-command.c. The new wrapper function async_with_fork() at least
helps suggest that this special "close()" is related to async in fork
mode.

[1] 09c9957cf7 (send-pack: avoid deadlock when pack-object dies early
    - 2011-04-25)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.c | 9 +++++++++
 run-command.h | 1 +
 send-pack.c   | 5 ++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 84b883c213..3c3b8814df 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1246,6 +1246,15 @@ int finish_async(struct async *async)
 #endif
 }
 
+int async_with_fork(void)
+{
+#ifdef NO_PTHREADS
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
diff --git a/run-command.h b/run-command.h
index 9b7f38202c..68f5369fc2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
+int async_with_fork(void);
 void check_pipe(int err);
 
 /**
diff --git a/send-pack.c b/send-pack.c
index e920ca57df..f692686770 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -203,9 +203,8 @@ static int receive_status(int in, struct ref *refs)
 static int sideband_demux(int in, int out, void *data)
 {
 	int *fd = data, ret;
-#ifdef NO_PTHREADS
-	close(fd[1]);
-#endif
+	if (async_with_fork())
+		close(fd[1]);
 	ret = recv_sideband("send-pack", fd[0], out);
 	close(out);
 	return ret;
-- 
2.19.1.1005.gac84295441

