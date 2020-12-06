Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EEDC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFB92313C
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgLFA0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFA0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 19:26:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677ADC061A52
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 16:25:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so10281914wmb.5
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 16:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTHFbVhDUv8EEB8HBCWBSFcFYN0XzA830DgCaKJ54LU=;
        b=fghb5tmFVQbSkCBPkvghbdv7+1W3BUHDQxw1wDywWFLBEKUq/JB7XSRamKpjUBrVUF
         8tCT3qRxq3lv0JKn9WdId7csamUlFCr4Z4uP5pgGHZ0m0DI3A5jxudyE9ZrDPaep5SGq
         cJ5H3SSs5PkPwlq41KZ8M5tmqMeAxGzEVSa0M7jsN9puJdgKBt/2TNTipOm/3/R+MZjE
         mYZVJ7yay5q01D3OkYnNP7bu43beUwI1jmIR3pQKx3k/kItq9SQAIEE2wBzBksxxOWPS
         vJMWXclrZZ0qxU2n5LikaweHHD4mAzvXETIuQYkex2kOyHWsOeOKiJdIJEgNOOuK2O5j
         5ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTHFbVhDUv8EEB8HBCWBSFcFYN0XzA830DgCaKJ54LU=;
        b=djdHjBvh8NitTF39fvSNhzMVtdlaEktsfbsp19blg1657VwXN7JOxIFbR5qwBicBUG
         WCrGjgWTP0r+pqS72e0IlewOLdSW2U4BwaUR2iX080v9fjtAieOwiW92beDBqAt4GgeS
         wMnYMjtkxHJA7o0cQ3LPEUedju14ey94/Ey9t6qdJjsEE57aXVDLJK6r0+Qmrc8JO2us
         4jS85HkZFlCtu0r81zX4SIq/wvAhOvvsbe1ZM0RNkOCiAeZUqLSQKS7RmTkDxCSBn847
         PRp1mdVXWvf+y/RPpJyTk02mwLvhGSqzzbKcF09PgnvCqHto1z3bNcEThietS8eLzQob
         dWaQ==
X-Gm-Message-State: AOAM5333jGdWT2iqc2xquZoV+88j87hVAy0Znnn44mhwC2MdxSnPpZ7v
        sErI+HsyAeY9wpp3mbl/yQgDWktlGxK5Yg==
X-Google-Smtp-Source: ABdhPJzmx9K0jYrBAvoxX2b1IL8KmHQJ9gVjNP+fOrjsrDIP5zbTqCixqvtBQIHAoLl98iyV3KnGsA==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr11406250wmf.59.1607214309802;
        Sat, 05 Dec 2020 16:25:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm9144338wrh.78.2020.12.05.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:25:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] pretty format %(trailers): add a "key_value_separator"
Date:   Sun,  6 Dec 2020 01:24:49 +0100
Message-Id: <20201206002449.31452-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201205013918.18981-1-avarab@gmail.com>
References: <20201205013918.18981-1-avarab@gmail.com>
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
index bf35f7cf219..17050a78245 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -284,6 +284,10 @@ option is given with no value, it's enabled.
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=BOOL]': only show the key part of the trailer.
 ** 'valueonly[=BOOL]': only show the value part of the trailer.
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

