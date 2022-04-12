Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D6C433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353153AbiDLTUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350381AbiDLTUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:20:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56C36B7C
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:17:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e8so12724848wra.7
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HoLlkMAB4MzQ69B+xcHE1iy0qKcuoUqNtTOcLeayHo=;
        b=I969pUKIfpIIqkOQAdMUUBoE/7Mqhf0UrC1XlPcC673AqR9sm3SfcDrUCR2WlwfQhc
         uzy4+ic8BSw4GN3/ebG5H0yt6DQDLmb2a3j6vsYeg2Jya0f2a2W7L7f4xrLSbuk9fM/R
         LS/JSuXsdiyTDR2cij0mERrKdi3VVYjElrzVbgcY1CsxpKfH922iAw5hADDF1+rAHbQl
         B2fsRgyExNRwM/5nGZNW5kYvn/0KRJuyVNY/IMHBEcJgqzEPd+E7ONOHneHCRSbHp9M5
         A0ejQcsSp8Z3hHSSTHKqAr1p1EsI5mkI78Tpofc+jYisSIKIrXq5bVcSTuN/KAO1JuMw
         bMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HoLlkMAB4MzQ69B+xcHE1iy0qKcuoUqNtTOcLeayHo=;
        b=o+eFMaSOhFUFJvqLzti+bH3qTLjHgt4IqDSj7ay3zIEKVKERYNy4/hdNM6rdlgxc4c
         DpgFZYb1JJl8lOjOA9ZC2LOa0P4z1UDaHHzkqX/gwIdv0wEf3v3zI8dIjQWPz3bVVj2U
         YdgvO90TD+U/2W5H5/xcroB2+sCIa2OdtAa7s1mCHmJDfvz7WiO32nR9GQ9hY8zEez3R
         O1Nr7bpcL/CaVUaQ7zAcRxhBv77aJQosf5tMB4hLfQqPoBu04PIDBqAQ+XRRU1E8UFyF
         6NxgXH/oGzsW3QCeahfgGCl5g6EUgatHCaTxEj6M0kaVuXG4ygnDH+UxISzDjtuSES6w
         C24Q==
X-Gm-Message-State: AOAM532M4qGdVyvVTNXnwFnumNTCEQKWqs0nSvs1pioaIjSk7gj0vfcJ
        9W7V8VmVyh/sP6JYUp+p8VVFKFlTeVI=
X-Google-Smtp-Source: ABdhPJy0GLEEnTsVftnQL6CRD1Zpifmm2dUD5OWr+k3GQ+ZTByt3QGVJiuj8FwjMUFZN+bcEctm1AQ==
X-Received: by 2002:a5d:65cf:0:b0:207:a62c:ecc2 with SMTP id e15-20020a5d65cf000000b00207a62cecc2mr9273251wrw.55.1649791071707;
        Tue, 12 Apr 2022 12:17:51 -0700 (PDT)
Received: from localhost.localdomain (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id az30-20020a05600c601e00b0038ebd950caesm289223wmb.30.2022.04.12.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:17:51 -0700 (PDT)
From:   Jonathan <git.jonathan.bressat@gmail.com>
X-Google-Original-From: Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
To:     cogoni.guillaume@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Subject: [PATCH 1/1] Merge with untracked file that are the same without failure and test
Date:   Tue, 12 Apr 2022 21:15:56 +0200
Message-Id: <20220412191556.21135-2-Jonathan.bressat@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.35.1.7.gc8609858e0.dirty
In-Reply-To: <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
 <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a merge while there is untracked files with the same name
as merged files, git refuses to proceed. This commit change this
behavior and make git overwrite files if their contents are the same.
This new behaviour is more pleasant for a user and will never be a
frustrating moment.

Add a if statement that check if the file has the same content as the
merged file thanks to the function ie_modified() (read-cache.c).
ie_modified () checks the status of both files, if they are different,
it verifies their contents.

Add new tests that need to pass to confirm that the new feature works.

Co-authored-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 t/t7615-merge-untracked.sh | 79 ++++++++++++++++++++++++++++++++++++++
 unpack-trees.c             |  4 ++
 2 files changed, 83 insertions(+)
 create mode 100755 t/t7615-merge-untracked.sh

diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
new file mode 100755
index 0000000000..71a34041d2
--- /dev/null
+++ b/t/t7615-merge-untracked.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='test when merge with untracked file'
+
+. ./test-lib.sh
+
+
+test_expect_success 'overwrite the file when fastforward and the same content' '
+    echo content >README.md &&
+    test_commit "init" README.md &&
+    git branch A &&
+    git checkout -b B &&
+    echo content >file &&
+    git add file &&
+    git commit -m "tracked" &&
+    git switch A &&
+    echo content >file &&
+    git merge B
+'
+
+test_expect_success 'merge fail with fastforward and different content' '
+    rm * &&
+    rm -r .git &&
+    git init &&
+    echo content >README.md &&
+    test_commit "init" README.md &&
+    git branch A &&
+    git checkout -b B &&
+    echo content >file &&
+    git add file &&
+    git commit -m "tracked" &&
+    git switch A &&
+    echo dif >file &&
+    test_must_fail git merge B
+'
+
+test_expect_success 'normal merge with untracked with the same content' '
+    rm * &&
+    rm -r .git &&
+    git init &&
+    echo content >README.md &&
+    test_commit "init" README.md &&
+    git branch A &&
+    git checkout -b B &&
+    echo content >fileB &&
+    echo content >file &&
+    git add fileB &&
+    git add file &&
+    git commit -m "tracked" &&
+    git switch A &&
+    echo content >fileA &&
+    git add fileA &&
+    git commit -m "exA" &&
+    echo content >file &&
+    git merge B -m "merge"
+'
+
+test_expect_success 'normal merge fail when untracked with different content' '
+    rm * &&
+    rm -r .git &&
+    git init &&
+    echo content >README.md &&
+    test_commit "init" README.md &&
+    git branch A &&
+    git checkout -b B &&
+    echo content >fileB &&
+    echo content >file &&
+    git add fileB &&
+    git add file &&
+    git commit -m "tracked" &&
+    git switch A &&
+    echo content >fileA &&
+    git add fileA &&
+    git commit -m "exA" &&
+    echo dif >file &&
+    test_must_fail git merge B -m "merge"
+'
+
+test_done
\ No newline at end of file
diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3..834aca0da9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2259,6 +2259,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			return 0;
 	}
 
+	if (!ie_modified(&o->result, ce, st, 0))
+		return 0;
+
+
 	return add_rejected_path(o, error_type, name);
 }
 
-- 
2.35.1.7.gc8609858e0.dirty

