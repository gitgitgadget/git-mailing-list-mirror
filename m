Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4BEC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B42074B
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMIxflU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgFIAEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgFIADr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 20:03:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0EAC08C5C5
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 17:03:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so1321026wmi.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zJXRHFxc0OC9MMHLup2QPzwJeTQ+v7aq/X3jjRV48Hw=;
        b=pMIxflU40XxiclqqE0oEhNduDc7JSbmBFM4ocoSJzBMmurF/zBhW2/l9Dp1B2L0JVQ
         jo/IfuEJWOh6MrGGI+e15niaYsd1mIpzkJXjesSMtPgDCUjG+liBpYZTHHhiOZo2aTT7
         6ySylT2ulpvJcYxF7d8B66ELsz46A3oX8Y8K5Zh9sD5P4haiWl4u6HOOiPqDNNIRBkkE
         Jug7CPu6J49IIAZsjXR7e5SqMEB6ES3ArVRzaCUDwqJr1pd79PDgU+YwUOWZ4U6WHSvC
         p+zpFG4Xw3WMQg+RAoeE9PaRVCa07HjpljLcBjd8TDKvq5WzaPudtX/kJIoJ1AmkKtnC
         teqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zJXRHFxc0OC9MMHLup2QPzwJeTQ+v7aq/X3jjRV48Hw=;
        b=dr4+XJgcKAiagWYpR0hTNMNIHno5TYIv6VsAjGc8JF3OZpzCW6VcQ29WlLDrXnOV4H
         5qeINM9Ss/v6+B1WbdHBL3eeFOT/VF/hX6WCs1WXSo9Riu47o+wZnEtY3UYKZSHHlA1R
         kuOq8xuAcDrYQCnr8oyMTFAyHWzs+UOB2LLVJhQcDoZTW20bzWPhcD12bTp+ejM9oTEK
         FqgEsjktQwFXX6dvSw/eWiKTe64PgSB9tgZPRt54fZxwzUhBiUFIICrK8UWwE+trzSVx
         fvqm/xAFuOI/uF9L8EYouiZ6nh6eXl66Gu02eeB/fy5gkSGl9qq5I/aoYnsVFE5XaoSn
         TGVA==
X-Gm-Message-State: AOAM530GgRbbk+F3ikwxba5Ofv/+guB1m3dMi8rcB0+8EIy2IS/K3FW2
        kY8LnXxW6Xyc88mzNN2Zqwmr5dh8
X-Google-Smtp-Source: ABdhPJxjGqcL/ncZ0FMeDZR6f1TdubLi4mmOqGOgVe+DVLE1P2F39cgcSpyBSTYD89WBJHjbNt/SEw==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1084795wmj.35.1591661025563;
        Mon, 08 Jun 2020 17:03:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm1315037wro.32.2020.06.08.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 17:03:45 -0700 (PDT)
Message-Id: <9318365915cfe1898b2942c735d675656ce7b5e5.1591661021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 00:03:41 +0000
Subject: [PATCH 3/3] Documentation: tweak git diff help slightly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

Update the manual page synopsis to include the two and three
dot notation.

Make "git diff -h" print the same usage summary as the manual
page synopsis.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 Documentation/git-diff.txt | 2 ++
 builtin/diff.c             | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 37781cf1755..c6a201abd72 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -12,6 +12,8 @@ SYNOPSIS
 'git diff' [<options>] [<commit>] [--] [<path>...]
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]
 'git diff' [<options>] <commit> <commit> [--] [<path>...]
+'git diff' [<options>] <commit>..<commit> [--] [<path>...]
+'git diff' [<options>] <commit>...<commit> [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
 'git diff' [<options>] --no-index [--] <path> <path>
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 8b8b95ec97e..365f9e9a908 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -24,7 +24,14 @@
 #define DIFF_NO_INDEX_IMPLICIT 2
 
 static const char builtin_diff_usage[] =
-"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
+"git diff [<options>] [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <commit> <commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <commit>..<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <blob> <blob>]\n"
+"   or: git diff [<options>] --no-index [--] <path> <path>]\n"
+COMMON_DIFF_OPTIONS_HELP;
 
 static const char *blob_path(struct object_array_entry *entry)
 {
-- 
gitgitgadget
