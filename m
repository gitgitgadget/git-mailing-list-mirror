Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C53C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJLNwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJLNwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:52:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4FCD5D3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so13596910wrb.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BuWtt731hYxc+21YZv1Oh27qLFhiG6Rg/CdXLit2ck=;
        b=PlJ1LdogroCQ08TbNp2zJfsA90Ic3HcIwcR0aCzmNfeyi7NoJsL8jpYljvm3vLnGfo
         5fEYE59RgyXVJW7fjQ2DsO6rePvryKKFbTGAbwcoi5IK3/gyyUubruFeUqGSh5tLQnBj
         s4kx3c6gU5BOWoobOCE1DzHh2L3Ozxe21gcN44Ggrp8bpUxV9E32JxeLIeCxUlqYCUIu
         GjE652KJAA+s7fC9I14erayq76pfDOOxC+fd8E3EztKp0Y7I53o4IkIgsP+mZMYk+BmS
         pnK/6SgIH6cMefGUgyfU8rh7vQeIlToccN98J5XNyEYtw62e9RFl3PFclLmxnSdHpPL+
         FGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BuWtt731hYxc+21YZv1Oh27qLFhiG6Rg/CdXLit2ck=;
        b=EMF2iJh0MG2Y3qRtmbEw5bmvA6W7XpTiww+uhyW21YrjWav1aY6vT38WkTuBVHaxg2
         AzkvRCiMoaHYyV1umQmh1fH9DqbhQuKnLoT1dNUjHBr2ApMrRJrHrxF8Pe/5IOnyh3w7
         F9N/1cNKot9e3v4Y+xMlJhpdSrs6Yre5+yUXYVi2UrrlfXSyt2DqV6f9M4figPR861li
         PkF3EGcREd6EnwcGflZViXeOPVeUjV0ZgeVxkJTzCsB313ec0tHTBiLfMMhnSzMVY+h3
         YXFIq2fhkKo8hbEWMZ5gwDn0PLDydornjOMiCA9JmYMnNjXrsL6iZUXPlKnQXMAx3jQz
         aCiw==
X-Gm-Message-State: ACrzQf1XIx3GSpd7gmFHyea0N41lr5hmTMLKbj6EMVyKEeEXcBw3sNPD
        GfYVsRlcQ6v7P1V7rCdA5QfMhVbluSY=
X-Google-Smtp-Source: AMsMyM67Kt3NXOxR9a8JJZZSrrvMgtvcDyUmiZTHQC0bZ3XGBvXiqDNsbBPPnFYbdwYwKPHIJ4CiUg==
X-Received: by 2002:a05:6000:1002:b0:22e:131c:4249 with SMTP id a2-20020a056000100200b0022e131c4249mr19649175wrx.50.1665582737479;
        Wed, 12 Oct 2022 06:52:17 -0700 (PDT)
Received: from Precision-5550.. ([2a01:e0a:595:6400::ae22:851d])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0022f40a2d06esm11396284wrh.35.2022.10.12.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:52:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] repack: introduce --force to force filtering
Date:   Wed, 12 Oct 2022 15:51:14 +0200
Message-Id: <20221012135114.294680-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.0.4.g7f9724c7bf.dirty
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit introduced --filter=<filter-spec>, but disallowed it
when stdin doesn't refer to a terminal, and asked the user when it does
refer to a terminal. This is because this option is dangerous as it
could lose data and corrupt the repo.

In some cases people might want to run this command automatically when
stdin desn't refer to a terminal or when no question should be asked.
Let's introduce --force for this purpose.

Unfortunately, we cannot use OPT__FORCE() to implement this because -f is
already a repack option (to pass --no-reuse-delta to git-pack-objects),
so we use OPT_BOOL() instead.

This is also a good time to test that --filter works properly as it
wasn't done in the previous commit that introduced --filter.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt | 12 +++++++++++-
 builtin/repack.c             |  7 +++++--
 t/t7700-repack.sh            | 15 +++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 230f176e10..574f569fbe 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -142,7 +142,17 @@ depth is 4095.
 	packfile. WARNING: this could easily corrupt the current repo
 	and lose data if ANY of the omitted objects hasn't been
 	already pushed to a remote. See linkgit:git-rev-list[1] for
-	valid `<filter-spec>` forms.
+	valid `<filter-spec>` forms. See also `--force` option below.
+
+--force::
+	By default when using `--filter=<filter-spec>` and stdin
+	refers to a terminal, the user will be warned and asked if the
+	filtering repack should really be launched. This tries to
+	avoid possible data loss and repo corruption. See `--filter`
+	option above. If stdin doesn't refer to a terminal, the repack
+	is aborted. `--force` allows the repack to go on anyway when
+	stdin doesn't refer to a terminal or when no question should
+	be asked.
 
 -b::
 --write-bitmap-index::
diff --git a/builtin/repack.c b/builtin/repack.c
index 0a93f38da4..3660dbb7a7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -56,6 +56,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int force;
 };
 
 static int repack_config(const char *var, const char *value, void *cb)
@@ -793,6 +794,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
 				N_("object filtering")),
+		OPT_BOOL(0, "force", &po_args.force,
+				N_("force object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -825,12 +828,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
 	}
 
-	if (po_args.filter) {
+	if (po_args.filter && !po_args.force) {
 		const char *yesno;
 
 		if (!isatty(STDIN_FILENO))
 			die (_("Repacking with a filter is not allowed "
-			       "yet unless a terminal is used!"));
+			       "unless a terminal is used or --force is passed!"));
 
 		/*
 		 * TRANSLATORS: Make sure to include [y] and [N] in your translation.
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f8764d1dd9..20727112b5 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -242,6 +242,21 @@ test_expect_success 'repacking with a filter is not allowed' '
 	test_i18ngrep "Repacking with a filter is not allowed" actual
 '
 
+test_expect_success 'repacking with a filter works when --force is passed' '
+	test_when_finished "rm -rf server client" &&
+	test_create_repo server &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true &&
+	test_commit -C server 1 &&
+	git clone --bare --no-local server client &&
+	git -C client config remote.origin.promisor true &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 0 &&
+	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none --force &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 1
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.38.0.4.g7f9724c7bf.dirty

