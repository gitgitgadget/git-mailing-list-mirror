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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E1C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7CD6100C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhEHAJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhEHAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501DC06138A
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so5737730wmb.3
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=XRTM6MSSbaFWMPO1AA+FMSdIYfzmGm60Mq/8E2tSeGUoMoN2Bwt15HOY9lJzil1Ri9
         23fe53NLsMX3FgOZYWWJfNndifq1kk5fkdiWokpr/oU3P6/5R3HvkZmrlHmjyCOa/dT4
         tBR205sabla83bOFTFMvysqCvu46NxAW+exKjV8wjazpdRcl42vfDK3BlcMPBQbOTXwL
         tMRTOnLjD9s74/6jK1IateDBlFMi0Xq4hxwa6xuUgnr+8F0jXSFFC7xw12GcrqEnpyBm
         gS2tlF4o7w3/8hjx9Ai0FSYAyeGbRKZLg1AgUqGBd2/fvKNroYZehPWpW/2aOnjoXiDy
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0e4RrCJuKuAV6s9KmC98iAx1qWZSkyg2U2VQQvqOO0E=;
        b=j1KbGovksLq6c9/KKaG+7dpyj58jNa9y/0aGbPdceYMganuj8n2xK8yMm5G/QrSRc1
         wRt55yjRAIOdE2tW3KrLz1JfKt8UZLye1ZKn7tIoXwzGrYWFbSsYUTcJXGr3yJXB0Llx
         +CD7ThbhuXr71ZilImq7wean1s0z6WxbyCsNzaf26CKrPCU1y3b3GlIBRHDReP1euh7M
         vdOC89hQXteb/OVrVfQ+YG0rqAXrEbfsAwB+OQTncmc6a6YTzW/Q3U2jUuujfu0SKnFX
         JPH/Fj2a/HhMNXGeT2zua1y1CIEr9pOHG4gElQpP9wjZUy1/T2p4F2xn6qJqshv4r1zB
         GWVA==
X-Gm-Message-State: AOAM530Y5jO+5XITKpg63ln4fLotZIVtorMsGxRqF7UDI9vTRfuS2lk4
        ggaKYogzCkC0rplZFxxm1i9HHLJSLmU=
X-Google-Smtp-Source: ABdhPJyV2qr0EyR75Kn/bLEYTbpVPONXCkv/xV0qj+5NLhqrJtWlNYcAcd76BUtG7Veuw1MRfIBNHw==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr12687101wmc.137.1620432504650;
        Fri, 07 May 2021 17:08:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s21sm8060854wmc.10.2021.05.07.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:24 -0700 (PDT)
Message-Id: <3d8dd00ccd10d6b7ce9f928f31f8a04e885730fc.1620432501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:17 +0000
Subject: [PATCH v2 5/8] [RFC] ls-files: error out on -i unless -o or -c are
 specified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

ls-files --ignored can be used together with either --others or
--cached.  After being perplexed for a bit and digging in to the code, I
assumed that ls-files -i was just broken and not printing anything and
had a nice patch ready to submit when I finally realized that -i can be
used with --cached to find tracked ignores.

While that was a mistake on my part, and a careful reading of the
documentation could have made this more clear, I suspect this is an
error others are likely to make as well.  In fact, of two uses in our
testsuite, I believe one of the two did make this error.  In t1306.13,
there are NO tracked files, and all the excludes built up and used in
that test and in previous tests thus have to be about untracked files.
However, since they were looking for an empty result, the mistake went
unnoticed as their erroneous command also just happened to give an empty
answer.

-i will most the time be used with -o, which would suggest we could just
make -i imply -o in the absence of either a -o or -c, but that would be
a backward incompatible break.  Instead, let's just flag -i without
either a -o or -c as an error, and update the two relevant testcases to
specify their intent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/ls-files.c          | 3 +++
 t/t1306-xdg-files.sh        | 2 +-
 t/t3003-ls-files-exclude.sh | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..9f74b1ab2e69 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -748,6 +748,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (pathspec.nr && error_unmatch)
 		ps_matched = xcalloc(pathspec.nr, 1);
 
+	if ((dir.flags & DIR_SHOW_IGNORED) && !show_others && !show_cached)
+		die("ls-files --ignored is usually used with --others, but --cached is the default.  Please specify which you want.");
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index dd87b43be1a6..40d3c42618c0 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -116,7 +116,7 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 test_expect_success 'Checking XDG ignore file when HOME is unset' '
 	(sane_unset HOME &&
 	 git config --unset core.excludesfile &&
-	 git ls-files --exclude-standard --ignored >actual) &&
+	 git ls-files --exclude-standard --ignored --others >actual) &&
 	test_must_be_empty actual
 '
 
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index d5ec333131f9..c41c4f046abf 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -29,11 +29,11 @@ test_expect_success 'add file to gitignore' '
 '
 check_all_output
 
-test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
+test_expect_success 'ls-files -i -c lists only tracked-but-ignored files' '
 	echo content >other-file &&
 	git add other-file &&
 	echo file >expect &&
-	git ls-files -i --exclude-standard >output &&
+	git ls-files -i -c --exclude-standard >output &&
 	test_cmp expect output
 '
 
-- 
gitgitgadget

