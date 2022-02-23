Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ACFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbiBWSc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2D84B87E
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o4so4301760wrf.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jJsXhVhG82wFUXv4oii4SDL+BE/grwhSYmD/abbrqhE=;
        b=SIV9WYKtFHqYWyxRBHvUy5TofkHBY5LduR7wuFGS3j4Zr4JxVvrn/ZNf2EwERGaglW
         noqrBWDN/LXDXOjHpEunWP7LDinDY+oycfhR3BvlYZGAcQlTWulVMwexPy+HVjS8Vs6n
         gXsAeSIbaLR5tZI6sq4q4b7HFDtpJIj1Cfn+PWOXaGuBqKgn+SYbehyV/IHQ7FdirE/v
         q3WAERizD3cKZREF4Ll8Iv8leYIHTfb6gZQQX+THC1+EP1oPTf66h86ws8rZTWmj8dSp
         t+JczVz61DKk5j9RQLNtjG/LEvDiJ/s7e/uuKKf31d3mOaEViCC3jGp0XIF4IDncl+2o
         grqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jJsXhVhG82wFUXv4oii4SDL+BE/grwhSYmD/abbrqhE=;
        b=nVWNJGU05sW8YjC98lak6BuWdDnsWsNJTWPNlmf+qADjqOEN9Ffd1u60FANezHS+IU
         iFED3hWi+A40Y3rgNGh/Yvssc68P9xK3MT83HUSwrIgh+WecTh1W4R3y1cgKQ8wg7CWD
         2T0G/K6ZBYfK59g7SE4bGU9jfPaGeshRZ8PynSnXq2ANNf/fI4znBHY7VtAswgozxVs5
         m0W82M90akQh62kd4tbZVr1mDRRhU9COYihRhLrUr5jAxfHvBzd9Mp+Hd+Rzi91Y12C8
         L/h/uDPRjB1Y/EG0064f6uuCtkPI28EhbU9VxDgbSDuADUfQAdbGk8zeT+ZDQuQ9akmx
         xDJg==
X-Gm-Message-State: AOAM531HDO3bNF9OFYYz80a+YfXY5NfFA6mvdfiEtSPrwyqoMKIMXijt
        zKYnXBEsryBJG5r4jRBOv65Ot7GJ9eA=
X-Google-Smtp-Source: ABdhPJxKM2S2Z02wMWYK9NIQgFgex75H7btp3zrWeO/VjYrxKqz9Ux8apjFGv67tFuTrdlixjBMf4A==
X-Received: by 2002:a5d:4890:0:b0:1ed:9d4e:f8ef with SMTP id g16-20020a5d4890000000b001ed9d4ef8efmr662691wrq.595.1645641084708;
        Wed, 23 Feb 2022 10:31:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm365847wri.74.2022.02.23.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:24 -0800 (PST)
Message-Id: <9a72854af51cae0813cf98318f5ea20a9c8bd559.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:57 +0000
Subject: [PATCH 19/25] protocol-caps: implement cap_features()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'features' capability sends a list of "key=value" pairs from the
server. These are a set of fixed config values, all prefixed with
"serve." to avoid conflicting with other config values of similar names.

The initial set chosen here are:

* bundleURI: Allow advertising one or more bundle servers by URI.

* partialCloneFilter: Advertise one or more recommended partial clone
  filters.

* sparseCheckout: Advertise that this repository recommends using the
  sparse-checkout feature in cone mode.

The client will have the choice to enable these features.

RFC-TODO: Create Documentation/config/serve.txt

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 protocol-caps.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 protocol-caps.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/protocol-caps.c b/protocol-caps.c
index bbde91810ac..88b01c4133e 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -8,6 +8,7 @@
 #include "object-store.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "config.h"
 
 struct requested_info {
 	unsigned size : 1;
@@ -111,3 +112,68 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 
 	return 0;
 }
+
+static void send_lines(struct repository *r, struct packet_writer *writer,
+		       struct string_list *str_list)
+{
+	struct string_list_item *item;
+
+	if (!str_list->nr)
+		return;
+
+	for_each_string_list_item (item, str_list) {
+		packet_writer_write(writer, "%s", item->string);
+	}
+}
+
+int cap_features(struct repository *r, struct packet_reader *request)
+{
+	struct packet_writer writer;
+	struct string_list feature_list = STRING_LIST_INIT_DUP;
+	int i = 0;
+	const char *keys[] = {
+		"bundleuri",
+		"partialclonefilter",
+		"sparsecheckout",
+		NULL
+	};
+	struct strbuf serve_feature = STRBUF_INIT;
+	struct strbuf key_equals_value = STRBUF_INIT;
+	size_t len;
+	strbuf_add(&serve_feature, "serve.", 6);
+	len = serve_feature.len;
+
+	packet_writer_init(&writer, 1);
+
+	while (keys[i]) {
+		struct string_list_item *item;
+		const struct string_list *values = NULL;
+		strbuf_setlen(&serve_feature, len);
+		strbuf_addstr(&serve_feature, keys[i]);
+
+		values = repo_config_get_value_multi(r, serve_feature.buf);
+
+		if (values) {
+			for_each_string_list_item(item, values) {
+				strbuf_reset(&key_equals_value);
+				strbuf_addstr(&key_equals_value, keys[i]);
+				strbuf_addch(&key_equals_value, '=');
+				strbuf_addstr(&key_equals_value, item->string);
+
+				string_list_append(&feature_list, key_equals_value.buf);
+			}
+		}
+
+		i++;
+	}
+	strbuf_release(&serve_feature);
+	strbuf_release(&key_equals_value);
+
+	send_lines(r, &writer, &feature_list);
+
+	string_list_clear(&feature_list, 1);
+
+	packet_flush(1);
+
+	return 0;
+}
diff --git a/protocol-caps.h b/protocol-caps.h
index 15c4550360c..681d2106d88 100644
--- a/protocol-caps.h
+++ b/protocol-caps.h
@@ -4,5 +4,6 @@
 struct repository;
 struct packet_reader;
 int cap_object_info(struct repository *r, struct packet_reader *request);
+int cap_features(struct repository *r, struct packet_reader *request);
 
 #endif /* PROTOCOL_CAPS_H */
-- 
gitgitgadget

