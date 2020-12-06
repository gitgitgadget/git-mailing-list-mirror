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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A639C193FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF33B2313F
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLFAZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLFAZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 19:25:55 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6BAC061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 16:25:08 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so10302014wmf.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4qj8uKOjVNvuGI4EuAJXJRGBvpZoYBsOgGr/HA52zs=;
        b=OPGXlr87lBhAHxLoA7V3fzLcJSstbRv/Ym5avE1D3NR/3QdZZoQt9KCFgGEBT0HWoM
         43FpvuJ8raH6d3cNZnNbNeZD9yT10GGDzWc06Wu/bHeIzWFNGN6d/wV+l+yCoO8SeNSj
         u0O2zWLS0Qjkh3iCByT4M8T0XDCt45fCavhsR6j+D4HXC8xdLwYWEXy0uvUYsmTLiuRg
         wwt2mmAxWrefGoz6XTH+N1Ulnq88z0daZ1VhIDrH62xQQGTgvcZrHobpqBIG6yBTAqrF
         GmoaBd3KjiGBtu3rtavVzWYdl2+hveTa7gCgjXdqF2nFIXwFoiNXF77Ufk3bKMJMDk0p
         4c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4qj8uKOjVNvuGI4EuAJXJRGBvpZoYBsOgGr/HA52zs=;
        b=n7wr3Hx9LXfk9cdPpAfE5SPN50JxOT/WzKFL8gX13DNO1B3d2gATjMHsODeatyaG24
         ER3w+f+FiV88UNA/+u5mUElc5+IugSxpnUyAOxAU6aggg+L+OdDTtoXtdWrqQXvJ4yG2
         tyDapQAvtdy+9I5IfZou3yDW89X+wDJGoRKAGU+jIz4SSIsMuS+8ejqZ6Sn/bad83iZS
         yxsIznegCZ9xEdxfDFSckDT32PUgjq+UBux8nKZRtyNOQuik5OdNHIK8z280ekfhit+p
         B+oGEulAyix7/6bKFo/hSyTDnYhejLTCQiIb1a90xkeze/KQoMyDTuqQOGme4N34CnUV
         tqEQ==
X-Gm-Message-State: AOAM530i4OlcS2qvEm2nr1jiPtK633YA4PI33uoEImO4D5LqGfU3Tknr
        213utDIZdG6B1+oyVxrZZ5mFO98MPU4lCg==
X-Google-Smtp-Source: ABdhPJwAy2xuPiQOHmekbMSffVn8MQnTvThRiHy0octfaX2Tzuiy7z1bCRknGMJuuKzk+n8psD6uRg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr11204633wmj.170.1607214307419;
        Sat, 05 Dec 2020 16:25:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm9144338wrh.78.2020.12.05.16.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:25:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] pretty-format %(trailers): fix broken standalone "valueonly"
Date:   Sun,  6 Dec 2020 01:24:47 +0100
Message-Id: <20201206002449.31452-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201205013918.18981-1-avarab@gmail.com>
References: <20201205013918.18981-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix %(trailers:valueonly) being a noop due to on overly eager
optimization in format_trailer_info() which skips custom formatting if
no custom options are given.

When "valueonly" was added in d9b936db522 (pretty: add support for
"valueonly" option in %(trailers), 2019-01-28) we forgot to add it to
the list of options that optimization checks for. See e.g. the
addition of "key" in 250bea0c165 (pretty: allow showing specific
trailers, 2019-01-28) for a similar change where this wasn't missed.

Thus the "valueonly" option in "%(trailers:valueonly)" was a noop and
the output was equivalent to that of a plain "%(trailers)". This
wasn't caught because the tests for it always combined it with other
options.

Fix the bug by adding !opts->value_only to the list. I initially
attempted to make this more future-proof by setting a flag if we got
to ":" in "%(trailers:" in format_commit_one() in pretty.c. However,
"%(trailers:" is also parsed in trailers_atom_parser() in
ref-filter.c.

There is an outstanding patch[1] unify those two, and such a fix, or
other future-proofing, such as changing "process_trailer_options"
flags into a bitfield, would conflict with that effort. Let's instead
do the bare minimum here as this aspect of trailers is being actively
worked on by another series.

Let's also test for a plain "valueonly" without any other options, as
well as "separator". All the other existing options on the pretty.c
path had tests where they were the only option provided. I'm also
keeping a sanity test for "%(trailers:)" being the same as
"%(trailers)". There's no reason to suspect it wouldn't be in the
current implementation, but let's keep it in the interest of black box
testing.

1. https://lore.kernel.org/git/pull.726.git.1599335291.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 28 ++++++++++++++++++++++++++++
 trailer.c                     |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5e5452212d2..cb09a13249e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -605,6 +605,12 @@ test_expect_success 'pretty format %(trailers) shows trailers' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:) enables no options' '
+	git log --no-walk --pretty="%(trailers:)" >actual &&
+	# "expect" the same as the test above
+	test_cmp expect actual
+'
+
 test_expect_success '%(trailers:only) shows only "key: value" trailers' '
 	git log --no-walk --pretty="%(trailers:only)" >actual &&
 	{
@@ -715,7 +721,29 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(trailers:valueonly) shows only values' '
+	git log --no-walk --pretty="format:%(trailers:valueonly)" >actual &&
+	test_write_lines \
+		"A U Thor <author@example.com>" \
+		"A U Thor <author@example.com>" \
+		"[ v2 updated patch description ]" \
+		"A U Thor" \
+		"  <author@example.com>" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pretty format %(trailers:separator) changes separator' '
+	git log --no-walk --pretty=format:"X%(trailers:separator=%x00)X" >actual &&
+	(
+		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
+		printf "Acked-by: A U Thor <author@example.com>\0" &&
+		printf "[ v2 updated patch description ]\0" &&
+		printf "Signed-off-by: A U Thor\n  <author@example.com>X"
+	) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separator' '
 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
 	(
 		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
diff --git a/trailer.c b/trailer.c
index 3f7391d793c..d2d01015b1d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1131,7 +1131,8 @@ static void format_trailer_info(struct strbuf *out,
 	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter && !opts->separator) {
+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
+	    !opts->separator && !opts->value_only) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
-- 
2.29.2.222.g5d2a92d10f8

