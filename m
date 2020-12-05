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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9413AC4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5814322DD6
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgLEBkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgLEBkW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:40:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CBC061A52
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:39:41 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so7033558wrw.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DaTQP0Z0JGsTczGKHG+8I9GArkW8zPVJLqwl99ke6w=;
        b=GpKT8zGK689OFQbhmnxEcayQgHDD+nTPu4dmdBmq+8HwJpxoN6aJ12S8XK8/QcF54S
         TnGgho5Fc0rzHmi/3YdxR2uinw47joavFUP/QwC2FnJ6d5qC99NGBzglYGh2lDYlEWQM
         fIGK8M8PxJ74r6fncnZmrfB3BZFUoiHhAMqB1ox8oop46rLGF+dsw5s45n3GW2V4VdH0
         NlvjXDU6hPssVULsfkYT7GFcY6mP7rHVnA7WUW2EEst/mSvlXBlXxJDOx0mNVMH7U3OZ
         GID9tI7lPx2zINTah0Elf+Gw4Pibnyna+e2ULNgeiReg6L/rSzRGEeTFc+iusWae0e5y
         YCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DaTQP0Z0JGsTczGKHG+8I9GArkW8zPVJLqwl99ke6w=;
        b=Gt1cd+8hgSngfsS5kxSprsXGIj+QIp3a/L7WD3L8US1FbuvsdsumtEcyxa/3jy3nhv
         D5CWLfeSILdrHraT0MxlD/1+E0ioojltAymMQezMQZ95/itIcBZ2dlNMSw5KmJ32/Uzn
         FeAJ8YZK4V+m5oaKjTA0JLceBS2n0eDmgZEeuvNNGME3540hTa5lcfq5sHTjIEYL+/GD
         bHxV4Ux9QkIJ+7JpNF0NvWnp9ofPusuYIfzLP406fooJwlPexwjECjIwBtC7d8Mfr4qo
         kLqJ08PSLrfj1f+dC+aNuIouof9hTi1Ht3C4nM1iV3bGBCaxu3tjtCRiPc08eM5k5y//
         VgSg==
X-Gm-Message-State: AOAM530ELeYIlRuWol5fgA3FjhIyDbU/QfPqSi8k/82DNyJpsIhdU53T
        srHIqNPyq40CV+RUhqS5wYi9w3RfK3+ezg==
X-Google-Smtp-Source: ABdhPJxAvueI8oqmDftUaPYUOAE7ao7D4wwYo5byEfYYg39bcMWh5knKv0gHBA3SpAyaCe6uik7Ong==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr7949776wrr.6.1607132379996;
        Fri, 04 Dec 2020 17:39:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a1sm5537821wrv.61.2020.12.04.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:39:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] pretty format %(trailers): add a "keyonly"
Date:   Sat,  5 Dec 2020 02:39:16 +0100
Message-Id: <20201205013918.18981-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for a "keyonly". This allows for easier parsing out of the
key and value. Before if you didn't want to make assumptions about how
the key was formatted. You'd need to parse it out as e.g.:

    --pretty=format:'%H%x00%(trailers:separator=%x00%x00)' \
                       '%x00%(trailers:separator=%x00%x00,valueonly)'

And then proceed to deduce keys by looking at those two and
subtracting the value plus the hardcoded ": " separator from the
non-valueonly %(trailers) line. Now it's possible to simply do:

    --pretty=format:'%H%x00%(trailers:separator=%x00%x00,keyonly)' \
                    '%x00%(trailers:separator=%x00%x00,valueonly)'

Which at least reduces it to a state machine where you get N keys and
correlate them with N values. Even better would be to have a way to
change the ": " delimiter to something easily machine-readable (a key
might contain ": " too). A follow-up change will add support for that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt |  4 ++--
 pretty.c                         |  1 +
 t/t4205-log-pretty-formats.sh    | 31 ++++++++++++++++++++++++++++++-
 trailer.c                        |  7 +++++--
 trailer.h                        |  2 ++
 5 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8e066594624..d080f0d2476 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -284,8 +284,8 @@ multiple times the last occurance wins.
 ** 'unfold[=bool]': make it behave as if interpret-trailer's `--unfold`
    option was given. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'valueonly[=bool]': skip over the key part of the trailer line and only
-   show the value part.
+** 'keyonly[=bool]': only show the key part of the trailer.
+** 'valueonly[=bool]': only show the value part of the trailer.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 3c374abffe5..590f37489f6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1454,6 +1454,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.separator = &sepbuf;
 				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
 					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
+					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
 					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
 					break;
 			}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index bf9b30ff3d6..5dd080c19b2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -715,12 +715,34 @@ test_expect_success '%(trailers:key) without value is error' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,keyonly) shows only keys' '
+	git log --no-walk --pretty="format:%(trailers:keyonly)" >actual &&
+	test_write_lines \
+		"Signed-off-by" \
+		"Acked-by" \
+		"[ v2 updated patch description ]" \
+		"Signed-off-by" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo,keyonly) shows only key' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,keyonly)" >actual &&
+	echo "Acked-by" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 	git log --no-walk --pretty="format:%(trailers:key=Acked-by,valueonly)" >actual &&
 	echo "A U Thor <author@example.com>" >expect &&
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,keyonly,valueonly) shows nothing' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,keyonly,valueonly)" >actual &&
+	echo >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
 	(
@@ -732,7 +754,7 @@ test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	test_cmp expect actual
 '
 
-test_expect_success 'pretty format %(trailers) combining separator/key/valueonly' '
+test_expect_success 'pretty format %(trailers) combining separator/key/keyonly/valueonly' '
 	git commit --allow-empty -F - <<-\EOF &&
 	Important fix
 
@@ -759,6 +781,13 @@ test_expect_success 'pretty format %(trailers) combining separator/key/valueonly
 		"Does not close any tickets" \
 		"Another fix #567, #890" \
 		"Important fix #1234" >expect &&
+	test_cmp expect actual &&
+
+	git log --pretty="%s% (trailers:separator=%x2c%x20,key=Closes,keyonly)" HEAD~3.. >actual &&
+	test_write_lines \
+		"Does not close any tickets" \
+		"Another fix Closes, Closes" \
+		"Important fix Closes" >expect &&
 	test_cmp expect actual
 '
 
diff --git a/trailer.c b/trailer.c
index b00b35ea0eb..40f31e4dfc2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1233,8 +1233,11 @@ static void format_trailer_info(struct strbuf *out,
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
-					strbuf_addf(out, "%s: ", tok.buf);
-				strbuf_addbuf(out, &val);
+					strbuf_addstr(out, tok.buf);
+				if (!opts->key_only && !opts->value_only)
+					strbuf_addstr(out, ": ");
+				if (!opts->key_only)
+					strbuf_addbuf(out, &val);
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
diff --git a/trailer.h b/trailer.h
index aad856da8c1..d4507b4ef2a 100644
--- a/trailer.h
+++ b/trailer.h
@@ -71,9 +71,11 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int key_only;
 	int value_only;
 	int canonicalize;
 	const struct strbuf *separator;
+	const struct strbuf *key_value_separator;
 	int (*filter)(const struct strbuf *, const char *alias, void *);
 	void *filter_data;
 };
-- 
2.29.2.222.g5d2a92d10f8

