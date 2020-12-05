Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECBC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAAB22DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgLEBk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEBk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:40:59 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C05C061A54
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:39:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so7007170wrm.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZyXsgKx2aZYWJ7N8061TWROG8vMVEfxs/GSrHNkh0o=;
        b=EG56rqbRgqEaAJ6igBTZ+kadKZ5bv4/Bm9/pJ+PQTW5iXpo62h5CQhNqQLpO5GrROw
         2+puXW9QSXBkUsFEc+WUqkAePeC1URGJYQMRVE5bkjckS4ZzVsWOCiEE7uQbxNsG9AP4
         LiZoXbFACwmz1PPw2H0NuujzBsmM6gjGcy+x4UI+3GKjewl5XuVwvl6JdXTCPO/gIhjs
         f0DvimpYDIL28pvjkjQRd3y8zkwbakN8B8FAU4TJimvdrbJDQz8O0gzHRzeQZtKnB7dn
         d3LehAdeZfElp7zjwrR+pu7ny7ctWfF84oZ6jq0OfhL/tgmJUjigRtm9hzTgCZH4CkRw
         OelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZyXsgKx2aZYWJ7N8061TWROG8vMVEfxs/GSrHNkh0o=;
        b=QzP/aGUsyPK9cCzpvDuhm7ayfatJ2cRXIIBjQ63U2FC75pGcFNBlsijckjLW9U/nB/
         23oATJNIL1HMRWuD6VuEkCzksy8f2by3wQPqNdRS1dpFjdyOgkgAl2TK0OWJzQaVqK4C
         FuzBcVh4A29B9IJtfDjNBqlQ0BjhK/SYxnfcNxxsrl92Whf9p+RFTCkcGs8HFQTJlzKn
         PMzAIJ/5CeIIkLuj6qC1MKgYHOeM+05GHgi4m4m1oY6RcOannQNy2UXWD1HANyUs1/ma
         ZBPofecKCiOkxxnG6dkwmHiEG2BVpteRQ8voZ2ssn1tR7ddUrr3AK4P/EtruJ3/o9viQ
         tNDw==
X-Gm-Message-State: AOAM530l2gJpdPPYuiurUjWMf5KFd8cpaItcFiuFfKmtpqvN2cqIQ1WS
        68TDezJ9gmogSphJWhHYvg7TV5O9kVlmLQ==
X-Google-Smtp-Source: ABdhPJy+w+RGjY/l2FWxUdFsaiSM/QNK6ULwMmLq36WoxePYL/v0Ma0AkqgYnyyGRm+YAUXYc9SR2w==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr8039294wrv.170.1607132382430;
        Fri, 04 Dec 2020 17:39:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a1sm5537821wrv.61.2020.12.04.17.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:39:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] pretty format %(trailers): add a "key_value_separator"
Date:   Sat,  5 Dec 2020 02:39:18 +0100
Message-Id: <20201205013918.18981-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a previous commit which added "keyonly" it's needlessly
hard to use the "log" machinery to produce machine-readable output for
%(trailers). with the combination of the existing "separator" and this
new "key_value_separator" this becomes trivial, as seen by the test
being added here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt |  4 ++++
 pretty.c                         |  9 +++++++++
 t/t4205-log-pretty-formats.sh    | 22 ++++++++++++++++++++++
 trailer.c                        |  8 ++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d080f0d2476..369d243eae9 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -286,6 +286,10 @@ multiple times the last occurance wins.
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=bool]': only show the key part of the trailer.
 ** 'valueonly[=bool]': only show the value part of the trailer.
+** 'key_value_separator=<SEP>': specify a separator inserted between
+   trailer lines. When this option is not given each trailer key-value
+   pair separated by ": ". Otherwise it shares the same semantics as 
+   'separator=<SEP>' above.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index d989a6ae712..dea77f2621a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1421,6 +1421,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
 		struct strbuf sepbuf = STRBUF_INIT;
+		struct strbuf kvsepbuf = STRBUF_INIT;
 		size_t ret = 0;
 
 		opts.no_divider = 1;
@@ -1454,6 +1455,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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
index e1100082b34..47b3f7d67c4 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -765,6 +765,28 @@ test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
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
index da95e1f3c66..70a560647c1 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1233,8 +1233,12 @@ static void format_trailer_info(struct strbuf *out,
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
 					strbuf_addstr(out, tok.buf);
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
-- 
2.29.2.222.g5d2a92d10f8

