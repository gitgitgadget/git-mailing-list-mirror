Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2722C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjHHRMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjHHRMF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:12:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134301BAC7
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:05:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9c66e2e36so70583861fa.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510696; x=1692115496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t/wAz4TgQLYxjAc9YYbMNSxwtUsNEuCjYyaZXBc7IDI=;
        b=W3dk241zLmpIOG/2k3xBOsS/IsvocGGv7FWoaFaqRu00R5Fyb7xWASSIFmJOUIlEEh
         B7V4ziWz/OxqPJe3Ymbis9XFQM40Dohe1kMNOq8r3mRpSvH4EhQ1VS31O0LOboiDpcfn
         tKesCYvoFZMGkMoe6ofFlqqijFzgOWQ5vUOiJAqe93OHDcjFziObb0+LTPdHYU3OTg4N
         U7SMdjafssAY/QYE//HaBbIQxhUZyDXiwP++cRoxNlYozuhUyCTPISM+QGDidWAOmU5X
         d8/N1SaF+0rdKcDLyE62Ka1KGhIM7KvyFVFmhqCGp4R0sllySc+9cBura2frRwAWmkzp
         V9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510696; x=1692115496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/wAz4TgQLYxjAc9YYbMNSxwtUsNEuCjYyaZXBc7IDI=;
        b=BccL3keivhi+aZLl6jMI4h28gKmrLblOXyy9+bkPz++ALeuG4rqzJjYUFgtLG0Qyn7
         5K2Gn1k6mAr7qOVI5fY7CWCl0cYDGUoVOlP5TqagoPPzNvi+jdOdsI5amCsIEJ6gzFP0
         zGspVO4DgaHxBWMq63aAHx/JQv+qmid7C9c3sbQwxavp2vA9JgahTqraaM/HPp1WkFmG
         O3sBcesW1iGJEFGtvRQDm9JQX4jVFT2iJIWa0WbSMGBNFuOmZ3Lh87IUy3fArvATe3x5
         hZ9jmt9PajErKsVO6C2MrlHZuUbIRU9Yp55aSG1t9vAuq6NHYe3WcEUtEIvPboI2TeWq
         QUdw==
X-Gm-Message-State: AOJu0YyZCV69ikinvUqjAzFgSeiZapCOBpUaJypOoPMWE+rz0lStP6Lw
        WzHZGsKt6ERLHcLeImTKTccf+s8MXhg=
X-Google-Smtp-Source: AGHT+IFSDPsohYIlocpt3qUiGqDeUN4l7rN/Moq4HXmf35z0JHLYGepP0FkDEPrp06DIcFEdYxEJWQ==
X-Received: by 2002:a05:600c:8516:b0:3fe:21f1:aba8 with SMTP id gw22-20020a05600c851600b003fe21f1aba8mr8002792wmb.12.1691506432916;
        Tue, 08 Aug 2023 07:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c290c00b003fbb618f7adsm13998706wmd.15.2023.08.08.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:53:52 -0700 (PDT)
Message-ID: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
From:   "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Aug 2023 14:53:50 +0000
Subject: [PATCH] fix `git mv existing-dir non-existing-dir`*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sebastian Thiel <sebastian.thiel@icloud.com>,
        Sebastian Thiel <sebastian.thiel@icloud.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sebastian Thiel <sebastian.thiel@icloud.com>

*in some environments.

When moving a directory onto another with `gix mv`
various checks are performed. One of of these
validates that the destination is not an existing
file.

When calling `lstat` on the destination path and
it fails as the path doesn't exist, some
environments seem to overwrite the passed  in
`stat` memory nonetheless.
(I observed this issue on debian 12 of x86_64,
running on OrbStack on ARM, emulated with Rosetta)

This would affect the code that followed as it
would still acccess a now
modified `st` structure, which now seems to
contain uninitialized memory.
`S_ISDIR(st_dir_mode)` would then typically
return false causing the code to run into a bad
case.

The fix avoids overwriting the existing `st`
structure, providing an alternative that exists
only for that purpose.

Note that this patch minimizes complexity instead of stack-size.

Signed-off-by: Sebastian Thiel <sebastian.thiel@icloud.com>
---
    fix git mv existing-dir non-existing-dir*
    
    fix git mv existing-dir non-existing-dir*
    
    *in some environments.
    
    When moving a directory onto another with gix mv various checks are
    performed. One of of these validates that the destination is not an
    existing file.
    
    When calling lstat on the destination path and it fails as the path
    doesn't exist, some environments seem to overwrite the passed in stat
    memory nonetheless. (I observed this issue on debian 12 of x86_64,
    running on OrbStack on ARM, emulated with Rosetta)
    
    This would affect the code that followed as it would still acccess a now
    modified st structure, which now seems to contain uninitialized memory.
    S_ISDIR(st_dir_mode) would then typically return false causing the code
    to run into a bad case.
    
    The fix avoids overwriting the existing st structure, providing an
    alternative that exists only for that purpose.
    
    ------------------------------------------------------------------------
    
    It's worth pointing out that the test demonstrates this case only if one
    happens to execute it in one of the environments that happen to have an
    lstat that writes into stat even on error. Thus it already worked for me
    on MacOS, even without the patch applied, which matches my observation
    that a certain script works there but doesn't work on the VM.
    
    Even though the patch now minimizes size, I can imagine one might
    instead want to rather copy st.st_mode to protect only the relevant
    field from being affected by potential rewrites of st later on.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1561%2FByron%2Ffix-mv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1561/Byron/fix-mv-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1561

 builtin/mv.c  | 4 ++--
 t/t7001-mv.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index fa84fcb20d8..05e7156034e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -184,7 +184,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int src_dir_nr = 0, src_dir_alloc = 0;
 	struct strbuf a_src_dir = STRBUF_INIT;
 	enum update_mode *modes, dst_mode = 0;
-	struct stat st;
+	struct stat st, dest_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
 	struct cache_entry *ce;
@@ -304,7 +304,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			goto act_on_entry;
 		}
 		if (S_ISDIR(st.st_mode)
-		    && lstat(dst, &st) == 0) {
+		    && lstat(dst, &dest_st) == 0) {
 			bad = _("cannot move directory over file");
 			goto act_on_entry;
 		}
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 898a9205328..9894bc45ee6 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -174,6 +174,12 @@ test_expect_success 'do not move directory over existing directory' '
 	test_must_fail git mv path2 path0
 '
 
+test_expect_success 'rename directory to non-existing directory' '
+	mkdir dir-a && touch dir-a/f &&
+	git add dir-a &&
+	git mv dir-a non-existing-dir
+'
+
 test_expect_success 'move into "."' '
 	git mv path1/path2/ .
 '

base-commit: 1b0a5129563ebe720330fdc8f5c6843d27641137
-- 
gitgitgadget
