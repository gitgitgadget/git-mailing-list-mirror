Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34EC76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbjDDXsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 19:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbjDDXsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 19:48:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346283C1D
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 16:48:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso195124wmr.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680652123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSx7z/4fjJNqKjf3NEmaHak5bBBiC8nBj4iFJZ+QAO8=;
        b=aImoLTyjQQFzmkeZVkh+sRSs1MWgrZmCCXMhPfcwonXkVDbGK7dPVph5uPKaikx3dk
         Gm0DstbBaBmPCPqARzwSOOyMQHJ0lWTU8HCKEmJsYQnrsEdnBi91WD++uBKQsMtgk32Z
         jSpduQKI6T8+/+jrGeqWvwe7xLIjQc+z33zFQYVoy5acq/sFyKvdpKUrgoruE+F1SzuQ
         DL7pdMe9TjUVmW0Lbe/lClYH5IP97XUS313TbgXFszJcrZbiH+ik9EC7fQIU+2u+f1Na
         F7tt2LcVj95fEpB49A5i2WtWWhFKdzKBeq2qFGEkR1jKUL3L2HqeRWLnsWbRlZYsnd+L
         0SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680652123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSx7z/4fjJNqKjf3NEmaHak5bBBiC8nBj4iFJZ+QAO8=;
        b=uw76WKmxVH0eEGPQGNUF+iDeY8HXggSdlzVnlzasCPc5IPV6E7WGa5OAf4uNnzjEhs
         otN3SrA36FeZIRPRHQdDzNMJE+/rkZX4hJvYmGfZOigOsqqqco7uIOhwWzFcD4FHJ3ng
         YLHgwmoh47UeCdbi/iFYLwayomHnGWFAeGBWYjHZoXnsV6XqUKS5xHAAJzgrM5eW4+xe
         dYXqYSn9zy0Q6OZHVfzHgIC0VtIWCWJzQ2q9LkH9PCNqj4t2jNtJ8DIUJYdyV2Q2tz3S
         1HjUMupVJ0gd99ga2oCxkmDHDsWH3ocS5ZqTFp+js1+j3FH2M7AqbRz8kT4EEo/W23+H
         IDyQ==
X-Gm-Message-State: AAQBX9diYK1OqaTxpJTfb9F0OXqVmIikCAh/PnRV1xfkhf2LHSzk8xuo
        HjgVThq+OfGaK8umGoqsfGoqY92/SRM=
X-Google-Smtp-Source: AKy350ZGOOanRLrUaAR79kwEBkD1U9j6hhGxRIoRIiR0yfHL70p3ZR9/6N3HX8OyiKp5Xm5KdxMS+A==
X-Received: by 2002:a7b:c850:0:b0:3ef:6ea4:a675 with SMTP id c16-20020a7bc850000000b003ef6ea4a675mr3209257wml.36.1680652123206;
        Tue, 04 Apr 2023 16:48:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm379946wmj.4.2023.04.04.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 16:48:42 -0700 (PDT)
Message-Id: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 23:48:42 +0000
Subject: [PATCH] clone: error specifically with --local and symlinked objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

6f054f9fb3 (builtin/clone.c: disallow --local clones with
symlinks, 2022-07-28) gives a good error message when "git clone
--local" fails when the repo to clone has symlinks in
"$GIT_DIR/objects". In bffc762f87 (dir-iterator: prevent top-level
symlinks without FOLLOW_SYMLINKS, 2023-01-24), we later extended this
restriction to the case where "$GIT_DIR/objects" is itself a symlink,
but we didn't update the error message then - bffc762f87's tests show
that we print a generic "failed to start iterator over" message.

This is exacerbated by the fact that Documentation/git-clone.txt
mentions neither restriction, so users are left wondering if this is
intentional behavior or not.

Fix this by adding a check to builtin/clone.c: when doing a local clone,
perform an extra check to see if "$GIT_DIR/objects" is a symlink, and if
so, assume that that was the reason for the failure and report the
relevant information. Ideally, dir_iterator_begin() would tell us that
the real failure reason is the presence of the symlink, but (as far as I
can tell) there isn't an appropriate errno value for that.

Also, update Documentation/git-clone.txt to reflect that this
restriction exists.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    clone: error specifically with --local and symlinked objects
    
    We noticed this because repo [1] creates Git repos where
    "$GIT_DIR/objects" is a symlink, and users have gotten confused as to
    whether this was intended behavior or not.
    
    I'm no good with lstat() and errno, so if there's a better to do this,
    I'd appreciate the input :)
    
    [1] https://gerrit.googlesource.com/git-repo

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1488%2Fchooglen%2Fpush-nymnqqnttzxz-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1488/chooglen/push-nymnqqnttzxz-v1
Pull-Request: https://github.com/git/git/pull/1488

 Documentation/git-clone.txt | 5 +++++
 builtin/clone.c             | 7 ++++++-
 t/t5604-clone-reference.sh  | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d6434d262d6..c37c4a37f74 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -58,6 +58,11 @@ never use the local optimizations).  Specifying `--no-local` will
 override the default when `/path/to/repo` is given, using the regular
 Git transport instead.
 +
+If the repository's `$GIT_DIR/objects` has symbolic links or is a
+symbolic link, the clone will fail. This is a security measure to
+prevent the unintentional copying of files by dereferencing the symbolic
+links.
++
 *NOTE*: this operation can race with concurrent modification to the
 source repository, similar to running `cp -r src dst` while modifying
 `src`.
diff --git a/builtin/clone.c b/builtin/clone.c
index 462c286274c..74ec5b8b02a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -327,8 +327,13 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 
 	iter = dir_iterator_begin(src->buf, DIR_ITERATOR_PEDANTIC);
 
-	if (!iter)
+	if (!iter) {
+		struct stat st;
+		if (lstat(src->buf, &st) >= 0 && S_ISLNK(st.st_mode))
+			die(_("'%s' is a symlink, refusing to clone with --local"),
+			    src->buf);
 		die_errno(_("failed to start iterator over '%s'"), src->buf);
+	}
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 83e3c97861d..9845fc04d59 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -358,7 +358,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked objects directory' '
 	test_must_fail git clone --local malicious clone 2>err &&
 
 	test_path_is_missing clone &&
-	grep "failed to start iterator over" err
+	grep "is a symlink, refusing to clone with --local" err
 '
 
 test_done

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
