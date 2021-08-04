Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A63C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AED260EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhHDXvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbhHDXvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68825C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:50:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso4969798wms.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zmpnPsvcqb+mAFbyJP8JHp9yNg9HEjRw+9aOiMUR060=;
        b=C99PY3mn7DWMa/fprKg3uSzgu/bDgrDdawSnLI4d8CKXqgsOmhhrOzGcyvSI7Oaurf
         FqExMmvZH3K3A9GsTPHojAv1Ks0Lf2dLh4SlOPhwvlTI5vxQrGeEDk5t0amT42blpfyc
         vAQqblQrzSMC6q/S3k0n1TlvFVdfQ2+kPis8BOA3pkn89ht4HQlt3TBDd4p8KM/GC3EU
         fwRGSeRT5xl/7h0/to2krhCiGnWFcYqEec3Ac9EUYoWkiqlO1S54/wEpsd35mrln6N9B
         U2umBlweHfGTL/99Jv0Sf8Fo7TM2FpJjt3OHqy9AsjhZc/EZbQuZ88rlL5z/GYj4hJep
         9ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zmpnPsvcqb+mAFbyJP8JHp9yNg9HEjRw+9aOiMUR060=;
        b=P/+tytNZeHHFMmmxQ/SIu2gUn8X55Mf0Dof8xLv5MgIhnOVQ5O5wQBGEZj5tYIaDJv
         A54pjs4/OLm6QZcxF1CZOWHzWTuQpILk/j90mhCs8cp7PVhp9tJeGyiNoy56PZ22wU6C
         2Eb0DMUZdI5pDQuPUTKFi2GQJQ7t+xu9EwaoBrLk9C0aB6jZ2Hsua/4vRj2mc9jyrjEy
         2dTIbDepG53vCrGxsIjGFB+5CTTvP8ioat6JQJg425SHUtY2BtrjXOF+/D34jNmUut8o
         9/sPAOGRtKyHInHLdIpP3uDyhbiyYtQO1TdGCjwunBqEhJ09nhmkERvg+f5uSsdSvRdh
         xFNw==
X-Gm-Message-State: AOAM531HtYeFoRtLU+GgusZHSNNPl0HEsFOS3h3Nzn0tt9DQtVIkNv1d
        RDE6KXiVRk9Wi5lduBFURcgfORcDR50=
X-Google-Smtp-Source: ABdhPJwdq4PtpkQzJ7TJDWNv53vnLYWcHuITqD0pLE5qlyOs0B4hyV1RxuJmxbgAq+u10WLNtrEUIw==
X-Received: by 2002:a05:600c:17d8:: with SMTP id y24mr11913168wmo.91.1628121058060;
        Wed, 04 Aug 2021 16:50:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm4007667wru.67.2021.08.04.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:57 -0700 (PDT)
Message-Id: <48f72d7e0286a9cad5476292c45e811ff77596fd.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:47 +0000
Subject: [PATCH v3 03/10] Documentation: edit awkward references to `git
 merge-recursive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A few places in the documentation referred to the "`recursive` strategy"
using the phrase "`git merge-recursive`", suggesting that it was forking
subprocesses to call a toplevel builtin.  Perhaps that was relevant to
when rebase was a shell script, but it seems like a rather indirect way
to refer to the `recursive` strategy.  Simplify the references.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt       | 5 ++---
 Documentation/merge-options.txt    | 4 ++--
 Documentation/merge-strategies.txt | 9 +++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a67227846a..c3edcb07e3e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -354,9 +354,8 @@ See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
 --strategy=<strategy>::
-	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	Use the given merge strategy, instead of the default
+	`recursive`.  This implies `--merge`.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..f819bd8dd68 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,8 @@ With --squash, --commit is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
+	is used instead (`recursive` when merging a single head,
+	`octopus` otherwise).
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2912de706bf..5d707e952aa 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -51,10 +51,11 @@ patience;;
 	See also linkgit:git-diff[1] `--patience`.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
-	Tells 'merge-recursive' to use a different diff algorithm, which
-	can help avoid mismerges that occur due to unimportant matching
-	lines (such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Defaults to the
+	`diff.algorithm` config setting.
 
 ignore-space-change;;
 ignore-all-space;;
-- 
gitgitgadget

