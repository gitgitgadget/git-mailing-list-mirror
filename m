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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BDC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48886108E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhFHGDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:03:14 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43997 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGDN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:03:13 -0400
Received: by mail-ot1-f54.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19214921otu.10
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hhe1x6WBEFSZPKQCZzZOOCqB/UUvnG+vp3eAzoW/qXk=;
        b=MJB6fKdbDoz65aq/nl2N0DiB4St+qBHsB7ohzregSc5hMdJYTfD/XxyhHJzp6tcOeL
         QI2DmelqLPgvsVj2+bZ6rPF9MW06NXvpHpKGSq3mltsEsKG4+lGOyD5rsnec7BfJXz/Z
         JrkrQcrGqeBUAjK0M78U3Fhb+adbCknpBrvFSHQ4pK1f9mMOMvhRsKgbM+zusinciGL6
         nG3LWoZBvMpYoiNZpmDtzxvuaajXkMaSRJ3dXg2SW4PbtKBI2VGxabZRpG9IpvlTd0kH
         X1NafNGIMGCgFnyXR6VTRjvnbG4tI6w95DdppsprBZCsqil82a2paXP/ral/0qR/3FB6
         U/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hhe1x6WBEFSZPKQCZzZOOCqB/UUvnG+vp3eAzoW/qXk=;
        b=gBIBkr9sCX/XP5vOH+RBo8UOvQ89k1uJ1b/Vj20TtVFjWcIKB4jNYGT5AaZ4Sm/xnk
         QCMGhdg8P/WjS1bYtcrzUQ/Zl6Zjwta+ecWnl5aiBSjIWAHg606aaqZT/ldux9NTQF9r
         7a3eoMqukhJ137rJRfLJDJRgS5WdQGsBHWYWm719wtEP/yBiOV81vGPImvb3Q04fuEkK
         wpVT+ZnNOjhNQTVvV1qfc+JFC2zD9YbvSZtfXuq32MUXpK/UOxmpKafStNBhpGYgzqeW
         fcWck3682aLi9vw0kZ64kZWhVg62okBfqEcf/35I5iW5vTdO3gV8zSOSf3lLzpQDzE50
         1dJw==
X-Gm-Message-State: AOAM532f3zSp7Rn/o4vPzFzffspVQBbdpn0iYqhPxqkdoXABlEt6G/g6
        VN0i8sy3nIw4wRWThkhdplaz8lYZl8u5jQ==
X-Google-Smtp-Source: ABdhPJz3e6AEGrFW/LB3+VxM5EKf3/5TxZYxlD2VvueYdLvDJ23R1xdE/TCPUFjdcTuUtxd9C1DqRQ==
X-Received: by 2002:a9d:b86:: with SMTP id 6mr14808295oth.340.1623132020970;
        Mon, 07 Jun 2021 23:00:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a6sm2677080oon.20.2021.06.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:00:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/4] completion: bash: fix prefix detection in branch.*
Date:   Tue,  8 Jun 2021 01:00:07 -0500
Message-Id: <20210608060010.1676208-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608060010.1676208-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210608060010.1676208-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..47b48fbab6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2649,8 +2649,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.32.0.2.g41be0a4e50

