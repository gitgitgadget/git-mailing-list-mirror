Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E9C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357809AbiFVO33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358029AbiFVO2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FD1A051
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r20so3256759wra.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+r5och2DZ/8noC0JmNt3LVq+VX5ioGRh30WmY3pn6g=;
        b=M9TuZyWGcbAN74fmp1/w1g6bdJ7oyZtJpPxQAbgmHDgvwpka6e9Irb2Omw1RS669l8
         1RZiQpVZ4RTwbdUrwsvrjAeJQHywiw7n+yBK9JGaLLSZ/od0ESBmHXslzKyFU9SZzce6
         MD1OAAom6D0NKUug73BOoTCzCOg4Rj+UmCi2s8cBr9/lanka4zitvbBfMET0TSRMx6J2
         JocXlRKt7L8bP1sMm/JZgQKdhJ0Ri4MSCp9QDTPIScH59Ry7Hwjol4Ms2ZqT+MRSGgBu
         lGcfiTmMwb8ikScPprA25r0AHKvpjOM7k63nfSaTXhRwOBZk2yahj0C1IAsFDJZ9DF1M
         OaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+r5och2DZ/8noC0JmNt3LVq+VX5ioGRh30WmY3pn6g=;
        b=Ss+S4yhDMCz7XmkYzkb4KpHH4SDkphQeBTBI5DGpAs7syv8+7pKB4JO8QOjM44inh2
         Pq978DIshU6nV7HhbvyGXbY8G1zCL4XZB8kvc3zRfuaZ4nb5Rp0HEV4tug5gKuYhSMcA
         awR4RerXsP4svTq7ZLYG9KorSAp8q96Vp8JdHjhBD3wZtVN7bVESIjtUGfZa5xaiJ92z
         w/tgoySqJD0eOqy4eZxHWtW5vRAX/ZHRzgLnvBrhmhBH3mbUVthMtBeQVP+OaFh9xxf8
         SkQLywa35+FFZsoyXHdGebtQQx+4xYGokGp3kBolaWX4mh+tMlGOOWWSoZjwE5COneU6
         V1VQ==
X-Gm-Message-State: AJIora/RjTXz/vWc3dZRXeRjwjYdXQuU+CslM2ErfuASiZKKXsdKiJqz
        3fIn6muc5RymBfkyTvl/gn+IuYp0vCoTGA==
X-Google-Smtp-Source: AGRyM1t21HWA3g9p6WoLWKc6SUd3iyvQYV2+rf79qHGf0xFFzSf3lmnY+7bb2EyAfuAPKcHBE3viuA==
X-Received: by 2002:a5d:49cf:0:b0:21b:818a:a09b with SMTP id t15-20020a5d49cf000000b0021b818aa09bmr3640433wrs.676.1655908093149;
        Wed, 22 Jun 2022 07:28:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/12] git-submodule.sh: make the "$cached" variable a boolean
Date:   Wed, 22 Jun 2022 16:27:58 +0200
Message-Id: <patch-v3-03.12-3948aa5d782-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the assignment of "$1" to the "$cached" variable. As seen in
the initial implementation in 70c7ac22de6 (Add git-submodule command,
2007-05-26) we only need to keep track of if we've seen the --cached
option, not save the "--cached" string for later use.

In 28f9af5d25e (git-submodule summary: code framework, 2008-03-11)
"$1" was assigned to it, but since there was no reason to do so let's
stop doing it. This trivial change will make it easier to reason about
an eventual change that'll remove the cmd_summary() function in favor
of dispatching to "git submodule--helper summary" directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 53847bbf6e2..b99a00d9f84 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -446,7 +446,7 @@ cmd_summary() {
 	do
 		case "$1" in
 		--cached)
-			cached="$1"
+			cached=1
 			;;
 		--files)
 			files="$1"
@@ -583,7 +583,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached="$1"
+		cached=1
 		;;
 	--)
 		break
-- 
2.36.1.1239.gfba91521d90

