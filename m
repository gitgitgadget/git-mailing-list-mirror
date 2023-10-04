Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E36AE936E7
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 21:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbjJDVqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjJDVq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 17:46:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF5D7
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 14:46:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so3732441fa.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696455982; x=1697060782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaoLmD52Y+EL+MseUZEJT5nWlN61NOhtDRWfe/woSqc=;
        b=kBUm0Mdr2ER1vMYf7phDAZ/bouPAQQXDzonxU8trMMdCVP26lIDFOgnFVnUvgteiyW
         JIEwHpVsx0RfXjweO1sSXoNed1oYNbycxhi4sCScLaZNDfFhT2kYIsVfZMZ+9SbopxYs
         i3e5D3E7lhdMP5nh1NCfJDJwscyjTK0r+WHagduvL0tv/xOzHKTQsRtdStzhAk0vBpSq
         vhA2j/LUXJaQ8jWpPujuIBAH+CuJFiuGuG9LZd6j/5XWr/ly/0qYYtb74tPXZF0/ufbd
         RywF8GXWImvw1jBSD+3gsV24YOXzjfm09K5Euvmog0i4H6K0xK4HY0djeCPJ74yLrKE3
         nIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696455982; x=1697060782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaoLmD52Y+EL+MseUZEJT5nWlN61NOhtDRWfe/woSqc=;
        b=w5jNh4gkvsk4ImpTDGudMOwRNRvgtc73tX9DalFjy4iuURqkifOfDwT/DxvFm0FLHF
         r0Fo68qgfaSgjwIqhMEB3FdZJjnhGGc+X2UUqJPAqf3Dajsv5mWt605w27dXU6gnxAmW
         MM52ZSSfpaVzRGhZ/upSDSW0N545v95bSoZSBp8gGkmAk8nqBnjEWEWERgtWrZ7RRq1U
         YMoqHfeBAt0263wMbvVYI5Mlh+BOnVwq4qTwJDNUrURGvMphVButeV5inAarm2h6hJga
         XYgP15pMbTem0Hx1ToCvKCaO8jMoQRBPFIJ9vYhCYV3kC2Xishve6/I5ImvUo96q++WL
         JLmw==
X-Gm-Message-State: AOJu0Yz4V5YELqS/QWdTTRECqc0u6RvVFkj3LZ7WgbeysFdcvUt0x52P
        9wbwsWFwS5fMMBZHey5A12U=
X-Google-Smtp-Source: AGHT+IF8/khzyWGgWdCSgx68inyCip0bNjsg6hUp/9BEoa4w+dnSDIDPYB2s+km2hcS6ttIidEBmqQ==
X-Received: by 2002:a2e:7c15:0:b0:2b6:e2e4:7d9a with SMTP id x21-20020a2e7c15000000b002b6e2e47d9amr3297414ljc.38.1696455981775;
        Wed, 04 Oct 2023 14:46:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b002bfba0d26bcsm7818ljj.8.2023.10.04.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:46:21 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 3/3] completion: complete '--dd'
Date:   Thu,  5 Oct 2023 00:45:58 +0300
Message-Id: <20231004214558.210339-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231004214558.210339-1-sorganov@gmail.com>
References: <20230909125446.142715-1-sorganov@gmail.com>
 <20231004214558.210339-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'--dd' only makes sense for 'git log' and 'git show', so add it to
__git_log_show_options which is referenced in the completion for these
two commands.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae7..ca4fa39f3ff8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
 "
 # Options accepted by log and show
 __git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
+	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-- 
2.25.1

