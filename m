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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1077C0018C
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7707923100
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgLEBkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgLEBkX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:40:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1BC061A53
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:39:42 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so8598073wmb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CduL7JHxRS2/Vst2oCsNVDnmnVm/aVb+SN0eYd+gP3o=;
        b=kBP3Ig/5QmfrcKYAt8ImyK+LYNZd6JWDdiGkO7eDbHGuL1n98kokqi0xPcXMCxlPgZ
         Ub+NNMru0830L8dOWqCAguBasXfsaI/A+jjoObG2wYCtqmip4qvsWvP+qdSVmgcAoVlh
         tCB8SUBY27Il5tcyXE8F+xUlTJ6qTcB8q5YqMhxVfHPxGDI0BpamsXum/Ubeo1fIIkS1
         csSx26Emih4f0qofIJCV+B+8LxciUMKDOGJOw/iJCO4n38ZGw8vZXaTgxn9z+iACAlbC
         QWZm4mPsgZPXOzaxknZBFkV3w2nKX69OCho7uQF23C1jR0zA5tAjV/K+sVAClP9xukz2
         6VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CduL7JHxRS2/Vst2oCsNVDnmnVm/aVb+SN0eYd+gP3o=;
        b=Lh12gk4YNF5nJAoo5kWjl3LcsgjUdLfaMFwWP9pl4tel8VMsEgx4mAfXkCKXq4VxhL
         ywibYYJkLAbCgTCSvfdQZ4PqNOIov/6AwaBE20L7ZOcMB1qrq179EPLff6EcaXg2b1zf
         EKjHevvTltUyFtExolvJXg7vzGbCD5/IXnyNT9fao6lAwbBkj5ivxoPkANSGxzAoiruD
         6ULOTFT8gnKEWGmGOQnm3NjDnRNYgKD1GHfsdqO+1+jD7lGUXuKLEIt8AGFa7Gz3IHJs
         TCSm7ztgSg6yyZbwcJ1chOax2Kcgj9DjKe3BBCinfSXFA37MG8atwQCOLzbChgz4LNpG
         c79A==
X-Gm-Message-State: AOAM530Ef/vTK6IPL4PYlF7JN4NFm6/wRNPEfoxPuByKrQuC3ygXS73+
        LgRu/nISW52IHsGMLYKpL7FaXzMMcww/7A==
X-Google-Smtp-Source: ABdhPJyzbaPbAGYxN/O1Xb9pdTIuSH6nOH+1/ee0AeZdHDU1GIO8oJ4DIV/6EdiHgDCa26dIOsvjIA==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr6804824wmh.141.1607132381208;
        Fri, 04 Dec 2020 17:39:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a1sm5537821wrv.61.2020.12.04.17.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:39:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] pretty-format %(trailers): fix broken standalone "valueonly"
Date:   Sat,  5 Dec 2020 02:39:17 +0100
Message-Id: <20201205013918.18981-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix %(trailers:valueonly) being a noop due to on overly eager
optimization. When new trailer options were added they needed to be
listed at the start of the format_trailer_info() function. E.g. as was
done in 250bea0c165 (pretty: allow showing specific trailers,
2019-01-28).

When d9b936db522 (pretty: add support for "valueonly" option in
%(trailers), 2019-01-28) was added this was omitted by mistake. Thus
%(trailers:valueonly) was a noop, instead of showing only trailer
value. This wasn't caught because the tests for it always combined it
with other options.

Let's fix the bug, and switch away from this pattern requiring us to
remember to add new flags to the start of the function. Instead as
soon as we see the ":" in "%(trailers:" we skip the fast path. That
over-matches for "%(trailers:)", but I think that's OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pretty.c                      |  2 ++
 t/t4205-log-pretty-formats.sh | 11 +++++++++++
 trailer.c                     |  3 +--
 trailer.h                     |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index 590f37489f6..d989a6ae712 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1426,6 +1426,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		opts.no_divider = 1;
 
 		if (*arg == ':') {
+			/* over-matches on %(trailers:), but that's OK */
+			opts.have_options = 1;
 			arg++;
 			for (;;) {
 				const char *argval;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5dd080c19b2..e1100082b34 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -737,6 +737,17 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
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
 test_expect_success '%(trailers:key=foo,keyonly,valueonly) shows nothing' '
 	git log --no-walk --pretty="format:%(trailers:key=Acked-by,keyonly,valueonly)" >actual &&
 	echo >expect &&
diff --git a/trailer.c b/trailer.c
index 40f31e4dfc2..da95e1f3c66 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1206,8 +1206,7 @@ static void format_trailer_info(struct strbuf *out,
 	size_t origlen = out->len;
 	size_t i;
 
-	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter && !opts->separator) {
+	if (!opts->have_options) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
diff --git a/trailer.h b/trailer.h
index d4507b4ef2a..e348c970ce7 100644
--- a/trailer.h
+++ b/trailer.h
@@ -65,6 +65,7 @@ struct new_trailer_item {
 };
 
 struct process_trailer_options {
+	int have_options;
 	int in_place;
 	int trim_empty;
 	int only_trailers;
-- 
2.29.2.222.g5d2a92d10f8

