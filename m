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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAACC11F68
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B54361446
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhF3Qkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Qkq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:40:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D3C0617A8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u6so4427259wrs.5
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pF/2z1EMeqcKWl1pcQ275R9HcTceKENoTxCAZiH/IO8=;
        b=C6AE3FNR72MpnOCaY8rtEnvXvTc+2WKIYUYvXS5NpWVMEKjP5z0HTOhMhaLPTAyYjp
         Pdq+4s27egteO1zDHfZ2sQBPb7MnqkGrBoSk/w0xI5vqVGT46BoJfz46K6+nfuSNcr3W
         EIWUI7nMyWFvbFwxcepD2vuqwqz16uAFzKU/PmA9dV9itZztx7Dlf7qO1E66GwJfkBcX
         RVw7J/OMLJ+vT9FgDCiJgzy3eM+b8BeRNvPJyIEe2cO3Y3WfKXQhfo6AgUPkklmTDGoc
         fdb03oDfKg0yOZPO6R4mdgaWXAs7idBdV/ALovPHOL6V/u1mjGe0o+lMD0r7mJ/q2J8y
         XoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pF/2z1EMeqcKWl1pcQ275R9HcTceKENoTxCAZiH/IO8=;
        b=O1tNjvF7hgF0GGUA7Ye7ErorzJqwYN/mT3cjrxGbbUJP/H3jVpDunWf68fvMCinhpO
         s2dZ9EgIUSC6SclBuYzyJm07dekh0h9KVjNQsOQHWXjx5juUlg8zJHZoDsFOSm2mfDrn
         gRqBzvMXX11QxwvWD5ZqNu7tkUF6aYORWL4qePrF6gip5nGOilqJ/DPWbe3fzi3i7G3v
         Hcm6j/Z7czSJjFFA+EGMYxP6c4VMTxHfkFk3jJ7JNBeKp3mD2i34bYNv9hA9jbEBjZnW
         AjEnpSLJHzTpYfN6wfrw1krLh02UDsz9SfrP8QbGZ2INM+pP4/ZiH4S5UNJgy40yZS1Q
         D9ow==
X-Gm-Message-State: AOAM532JshD0rpohg5yGqQPcuDqolDoc6X3czAz4qOLGIEZuUNlkfxUF
        LIkaw+ciBPFrc8kOeClissa4SWUd0eKF+g==
X-Google-Smtp-Source: ABdhPJySFg+bd14NW7zCN7XDdCGk6puSzWO3oaR9m4H2972h6TvaszDpnzRZuhd6FET1DeDnfm31uQ==
X-Received: by 2002:adf:d0ca:: with SMTP id z10mr38871550wrh.376.1625071094699;
        Wed, 30 Jun 2021 09:38:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l1sm1952066wme.11.2021.06.30.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 09:38:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] send-pack.c: move "no refs in common" abort earlier
Date:   Wed, 30 Jun 2021 18:38:10 +0200
Message-Id: <patch-1.3-1cd8b98d3d6-20210630T163329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.619.g53a98c35da0
In-Reply-To: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
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
2.32.0.619.g53a98c35da0

