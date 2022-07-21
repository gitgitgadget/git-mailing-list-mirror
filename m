Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC01CCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGUTOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiGUTOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924A18CE8C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id id17so1580542wmb.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQ6uyQNX2Suui5juRKz5J57X9l+PRekZyvmbwm4mcsI=;
        b=ZDY/w4i0WUNmPd80RuXoZGt4LF3bnWQDoQUmv8UzsBxqAvkNxBpUieuepp/5rbCvTY
         UtzlEU+Ba6kuhQVJonsUoBvvnNqxKQjbieQbknVfNVzn0g5jS/lZfOAIE4Xpy7eguTEk
         VU33z2g0AL+twMdEC9gQSCUsmlNNLKO0bQXnxEO0ZDborTjn1veyy6wh6nbMIPiis2f9
         HxfPA7OppzUDLTCpLMNT5uQHCVT/MOrdlAp2adHl3QRuXbTMgxmw9nthv5XmO4MKvxGR
         urcyY1i71V1w1uoG69xK6raQFrTLBGtp6a0sLhFHq+ZbZI+VquIAK1tGnrTpsWBiTiyP
         TV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQ6uyQNX2Suui5juRKz5J57X9l+PRekZyvmbwm4mcsI=;
        b=2XvK78KnmJGzG6EdfUtk6xLOyH79jWW+CvJj9nGXdV8SKknqN8NkJcv+l75Vi8PiZm
         JIo8fdYpOHvz6KSpA5t5h5+BJMqeETKVtsexhmYsJJwLyyVX1TiiLqXK0BDWa4pTmk7n
         VftPhEvgbhDEtInim92iljcKRW7DLWQ/N5BfXMRYGDpFWMavPTqMXew6uC6KHNEnG4KL
         n8uJO0AwKGz+3hgr6dkksK+Hms6DuCFm7I9VWqhp/zJ53gl+mxJxAkC5qyYrf9ixqBzU
         73X3S/WnswCGT6ek7AQttqS87gZ368XkPT5XuEuUVMJZ4az1okZNiuWJEYDwaR8CNRz3
         LYKQ==
X-Gm-Message-State: AJIora/k4WZtapBFikJc3P516erBm0H9WLtHP8HhxLke7Eo3RNu9bLuj
        J0rQFTh367IQELSdWhu2BX3ZWrU0c0Q2OQ==
X-Google-Smtp-Source: AGRyM1u/Drnlno2Bcd89+5sN5Fam/9hEuZXKcwCJ0kuvgp++Jd3YO9iVGBAZGsOo8Z627PMqz8kQ6g==
X-Received: by 2002:a1c:c912:0:b0:3a3:20d5:8351 with SMTP id f18-20020a1cc912000000b003a320d58351mr9253095wmb.126.1658430843841;
        Thu, 21 Jul 2022 12:14:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/26] submodule--helper: fix a leak with repo_clear()
Date:   Thu, 21 Jul 2022 21:13:10 +0200
Message-Id: <patch-v3-14.26-b8560e8c111-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5492c6d89a..a3de17754fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2458,6 +2458,7 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+	repo_clear(&subrepo);
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
-- 
2.37.1.1095.g0bd6f54ba8a

