Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7409EC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618DB610CF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhJVI6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhJVI6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C46C061226
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v17so1872686wrv.9
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFGZhDckZHi4LCQKi6L1+tYWxq8SIqnm5SIpUKcirdM=;
        b=Jjb2L4xcvNoi1Alqwm59C4xYEGh3rKB4Zs0PbjliWP/4iS4BG7SiwmJaHWmepfAFcx
         neap35Xm76LmTc/iYNO8n2FLS6kkS5eIj3jgcrqFuXvt3i5WRRb6lYQcg/VnvjlTAjxQ
         h7BOjjO/lJEYYPyP6RnXFVfxwDxUQ5cCB8RRNymUTBvvSuWyeJ8p1xSq6iEBuBaJxvGQ
         Ye4drwGu/SVWeFHPLzNGAEAaq7UXKPXBRr1V3sx47Hy/3oYnJrmV1++prbNEp9AmIoH1
         /sCjVAVazPEDbwsKJ0vRnzzCcOJ0/j7BGaLSL0ClZlRbO5KABmGqXfOQOV3aVdvLlyhV
         HSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFGZhDckZHi4LCQKi6L1+tYWxq8SIqnm5SIpUKcirdM=;
        b=Grvx1cRYjkPP6S5PIBMu09GoNoFp0uVO7FBjf/Y1gbk++QxAbolIFdw2CX6J+iuFJR
         5j5SIoIgNoGnqYnjZfqYEs9MIC1eM6SfT/01a3RZRfQbsdYelMTUdIM8OyWbKPafLcXr
         9EuirBVxcEMGYJk4DoFbhNH+a5CoZ0x+WiZuDpfVzUos5bOYm7EGYSM8FHuw+Qc1tCho
         H/fHO52PccwQ6HWEzgFh0RZO9l9yqA2NpLFeFfPtrhGduPrI1QsRGOYe1nBcEYtCVfRJ
         0djyvjUH1X5SmJ5m5G5rHYIzqLQ1a9Pxar1p8zbizZAeh7O3YVSBZvA0rlJZKxi8N0VD
         BtQA==
X-Gm-Message-State: AOAM532JBRfUIZPwR6WW7xpIHBYqgWII0BzQPAYxa2NlrgO+m9id7m+/
        ZVJQK4jMSk1GsjUZfEfG5Q8lXJiXpV8MTQ==
X-Google-Smtp-Source: ABdhPJzthA4AMyG4xJ7iAU7e2lcOBim7G2XwWg6SjvI8WPdj5njK/BHVoX7MnQl0tJcZ9s2K6crkQA==
X-Received: by 2002:adf:a118:: with SMTP id o24mr14006959wro.15.1634892952617;
        Fri, 22 Oct 2021 01:55:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] submodule--helper: fix small memory leaks
Date:   Fri, 22 Oct 2021 10:55:43 +0200
Message-Id: <patch-v2-5.6-a529c04a29a-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing strbuf_release() and a clear_pathspec() to the
submodule--helper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6298cbdd4e5..a157656a48a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3220,6 +3220,7 @@ static void die_on_index_match(const char *path, int force)
 		}
 		free(ps_matched);
 	}
+	clear_pathspec(&ps);
 }
 
 static void die_on_repo_without_commits(const char *path)
@@ -3231,6 +3232,7 @@ static void die_on_repo_without_commits(const char *path)
 		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 			die(_("'%s' does not have a commit checked out"), path);
 	}
+	strbuf_release(&sb);
 }
 
 static int module_add(int argc, const char **argv, const char *prefix)
-- 
2.33.1.1494.g88b39a443e1

