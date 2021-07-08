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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F80C07E99
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7237B6157E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGHK4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGHK4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:56:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B2C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 03:53:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q17so6964348wrv.2
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DKSmngizrES+yuw4Ird1aAqeHyUOGZfBrw2oTaSDKiU=;
        b=OxO6S7wC1Hd/O3CJWlTAOOizazIh6MXhloUaKrM1t2eotfG2di2FTARnGPCCwW6VI3
         lpmhFNVCtyvpLNGyiqFiSYVwkFqm1lPOAAIahFh/tmMt3vdgCgcWu1TQs5WNdiZJm6fF
         6JG4KhdQ0AuZfXQfMU1jPMUBueyCj0ChsJuPZLzxNF+/luOHyiP1RF9VCsZFCSIDu8qk
         7399ERj8TKIbn+DgfvO1eP3IOt54a+fcUGh3giapnXYIo27FnDOc3SBVWoYYkb2pWNKH
         H8Zf9eFpzidRp4tWWbT4deVlLf+C76GgQjiNTRvHZyIySX/Q76KFYcUTU0hnSmkzZoX6
         Og/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DKSmngizrES+yuw4Ird1aAqeHyUOGZfBrw2oTaSDKiU=;
        b=D5pdPPb4aJkl1N906ZgQ5K/7lTx4tyPLU5qdoxyX+hJbPlPumlbtlI2w81oodYuS54
         c1LrjzHCiIc62JYqqsSxLTEIi+3i7fHWhXDQKFXnkrbrfOhG+ehh9H2x7RpiALRgpoJ4
         rSfLTrgUPOQ82IhhEbxPchMma/QzJk73Hb3mwRuVD4FfR3SUDahkTPgWm78s+4YvdS1t
         WmIqugwpX+JMca4yHdBu6UoeTa+6ekLrtbhbBLmqW5aAjMqcsGKgnypGAqQ89Nn3lK12
         HmWVh7GleUZsR+e+aHr3Fv428prR5qXs4Y8Newtux0mErcYQcbgGkwxYIFuF119grIiW
         hfcw==
X-Gm-Message-State: AOAM531SuDMXCra/nYHO9NbNoxL85xMXvCpUTsSSPEjrKzBnpYNhZXTX
        MvRTwoJjFIeLhGviZq/Tdbx5PcKC3OhmmQ==
X-Google-Smtp-Source: ABdhPJyDg7BCfLHuYCFkVErQfrhQTRPA8ojFaNiD7/AUDTgn9qyGvAHAgi8CoFnY895fM+o0JDppkg==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr33797007wrt.199.1625741599443;
        Thu, 08 Jul 2021 03:53:19 -0700 (PDT)
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
Subject: [PATCH v2 2/3] fetch: document the --negotiate-only option
Date:   Thu,  8 Jul 2021 12:53:14 +0200
Message-Id: <patch-2.3-f86f4fc0e6f-20210708T105034Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com> <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
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
2.32.0.636.g43e71d69cff

