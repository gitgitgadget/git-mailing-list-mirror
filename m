Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF573C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbiDRR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbiDRR1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E933E32
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t1so19310483wra.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zn3yVLvYXtgT/5nSH5RBjOUFWFYAJDlLRjTQ7k0Vr1A=;
        b=UvX7P/KaDiAQ5l02CZ/X1O373Gti3yLNsi//FKH+Pfybm26PzRFnqHq2Ea8I8Ppa2M
         ru0X5kHoNA88EqNvujhDcqjJ24E7fUeBtwJqk14A+j/ePvWNL3RLbZhpXgDvgdLUI2uQ
         Z3ERhqL2AEQvgWrLHHtbchNgrgWfdhPhlYN8e/46FXzjw3oGJuPvjG+WI/o+qLHeiS/S
         5IyYsNEkEFCwofDyubPW+fxIQ6/g36gb4yavWpvLppb5b4lpxPQewITx1xqVGct+sEzy
         HDixyM217MU+V9NOpHNdPYXkWXXam20sWIiMbhBW1fffJUUkzrusKUdotuVq1uI83aD8
         FsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zn3yVLvYXtgT/5nSH5RBjOUFWFYAJDlLRjTQ7k0Vr1A=;
        b=SNAw+h1yg8pdwf9WcQGlTywOFgsEuIZJsfHr76GYpHYHEx7mXDYWDoARkqGSwPJmqK
         9oPobpz5uFAsjBG0EPUvzPL/9PCW2GTQcOMWjMl9vG6guFj8cEgODriyte0CDB9t0AGw
         px9e7l4Db/+OzdTQXNVyjePf04xIf1drYkDGE5XVS1GncM1/aoP88Z1ZDvVa9mJFP+CX
         zasTL4XbTzz85EV+rEdvdKK55fofodDnBt56H3uSGOYRB3QKi0eH7YMRXDuVmuDi//wT
         fCwDJR3BMKgI2y+v97xwi6ASd0Iby/1nRz04LOJqeptI8QgG4kl1+GdTjeqWtBqfO7s+
         YYfg==
X-Gm-Message-State: AOAM531Xkq3iprOFjPf7pP6vg+Z/zGbFZ0SRdGo832w/uV0mXzioz+kX
        Fpxw46s458WB3VtkSMKFntWE0WsoOJG59A==
X-Google-Smtp-Source: ABdhPJy/IpcCZ7ZrQ20gyxbG/Mz0edI9iXGOUo8gzuKiYzzoBoSoyxAKNaR/7Y/5HjWKICciK9Jagw==
X-Received: by 2002:adf:dc41:0:b0:205:8df5:464c with SMTP id m1-20020adfdc41000000b002058df5464cmr8525340wrj.445.1650302668005;
        Mon, 18 Apr 2022 10:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 27/36] protocol-caps: implement cap_features()
Date:   Mon, 18 Apr 2022 19:23:44 +0200
Message-Id: <RFC-patch-v2-27.36-5e8cec1e193-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.36.0.rc2.902.g60576bbc845

