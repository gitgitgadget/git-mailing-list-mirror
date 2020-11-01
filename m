Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31031C388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E675A2225C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJFN2H1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgKAR2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKAR2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEBAC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so1124620wrl.7
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lYkCC/XhpsvZEYMbyETUyzIgqzKocwovbfQT60HnuCs=;
        b=OJFN2H1t6nqJbnok0NhaQzagh3Gl84xwwp07wojarHrM2BZE5In0oIilJ8RCmFdVco
         Q0pGRINrzIUgAdC9tgo5CyP5P7LkbOEN0ToEDyuH96K8GluMKt2DA7U/BDfkFTkoqrw7
         NPVyC+IwrX7NezQCSVOPEV15K+7H2UppnyS10GN4SXviiHwJfJfcXD+4/gLogx0Q+9Za
         mCi0zPxIX4go36en7TGQ1OXQuFPeeqjxcUCCMWUQ9AEJIktW1WV/9mIQ9mM/OPdwHiXh
         pMnZYSaxNqapgsHx8WAqYBMBeeP7EZYNRi0XnuFfRbncDWPNGACXBa2YxLLYL70bvTgN
         oQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lYkCC/XhpsvZEYMbyETUyzIgqzKocwovbfQT60HnuCs=;
        b=hgNOeUwXgckpyy9jYO0BRTRRGQvMGpg5+Yx9i8lSxN85/2zU5gBmLSyNbdAI6xzazV
         pfjLeeI0far9g1rlXPBBQVKRTUzbxOuK6f6F7Ml4H+x1eE+mfBCkeYKD7Y9YTpiRTP/x
         zst28eKMweTWB68w4LzU+zs7QkIsWvrxrC8IFVh3LzKqaC/V9VaJffKD7W5m8SFnE2/f
         c2VF5MX/duTuAf4YzXLbq6Y2KTac8lAHmfBtouXiwr92OlzJQqbooU3Xk/tNXdcFP9UJ
         x0NxcVijZqgs7tB5kXspm+6SX2tRmDqgGTeOvBIzR49rGqmW8wN7sO5Cz75E5SQi1cHG
         YFcw==
X-Gm-Message-State: AOAM531OX0Ktl5sBpjKctka7LpngCFeV9uURrIHCKP3wpFCkvHG0KcYN
        fzEgCjNujzDou6k4y74Za2BBV9p/PCA=
X-Google-Smtp-Source: ABdhPJwzrVPkbZsxxbhSNFP59+/I+uwIsO19BimTnLZKMcJm5lRIOKwp9rz/sYEbO/WxEg7HQsC+SA==
X-Received: by 2002:a5d:660a:: with SMTP id n10mr15836811wru.59.1604251732393;
        Sun, 01 Nov 2020 09:28:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2sm4049215wmc.28.2020.11.01.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:52 -0800 (PST)
Message-Id: <9443a681e3c26410d0c262ac52fc604b39a89421.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:43 +0000
Subject: [PATCH v2 4/8] doc: add more pointers to gitattributes(5) for
 userdiff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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
index 573fb9bb71..72b558ce21 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -695,7 +695,10 @@ endif::git-format-patch[]
 
 -W::
 --function-context::
-	Show whole surrounding functions of changes.
+	Show whole function as context lines for each change.
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
index 43759eef89..9b51e9fb66 100644
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

