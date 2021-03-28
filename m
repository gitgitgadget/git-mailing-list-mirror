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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB4C433F7
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8CF6196C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhC1NQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhC1NQK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46288C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so7487749wmq.1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyrEqDr1cbgxRGlepMxgPedJ6jhbIsGGF/CxDBIqJRI=;
        b=gk8DF54qa4nC8l8jYLlbZpVK5fN/3O1i9apx4mjVMVSHAkJedKMJa1Nf0y9xX+jnip
         unr/Wc24azof35fl08YUZmDrs+eXSVZHWWNXC6XkWbffAPEPcoW3bjrnRTMxGuGkU6Xp
         2m8dWyQ3oeeZxVRH0Cn9F6lfNF/jOlZWmB4zDdb39+63+YqOIYA9RSO+rmOV0hY8ydB9
         l+Wr3QYLEnZvVkORHlN5U42FkFbNhBl11t9oZIfBEKTsjX3+Ib0x4hmZy6BGEiTc+caR
         FFJXHE7DngCbwJ1x3pTEtupI3Yd67aHa5SFkWWd+vLDKChicCYjd/TTbyYdChMUqszJ1
         mKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyrEqDr1cbgxRGlepMxgPedJ6jhbIsGGF/CxDBIqJRI=;
        b=lnfKpswsdSy6nMtlnf0s/wnDikrzcEGSSg/wK4IXDQMsShrK0Kb7LmRW5JbyxeiOb7
         diGuaKVZxXIcr+z8621EBsghJm3/OYkvKq+FTVtLzdilwiPMPya5qJ2rGmIYmPkv/egR
         OsDcaB7p8qB0A8jMvm4MYJKe+Cf1FMnuQ8REFWVYUhdJgD2yaczDGT/qMyCPe91BUTrw
         13N2onAJ09kiWGZ0vww5TWgVLVbheFCWozpxD7af+TV4GzNXLAOybSFH7Tx5nXHYD0mn
         SKA2sjRvreFg9QB6+4jm0NVkmO4uSHsvJqwWrfkBtzFkVEYb5LdGLSkXnB0tlsfs9EVZ
         ZBLQ==
X-Gm-Message-State: AOAM530hdC+pt5HnSgFuC2RwLmTtovIdURd14QzoZKUFnwwLFmDeDczm
        YJv0rkqnkI9HiI34efzPXlP6sdYRtNPRcA==
X-Google-Smtp-Source: ABdhPJzNTjSzmcJSLfKm79IPr/doeuiV1kkhuJKs4VmxXnN3StyzssgnYXlq9c2/zA3ebDUV0FoYEQ==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr21467138wme.4.1616937368768;
        Sun, 28 Mar 2021 06:16:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 17/19] fetch-pack: don't needlessly copy fsck_options
Date:   Sun, 28 Mar 2021 15:15:49 +0200
Message-Id: <patch-17.20-03d512c8448-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the .gitmodules validation added in
5476e1efde (fetch-pack: print and use dangling .gitmodules,
2021-02-22) so we're using one "fsck_options".

I found that code confusing to read. One might think that not setting
up the error_func earlier means that we're relying on the "error_func"
not being set in some code in between the two hunks being modified
here.

But we're not, all we're doing in the rest of "cmd_index_pack()" is
further setup by calling fsck_set_msg_types(), and assigning to
do_fsck_object.

So there was no reason in 5476e1efde to make a shallow copy of the
fsck_options struct before setting error_func. Let's just do this
setup at the top of the function, along with the "walk" assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2f93957fb5e..5b7bc3c8947 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1761,6 +1761,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
+	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
@@ -1951,13 +1952,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object) {
-		struct fsck_options fo = fsck_options;
-
-		fo.error_func = print_dangling_gitmodules;
-		if (fsck_finish(&fo))
-			die(_("fsck error in pack objects"));
-	}
+	if (do_fsck_object && fsck_finish(&fsck_options))
+		die(_("fsck error in pack objects"));
 
 	free(objects);
 	strbuf_release(&index_name_buf);
-- 
2.31.1.445.g087790d4945

