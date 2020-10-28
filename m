Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C896C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC6320796
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGcWIriH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390309AbgJ1XX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390203AbgJ1XX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:23:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F1C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:23:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w23so796101wmi.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gdHc3WPIoT6Wz+DV4JsC+xcs9U/R4ea4ajU43oT4IyU=;
        b=XGcWIriHr6go9Y6gN1LBMlLj8rESGqyCA5qtN5KRVW9M/JjrhA2xSUN7f2ThoSGZSN
         h6DIbxw5GuVa3A7E4ejheM9DJpjuPkl2Tey18Piy8flgxYMnA6JOF0Q7W0zuPT4D1oyt
         +6d+yrOcCG64gRq3CEpkxCCS8KgVvgboTjX/9Ve7qLYNV6lAgUqh8agzDRF/n3ki3+f/
         oHfipUUQTcxUL/mAXQ5ApV5QnFTDer2kgGBnQQ5uw3fFOi8skG5PFTl/68KRIhJ7czVb
         sG42+pI7MQYPT4ok/yhy/ILVi9GhGFQBNzxiFhgA0uWhbx+f8zyFHdFWAjuwdYnrig95
         JcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gdHc3WPIoT6Wz+DV4JsC+xcs9U/R4ea4ajU43oT4IyU=;
        b=ERHbniRYVRa/AWymIhUfExCWI4rtAuaMR/CLw8Pkc/4gyYGvKZNqjDJPqN0aMl38to
         RGdSNVd+1a2m5yXkw31Ol1IcuW3YI75GTV1J5MMhoRVxkRT9luHBhOR1T31xTWm3QY+6
         hbxJOf3HrqVGXZ7/co9FJ/BzP1hc/cyyyB17QgHpUYyx8uA0sVtAuk47wMDFZWeGSNa0
         4LlJE5txUohotLURygfaENyjehTVHDTW/3BgrsZrhqa7SHFiFiUp/+aNeoFrk1KiigBJ
         bkaThWlELHN6wATIM3RYh4UUJXB9aa8RATSagb0hIUPovHj+VyMspL66W6cUXm+oE5cN
         xBtg==
X-Gm-Message-State: AOAM531xe3xa2qaZVPOKPGlB0CrB6f+cd4tcn/RaqafTuiHtmfybiKB5
        w3bokHoscdA8DwkXGvpMCMQeF8sVJgU=
X-Google-Smtp-Source: ABdhPJzEGc/ePs8spdrWyT7Gd+KNCMq2eAJMLQGA3OyLhtCm8TGJSs3BuOyZ/DaLhcg+nzDiArR9MA==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr5383337wmz.87.1603889275901;
        Wed, 28 Oct 2020 05:47:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm3353793wrn.32.2020.10.28.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:55 -0700 (PDT)
Message-Id: <da76a10717c917abab9e1bd5ab78db2a4f7ca7c0.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:48 +0000
Subject: [PATCH 4/6] doc: add more pointers to gitattributes(5) for userdiff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Several Git commands can make use of the builtin userdiff patterns, but
it's not obvious in the documentation. Add pointers to the 'Defining a
custom hunk header' part of gitattributes(5) in the description of the
following options:

- the '--function-context' option of `git diff` and friends
- the '--function-context' option of `git grep`
- the '-L :<funcname>' option of `git log`, `gitk` and `git blame`

In 'git-grep.txt', take the opportunity to use backticks in the
description of '--show-function', and improve the wording of the
desription of '--function-context'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-options.txt      | 5 ++++-
 Documentation/git-grep.txt          | 6 ++++--
 Documentation/line-range-format.txt | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 573fb9bb71..39b511bb6b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -695,7 +695,10 @@ endif::git-format-patch[]
 
 -W::
 --function-context::
-	Show whole surrounding functions of changes.
+	Show whole functions as context lines for each changes.
+	The function names are determined in the same way as
+	`git diff` works out patch hunk headers (see 'Defining a
+	custom hunk-header' in linkgit:gitattributes[5]).
 
 ifndef::git-format-patch[]
 ifndef::git-log[]
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6077ff01a4..4e0ba8234a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -241,7 +241,7 @@ providing this option will cause it to die.
 --show-function::
 	Show the preceding line that contains the function name of
 	the match, unless the matching line is a function name itself.
-	The name is determined in the same way as 'git diff' works out
+	The name is determined in the same way as `git diff` works out
 	patch hunk headers (see 'Defining a custom hunk-header' in
 	linkgit:gitattributes[5]).
 
@@ -266,7 +266,9 @@ providing this option will cause it to die.
 	Show the surrounding text from the previous line containing a
 	function name up to the one before the next function name,
 	effectively showing the whole function in which the match was
-	found.
+	found. The function names are determined in the same way as
+	`git diff` works out patch hunk headers (see 'Defining a
+	custom hunk-header' in linkgit:gitattributes[5]).
 
 --threads <num>::
 	Number of grep worker threads to use.
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 6ee159b683..ab3c70a1d5 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -27,4 +27,6 @@ regular expression that denotes the range from the first funcname line
 that matches '<funcname>', up to the next funcname line. `:<funcname>`
 searches from the end of the previous `-L` range, if any, otherwise
 from the start of file. `^:<funcname>` searches from the start of
-file.
+file. The function names are determined in the same way as `git diff`
+works out patch hunk headers (see 'Defining a custom hunk-header'
+in linkgit:gitattributes[5]).
-- 
gitgitgadget

