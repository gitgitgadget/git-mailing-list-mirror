Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE7C07E9C
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BE061494
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhGHK4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhGHK4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:56:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A747C06175F
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 03:53:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6402724wmh.4
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9aMTtyG5favo4OHeEDIcIyaAJX/mOAznYT32Y+BoMA=;
        b=D3shSi6JGrSHtg5bGduks48BtBToWtGdg3STaMVz+m8NU/RoknHL7RRGn3kXOEYO2k
         ZNpIF7lr8faeHTUj7LgPMxXkD5sTHky5mkFinl7JYFFNy0WTnnzhlhcE2eBpuqVhj+QT
         57XrX2N7sejBi/gZZTdjs104QvN58L3WZM3OvylXtkA99b3yNWkSFQHie/3i8jkkxI5j
         Ii6b8MHq27nopDJn/8ZbvEnJB2m/at6Zo4J13oKVXJtsOtS7S3fBv7/h/SDR7bPecE8G
         TxM17qPTiu+fX9VwZcu1GLPhgX/qCLbgvBZ/zVJCm/yCPMBjpid5pHSKniR82N6QbPLd
         HlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9aMTtyG5favo4OHeEDIcIyaAJX/mOAznYT32Y+BoMA=;
        b=JELSSgDt469xOebdv+BrZ8dYFDXnWQ8v9QiS3SWR5ZqTwakXreBQZbMBnUaHiBPW/Q
         TtQToYrufrAWvV3sEarGWNlfhTrTv3zyBvOu8NBpOT49LKe9Vov4IM15Jc34HF1SSW5R
         G3YVQAZqGryDU/rne691Slll4fjNeZl2TOa5k0ooGBkDIs11XLgmZ5u50n6iRqUj8tR6
         xM799Ao4MJIwyHxEYUI+mJ+CYPghEKp833SoxCYjeZj/tP6xboTtj5IfNEdh8f/2Wnyz
         aqTEV+/9tTS71KKB51mseMKoUOkz+423UV1sDqXy7kt67g4qp5pQdZa0ptXswmopGVn3
         3G5Q==
X-Gm-Message-State: AOAM533LL0EhzNK+s403O2GCXxo+IMpZ97u3bf5QHRAdFxFmTxoGIbeJ
        1dhbal41a8+yT4en16+porHAjssCMr41Ww==
X-Google-Smtp-Source: ABdhPJx2pMJyhtQSZJRUu5u06r9v5jyNgZz1zQeFm8aLevzEUrasnLUo0p8F/BTIiXCA7FJG8LdFcA==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4548692wmh.23.1625741598700;
        Thu, 08 Jul 2021 03:53:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15sm1838920wrp.29.2021.07.08.03.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:53:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] send-pack.c: move "no refs in common" abort earlier
Date:   Thu,  8 Jul 2021 12:53:13 +0200
Message-Id: <patch-1.3-10375a6484e-20210708T105034Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com> <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the early return if we have no remote refs in send_pack()
earlier.

When this was added in 4c353e890c0 (Warn when send-pack does nothing,
2005-12-04) one of the first things we'd do was to abort, but as of
cfee10a773b (send-pack/receive-pack: allow errors to be reported back
to pusher., 2005-12-25) we've added numerous server_supports()
conditions that are acted on later in the function, that won't be used
if we don't have remote refs.

Then as of 477673d6f39 (send-pack: support push negotiation,
2021-05-04) we started doing even more work on the assumption that we
had some remote refs to feed to --negotiation-tip=* options.

We only hit this condition if we have nothing to push, so we don't
need to consider "push.negotiate" etc. only to do nothing with that
information.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 send-pack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 9cb9f716509..5a79e0e7110 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -486,6 +486,12 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
+			"Perhaps you should specify a branch.\n");
+		return 0;
+	}
+
 	git_config_get_bool("push.negotiate", &push_negotiate);
 	if (push_negotiate)
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
@@ -534,11 +540,6 @@ int send_pack(struct send_pack_args *args,
 		}
 	}
 
-	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch.\n");
-		return 0;
-	}
 	if (args->atomic && !atomic_supported)
 		die(_("the receiving end does not support --atomic push"));
 
-- 
2.32.0.636.g43e71d69cff

