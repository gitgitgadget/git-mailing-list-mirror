Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08101C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB4F22D07
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgLIPxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgLIPxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF0C0617B0
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so2256971wrr.12
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcEqSGOsiXaPJ6jV34M5r6wl3qXeqxbsXAcm7tF7IxM=;
        b=rlIQBATQaYeDDLGGiIJsVJs709hgKPSpimOyLYz5j7mtsh/G0PqJcV/vDjq/cJ9YIT
         2tWUHsjxnZ1qZW5Y+270JtRjVx7v0Aw1aA0ZtnLIuX7kA+nInTNhWZa9mvHkvf72WigB
         LZxzhcUzGiaN7ptuam6jSwnPD/e4raA2PnR2aZg/WN/O2dCksfLltFpRKysMkx3fD0/K
         +h4Dd517ytThAPsP9jnx1oiOlXTpdHgKdlIVOWqBbVD1cxvrp4ANA/YKZM+i98qExIZO
         On0fktGJQONpUuJq8b0e/JzaKEsvkgqhNdpKhpxZIiqZNdVqtZJyrAE9Z8cNbNL0OVDz
         BbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcEqSGOsiXaPJ6jV34M5r6wl3qXeqxbsXAcm7tF7IxM=;
        b=TYMysycZyq7s6cqtDFR7rhUMZcQygQW6OtWrdIfrm8Pvd4MoI9a98BGb2vJvM/4OOk
         ljA6ViDcFyj2tVtBg2xOO3gbuo7VPfEoBZJZD5N8v1PnA2iH5Si9Qii8QkgVsUS8Mtvx
         5UF7uJAC3TfjIK3XQWYRHSjWBwD4c3i5XiZtvSxNCO66QhViOzmvhFi0419NOZLXeqdg
         dCqTlYBWqLgQmtIBnAuz4E9eaGk4E1II1aSk4qCwbtaKwO1E7p29DPPDP1YtzSdCzeml
         /V/4Nqd0D2UNvDU/ZVwX1ViOjlmCoi6+rgC+cL8SOc5aBitqZiMFZy9AfiUwJ8m/6xFu
         PaEg==
X-Gm-Message-State: AOAM530vw2kVn4Kq02IXPGKR+tuXl52JqVALuZC2/aKZo1IZes7302F4
        l9eI118br+X82conJktEPUL/StDX2nCFrg==
X-Google-Smtp-Source: ABdhPJwf3BU+caMVAPVP7X5I+zy3AeEIL8PFRyxhblemIyOpju6eIH7Xu7ltCGNwwI/8lVs4Vf9XFw==
X-Received: by 2002:adf:f143:: with SMTP id y3mr3450880wro.138.1607529151564;
        Wed, 09 Dec 2020 07:52:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] pretty format %(trailers): add a "key_value_separator"
Date:   Wed,  9 Dec 2020 16:52:08 +0100
Message-Id: <20201209155208.17782-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "key_value_separator" option to the "%(trailers)" pretty format,
to go along with the existing "separator" argument. In combination
these two options make it trivial to produce machine-readable (e.g. \0
and \0\0-delimited) format output.

As elaborated on in a previous commit which added "keyonly" it was
needlessly tedious to extract structured data from "%(trailers)"
before the addition of this "key_value_separator" option. As seen by
the test being added here extracting this data now becomes trivial.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt |  4 ++++
 pretty.c                         |  9 +++++++++
 t/t4205-log-pretty-formats.sh    | 33 ++++++++++++++++++++++++++++++++
 trailer.c                        | 11 ++++++++---
 trailer.h                        |  1 +
 5 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 5eac36500d4..6b59e28d444 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -284,6 +284,10 @@ option is given with no value, it's enabled.
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=<BOOL>]': only show the key part of the trailer.
 ** 'valueonly[=<BOOL>]': only show the value part of the trailer.
+** 'key_value_separator=<SEP>': specify a separator inserted between
+   trailer lines. When this option is not given each trailer key-value
+   pair is separated by ": ". Otherwise it shares the same semantics
+   as 'separator=<SEP>' above.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 1237ee0e45d..05eef7fda0b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1418,6 +1418,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
 		struct strbuf sepbuf = STRBUF_INIT;
+		struct strbuf kvsepbuf = STRBUF_INIT;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1449,6 +1450,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
 					free(fmt);
 					opts.separator = &sepbuf;
+				} else if (match_placeholder_arg_value(arg, "key_value_separator", &arg, &argval, &arglen)) {
+					char *fmt;
+
+					strbuf_reset(&kvsepbuf);
+					fmt = xstrndup(argval, arglen);
+					strbuf_expand(&kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
+					free(fmt);
+					opts.key_value_separator = &kvsepbuf;
 				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
 					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
 					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4c9f6eb7946..749bc1431ac 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -776,6 +776,39 @@ test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
+	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00)X" >actual &&
+	(
+		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
+		printf "Acked-by\0A U Thor <author@example.com>\n" &&
+		printf "[ v2 updated patch description ]\n" &&
+		printf "Signed-off-by\0A U Thor\n  <author@example.com>\nX"
+	) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
+	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00,unfold)X" >actual &&
+	(
+		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
+		printf "Acked-by\0A U Thor <author@example.com>\n" &&
+		printf "[ v2 updated patch description ]\n" &&
+		printf "Signed-off-by\0A U Thor <author@example.com>\nX"
+	) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:separator,key_value_separator) changes both separators' '
+	git log --no-walk --pretty=format:"%(trailers:separator=%x00,key_value_separator=%x00%x00,unfold)" >actual &&
+	(
+		printf "Signed-off-by\0\0A U Thor <author@example.com>\0" &&
+		printf "Acked-by\0\0A U Thor <author@example.com>\0" &&
+		printf "[ v2 updated patch description ]\0" &&
+		printf "Signed-off-by\0\0A U Thor <author@example.com>"
+	) >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pretty format %(trailers) combining separator/key/keyonly/valueonly' '
 	git commit --allow-empty -F - <<-\EOF &&
 	Important fix
diff --git a/trailer.c b/trailer.c
index 889b419a4f6..249ed618ed8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1132,7 +1132,8 @@ static void format_trailer_info(struct strbuf *out,
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->key_only && !opts->value_only) {
+	    !opts->separator && !opts->key_only && !opts->value_only &&
+	    !opts->key_value_separator) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
@@ -1155,8 +1156,12 @@ static void format_trailer_info(struct strbuf *out,
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
 					strbuf_addbuf(out, &tok);
-				if (!opts->key_only && !opts->value_only)
-					strbuf_addstr(out, ": ");
+				if (!opts->key_only && !opts->value_only) {
+					if (opts->key_value_separator)
+						strbuf_addbuf(out, opts->key_value_separator);
+					else
+						strbuf_addstr(out, ": ");
+				}
 				if (!opts->key_only)
 					strbuf_addbuf(out, &val);
 				if (!opts->separator)
diff --git a/trailer.h b/trailer.h
index d2f28776be6..795d2fccfd9 100644
--- a/trailer.h
+++ b/trailer.h
@@ -74,6 +74,7 @@ struct process_trailer_options {
 	int key_only;
 	int value_only;
 	const struct strbuf *separator;
+	const struct strbuf *key_value_separator;
 	int (*filter)(const struct strbuf *, void *);
 	void *filter_data;
 };
-- 
2.29.2.222.g5d2a92d10f8

