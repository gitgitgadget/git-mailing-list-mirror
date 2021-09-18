Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ADC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A39610A5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhIRXQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbhIRXQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB94C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so21601814wrb.0
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/3m+7QqjHSrfqnwKbprHOY8NTr4Stirdf/5VwuV4OCM=;
        b=jNsX3EKQDvJiWo9duKajnqAwEeTxC/BYQrY5TOJicctG11tfGJOP0gnMfuemd/oX7J
         jaeAaPz5uJYNqmNR2FuleboLEmU5COccKiWvb18eL1LMwBa8NLVdTPyvXT+WlaFCEOc/
         kBQ1J3yhLTPtIR94Kho8cK51332GK2RZXHEBctp7+9CnJ/SQtqu34ESfdYD2tRyzAJeJ
         US6IECX+1+FC/OGxTAHZk9Et+rngMv2iRFzicI2GlLhgGtULZ1rObw0xOhsKliTW47wv
         CQSdYX+qRHK4P1/YSoAFUuf0baiH2A5J5q03D9dUiJDrZBt7TV2NU78LBcb2zCyOKDFD
         mv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/3m+7QqjHSrfqnwKbprHOY8NTr4Stirdf/5VwuV4OCM=;
        b=NwKP92m1F0qG/MNmMvKCjCvs6RK2hiG6RbH+mB3/AbWW9hWaldyY6zH9EZ4dmPpkWY
         CAOZ+E1kLbhfIs9bHY1GXWPZQnAER2MkoKVm9m6QkOIxI3oyzJzObTKO42QU7vibfhfC
         h2jvdvxl4KE0vx+H9fVhC5GFpmmSpaFn19Kb9BxKPSgNjBhwMjqG7vLM6SkcY2lsnhjQ
         uI7jNp6VCFNwzfZIH01S1c6qBWVH0W7T57Vi6VnCgYmRUT8HSA2bOMoa4GHyz2gusV/W
         MDuNKaWPRRJU73JiuOye+b5DuCKfFerwRutPrxCqMo2tRyilRI1eB1hieTewF0WixfUz
         wkUA==
X-Gm-Message-State: AOAM531uYfoPeaDVUtw7w2mOX+Qlu72/jwknEho8jprtTcijZcPJyd/S
        FeinQZdO2mNwpw6qiV5wxiZdNRv7boE=
X-Google-Smtp-Source: ABdhPJx0EsfDDWvIKq06fE6loS/nYUxZG0mswXRuOL0KFZla7eJfeaZSKlFmnA7WTYs8CrnQx/W3vg==
X-Received: by 2002:adf:f011:: with SMTP id j17mr19854082wro.320.1632006929247;
        Sat, 18 Sep 2021 16:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm11179301wrt.41.2021.09.18.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:28 -0700 (PDT)
Message-Id: <6ea23d165cf1f9433831cb4a01abf6f483a8bc29.1632006924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:23 +0000
Subject: [PATCH 6/6] Documentation: call out commands that nuke untracked
 files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Some commands have traditionally also removed untracked files (or
directories) that were in the way of a tracked file we needed.  Document
these cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-checkout.txt  | 5 +++--
 Documentation/git-read-tree.txt | 5 +++--
 Documentation/git-reset.txt     | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..d473c9bf387 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,8 +118,9 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from `HEAD`.  This is used to throw away
-	local changes.
+	working tree differs from `HEAD`, and even if there are untracked
+	files in the way.  This is used to throw away local changes and
+	any untracked files or directories that are in the way.
 +
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5fa8bab64c2..4731ec3283f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -39,8 +39,9 @@ OPTIONS
 
 --reset::
 	Same as -m, except that unmerged entries are discarded instead
-	of failing. When used with `-u`, updates leading to loss of
-	working tree changes will not abort the operation.
+	of failing.  When used with `-u`, updates leading to loss of
+	working tree changes or untracked files or directories will not
+	abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 252e2d4e47d..6f7685f53d5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -69,7 +69,8 @@ linkgit:git-add[1]).
 
 --hard::
 	Resets the index and working tree. Any changes to tracked files in the
-	working tree since `<commit>` are discarded.
+	working tree since `<commit>` are discarded.  Any untracked files or
+	directories in the way of writing any tracked files are simply deleted.
 
 --merge::
 	Resets the index and updates the files in the working tree that are
-- 
gitgitgadget
