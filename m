Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04872C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiFKREF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiFKREE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 13:04:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BBE6421
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 10:04:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i64-20020a1c3b43000000b0039c6fd897b4so255003wma.4
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BGeP9SxuDfju+o2zxS8lsXqzr306BAQ3jEeMChcfCQg=;
        b=XLyJpfBBEPetbQdPABQTzN1ft/zxKGmlUKohi8fK4ABjOEPDHPilsiIqHI438SElKV
         hfqYaA9AJ0E1cU0Tt6oyqeeh2+ZWrb/vOWUXXNth50AqQmJG7JUoi1/tLjmuAvVZlhp9
         /sn6yFBuv23E1Se1fW0xFSTzq0U6mcDPy7ZnnKySQ0uP6faxr7gTwM+ChQKheBiQukoy
         7uio2mbuDPPAQvySXlldoeHhQ2n9ElA33QyAdZ3b7mK/1RQE7k7VW+9crxkl49QFkQZm
         n3b3e8uRjrbJgkZdiy6vN+bJSiODSJLP1L1UcYV0qgbPMQ4lFMExQfX3gnqtI+e1iXge
         nI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BGeP9SxuDfju+o2zxS8lsXqzr306BAQ3jEeMChcfCQg=;
        b=MyCi54E2ADrBAiBqmTYidruSXJLpLd/P8KbrGuIKG0uBc95kbsnGtBm82b0PW2Lllt
         4T9sGoecRgXA80Eln+b3z8demOdOWl7fJnsnb4+XAmjlNVFKUzEQAKuQGVqHXuwLq6ho
         VrfjdYX7qNiTaz+6WNjfOiIixu0J+J8N83EGX1U7u/Nc0dKZGi+8IQJ7GLhKh0RjraV8
         zPoCBVN105kbxixdt9LhgyRgM6JxtkAtYIn4mZeXgs94zPzawi9UHh2jWdvURi0JwJd/
         fH/Hw3doE8VRa5G1aHMjZHed0I+IYuKhjjkziikdQBuuUK2S7lBpwCpNFDrigk+E16+i
         5JLQ==
X-Gm-Message-State: AOAM533zz7NyIRcByiZBg4U0gOQiMNntlJ8ZtnecZO6Krm7Apwl/9LCd
        gknZ94rtYx5tHg6UmvMCBoUVEywsmbNLTg==
X-Google-Smtp-Source: ABdhPJztwE9Yzf9aXZ9qiwEOZpHIenvIIfEdpsy/SpAUDbpcgYHuGNTAycEmbJyQcNF2I0XogAhnGQ==
X-Received: by 2002:a05:600c:4f42:b0:39c:87b9:2e24 with SMTP id m2-20020a05600c4f4200b0039c87b92e24mr2579806wmq.80.1654967040345;
        Sat, 11 Jun 2022 10:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b002108ab90e5asm3080549wrs.58.2022.06.11.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 10:03:59 -0700 (PDT)
Message-Id: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Jun 2022 17:03:58 +0000
Subject: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

"git apply" checks, when validating a patch, to ensure that any files
being added aren't already in the worktree.

When this check runs on a case-only rename, in a case-insensitive
filesystem, this leads to a false positive - the command fails with an
error like:
error: File1: already exists in working directory

Fix this existence check to allow the file to exist, for a case-only
rename when config core.ignorecase is set.

Also add a test for this case, while verifying that conflicting file
conditions are still caught correctly, including case-only conflicts on
case-sensitive filesystems.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    apply: support case-only renames in case-insensitive filesystems
    
    As suggested recently in thread
    CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com,
    proposing a fix to git-apply for case-only renames on case-insensitive
    filesystems.
    
    Also including tests to check both the corrected behavior and the
    corresponding legitimate errors.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1257%2FTaoK%2Ftao-apply-case-insensitive-renames-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1257/TaoK/tao-apply-case-insensitive-renames-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1257

 apply.c                                  |  2 +
 t/t4141-apply-case-insensitive-rename.sh | 50 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100755 t/t4141-apply-case-insensitive-rename.sh

diff --git a/apply.c b/apply.c
index 2b7cd930efa..ccba7f90393 100644
--- a/apply.c
+++ b/apply.c
@@ -3942,6 +3942,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	if ((tpatch = in_fn_table(state, new_name)) &&
 	    (was_deleted(tpatch) || to_be_deleted(tpatch)))
 		ok_if_exists = 1;
+	else if (ignore_case && !strcasecmp(old_name, new_name))
+		ok_if_exists = 1;
 	else
 		ok_if_exists = 0;
 
diff --git a/t/t4141-apply-case-insensitive-rename.sh b/t/t4141-apply-case-insensitive-rename.sh
new file mode 100755
index 00000000000..6b394252ff8
--- /dev/null
+++ b/t/t4141-apply-case-insensitive-rename.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='git apply should handle case-only renames on case-insensitive filesystems'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# Please note, this test assumes that core.ignorecase is set appropriately for the filesystem,
+# as tested in t0050. Case-only rename conflicts are only tested in case-sensitive filesystems.
+
+if ! test_have_prereq CASE_INSENSITIVE_FS
+then
+	test_set_prereq CASE_SENSITIVE_FS
+	echo nuts
+fi
+
+test_expect_success setup '
+	echo "This is some content in the file." > file1 &&
+	echo "A completely different file." > file2 &&
+	git update-index --add file1 &&
+	git update-index --add file2 &&
+	cat >case_only_rename_patch <<-\EOF
+	diff --git a/file1 b/File1
+	similarity index 100%
+	rename from file1
+	rename to File1
+	EOF
+'
+
+test_expect_success 'refuse to apply rename patch with conflict' '
+	cat >conflict_patch <<-\EOF &&
+	diff --git a/file1 b/file2
+	similarity index 100%
+	rename from file1
+	rename to file2
+	EOF
+	test_must_fail git apply --index conflict_patch
+'
+
+test_expect_success CASE_SENSITIVE_FS 'refuse to apply case-only rename patch with conflict, in case-sensitive FS' '
+	test_when_finished "git mv File1 file2" &&
+	git mv file2 File1 &&
+	test_must_fail git apply --index case_only_rename_patch
+'
+
+test_expect_success 'apply case-only rename patch without conflict' '
+	git apply --index case_only_rename_patch
+'
+
+test_done

base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64
-- 
gitgitgadget
