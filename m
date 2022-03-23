Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F353C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiCWDto (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiCWDtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF264FE
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m30so346379wrb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70VV+6yT0c9eqf/7E5fdebsBvCLDgB/oaDYP50qyygc=;
        b=eqC5ikVcaDjL9XZUFWxbkzUYcgglgIP/E+xTDk0c+6FWy6YMjO8hMObxQfIwRu2vU4
         GigafYpo6rJeZoKGn3bRDM65KhQE8ASl3TIu9A9VB3TibmAduUv+Ntrpe7lCfRJ8m4LK
         Pjp6+3xp3L5mgmIGUQ5a4TbVnELkt7QUdUU4w/BLlpOGcMo39TimK2H4VVXYFH+Pgn90
         WhUuv7upMd1sfXsrFvfmuM+GnXGZxhZFI6Oi8USv6aa5GyUrksZc2AAhsaIHDV49seUV
         114oeOCIRG9E85mpCIdtJOrhoU3R42N1Xsr0p5RPvtJFNxlpZjtSK9S88mStEtPsLkC+
         hgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70VV+6yT0c9eqf/7E5fdebsBvCLDgB/oaDYP50qyygc=;
        b=f2+o1ZJo6KX7yhgSUcLUqSj5dAEf+k6fmzmcP3EeNGYLY+ANaXOfqCAoqpnqLizggz
         7R2y1BIjVeUiKg6W8arfjzn2L8UT8mZjhltc6JtEJI+SPv8fSvD9+AQ2jGkfUBQYBSbn
         /lIRqCpQHg2HHtI6yp2M4yuWfahUoXbEFOTyhHavztliRlKMyzeQOnpOeCJlskQgaGxJ
         wn+FU+dtUnC9CQsg0RvuJ1h3ms4pe7b9w6k2LM8loaFTOSW9EoO1A8GIGaElcfk58ve8
         5rw+ZAEUqnGQUQsnKMkzpN6pgrVagRvJPrL0tNc/cv14+GUidRP8P6og5ECZsw2kVpKK
         BxoA==
X-Gm-Message-State: AOAM532hRbaP1vnwq+o7aMPV59w01B9jb54c25S75Z+BxQYAVyaiRQVv
        AsaC2/L7AGLlUxQwgjUbUGdqc/Cg6JtiuA==
X-Google-Smtp-Source: ABdhPJxKxEw3q7wrarb7p78rHsEp8FpHOa+e04IjMYgCqaW3J4LxR4tUTj0EygIg12OI7/c04L75cA==
X-Received: by 2002:a5d:6244:0:b0:1e7:686d:41e7 with SMTP id m4-20020a5d6244000000b001e7686d41e7mr24884825wrv.491.1648007282883;
        Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/7] update-index: use a utility function for stdin consumption
Date:   Wed, 23 Mar 2022 04:47:33 +0100
Message-Id: <RFC-patch-4.7-2c5395a3716-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 95ed3c47b2e..80b96ec5721 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -971,6 +971,25 @@ static enum parse_opt_result reupdate_callback(
 	return 0;
 }
 
+static void line_from_stdin(struct strbuf *buf, struct strbuf *unquoted,
+			    const char *prefix, int prefix_length,
+			    const int nul_term_line, const int set_executable_bit)
+{
+	char *p;
+
+	if (!nul_term_line && buf->buf[0] == '"') {
+		strbuf_reset(unquoted);
+		if (unquote_c_style(unquoted, buf->buf, NULL))
+			die("line is badly quoted");
+		strbuf_swap(buf, unquoted);
+	}
+	p = prefix_path(prefix, prefix_length, buf->buf);
+	update_one(p);
+	if (set_executable_bit)
+		chmod_path(set_executable_bit, p);
+	free(p);
+}
+
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, nul_term_line = 0;
@@ -1174,20 +1193,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
-		while (getline_fn(&buf, stdin) != EOF) {
-			char *p;
-			if (!nul_term_line && buf.buf[0] == '"') {
-				strbuf_reset(&unquoted);
-				if (unquote_c_style(&unquoted, buf.buf, NULL))
-					die("line is badly quoted");
-				strbuf_swap(&buf, &unquoted);
-			}
-			p = prefix_path(prefix, prefix_length, buf.buf);
-			update_one(p);
-			if (set_executable_bit)
-				chmod_path(set_executable_bit, p);
-			free(p);
-		}
+		while (getline_fn(&buf, stdin) != EOF)
+			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
+					nul_term_line, set_executable_bit);
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
-- 
2.35.1.1428.g1c1a0152d61

