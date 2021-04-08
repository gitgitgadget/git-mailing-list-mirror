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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AE9C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD0461151
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDHNe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHNey (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B5C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so3042417ejo.13
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSmAa771LGQPRQS501hQMMyWWy1OwFK/WlMj+WigPok=;
        b=A1OJNXKaBY4VSEaXjfYyNV/JLeId7fUKr9HMGCSsdosYPd1Jl7hxcEfsCUBD0MN11U
         tn6elbo+hKWVjqCKM9cjDaAVyR911UiGAQwmVDtCKfuRWPnRlbbGsXh2PDfmOzblsDC2
         VMq9jR9ti6FYXuuNaYbq5AKsCX1+DMoNDP2l4zFfRUMSyfwOMhWjTLmj0XQdlKbXQA5A
         zeBa5UkNxJ8LBXKu6pzOsh9v3kXxSmc1iupre6dhEOvHeix3wts6wU8/wBTNKvmQuD8k
         FD5kwkLxDBxr7rWK3nuCR7nCOGQfib3TznNgw9BlNiTxzQiNM/atqDXfBGdxa7jU1cmP
         tcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSmAa771LGQPRQS501hQMMyWWy1OwFK/WlMj+WigPok=;
        b=nto7Jkdz6gAjoKog7XTsG831Wv0rKOIsWHOlOHFqrWic+lDqjwf34AU+TDGeqrVRxr
         yX9b/aRJxcoOiKzj608Vn6ZYJrDULM7ehHK9XUpLXbXZfgNGZQ630OLh6NGUiUN/ygva
         kBVnb4p0lKqmGpxeiRVItNWpBrcV4pC9dStfDtuRCriZ8t8Lk543bpuoPpaTOOiCJoW1
         CFUlJUibE/aco8r1Bl2wMS8S5/iebsoAo8/o59dgxNLhrJLGREgQ9f71vbF8f+Nl6ivu
         Zn7Jdqnsr2wCdqWI3wTxEy+lmqMdh3kJDYyaMLSto2qk2AJQTgUkCx8pDztD88uesEbt
         /dkg==
X-Gm-Message-State: AOAM532fsGjPFYXPBL8F165lGQJC+qOTMLKe+Pg0U9MyltRgfLU6zAvE
        ztYQQa9Fh3o9xjRYGJ/2ScMSHYUnHSV90A==
X-Google-Smtp-Source: ABdhPJwJ9p5CUH1bGn77XB2RSiOvF2wxINDtO1C6UzpOAPuQdlSpnaawEe9NZ2eNzcZx5HL0P317oA==
X-Received: by 2002:a17:906:1957:: with SMTP id b23mr10204803eje.245.1617888881229;
        Thu, 08 Apr 2021 06:34:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] git-config: document --bool-or-str and --type=bool-or-str
Date:   Thu,  8 Apr 2021 15:34:27 +0200
Message-Id: <patch-3.6-8aa59b3118-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the new "bool-or-str" facility added in
dbd8c09bfe (mergetool: allow auto-merge for meld to follow the
vim-diff behavior, 2020-05-07).

Unfortunately that commit also added a --bool-or-str option, even
though we've preferred to deprecate that form ever since
fb0dc3bac1 (builtin/config.c: support `--type=<type>` as preferred
alias for `--<type>`, 2018-04-18).

Since we've got it already let's document it along with the preferred
--type=* form, and change our own code to use the --type=bool-or-str
form over --bool-or-str.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-config.txt | 3 +++
 mergetools/meld              | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4b4cc5c5e8..4ae9ef210c 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -187,6 +187,8 @@ Valid `<type>`'s include:
   1073741824 upon input.
 - 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
   above.
+- 'bool-or-str: canonicalize according to either 'bool' (as described
+  above), or emit the value as-is.
 - 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
   `~user` to the home directory for the specified user. This specifier has no
   effect when setting the value (but you can use `git config section.variable
@@ -202,6 +204,7 @@ Valid `<type>`'s include:
 --bool::
 --int::
 --bool-or-int::
+--bool-or-str::
 --path::
 --expiry-date::
   Historical options for selecting a type specifier. Prefer instead `--type`
diff --git a/mergetools/meld b/mergetools/meld
index aab4ebb935..8386e0574e 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -59,7 +59,7 @@ check_meld_for_features () {
 	if test -z "$meld_use_auto_merge_option"
 	then
 		meld_use_auto_merge_option=$(
-			git config --bool-or-str mergetool.meld.useAutoMerge
+			git config --type=bool-or-str mergetool.meld.useAutoMerge
 		)
 		case "$meld_use_auto_merge_option" in
 		true | false)
-- 
2.31.1.527.g9b8f7de2547

