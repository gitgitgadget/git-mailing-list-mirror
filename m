Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2C41F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeJOFzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeJOFzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id v18-v6so16051977edq.12
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcp7KkEXGvI8g0QdCJwMf+b2EsonClA3o3Ei3knwfbQ=;
        b=jTo0aX8CuPr6t4AzWL64eaL35s8dc3UyakHILLwH1Wamg8T6XXsqfMtDWeN7uaqa5F
         i1Ex/DoBSqncsmre1vWfq+xYawudpJYD0xThtxlgN72ymltwGoFWgjIKHWtyLR/SF5j3
         JpZ2DR1DOsfgJ729zC0yh9IVWTBPKKS2Awp9widjYArc1wd50ybKaeay+kt5fAxJrpTA
         mKgB4o/CkrWoZTnfpBIVkBr0hAJapj7bE+eqg3c0On8tbCYCvtGsbuc0Umvh13XSCgZg
         qWJ6WqiQdh4/d5WilH7KCYTktpkM3qVpvFXz72ZDSAVPSIPg+jxFOKGSlqDoRkwa6QNj
         Be0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcp7KkEXGvI8g0QdCJwMf+b2EsonClA3o3Ei3knwfbQ=;
        b=SB+lh5CiTrxY5tJIPyYSXT2ro6HxtNtYGPZRFWGLtrFjliZjkayTbkQ484ufMrW3Ld
         KaYZNg5z/DYoCuvizlAoKlz5zxY83czBTfYHFmt8A5oTu8w7UGl6xLwPoEvcpGTEls/x
         XQF2rY5XtXzpF3//RDltO4UoCUvz6K8B+5MAXCJtwxArVGEI0nybzStcnQ79bRUZ40AL
         yVV3d3dbMpcaKmGRpFfcwjoEuZQ1jnpfHDH+hxujUnHHL/7MSoLCRhUzEz8jHkREOWUI
         BwY0FSeKXwbsqKDndi0yfibUsGfp57M8SrjQtqYByCf+k/7+hHSGzAzLLYVCkmfqTNO3
         gaow==
X-Gm-Message-State: ABuFfog4rBMtN0nTXTixLnI6FnnKcof1FoaCJKiYjYIil6AQ5Z5R1KhB
        8cMirPTS8+euLq+QPa7Ijf48oYZs
X-Google-Smtp-Source: ACcGV630yjRbp8QaGDeu0IvY70ijh1mYWZdSyUn6Bxlhrj0Q8OVUx7HwBwup2vhhkUDHinkRO5E/KQ==
X-Received: by 2002:aa7:da1a:: with SMTP id r26-v6mr21100074eds.54.1539555191286;
        Sun, 14 Oct 2018 15:13:11 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:10 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 02/21] strbuf.c: add `strbuf_join_argv()`
Date:   Mon, 15 Oct 2018 01:11:08 +0300
Message-Id: <ed065178766fd1f1f5856422af0db785dde40f40.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement `strbuf_join_argv()` to join arguments
into a strbuf.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 strbuf.c | 13 +++++++++++++
 strbuf.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 64041c3c24..c8a104099a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -259,6 +259,19 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 	strbuf_setlen(sb, sb->len + sb2->len);
 }
 
+void strbuf_join_argv(struct strbuf *buf,
+		      int argc, const char **argv, char delim)
+{
+	if (!argc)
+		return;
+
+	strbuf_addstr(buf, *argv);
+	while (--argc) {
+		strbuf_addch(buf, delim);
+		strbuf_addstr(buf, *(++argv));
+	}
+}
+
 void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
 	strbuf_grow(sb, n);
diff --git a/strbuf.h b/strbuf.h
index 60a35aef16..4ec912f4b7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -284,6 +284,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
  */
 extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
+/**
+ * Join the arguments into a buffer. `delim` is put between every
+ * two arguments.
+ */
+extern void strbuf_join_argv(struct strbuf *buf, int argc,
+			     const char **argv, char delim);
+
 /**
  * This function can be used to expand a format string containing
  * placeholders. To that end, it parses the string and calls the specified
-- 
2.19.0.rc0.23.g10a62394e7

