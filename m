Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2154AC4332F
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 18:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347016AbiDZTCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbiDZTCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 15:02:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577B18884A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 11:59:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso1625915wmq.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mcUoeZ/FdIrcfvGP8f1vb5+NryVNwJGJtg+A9iLTgic=;
        b=VBmGQqQsFbnxjeFtUzUcsdR/gGVM/eTinESsEwjT5SI/uHPvuc27+xUFPqfs4q1pl1
         717KpuQ02uQ9gQmik9OwYQZeASl4hepaaFdDbGoBbR0PIdEFdgoem+v4gr6F62UQzrk+
         CZ7hD0rohyRkBEG7MIvS/hIHJyLRiUhWu/1tZOBvucH85NwJmUtNcMVRR+5/SZfoN68P
         78oC4WDFnYWiUZxBvi+7tC8Wfuo4utQoCQYMNXsQKp+xzfDHK6fcrFEPKhwv+pt8u/PA
         zRtmCBCYqZAb6W+ykmgsLWOkVlG+NaJ4jIVZt2EO/zKS8p6Aa839LGnz/niifSykxZEa
         TMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mcUoeZ/FdIrcfvGP8f1vb5+NryVNwJGJtg+A9iLTgic=;
        b=Q6iyNhIn8Dc4zWuWYqSoJ2VtLw1Hb/gygVyDaQXKRAtIb2P1KPxRPCJ7npOrtSc8+/
         m67eKHS5nsniJtMj5Ij+aGPrgeDNU00/z8A80zkfvppGc1lvpZUqn2hsh54W6DsW/6dA
         aUtZETchJFGF/oqk+9jYohERt+H2nL5gXi+gt0W9Mq4SgtTaKEf4rbzIoWvLITyOukw7
         NwnXke7VawcmWCylVtPGlt7646WuD1fzDauUk/jy/oiMcnHflbo0K8T9tifP3/JEjA40
         QkFMWpGPc6Ig+jra10BjOwuRIXGOSxy5VRbc2rA6Cp3ycrFo7OZcE4/0Dri42TaL35Xr
         +cQA==
X-Gm-Message-State: AOAM532m9OW8t9uHdf1Re/CB9u8TcnPYBgruZTVrCE/KmqeMMtYhCXPm
        1aluDYwJWDzu9Zt0w4pHhv+sUWC/bGc=
X-Google-Smtp-Source: ABdhPJx2ccHUz4aI3cshN/nP84nfWZLjUnPsg2WoJ3o6RLnwF13bma04gIXIncm3N0bnWvDWObu9UA==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr16784626wmp.41.1650999571734;
        Tue, 26 Apr 2022 11:59:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm12587696wri.4.2022.04.26.11.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:59:31 -0700 (PDT)
Message-Id: <pull.1253.git.git.1650999569737.gitgitgadget@gmail.com>
From:   "Bertin Philippe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 18:59:29 +0000
Subject: [PATCH] git-p4: properly initialize the largefiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bertin Philippe <tumata.codes@gmail.com>,
        tumata <tumata.codes@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: tumata <tumata.codes@gmail.com>

This commit takes care of initializing the largeFiles
with the already existing files referenced in the .gitattributes
instead of initializing with an empty set by default.

This makes it so that the 'git p4 sync' command works as
expected with git-lfs.

Signed-off-by: tumata <tumata.codes@gmail.com>
---
    git-p4: Properly initialize the largeFiles set so that it includes the
    already existing large files
    
    git-p4 sync isn't taking into account existing files that are managed by
    git-lfs. This is fine when doing git p4 clone but doing git p4 sync
    needs to take into account the files that are already managed by
    git-lfs.
    
    This change reads-in the .gitattributes and re-generate the data so that
    sync can iteratively add files to the git-lfs. It takes care of
    initializing the largeFiles with the already existing files referenced
    in the .gitattributes instead of initializing with an empty set by
    default.
    
    We had issues cloning the first commit, then syncing the remaining
    commits of a really large Perforce repo (making hundreds of smaller sync
    instead of one massive sync). The sync was deleting the git-lfs each
    time. We were able to fix this issue by first reading the current
    content of git-lfs instead of initializing to an empty set.
    
    Signed-off-by: tumata 5684571+tumata@users.noreply.github.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1253%2Ftumata%2Fgit-p4-initialize-large-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1253/tumata/git-p4-initialize-large-files-v1
Pull-Request: https://github.com/git/git/pull/1253

 git-p4.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index a9b1f904410..576e923a1de 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1195,9 +1195,28 @@ class LargeFileSystem(object):
     """Base class for large file system support."""
 
     def __init__(self, writeToGitStream):
-        self.largeFiles = set()
+        self.largeFiles = self.parseLargeFiles()
         self.writeToGitStream = writeToGitStream
 
+    def parseLargeFiles(self):
+        """Parse large files in order to initially populate 'largeFiles'"""
+        paths = set()
+        try:
+            cmd = ['git', 'show', 'p4/master:.gitattributes']
+            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
+            if p.returncode:
+                print("Failed to read .gitattributed - error code: " + p.returncode)
+                raise
+            out = p.stdout.readlines()
+            for line in out:
+                if line.startswith('/'):
+                    path = line[1:].split(' ', 1)[0]
+                    path = path.replace('[[:space:]]', ' ')
+                    paths.add(path)
+        except:
+            print("parseLargeFiles: .gitattributes does not appear to exist.")
+        return paths
+
     def generatePointer(self, cloneDestination, contentFile):
         """Return the content of a pointer file that is stored in Git instead of
            the actual content."""

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
gitgitgadget
