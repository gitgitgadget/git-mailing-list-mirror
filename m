Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A11C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiKQLar (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239322AbiKQLak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 06:30:40 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405D42998
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1644514pjc.5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnrIaY15ocEMQVBl2WYat1qxKAuWAkWFdRSCE7rxH1M=;
        b=pzaQ/0cMz2seF/ktc8J3CRBvkc3v7Q8pH5pph/gojgL8/zA7BPhdp+fDzX1YRjP8Mm
         IFpV0ObYn2TCsmn+m7RJ4Fcsqyvr9eKDw9UTbvK0n6RvahVXOXIjSpu/gRiFowXtYpJw
         pPljX7Z1Y3hjO9ditwpPH6sZGugd7Nqx17RS6YjKmanXB4efTs+Larcev4DNcIYrKvAh
         boPjohdJBI5XltnofeZDPzzVshsU3/rYdiv2RnRVrrlerICPVuvrGLmjhH2yuR53PuKv
         rlZNIZOk4uBgpXBfIihjyYYhxFnGSGug4ykXQW1LmBOPJYg7EhHWoPqDza10Zoc0ehKA
         Seww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnrIaY15ocEMQVBl2WYat1qxKAuWAkWFdRSCE7rxH1M=;
        b=yv3HLmM2ixndKMdti6O/DZIhyXfSucnGGPQ3uA+kwoikTpPYtQud+NwF754cSy1M0x
         1qGV9AQNOMDcd9CsmOmv+mu12KiR28G1wdodYU/Nq8GszUyRwXjbMMBb4GaUTOq3Btqy
         yFRYRZ6WmP0oFgV9iQNIFnju16QFldLCVT8MOUVVIeiRfTxWR0gmz6OMb7h0YJXsGV+W
         OgLDvJ7inpnt5k4CnDlyGvaayTR3UEQmpPVBl4+Qv5YqpvAwo1vIvqISveIZ+9A3f0DF
         Tzpv/tLbnY3SV5oyzaAyE+tyRR8UzZ74IPzM7sGICTntq0YfV0QGuv+xsN4ffMWVSrA6
         wiew==
X-Gm-Message-State: ANoB5pmwJLscjlgsJwLpGZ4T6XSBddndgKt59vpgV/xCz8n2zjVVXMNu
        wCdspXizgt0AhBqFPoD87JKR4/CvDzy2xw==
X-Google-Smtp-Source: AA0mqf4PYRtPl/vGT2v8okNvugiVVODhFeREMwfsHrrg6+UxdGhZPJ9CLL0h/4R0YZo935zHfQXnPw==
X-Received: by 2002:a17:90a:c217:b0:212:ca89:41c9 with SMTP id e23-20020a17090ac21700b00212ca8941c9mr2266177pjt.244.1668684638920;
        Thu, 17 Nov 2022 03:30:38 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b00186c5e8b1d0sm1056117pln.149.2022.11.17.03.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:30:38 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH 3/6] ls-tree: optimize params of 'show_tree_common_default_long()'
Date:   Thu, 17 Nov 2022 19:30:20 +0800
Message-Id: <20221117113023.65865-4-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.426.g770fc8806cb.dirty
In-Reply-To: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Function 'show_tree_common_default_long' has 3 parameters:

  * struct strbuf *base
  * const char *pathname
  * const size_t baselen

And the struct 'show_tree_data' which was introduced in
'e81517155e0370ae5433d256046ab287bb10d04d' is:

  struct show_tree_data {
	       unsigned mode;
	       enum object_type type;
         const struct object_id *oid;
         const char *pathname;
         struct strbuf *base;
  };

Actually, the struct includes all the data that we need to pass to the
function, so we could make a small refactoring by using 'show_tree_data'
struct directly.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8256fc0bc97..afb65af4280 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -200,15 +200,15 @@ static int show_tree_common(struct show_tree_data *data, int *recurse,
 	return ret;
 }
 
-static void show_tree_common_default_long(struct strbuf *base,
-					  const char *pathname,
-					  const size_t baselen)
+static void show_tree_common_default_long(struct show_tree_data *data)
 {
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
+	int base_len = data->base->len;
+
+	strbuf_addstr(data->base, data->pathname);
+	write_name_quoted_relative(data->base->buf,
 				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
 				   line_termination);
-	strbuf_setlen(base, baselen);
+	strbuf_setlen(data->base, base_len);
 }
 
 static int show_tree_default(const struct object_id *oid, struct strbuf *base,
@@ -225,7 +225,7 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 
 	printf("%06o %s %s\t", data.mode, type_name(data.type),
 	       find_unique_abbrev(data.oid, abbrev));
-	show_tree_common_default_long(base, pathname, data.base->len);
+	show_tree_common_default_long(&data);
 	return recurse;
 }
 
@@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 
 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
 	       find_unique_abbrev(data.oid, abbrev), size_text);
-	show_tree_common_default_long(base, pathname, data.base->len);
+	show_tree_common_default_long(&data);
 	return recurse;
 }
 
-- 
2.38.1.426.g770fc8806cb.dirty

