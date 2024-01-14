Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE485243
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuFDPSB/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso34666625e9.0
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705261852; x=1705866652; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wSoYpwPyV96gEb0DGSAZp3LNNvQtvNHcaOk+E4V1xPo=;
        b=IuFDPSB/xgNn1S9Icze+K23sAbGf79fCi2HKKXsA+ld1pPc9nkmf0rfu6CkAR2lLo9
         IVvx1I3MHfbpBuRWvlK5hj+IFcG5yS1Z+GQG4zA/ZddZ0CicOfGcpkdZWP17eadpG+5y
         ffBNYlvWTgJpjRGWSsXFSGEBIVpa/SNYQxYflXraX+CHgk0i/ffo1uXxqMfL2hoRC7/m
         cE3XI3e1kFdHtKgsNmD/L0Lc8jbYc9wQFGa3F7RA4u9h2D90gXv0CeS92hC/WKmxKpAN
         JEMB3bqykOfz0i+d83ZfUF5NoWRvKIjEqsjpDFI/pCyDiN07zvB/Qbw9XIdbkgf7ElXG
         jjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705261852; x=1705866652;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSoYpwPyV96gEb0DGSAZp3LNNvQtvNHcaOk+E4V1xPo=;
        b=Y3JijlUjrJbx5ctbi2F/kRrb6RZ9u94E5MoP+pRt9lK2dpTr6i69EKCtnx1KzlBM00
         s9mGs+/i1lyjBuZYj19sK+j6lZ5/XuZSGpORileluhFgG4RcGCPjD4I6RW0JcRfdcm5+
         cHVDy3FeJUQ3VftlwPzsMNM/SC/G5chIPXOXfILiTUAPsJZOngs/60c03Qg1BtVbnzH/
         EPxxNPwxICoKeenbIGRz2aBHEu75TvodUkmczWw8RWMTch3/smxoDhhbbUtsN7x6QIIf
         B3su9vIelUWKUqz7NYmgA3e9XhKnRdSv11pOqhRwfBbnvON4HMrMl2KIzvK7G9gFuG7c
         WNlw==
X-Gm-Message-State: AOJu0Ywdt/lYLijJnkPMBIT6D1EI27XkjtOexRoz8uTB7tDv9cI7Zx7O
	l0af9zzVt7tDev1cx4E8XoQ3E5IjR8M=
X-Google-Smtp-Source: AGHT+IFSlRPWFwpwrui7XCnLxbcUYlTK6QT1GfwHU91+9A3vlGB0PfxLVCnpCE9pOvi2fOtRW8yQKg==
X-Received: by 2002:a05:600c:2a15:b0:40e:7110:b3a0 with SMTP id w21-20020a05600c2a1500b0040e7110b3a0mr858035wme.149.1705261851699;
        Sun, 14 Jan 2024 11:50:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040e77ce8768sm1573157wmr.16.2024.01.14.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 11:50:51 -0800 (PST)
Message-ID: <pull.1645.git.git.1705261850650.gitgitgadget@gmail.com>
From: "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jan 2024 19:50:50 +0000
Subject: [PATCH] rev-list-options: fix off-by-one in '--filter=blob:limit=<n>'
 explainer
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Nikolay Edigaryev <edigaryev@gmail.com>,
    Nikolay Edigaryev <edigaryev@gmail.com>

From: Nikolay Edigaryev <edigaryev@gmail.com>

'--filter=blob:limit=<n>' was introduced in 25ec7bcac0 (list-objects:
filter objects in traverse_commit_list, 2017-11-21) and later expanded
to bitmaps in 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
2020-02-14)

The logic that was introduced in these commits (and that still persists
to this day) omits blobs larger than _or equal_ to n bytes or units.

However, the documentation (Documentation/rev-list-options.txt) states:

>The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n
bytes or units. n may be zero.

Moreover, the t6113-rev-list-bitmap-filters.sh tests for exactly this
logic, so it seems it is the documentation that needs fixing, not the
code.

This changes the explanation to be similar to
Documentation/git-clone.txt, which is correct.

Signed-off-by: Nikolay Edigaryev <edigaryev@gmail.com>
---
    rev-list-options: fix off-by-one in '--filter=blob:limit=' explainer
    
    '--filter=blob:limit=' was introduced in 25ec7bcac0 (list-objects:
    filter objects in traverse_commit_list, 2017-11-21) and later expanded
    to bitmaps in 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
    2020-02-14)
    
    The logic that was introduced in these commits (and that still persists
    to this day) omits blobs larger than or equal to n bytes or units.
    
    However, the documentation (Documentation/rev-list-options.txt) states:
    
    > The form '--filter=blob:limit=[kmg]' omits blobs larger than n bytes
    > or units. n may be zero.
    
    Moreover, the t6113-rev-list-bitmap-filters.sh tests for exactly this
    logic, so it seems it is the documentation that needs fixing, not the
    code.
    
    This changes the explanation to be similar to
    Documentation/git-clone.txt, which is correct.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1645%2Fedigaryev%2Ffix-blob-limit-off-by-one-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1645/edigaryev/fix-blob-limit-off-by-one-v1
Pull-Request: https://github.com/git/git/pull/1645

 Documentation/rev-list-options.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2bf239ff030..a583b52c612 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -947,10 +947,10 @@ ifdef::git-rev-list[]
 +
 The form '--filter=blob:none' omits all blobs.
 +
-The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
-or units.  n may be zero.  The suffixes k, m, and g can be used to name
-units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
-as 'blob:limit=1024'.
+The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
+bytes or units.  n may be zero.  The suffixes k, m, and g can be used
+to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
+is the same as 'blob:limit=1024'.
 +
 The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
 which are not of the requested type.

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
