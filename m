Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989FFC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 08:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiGOIHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGOIHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 04:07:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D27E02F
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:07:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so4432853wme.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FGf/XWhIyrtNk4gdwuk0vkU21mL1BBpqKX2lQ1Nv7w0=;
        b=lg/NqVjbAqjvSB7C+LmPUkS4LuSgU7iJSknwV4HWSGKP7g+Bn9RvFen5OydBtaVW80
         laj+CTek2iBpGu7Yhp1O6TXClzfROE/SHllZkyvxrihDVrsfO5G7X4hImRXFgJ67oApY
         eyLa2JRaGSk1W9kf4TOAJ6LsilMcIPV7nHDkF9zxkEaABzkW+97SA4Xg42p080myg/F4
         ZOE1HnSCdB99HKl10BfxFUx4LQ28x8o7Y4T14uOZ1gQdtYiQHtr7MMteLYwCx7IISC5U
         o2ws7Uj9TSesJuPzPoDWuBNRKxGl41VCZCW2nOFZmauQQbBJXML9AoCUa7+zfd0BM06J
         VLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FGf/XWhIyrtNk4gdwuk0vkU21mL1BBpqKX2lQ1Nv7w0=;
        b=pxt3a4kazxht2cX0SGQrpIGTGUiRD7S4urS2pqqBZbZsBgJil37lvsbWozrdlwSWhU
         om4vRpQ5LXh+8fZDCK8dYvXf8577OWSlSRlGqQ/Hfa7AhQl8ojwZ0pkwLQiXK0AJinKB
         JFLCdYRTCkZKaESRxAMulCcJTl+38BKP7qdEv3W5Zkte/k0g8dkQOzUzAQllaiv93VVV
         KlqXwoLxa3v7NCYl3/CmBEl0Ofbyfa6AExuRHidZIIsvNtWC9ta8S7H3YtPQRtsDFwi1
         iNw60/wBPQfJOoQZg4vaNw9+lCnBJQKhl/78T91+wrkFa58JzR/BaminDo5sPEITRMI/
         YxCA==
X-Gm-Message-State: AJIora9WDCeENqbWxW+wPCn8x9YdabJ2uCLIUDaJrT3/DBHF3XzVxnUs
        2XjY/+5LXZK6hViX+BiLGz6Jq+17uCk=
X-Google-Smtp-Source: AGRyM1uAQjieMNWNjUnaNnXwjDUVpdj6lbXB9DGroOKHAPaNYzsI0cPC8y4sg01n5navrYbQO8Th/Q==
X-Received: by 2002:a7b:c4d3:0:b0:3a1:8fbf:f03f with SMTP id g19-20020a7bc4d3000000b003a18fbff03fmr18838595wmk.172.1657872418399;
        Fri, 15 Jul 2022 01:06:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a1ccc0e000000b003a2e7c13a3asm4504985wmb.42.2022.07.15.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:06:57 -0700 (PDT)
Message-Id: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Jul 2022 08:06:56 +0000
Subject: [PATCH] refs: work around network caching on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pierre Garnier <pgarnier@mega.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pierre Garnier <pgarnier@mega.com>

Network shares sometimes use aggressive caching, in which case a
just-created directory might not be immediately visible to Git.

One symptom of this scenario is the following error:

	$ git tag -a -m "automatic tag creation"  test_dir/test_tag
	fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory

Note: This does not necessarily happen in all Windows setups. One setup
where it _did_ happen is a Windows Server 2019 VM, and as hinted in

	http://woshub.com/slow-network-shared-folder-refresh-windows-server/

the following commands worked around it:

	Set-SmbClientConfiguration -DirectoryCacheLifetime 0
	Set-SmbClientConfiguration -FileInfoCacheLifetime 0
	Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0

This would impact performance negatively, though, as it essentially
turns off all caching, therefore we do not want to require users to do
that just to be able to use Git on Windows.

The underlying culprit is that `GetFileAttributesExW()` that is called from
`mingw_lstat()` can raise an error `ERROR_PATH_NOT_FOUND`, which is
translated to `ENOTDIR`, as opposed to `ENOENT` as expected on Linux.

Therefore, when trying to read a ref, let's allow `ENOTDIR` in addition
to `ENOENT` to indicate that said ref is missing.

This fixes https://github.com/git-for-windows/git/issues/3727

Signed-off-by: Pierre Garnier <pgarnier@mega.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    refs: work around network caching on Windows
    
    While it is enough on Linux to look at ENOENT when allowing for missing
    refs, on Windows we also need to allow ENOTDIR.
    
    This fixes https://github.com/git-for-windows/git/issues/3727

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1291%2Fdscho%2Fenotdir-and-enoent-can-indicate-missing-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1291/dscho/enotdir-and-enoent-can-indicate-missing-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1291

 refs/files-backend.c  | 2 +-
 refs/packed-backend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aacb..b2a880f62f0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -381,7 +381,7 @@ stat_ref:
 	if (lstat(path, &st) < 0) {
 		int ignore_errno;
 		myerr = errno;
-		if (myerr != ENOENT || skip_packed_refs)
+		if ((myerr != ENOENT && myerr != ENOTDIR) || skip_packed_refs)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, &ignore_errno)) {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b68377673..23d478627a7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -480,7 +480,7 @@ static int load_contents(struct snapshot *snapshot)
 
 	fd = open(snapshot->refs->path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT) {
+		if (errno == ENOENT || errno == ENOTDIR) {
 			/*
 			 * This is OK; it just means that no
 			 * "packed-refs" file has been written yet,

base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
-- 
gitgitgadget
