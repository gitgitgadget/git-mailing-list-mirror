Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18155C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E721D2072C
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfKsPVwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgDMP0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgDMP0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:26:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F36C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cb27so12396367edb.11
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VJqJXQr2WC/8FI4EHcvahIna9npL1l91IGyZNgw0l9o=;
        b=VfKsPVwIQpmCKt/gh9SmbGI8Tv0rfWMifx7buve4meWp9j91k98sNYurdrWe70WkBU
         2e3cxg5a3K/+oPXJwFYbJkN9j4CroAMT34huZ3sh0YGZuP2FPOdyGZddSf/JZp3VEBt6
         p7bazKndSMfbZEpj8PNhLNyxsZ958YhZHMF0PEysMETXI3vbbn+Ihgoju6hET6C3BB+8
         6kB3FCG7HAbRlvLJOkkStG5B5nVp9XPQYqHBZMNv2ej6XFyjWt0fgzdoJkImutCnWZIf
         2ffVBqf1/shTebkORwTaHjWT8TPR1qMaD2KG3GhKptLGH/I4qwrfczo8Kg5G6AT3NMR8
         3nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VJqJXQr2WC/8FI4EHcvahIna9npL1l91IGyZNgw0l9o=;
        b=AwmuBEt2vLYMVymwQSrTgOzoIsblJl1vwn/jzjR3m/RzDqVLwVei1hPtnHiaPuQFYD
         pTFicMbNVHkHQ/HxRb4idGcGLr/FkvdokboTSsi/0hyiFYvb8UwidyFV2jLLdYZSv+8n
         d79TStPCAXqLyfSIgQT7eP0XYuFh1K+1k7RRFtndECAUcMKlVnvMIlr7FQIqY5TwR5nM
         V7DaaSNLLZWIZMhXYsJ8ymi7v1XAWILR5hKLhpOoPqQu2DA0/EllQ6y74u3lWkqCbW5b
         Sky5Oe6DPvkJ2ptB58DzgR0QWqTpJHuZDV52MbV7me7Ru+j/qMyIAxGV0IC/qs/bdXO9
         SXng==
X-Gm-Message-State: AGi0Pua+lpOqH0h/1lnIARS9+xM6QnKfHZc8/JT0RgPVByjt/b+wQrjt
        VGE+ob/hVNXNkVRkT5d90VCzWt8e
X-Google-Smtp-Source: APiQypLDxQv7LLAKD1AEqZDeJBQXOTFP3/mf4MXjPUxKVuxt/6qS1eetsqAW7zk6iuAe+gbvAigGaw==
X-Received: by 2002:a17:906:7d7:: with SMTP id m23mr12643850ejc.154.1586791564475;
        Mon, 13 Apr 2020 08:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22sm1649160eje.7.2020.04.13.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:26:04 -0700 (PDT)
Message-Id: <c1a44a35095e7d681c312ecaa07c46e49f2fae67.1586791560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
        <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
From:   "Dyrone Teng via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 15:26:00 +0000
Subject: [PATCH v2 3/3] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Dyrone Teng <dyroneteng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dyrone Teng <dyroneteng@gmail.com>

Partial clones are created using 'git clone', but there is no related
help information in the git-clone documentation. Add a relevant section
to help users understand what partial clones are and how they differ
from normal clones.

The section briefly introduces the applicable scenarios and some
precautions of partial clone. If users want to know more about its
technical design and other details, users can view the link of
git-partial-clone(7) according to the guidelines in the section.

Signed-off-by: Dyrone Teng <dyroneteng@gmail.com>
---
 Documentation/git-clone.txt | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index eafa1c39927..a6e13666ea1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -310,6 +310,78 @@ or `--mirror` is given)
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
+Partial Clone
+-------------
+
+By default, `git clone` will download every reachable object, including
+every version of every file in the history of the repository. The
+**partial clone** feature allows Git to transfer fewer objects and
+request them from the remote only when they are needed, so some
+reachable objects can be omitted from the initial `git clone` and
+subsequent `git fetch` operations.
+
+To use the partial clone feature, you can run `git clone` with the 
+`--filter=<filter-spec>` option. If you want to clone a repository
+without download any blobs, the form `filter=blob:none` will omit all
+the blobs. If the repository has some large blobs and you want to
+prevent some large blobs being downloaded by an appropriate threshold,
+the form `--filter=blob:limit=<n>[kmg]`omits blobs larger than n bytes
+or units (see linkgit:git-rev-list[1]).
+
+As mentioned before, a partially cloned repository may have to request
+the missing objects when they are needed. So some 'local' commands may
+fail without a network connection to the remote repository.
+
+For example, The <repository> contains two branches which names 'master'
+and 'topic. Then, we clone the repository by
+
+    $ git clone --filter=blob:none --no-checkout <repository>
+
+With the `--filter=blob:none` option Git will omit all the blobs and
+the `--no-checkout` option Git will not perform a checkout of HEAD
+after the clone is complete. Then, we check out the remote tracking
+'topic' branch by
+
+    $ git checkout -b topic origin/topic 
+
+The output looks like
+
+------------
+    remote: Enumerating objects: 1, done.
+    remote: Counting objects: 100% (1/1), done.
+    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
+    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
+    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
+    Switched to a new branch 'topic'
+------------
+
+The output is a bit surprising but it shows how partial clone works.
+When we check out the branch 'topic' Git will request the missing blobs
+because they are needed. Then, We can switch back to branch 'master' by
+
+    $ git checkout master
+
+This time the output looks like
+
+------------
+    Switched to branch 'master'
+    Your branch is up to date with 'origin/master'.
+------------
+
+It shows that when we switch back to the previous location, the checkout
+is done without a download because the repository has all the blobs that
+were downloaded previously.
+
+`git log` may also make a surprise with partial clones. `git log
+-- <pathspec>` will not cause downloads with the blob filters, because
+it's only reading commits and trees. In addition to any options that
+require git to look at the contents of blobs, like "-p" and "--stat"
+, options that cause git to report pathnames, like "--summary" and
+"--raw", will trigger lazy/on-demand fetching of blobs, as they are
+needed to detect inexact renames.
+
+linkgit:partial-clone[1]
+
 :git-clone: 1
 include::urls.txt[]
 
-- 
gitgitgadget
