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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5AC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD160F55
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhG0ABi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhG0ABZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:01:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F77C0613CF
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso664228wmq.0
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIH9xwMS/wVvgBREhMzvZdnz1R+SporpNqyLTVV/JZM=;
        b=Dv9q9M1wVQl1E8isutzG4tToeX7BLBrDVf8CN/OxwlpUai1MkdqebQatD+7aXFJCyS
         Rtqu6SBg5bu7NIavMYGQZ2OLb2UtSlPX5wCcJ7MBR99MdfBZylRfoSgjuep8DvuX9fJ8
         KolEExyB3xmyUqoOtNh91Bw42j4UP8ViAuGVuLMDhDvaO6yAwAPBsMSCpVhK5ssIQPs6
         QH6e8GEE3x8EeOGvTJXxK23Fsa4BjP/wO/L7mbL/OmumYvwISU/5RLsVWO9EqPaU/OJg
         um3aG7DvqCIqbwi1p9OpLhFPS+0l7dqaUOWAAYfQAZs0psa6XlpE5Tr8H/Y2SFHYP9LA
         7ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIH9xwMS/wVvgBREhMzvZdnz1R+SporpNqyLTVV/JZM=;
        b=kp2wt07AV4tf8fQiMAMJCQ11jt3pR/j5yeCuVW4VNTj6BEdaTDfa7Rx1NiW5rmfRzx
         /2+Gzk8It89FQCHjg5U9DEYTlRw01fx4+JxgrrS6OoqV+PrGKbtwe4ROenhHkyCYDKhs
         H69rStuTx/XS+NGjvEo5rsKcXvwkxFgRy2i6LrHjHL39XipQYiZJitGhiv21nIxGOI2H
         dSzBJ5svv+6LMcdqxidFedQHPBl4Wfs1Gc0FWRQdmRhUwLYR2n/3i6HLo4RSXW0d6Now
         bhalMUUuOb2NoKB/taQCIW1U6a29MZmEPjXARBsjw4fjjY6e4MNscCHaNubcuUO/W99T
         82gg==
X-Gm-Message-State: AOAM533KJsAkUvQRVb5As/lVFAF7YZtOju+YfKP7M3UWTojaaj0hFwcX
        IPhXCHx4UC9qNu+lxCxEy+oOForuXiYBGw==
X-Google-Smtp-Source: ABdhPJzMGKaswNlJXu0jC1yFUZidfnwIYvNb1ZXIv84l1WIGC5i8TMMMBcJEkArxgC1plgo7qwIR9g==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr1306644wme.119.1627346510889;
        Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c16sm1254377wru.82.2021.07.26.17.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:41:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] bundle: show progress on "unbundle"
Date:   Tue, 27 Jul 2021 02:41:42 +0200
Message-Id: <patch-4.4-01643f2ccd-20210727T004015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g189fd9ae38
In-Reply-To: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "unbundle" command added in 2e0afafebd8 (Add git-bundle: move
objects and references by archive, 2007-02-22) did not show progress
output, even though the underlying API learned how to show progress in
be042aff24c (Teach progress eye-candy to fetch_refs_from_bundle(),
2011-09-18).

Now we'll show "Unbundling objects" using the new --progress-title
option to "git index-pack", to go with its existing "Receiving
objects" and "Indexing objects" (which it shows when invoked with
"--stdin", and with a pack file, respectively).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 10f6f45770..f027cce3fe 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -162,7 +162,11 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
+	int progress = isatty(2);
+
 	struct option options[] = {
+		OPT_BOOL(0, "progress", &progress,
+			 N_("show progress meter")),
 		OPT_END()
 	};
 	char* bundle_file;
@@ -178,6 +182,13 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 	}
 	if (!startup_info->have_repository)
 		die(_("Need a repository to unbundle."));
+
+	if (progress) {
+		strvec_push(&extra_args, "-v");
+		strvec_push(&extra_args, "--progress-title");
+		strvec_push(&extra_args, _("Unbundling objects"));
+	}
+
 	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
-- 
2.32.0.988.g189fd9ae38

