Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E75C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDAIrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjDAIrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614121EA27
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso12466990otb.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9opIxlyolKgPJ9ZaPi/fz5XBE5t9vm/e6ZtmMdzj/E=;
        b=X9bS4vqW9PY9DX6ig1DgQ/7Mq3qkqJGXKW1a8DGb/iZSJd+M7FHcBMWAFVu7bJDGLV
         VeYeIblw0tG/0mqK1D5IAdQ8nkujlyTFKy0Bhv2Kp0TV6c8uazzQtowO0jcP+rmOr3Z6
         EbHNPbZY0Bfvn5c5VLywvXDCJBvAyAVbUcsFWwL2VIirtKT3UkUSPzT2vWklJlIumM4J
         HVUB2R8kxK1qDbsUHo83dWdtUnRXfw9ThAurj7BRl74h9GebVugiv6+5Ki1zJYI/3MaX
         LuJSi5hvuC28xTdKtcfBnfEvLqZcSNmiNLoE7YEjfB6FmZmK/Q2xr6e3+bpG4BK7tV9f
         8+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9opIxlyolKgPJ9ZaPi/fz5XBE5t9vm/e6ZtmMdzj/E=;
        b=3jo4gJfwnd+ADnT4PDvIA809ZdWcjZ8GenV56QfjauTAbdfYW4ZvR1coEV1Jt7AaZ+
         8rF7RjnUvR6KrqQwdUZOKt3KeCKJk1DHmlGDH/f067S2hV2T42m46rPqotYwnl07bt++
         ynHpZg1IMk1y5y/TIMoq8RumXX9FKgg7TMhoBA1o1qc1rnJvWUf00bo9apeDGZdQ3wHw
         ndsyv+Z4QaCej3Mj3YhV1Q23+sle6Ij49VGJeVEhm4bNIdVi7W5JD/V47v7/RtbK+24x
         a6HoquO7Ziid4qhCAJxkzUjRaNyp7XPRo+yxjCCVKgwC+74WMjDdAdFse4JCGBbZobyV
         zJHQ==
X-Gm-Message-State: AAQBX9d08x7YEKM4lBBjZ5h7bsWNR3tkoF/a6/fmukJ8Ey+aKo9z3+6q
        p9yBB5clq0ClqP+UEXa5Y4qIwxmJKa8=
X-Google-Smtp-Source: AKy350YmDshDETKjvamKcPaagGUAHDknqcTmnpkqr0ryn+THxSdrXGVmvB1fJ+kUmdHHEcF4kN48YA==
X-Received: by 2002:a9d:7594:0:b0:6a1:42ee:1f5e with SMTP id s20-20020a9d7594000000b006a142ee1f5emr9441907otk.0.1680338804668;
        Sat, 01 Apr 2023 01:46:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b11-20020a056830104b00b006a1287ccce6sm2076477otp.31.2023.04.01.01.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 12/49] completion: bash: do not modify COMP_WORDBREAKS
Date:   Sat,  1 Apr 2023 02:45:49 -0600
Message-Id: <20230401084626.304356-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no need for this once __git_reassemble_comp_words_by_ref() was
introduced. Now irrespective of the value of COMP_WORDBREAKS, words are
always joined together.

By default COMP_WORDBREAKS does contain a colon, and if it doesn't
somebody probably has a reason for it.

Completions are not supposed to modify COMP_WORDBREAKS and none of the
completions in the bash-completion project do.

We manually set it in Zsh so the Bash script is not confused.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 -----
 contrib/completion/git-completion.zsh  | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cf6ff0595f..fd2a43de38 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -65,11 +65,6 @@
 #     case insensitively, even on systems with case sensitive file systems
 #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 790879e319..186c49195b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -46,6 +46,7 @@ fi
 
 local old_complete="$functions[complete]"
 functions[complete]=:
+COMP_WORDBREAKS=':'
 GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 functions[complete]="$old_complete"
 
-- 
2.33.0

