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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA2BC19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0989922B47
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgLIPxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgLIPxL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:11 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F0C0617A7
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:31 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c1so2262460wrq.6
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH5bBPflncyWNKOpDQX12xOZqdS8ce/QX1r0FM/M65U=;
        b=C+AMzhsOaBwxU3g5zRvXnm7tZStTFYkoGZ0dAXz8ycZsFCg/bzbdfqRvKcPzrjvsQd
         2HJmgN5SMBccAsc7IM9/zzXPcBJOxbaI314jEmq0JdvYV932pB6XvVQDJij3R7PNkONS
         evGfDlZKDXn3X93/oBW8Bijtv55orHDu4PtvbiXVUGNitwMIauEi1BR6HeYRucJv0PBV
         9F2mrV8y3P9JE89h/eMA4ecTgkyLVcQ9JQKZRqoJLTH7L59UNdbz2AcXF5CfKwpUBAKl
         Nv2GHjoKpBt7B82OXowTt5nJdhTnVPH4+aAcHUj4Q9MZWLNl6LKvLiapXA4SghVeugRH
         7m7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH5bBPflncyWNKOpDQX12xOZqdS8ce/QX1r0FM/M65U=;
        b=itaSPHEvlM4+daVbFsSlqCd54CglEsc9a64vFUJVSk/elIpvNsY6k6M0df5K5J1h3O
         Y31+vQCmlthF3Tv7LAWrGoGiJyWSAJ01njoGwODZ5SP7DSKuB6dQ7I5N0hhwtgeY8+/P
         u99Qc9XI2YslhLe4MdwIrz1XEtLTHmZDebc9dB2xoAN+C8/f5qufHXgQ+783bsh5aG/F
         j+q0PdcS4Ti8d599EbBUlDtbbI1zN1Ishoh1YMNrfkbAMsMw+oTPaWYDc6EEMGOgwTzv
         UfD8nUX7KJG9vuovAIA0IVryL6fG6muCTYuSvkvCRS3ontxdm8s+fOAIN4R6yYULrGc6
         V4vw==
X-Gm-Message-State: AOAM531LZmcgwyygwr9FgbpcOZbvY3ON57nbWqge2F+vG3bJmRFfzQGF
        RQ7HzTB79xuXqdX1CZgQeXydeOw3SBmYqg==
X-Google-Smtp-Source: ABdhPJx9fOS2qK2RQq6J2YnPIWpUCb75F0chNhDZi7KU4O1kCh2czS9dvj5ZlPQFWauj40Rw6WMvZg==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr3374799wrn.392.1607529150103;
        Wed, 09 Dec 2020 07:52:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/5] pretty format %(trailers): add a "keyonly"
Date:   Wed,  9 Dec 2020 16:52:07 +0100
Message-Id: <20201209155208.17782-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
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

I don't really have a use-case for just "keyonly" myself. I suppose it
would be useful in some cases as "key=*" matches case-insensitively,
so a plain "keyonly" will give you the variants of the keys you
matched. I'm mainly adding it to fix the inconsistency with
"valueonly".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pretty-formats.txt |  4 ++--
 pretty.c                         |  1 +
 t/t4205-log-pretty-formats.sh    | 31 ++++++++++++++++++++++++++++++-
 trailer.c                        |  9 ++++++---
 trailer.h                        |  1 +
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 973b6c7d482..5eac36500d4 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -282,8 +282,8 @@ option is given with no value, it's enabled.
 ** 'unfold[=<BOOL>]': make it behave as if interpret-trailer's `--unfold`
    option was given. E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
-** 'valueonly[=<BOOL>]': skip over the key part of the trailer line and only
-   show the value part.
+** 'keyonly[=<BOOL>]': only show the key part of the trailer.
+** 'valueonly[=<BOOL>]': only show the value part of the trailer.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 7a7708a0ea7..1237ee0e45d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1451,6 +1451,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					opts.separator = &sepbuf;
 				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
 					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
+					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
 					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
 					break;
 			}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cb09a13249e..4c9f6eb7946 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -715,6 +715,22 @@ test_expect_success '%(trailers:key) without value is error' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:keyonly) shows only keys' '
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
@@ -732,6 +748,12 @@ test_expect_success '%(trailers:valueonly) shows only values' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:key=foo,keyonly,valueonly) shows nothing' '
+	git log --no-walk --pretty="format:%(trailers:key=Acked-by,keyonly,valueonly)" >actual &&
+	echo >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00)X" >actual &&
 	(
@@ -754,7 +776,7 @@ test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
 	test_cmp expect actual
 '
 
-test_expect_success 'pretty format %(trailers) combining separator/key/valueonly' '
+test_expect_success 'pretty format %(trailers) combining separator/key/keyonly/valueonly' '
 	git commit --allow-empty -F - <<-\EOF &&
 	Important fix
 
@@ -781,6 +803,13 @@ test_expect_success 'pretty format %(trailers) combining separator/key/valueonly
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
index d2d01015b1d..889b419a4f6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1132,7 +1132,7 @@ static void format_trailer_info(struct strbuf *out,
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->value_only) {
+	    !opts->separator && !opts->key_only && !opts->value_only) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
@@ -1154,8 +1154,11 @@ static void format_trailer_info(struct strbuf *out,
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
-					strbuf_addf(out, "%s: ", tok.buf);
-				strbuf_addbuf(out, &val);
+					strbuf_addbuf(out, &tok);
+				if (!opts->key_only && !opts->value_only)
+					strbuf_addstr(out, ": ");
+				if (!opts->key_only)
+					strbuf_addbuf(out, &val);
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
diff --git a/trailer.h b/trailer.h
index cd93e7ddea7..d2f28776be6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -71,6 +71,7 @@ struct process_trailer_options {
 	int only_input;
 	int unfold;
 	int no_divider;
+	int key_only;
 	int value_only;
 	const struct strbuf *separator;
 	int (*filter)(const struct strbuf *, void *);
-- 
2.29.2.222.g5d2a92d10f8

