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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C8C49EA2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0382D61001
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFUPGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFUPF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:05:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971DC06175F
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so203680wmb.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvmOoU+qw5MfjxE3Ker/KbH+PChm0hEdKygxZukDSv8=;
        b=AD6N0kZKNbjUx+Ktgiz0OAM1HVa28dxxOhpDkrJdigtTQizkZSQtno5fzf7w1BAS77
         U1G7lKxAzvde0F4O23JngpZc1XA2pU2xG9UFAp1H3suoQYkQ83s6BN8l6SnPuNJo3xeW
         lDK/Mu5ko+nBm6s6nHbc97ObhVHVGy7hWdPA9rteJceHSd6eY18azyIw9+/penonEBzH
         SvOgYDuTseYEdILa+0UqDWqdZJp+BwcGw3P4G1Uw2guwD4Y0KdM3JHtCnRHW5hkTNEsx
         1U9tGDFyCn8hKWQjEAXnpVN+rSKPzP1GZ2Do9QWvG2ABcd5ueSB+dCBWeNi/WWuwFfJ8
         tZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvmOoU+qw5MfjxE3Ker/KbH+PChm0hEdKygxZukDSv8=;
        b=o1/gI4CXzR2IuUXyNlwLiN/zbsDLCnjnwSSKXgjGXK38j+N1lUfe8/bT7VdzVxYNVR
         OK79emhhF62vA4MQOKPuv22umOIl0oOH7eozu4g9o9UjLf3zKCZnGTKG2uv+N5eMcyXQ
         cFQMR2Lwf7ZYzDDFP+d9xybejUcrdTCqq9z660ABX0jRV4apGyXFvPRpyUxeUU6B905o
         F/Z+mmGLSUC2nPufrmeBXVehcpFHreNqFbsa2jJMBz+TkrBqV3r6dIeNNsWWHu6ooKmB
         uG8l/Y7cGTPaMdwMlsUllD7aEJQBWEWjKw+yllD3oAG7zS9W1lD3B7xnkAHKKR+ou0vQ
         3SMw==
X-Gm-Message-State: AOAM531iG2A/BTZHXtC1WVhOtD2m9TuNAfYX974nrYJyvwF5EG7+I/fs
        MHBrAyMHiWLAGnaYQFsPw923dXqsKlULxw==
X-Google-Smtp-Source: ABdhPJxhoy4IhwCyeXTCsNBXF5qSTTiXebGiXnIIpOZdkPVeotQ1o7tcFy6kkbDhQxMShcLyN6O76w==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr16073184wmi.77.1624287821990;
        Mon, 21 Jun 2021 08:03:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y4sm11931939wrw.71.2021.06.21.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:03:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] pack-objects: fix segfault in --stdin-packs option
Date:   Mon, 21 Jun 2021 17:03:38 +0200
Message-Id: <patch-2.2-a9702132385-20210621T145819Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in the --stdin-packs option added in
339bce27f4f (builtin/pack-objects.c: add '--stdin-packs' option,
2021-02-22). The read_packs_list_from_stdin() function didn't check
that the lines it was reading were valid packs, and thus when doing
the QSORT() with pack_mtime_cmp() we'd have a NULL "util" field.

The logic error was in assuming that we could iterate all packs and
annotate the excluded and included packs we got, as opposed to
checking the lines we got on stdin. There was a check for excluded
packs, but included packs were simply assumed to be valid.

As noted in the test we'll not report the first bad line, but whatever
line sorted first according to the string-list.c API. In this case I
think that's fine.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 10 ++++++++++
 t/t5300-pack-object.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e0..65579e09fe0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3310,6 +3310,16 @@ static void read_packs_list_from_stdin(void)
 			item->util = p;
 	}
 
+	/*
+	 * Arguments we got on stdin may not even be packs. Check that
+	 * to avoid segfaulting later on in e.g. pack_mtime_cmp().
+	 */
+	for_each_string_list_item(item, &include_packs) {
+		struct packed_git *p = item->util;
+		if (!p)
+			die(_("could not find pack '%s'"), item->string);
+	}
+
 	/*
 	 * First handle all of the excluded packs, marking them as kept in-core
 	 * so that later calls to add_object_entry() discards any objects that
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 65e991e3706..330deec656b 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -119,6 +119,24 @@ test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
 	test_cmp err.expect err.actual
 '
 
+test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage' '
+	cat >in <<-EOF &&
+	$(git -C pack-object-stdin rev-parse one)
+	$(git -C pack-object-stdin rev-parse two)
+	EOF
+
+	# We actually just report the first bad line in strcmp()
+	# order, it just so happens that we get the same result under
+	# SHA-1 and SHA-256 here. It does not really matter that we
+	# report the first bad item in this obscure case, so this
+	# oddity of the test is OK.
+	cat >err.expect <<-EOF &&
+	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
+	EOF
+	test_must_fail git -C pack-object-stdin pack-objects stdin-with-stdin-option --stdin-packs <in 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 # usage: check_deltas <stderr_from_pack_objects> <cmp_op> <nr_deltas>
 # e.g.: check_deltas stderr -gt 0
 check_deltas() {
-- 
2.32.0.599.g3967b4fa4ac

