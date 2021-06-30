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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587FDC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B23761463
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhF3Qku (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Qku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:40:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB20C0617AD
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g7so4417077wri.7
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq2GjWaszMHVbSGR9tG99l7+0zfiMGE2iZdnipHKtUY=;
        b=WC7oScXK/7Vy8f2q2jkfIlFPHcU75ElwzTajtU4N0M0J9DnhS/CTytlaShRmPq+C7Z
         sIypkdTga/quPe38pRQcg74GGwn9cvGGMPiJ+hfMMKSiMk/a8jejVPDcI8Z/3cmlINam
         wfiY7m+J8/hoVF0YX2iSF8LmNOId1/yWY714ms5YKSYTwnT10Ixh+phsQ9JgdE9Svvw8
         DVVLicKRbL3YsmW8MnqvE2yXazeT7lXe/S9XJ/cCOPy78vWWjzE/IhIaOftIhlWvY8Ct
         RBz8YSkm8SzHRY/gneXFg2J2w7XagQwP4HBcrX+Z5u74rLvTcMN6h8MGa9wYDK6cA9PM
         rRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq2GjWaszMHVbSGR9tG99l7+0zfiMGE2iZdnipHKtUY=;
        b=XSZRI4bKcTihrOR4C5Hx+MNbROx2m3GGqdqNZlyehGJBBoOR5VPo9UAm4axA8gZOKV
         mc/8RsvIDc53ZWIbkPhjYjhfKeEeex1nftjmQjIoyVNzn+hDAiSWQslALQCGBYNEoFY1
         qwjcAqgJQwSobvjI6P0x9Ml60rgucxRZtecZu5bvl3KCk8I6bQiwEqfdFvG8owBy7bQ0
         DxMxmMzHjcRkf0HcceF/3ejmK5vWF2WkDKbieOm60cUYRMkV+WcaqT2/Sg3euRQGZDNL
         MvSPwg66MR5V4rtYaSFdcaDyCSEHB17Mp/oVTUXdPctdJ0suOhiaLDlsZ4G7SbRJnbXk
         XNVA==
X-Gm-Message-State: AOAM532XdWmtdjE7rRc08YibtD9M7xj44bWoHXG8kKjQ1x+ocp4NOlwy
        b5xijODKYHCWY0b2kAraOfnhl+y7BfkP/g==
X-Google-Smtp-Source: ABdhPJx8Z9/HSNUqdnZ1zKTREwVNEitLLSOnJGo5V7GaTOUaMcRwNGSWYWdkKwH2VPl9nRv/TRc28A==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr15396455wrn.408.1625071095400;
        Wed, 30 Jun 2021 09:38:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l1sm1952066wme.11.2021.06.30.09.38.14
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
Subject: [PATCH 2/3] fetch: document the --negotiate-only option
Date:   Wed, 30 Jun 2021 18:38:11 +0200
Message-Id: <patch-2.3-7ff734ed70a-20210630T163329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.619.g53a98c35da0
In-Reply-To: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no documentation for the --negotiate-only option added in
9c1e657a8fd (fetch: teach independent negotiation (no packfile),
2021-05-04), only documentation for the related push.negotiation
option added in the following commit in 477673d6f39 (send-pack:
support push negotiation, 2021-05-04).

Let's document it, and update the cross-linking I'd added between
--negotiation-tip=* and 'fetch.negotiationAlgorithm' in
526608284a7 (fetch doc: cross-link two new negotiation options,
2018-08-01).

I think it would be better to say "in common with the remote" here
than "...the server", but the documentation for --negotiation-tip=*
above this talks about "the server", so let's continue doing that in
this related option. See 3390e42adb3 (fetch-pack: support negotiation
tip whitelist, 2018-07-02) for that documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/fetch.txt  |  3 ++-
 Documentation/fetch-options.txt | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 6af6f5edb27..63748c02b72 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -69,7 +69,8 @@ fetch.negotiationAlgorithm::
 	setting defaults to "skipping".
 	Unknown values will cause 'git fetch' to error out.
 +
-See also the `--negotiation-tip` option for linkgit:git-fetch[1].
+See also the `--negotiate-only` and `--negotiation-tip` options to
+linkgit:git-fetch[1].
 
 fetch.showForcedUpdates::
 	Set to false to enable `--no-show-forced-updates` in
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9e7b4e189ce..e967ff1874c 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -62,8 +62,17 @@ The argument to this option may be a glob on ref names, a ref, or the (possibly
 abbreviated) SHA-1 of a commit. Specifying a glob is equivalent to specifying
 this option multiple times, one for each matching ref name.
 +
-See also the `fetch.negotiationAlgorithm` configuration variable
-documented in linkgit:git-config[1].
+See also the `fetch.negotiationAlgorithm` and `push.negotiate`
+configuration variables documented in linkgit:git-config[1], and the
+`--negotiate-only` option below.
+
+--negotiate-only::
+	Do not fetch anything from the server, and instead print the
+	ancestors of the provided `--negotiation-tip=*` arguments,
+	which we have in common with the server.
++
+Internally this is used to implement the `push.negotiate` option, see
+linkgit:git-config[1].
 
 --dry-run::
 	Show what would be done, without making any changes.
-- 
2.32.0.619.g53a98c35da0

