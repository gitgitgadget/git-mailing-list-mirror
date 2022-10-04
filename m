Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF69C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJDNZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJDNYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6743553037
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so1721472wrp.10
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6GOCkLeXiaAXxkHR4zjCkwrkpAKU387RNQzztOWYLU=;
        b=heDBVBbzLZYIzuPAc31vw75scJafD7YDcTgJjvQxOZKHrMuQZSl7BVnuiywooI0yMg
         BRzF389u3yrmEuveMoExwmrEprod5L0xpOwsa4iz3xBlfgTZTFX5NJlzzFL7EyPJ26iK
         OSTsuUUSL/ClGOitztGKVx6FPXXr4/WLiyq2fO83KPi+LsM8S40jycS0Ix3e0hsDHYVo
         Kput1GwpPKJHf8R6Xh8c2Uwu+bDfr39d6bwfQ1jZ5urP9K8/i665cpk8FRRd4nKfuZ/y
         5VGdAJKH2iWo9gz+uA/MjvJOIghbsV1HSPSzs7UUXT0g5aGW1CcZMkNjh4LTlKNER/bh
         CEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6GOCkLeXiaAXxkHR4zjCkwrkpAKU387RNQzztOWYLU=;
        b=KcB5gJ7CCLwkx6D8OTYwtmiTSG65799REUWdUUWCJ1jqxqE5CPZO3gP7eAjpweqUnp
         PsK6cUK0rEt8VAj/+ELs2rHiCVcr2bxpaozPkElKLKxPFMW6cNz5sn3a5jcAFkqS05Ee
         wKkQP/4HAyES1EIlnxc68g62XPmYTlU/2pRL3BmR9pZ3G4l7Bedk2k3u3fJfjgrfNuMj
         vVZSicFzwzBMW7hZrO0ovWhRLU6Mfxa0Emc82VzPwfDcBywXiZ42R3OnHIce1oWyTJIt
         hgD+uUpF4QhhrgmwA3649OyGE2+2PFBRScKWV58Lt8ck2C8ArK6+UmD4xNZcCC8r9Lw8
         EoKw==
X-Gm-Message-State: ACrzQf2eRBpALoxCjkVoeZHLiM0ayxyv6DEZ/QnezLgcgjIGRDfDLmj1
        DRAkzF4Ri/cnG+TXiD/tnZlPcJAfezEVTg==
X-Google-Smtp-Source: AMsMyM70BYkWvbDaHPP0yUBKDQUC2ene2svRFFDMcc12HfMlsUy88/p9eVGYPpeUNQUd/3/cfaOsIg==
X-Received: by 2002:adf:f2cd:0:b0:22e:49c0:aa3b with SMTP id d13-20020adff2cd000000b0022e49c0aa3bmr3169343wrp.97.1664889852546;
        Tue, 04 Oct 2022 06:24:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/34] doc txt & -h consistency: add or fix optional "--" syntax
Date:   Tue,  4 Oct 2022 15:23:31 +0200
Message-Id: <patch-v4-17.34-e6ef67f1c4f-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "[--]" for those cases where the *.txt and -h were
inconsistent, or where we incorrectly stated in one but not the other
that the "--" was mandatory.

In the case of "rev-list" both sides were wrong, as we we don't
require one or more paths if "--" is used, e.g. this is OK:

	git rev-list HEAD --

That part of this change is not a "doc txt & -h consistency" change,
as we're changing both versions, doing so here makes both sides
consistent.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-rev-list.txt | 2 +-
 builtin/for-each-repo.c        | 2 +-
 builtin/rev-list.c             | 2 +-
 builtin/verify-pack.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20bb8e82176..51029a22715 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [<options>] <commit>... [[--] <path>...]
+'git rev-list' [<options>] <commit>... [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c6379b783c8..d45d873f579 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <arguments>"),
+	N_("git for-each-repo --config=<config> [--] <arguments>"),
 	NULL
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ada68a4af5e..3acd93f71e1 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [--] [<path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index db9ac5c4606..27d6f75fd8a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

