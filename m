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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3276CC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0B722B47
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgLIPxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgLIPxK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:10 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041ABC0617A6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e25so2185791wme.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4qj8uKOjVNvuGI4EuAJXJRGBvpZoYBsOgGr/HA52zs=;
        b=IelZhEO3eG+fGeBTxH1AFBESE77tJnWo4eqfzhFW1bBldNbI/o+KS2ac/gtfEp5yEe
         0SE0VGXy/LaSj3d0AkCVtcOSd2FPtLUl0MIxQ0glxF06qJ132MItUdIP2Ijv5EVo0kfA
         ysf1BKDlI/dW8fI70RGxApKYCq3U61wVKl29f4BscxN/SbvmVIuMNrw14PxySVN9VmpB
         4kOS97TzMt4MtTRockUttMRtDrv/XkCo/+dxyakEy1kHqF7V4sQijKICgd6s79aVGXYf
         MMBLDsrxIt8XaC9X+1FtBkxrzRV1uiiuqhQkyN8kBEmGxG5Wm4XKeKF2aNxsp7mJr7ux
         Iayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4qj8uKOjVNvuGI4EuAJXJRGBvpZoYBsOgGr/HA52zs=;
        b=P+2lOHiAwsurbZjRdQy4iCM4zXtM//oJ2rhx5qsr+EbPAIvT6CH8ul2NSEJS+p0i9w
         1m8qoaZ34bZ1+Z/HfOnkNcSNRdX7ss4pC0+1k+KoErUns653e/FEnM3VMZWHuBU8hEmP
         sQ7GrK03A0WFUE7t4kpk5a1FrEH/OKddu1iA/8AV7ZyFJbzN/mqnKPvda1jfKqDMIykn
         xuR6OTHl+5xe6Qxco14RdyzXfKfP6F+BhIm6AltSfx81wMPOJ7ndq8ZcxLosYS9mkXPj
         xjESVVIOZjF6GncESzzgipjxOCo75AotThtbYl1xo4KO++EUxi+MEEHu8C2iEsH178Jg
         YM5A==
X-Gm-Message-State: AOAM532Vgm/lwX0NxdOZwPNVnfiRzhG3nbcoW/IOlXn7BbsviobUPvBb
        BeCOJLjMFA8FZpZtFXIbbMKBjCLI/DwQ6w==
X-Google-Smtp-Source: ABdhPJz34irDYUoacCyU4yVuPAGHTgKN0j/0KO4XogpkwbMenNRBAD9TawH2i9wh1VwDM4yVm3/cVw==
X-Received: by 2002:a1c:2c83:: with SMTP id s125mr3435420wms.161.1607529148749;
        Wed, 09 Dec 2020 07:52:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] pretty-format %(trailers): fix broken standalone "valueonly"
Date:   Wed,  9 Dec 2020 16:52:06 +0100
Message-Id: <20201209155208.17782-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
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

