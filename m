Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76276C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5897F613CE
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhEHUAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhEHUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE37C061761
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n205so7014867wmf.1
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0IcNdyy+P1E9kfy1TvyMMUfCIsm+EFtiBPGU4jbxVqE=;
        b=DSwhZQnr/Y/SvMyi0QtAo7YXb8TMWM6L68Nzkhg0pPYf4ZM2HjaKrENBx6LWnSdxUB
         jXw4NoUTjSlDbwIy11tIRIA7mS44C0J9zfStr3Wzu9wlbPF4bDeogM1Ab0ctHa5/+PZd
         9G3AqlfOAS+yoIzIpBuQJJ699gR09Ak25vZMcetXJHWA3lvFzXQMWVARMV7Fnogjt41/
         V38Mro7V6crNvGWSCkzHvMg2/mwxKbBdicLqSTdw7dlop4eLD8Zx4tJcGbRT0M+0GqO/
         mZiZpE5fnrCcqw7QoEOzbn+TVzBMoDcrSccyE8GqZnnKORYljkm0qKiK+hNp4wmHbXx/
         69yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0IcNdyy+P1E9kfy1TvyMMUfCIsm+EFtiBPGU4jbxVqE=;
        b=f+734AJQ2PD6pfCAlswG7IY89vIdEywmWk2Ie3P1MQu5RYfBDmOzeud5faQofMA4tc
         daPIy++2TKw9Hbz5pjQLYgzJp7qzc71ZcrbycY+gm0zWsv3O+MqDJeG0CG4KB7yV8qTs
         LK0F2NbQ4yg/hNX+h0IdeQCEil8/+QEDCBmENxcU25Idcf73jfM+jWVHDbRJHzpMgUSG
         keoAORASI3ctFN8ARsq2nriXLTr0ZfNwu1BXp5fvf9nX9on80H0dIUmPmwlLE2NfmDj9
         GeZbeJ6VfvIAHTkxSRIiSc1cBijrXphEg/y4szRnaBGIMiZcCaeN1wsaVmxJPaDt8PhM
         uX3g==
X-Gm-Message-State: AOAM532LYcC+ovtq0fx7b0Zd9M+cU89mOV+40yIGgxT9Zfjls106kuat
        z4fvM8lE3Gmsg1eEE/VqOb499z+5YO4=
X-Google-Smtp-Source: ABdhPJxAJ6DvfuRZzpxwQ30P+40q/sNnWS6Yl6iwOqe97CPFh/NLjesbuScBv090tj8Dabzc4snNzQ==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr16859848wmc.131.1620503950458;
        Sat, 08 May 2021 12:59:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm19246904wmc.46.2021.05.08.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:10 -0700 (PDT)
Message-Id: <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:59:00 +0000
Subject: [PATCH v3 4/8] t7300: add testcase showing unnecessary traversal into
 ignored directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The PNPM package manager is apparently creating deeply nested (but
ignored) directory structures; traversing them is costly
performance-wise, unnecessary, and in some cases is even throwing
warnings/errors because the paths are too long to handle on various
platforms.  Add a testcase that checks for such unnecessary directory
traversal.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a74816ca8b46..b7c9898fac5b 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -746,4 +746,26 @@ test_expect_success 'clean untracked paths by pathspec' '
 	test_must_be_empty actual
 '
 
+test_expect_failure 'avoid traversing into ignored directories' '
+	test_when_finished rm -f output error trace.* &&
+	test_create_repo avoid-traversing-deep-hierarchy &&
+	(
+		cd avoid-traversing-deep-hierarchy &&
+
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdxn -e untracked
+	) &&
+
+	grep data.*read_directo.*visited trace.output \
+		| cut -d "|" -f 9 >trace.relevant &&
+	cat >trace.expect <<-EOF &&
+	 directories-visited:1
+	 paths-visited:4
+	EOF
+	test_cmp trace.expect trace.relevant
+'
+
 test_done
-- 
gitgitgadget

