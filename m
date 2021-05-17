Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E8DC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0966121F
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhEQFzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhEQFzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 01:55:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85BC061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 22:53:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i17so4977098wrq.11
        for <git@vger.kernel.org>; Sun, 16 May 2021 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pXy1HGqILamEapxgt3vvXikOU0PQ3e9U1mtdHle/EiU=;
        b=H2KuGe8ydOSn6Jfqe7K4PT8ARevl6rNhgkYvVP/SxfZYPLcA/mtlHIf92cMYiRGIY6
         b1fJH+7dwBRseZglatLkjBsFG7dUjVUa6NR+C1HGyeI8Yax9DIiTaXhCK09mqlYG6iAH
         Lm+zfqg2MMeUicM9R1Nmlav2X6YrDe+EXFCXPVeCDkHlKsEm94zQNU3Cey7aK2YlGioA
         2xnTX5qGNjyVW2gkY6OCQh0zdGuCv/elYuvsU2uLw88gE2z2bBssdsGn/Cy7Q0yrayhZ
         glloq8C+mF109TQFwUWfki7NbhrM1+Db5LbM85M59H+F8Xa76xKAEGEXae6IwRYuxv+K
         xw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pXy1HGqILamEapxgt3vvXikOU0PQ3e9U1mtdHle/EiU=;
        b=GGdlP2Uw5VmARQNAsrvHmAJg/Ny0c3xrA7iUTM67yM39C8YBi/BhAkO231mRjy6OiT
         nBZL+y1BUt+dXoXbfVVZYg9w4QNSQH2Mp2t174QyFclgR7PaZ5eARIQFk4fO9RPUj2gh
         Thk2stsRQoBilIA2Vll0PVr39xbpfRL51O7P9EfOkJjrFsgImH2893x/Or6tXSI5V5Mk
         Q8OtAgE2keUYV9yWJUUodFaRvMIWBweC3LSPGd2D8ZVp2GLcwn5Ic4vx6Pi8fu3S2uI/
         UXETthV34/nvhu7qAcBHkXszm6ZNqb/9n351r/XNarL0p1tHovzlITbTBdNySWQEjfLH
         8fKQ==
X-Gm-Message-State: AOAM531MtOBPRc8IhBzr5gsOxNiisGDJ7unvPGqE/SM/7OMRXihdPDg5
        N7Sp4qpVWwz73TrfTIRzeGY4Z0onhvs=
X-Google-Smtp-Source: ABdhPJyHf8XarjzRVGWSYeUPv/Ymx6crvuJsNn6Tk2zOQvYnEqacYHTbnU4bXCjneTinGcQOM5IUMw==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr6828724wrm.194.1621230832433;
        Sun, 16 May 2021 22:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm16560545wmh.32.2021.05.16.22.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 22:53:52 -0700 (PDT)
Message-Id: <pull.1026.v2.git.git.1621230831465.gitgitgadget@gmail.com>
In-Reply-To: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
From:   "Anders =?UTF-8?Q?H=C3=B6ckersten?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 05:53:50 +0000
Subject: [PATCH v2] describe-doc: clarify default length of abbreviation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Anders =?UTF-8?Q?H=C3=B6ckersten?= <anders@hockersten.se>,
        =?UTF-8?q?Anders=20H=C3=B6ckersten?= <anders@hockersten.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Anders=20H=C3=B6ckersten?= <anders@hockersten.se>

Clarify the default length used for the abbreviated form used for
commits in git describe.

The behavior was modified in Git 2.11.0, but the documentation was not
updated to clarify the new behavior.

Signed-off-by: Anders Höckersten <anders@hockersten.se>
---
    describe-doc: clarify default length of abbreviation
    
    Clarify the default length used for the abbreviated form used for
    commits in git describe.
    
    The behavior was modified in Git 2.11.0, but the documentation was not
    updated to clarify the new behavior.
    
    Changes since v1:
    
     * tweaked the wording in --abbrev parameter to better match
       implementation, as suggested by Bagas Sanjaya
     * trailing whitespace removed
    
    Signed-off-by: Anders Höckersten anders@hockersten.se

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1026%2Fahockersten%2Fdescribe-doc-abbreviation-clarification-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1026/ahockersten/describe-doc-abbreviation-clarification-v2
Pull-Request: https://github.com/git/git/pull/1026

Range-diff vs v1:

 1:  a3aa09ab6fca ! 1:  4cf527801901 describe-doc: clarify default length of abbreviation
     @@ Documentation/git-describe.txt: OPTIONS
      -	Instead of using the default 7 hexadecimal digits as the
      -	abbreviated object name, use <n> digits, or as many digits
      -	as needed to form a unique object name.  An <n> of 0
     --	will suppress long format, only showing the closest tag.
      +	Instead of using the default number of hexadecimal digits (which
     -+	will vary according to the size of the repository with a default of 
     -+	7) of the abbreviated object name, use <n> digits, or as many digits
     -+	as needed to form a unique object name.  An <n> of 0 will suppress 
     -+	long format, only showing the closest tag.
     ++	will vary according to the number of objects in the repository with
     ++	a default of 7) of the abbreviated object name, use <n> digits, or
     ++	as many digits as needed to form a unique object name. An <n> of 0
     + 	will suppress long format, only showing the closest tag.
       
       --candidates=<n>::
     - 	Instead of considering only the 10 most recent tags as
      @@ Documentation/git-describe.txt: at the end.
       
       The number of additional commits is the number
     @@ Documentation/git-describe.txt: at the end.
      -The hash suffix is "-g" + unambiguous abbreviation for the tip commit
      -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
      +The hash suffix is "-g" + an unambigous abbreviation for the tip commit
     -+of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The 
     -+length of the abbreviation scales as the repository grows, using the 
     -+approximate number of objects in the repository and a bit of math 
     ++of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
     ++length of the abbreviation scales as the repository grows, using the
     ++approximate number of objects in the repository and a bit of math
      +around the birthday paradox, and defaults to a minimum of 7.
       The "g" prefix stands for "git" and is used to allow describing the version of
       a software depending on the SCM the software is managed with. This is useful


 Documentation/git-describe.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a88f6ae2c6e7..c6a79c2a0f29 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -63,9 +63,10 @@ OPTIONS
 	Automatically implies --tags.
 
 --abbrev=<n>::
-	Instead of using the default 7 hexadecimal digits as the
-	abbreviated object name, use <n> digits, or as many digits
-	as needed to form a unique object name.  An <n> of 0
+	Instead of using the default number of hexadecimal digits (which
+	will vary according to the number of objects in the repository with
+	a default of 7) of the abbreviated object name, use <n> digits, or
+	as many digits as needed to form a unique object name. An <n> of 0
 	will suppress long format, only showing the closest tag.
 
 --candidates=<n>::
@@ -139,8 +140,11 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + unambiguous abbreviation for the tip commit
-of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
+The hash suffix is "-g" + an unambigous abbreviation for the tip commit
+of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
+length of the abbreviation scales as the repository grows, using the
+approximate number of objects in the repository and a bit of math
+around the birthday paradox, and defaults to a minimum of 7.
 The "g" prefix stands for "git" and is used to allow describing the version of
 a software depending on the SCM the software is managed with. This is useful
 in an environment where people may use different SCMs.

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
