Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31931F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeDFXWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44805 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeDFXWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id p15so1784235pff.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5aVADZwqMnqLHlvdWw23z9CasGACAkpSywtRE+1nxe0=;
        b=CbFayOXgSbR9s+UDbtsIuGJ/LT5vcqks62JM8f/kAY0MdIPY0EL0kC3YAwstjUag9k
         /ubKbk9Cw1bWsiHZZTdVOzyuUuADgFbqBLaJsza5+T8KBGoK6zwTWHCjFCZJuCpeofvX
         x9iSEKYLPBnnUUmnmjd/zawG4w6DwPziMyF2AI+x2C9JbZDGHGhbwfaJwhq+MNVL/8Dx
         DlZVTitT4CWMCbjMTiv74NJ1d151EMy5ahDL383faDMBMcXoasNElIR3gjrDEnhG5pP2
         iH87K/tcm5Z0WnikmZgHyiINJeCsHQZRZvRXP6Usp3qmjpZ3TAVjFKJ9e8SghybFOCQV
         7bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5aVADZwqMnqLHlvdWw23z9CasGACAkpSywtRE+1nxe0=;
        b=AVHZhf07/KjQT0HkYb3zXwTW9r5YA89fAgtz3tKKeUH8tPK6Jcyg9u/iaQwXxSXNTT
         89ZQLw7wW8cJvV5ZrTvmvzv1yxj6L6bgVMWYalTsvgDxjsD26IlLVbXVnYI84KcNubws
         tsMP4E8OwFuE44nyITxRF9GWGsXAMhB8vD4wrAtYdq1RPjMLzMVDfVOPfKJxUlArF0Q9
         v5OVYJJu+3mxS96f1DkY8lH9ig7J9XPOpAuLeREZL/TvUA3ZcuieWW6vUPJzLfdnR5wz
         Kd3gDv8o64cSNYB6jMZsYfdFLyNqcZww20Ix0LFpFy+IdSkkEkRjkxjO3oCg2ODw1XHy
         5cgg==
X-Gm-Message-State: ALQs6tCI2lVk/DGx5DoyECEEiy53FkQZvYimeyWpaIeLzf7S5fCHtwkS
        L0C8YLriQhs7HwgborQdMd5U+8tjse0=
X-Google-Smtp-Source: AIpwx4+Pw/bcCoOi97m0DIce+amd98dFVHVgkr9Hju9INK1fZmdhNXFuYFKM3lMlNzwtclOOxyzVdQ==
X-Received: by 10.98.237.12 with SMTP id u12mr12078190pfh.81.1523056929829;
        Fri, 06 Apr 2018 16:22:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w16sm9166979pfk.125.2018.04.06.16.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:09 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/19] refs: allow for_each_replace_ref to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:31 -0700
Message-Id: <20180406232136.253950-15-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ++--
 refs.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 793b827e19..ee71733a74 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,9 +1415,9 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(the_repository),
+	return do_for_each_ref(get_main_ref_store(r),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
diff --git a/refs.h b/refs.h
index f5ab68c0ed..15f3a91cc4 100644
--- a/refs.h
+++ b/refs.h
@@ -300,9 +300,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-#define for_each_replace_ref(r, fn, cb) \
-	for_each_replace_ref_##r(fn, cb)
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
-- 
2.17.0.484.g0c8726318c-goog

