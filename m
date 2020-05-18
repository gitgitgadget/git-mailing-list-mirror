Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9710C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8732065F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyM5MO7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgERPrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERPrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4133C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f189so10538738qkd.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkYUT5SwuCNrZz5COB4j4PBTSRC/ZKKDjb8W0WB+11w=;
        b=TyM5MO7sgTehvYtSOg+0fNywdDr/CCk+Bxh9ltVVxMCElDpSxrYRJGnXsTBQO6yzOF
         c95vbybf0sW8sco3/GigkRKkwsVFkMQmxrxvDhj2IT/8GY9ZJB9hak9uBnoKVZwRimzA
         Jzcvdxs9EGrmE3h65GmgIMvc/bAoXOoXBzF/YQoyoP0WhsU/+WAitjex0D/YXKdkR1Wy
         808YbHrhwas6eL7no2HTD/xiSbwU98eUHShyuc0TPyejEauZXzzkbLbUlmZ+jgjsjc21
         czmYVKkHMUvTStMLmt9niYczwSzfk4R/+R16SJrj1Ng8c+vXhLY6/1w06bwWiZlNh4VM
         qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkYUT5SwuCNrZz5COB4j4PBTSRC/ZKKDjb8W0WB+11w=;
        b=e8AAC65cykduZxdRqNs4xHLNsfYvCYcw15/HTMNLxudjUMQWMeXYIKevS3NgXuu1Qs
         e2rdL0kMxRA8bfpZ5BZ89JzE0l6MTJA44VIlKrAXGbCSZgu7FNT0bwl2x3ROOHebx/xk
         +cPGTe7QxAhs11itXK3rEsYJXWAAvfmG+R1aRW1HAYvnmZCbe16VrXubUQ64fsdPbIh3
         dwZckmjsPs4VigeuTYZNhKYpuDllrRR9NzU9cGhKFyqtpkD4qxizA3wHcxeCzkCBgKrW
         DZs0H+df1xfsk6+zhuAgO5K4epELs+bPaFHdDhVgXrXRAyXwf1VE4OdJqq5y0Di+dU8u
         SDsg==
X-Gm-Message-State: AOAM5308IpJU7zLIESVvsjTXTvjJXx5bbkP71wXESFe6U3NGQxbKJ4jg
        mCfI6+6iMnL+5ORGyWQ3PXGBM2GT
X-Google-Smtp-Source: ABdhPJwv0+4INkpdS18bLA7a+nOGVM1rctfHVEMCXa1TmoJTUWfLILV181sbIJJEDIJLCMESEdWEAw==
X-Received: by 2002:a37:9f4a:: with SMTP id i71mr16631750qke.281.1589816858636;
        Mon, 18 May 2020 08:47:38 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:37 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/7] pkt-line: extern packet_length()
Date:   Mon, 18 May 2020 11:47:21 -0400
Message-Id: <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be manually processing packets and we will
need to access the length header. In order to simplify this, extern
packet_length() so that the logic can be reused.

Change the function parameter from a `const char *` to
`const char linelen[4]`. Even though these two types behave identically
as function parameters, use the array notation to semantically indicate
exactly what this function is expecting as an argument.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c | 2 +-
 pkt-line.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index a0e87b1e81..5c3b4539b5 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -306,7 +306,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	return ret;
 }
 
-static int packet_length(const char *linelen)
+int packet_length(const char linelen[4])
 {
 	int val = hex2chr(linelen);
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
diff --git a/pkt-line.h b/pkt-line.h
index fef3a0d792..de81776a7a 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,15 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+/*
+ * Convert a four hex digit packet line length header into its numeric
+ * representation. linelen should not be null-terminated.
+ *
+ * If linelen contains non-hex characters, return -1. Otherwise, return the
+ * numeric value of the length header.
+ */
+int packet_length(const char linelen[4]);
+
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
  * returns an 'enum packet_read_status' which indicates the status of the read.
-- 
2.26.2.706.g87896c9627

