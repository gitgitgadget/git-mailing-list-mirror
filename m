Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98058C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiG2KF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiG2KF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:05:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039655F8E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:05:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q30so991765wra.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=leYB02IzLCSD31y7AtnOtJIUg1IE1ZzfMfBtxgmb/wA=;
        b=L3UV74iIhJZbEbx3RYWY3CkTYYp+rXXH6Xu8BtXDEdCdtBD/2bfxZgB1xnFvmiGcex
         U4c0jIKFRTp/8wP95kTuUfgC3NK7atnLWbZpOI4Tj46Rfw/cFphhFl8AnbKrOEfrCLc9
         DZFvsvJ0rfvxgBhaVpO5st4oMdVngnG6BYqZPpoPQVkbgFBeP+IoMGqkLk/9MnaY3h8h
         aVbQINjqMGDOOTtCpWNa+V18YWutpZnHzynaJd9/aiwRSoLrPtLm+p1cieQbsAyVPqkc
         kOAx0ryBmYCGslSNFiUIOscTGjU/u8rTpNCxyxKa5tzpIQNhzWL5DZlNFAnZ4YfNS/wE
         40vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=leYB02IzLCSD31y7AtnOtJIUg1IE1ZzfMfBtxgmb/wA=;
        b=yDVEiwrQvLlswnD247nHmt8IXotSlpJpzDj9m2p9OnDNgW7AyD0esNZmpiUGCaYGxU
         ZNxhXElkg0eYuKpdoGKzn7qE3sWjW2a249F38N4pV3q6xzOt5OyalfbM/uCrKkqE4dmW
         siycn1E5E+uQVX/S8bIWJTCspEiGwybZglUsmnWX/Bpjg8tzJSvUF3fIge+6vr7LupLt
         cdm0Yd8Vuy11ZCAU9dKokKcgTtQNCWMZmcMk3ELVrRRD+6wjBuYtWngewfdjVOgwMyRn
         36+9FDuXQcPUMBjeoXcuxlHjAPPo8RnN2exhFp61RvbnIg1Y2mbJWDDe8uFVJ5y1EOSq
         WYEw==
X-Gm-Message-State: ACgBeo3EmSoCdrKAESRHS66Je42EStZHTZC4TNwUACNlcF4D4Zij/++J
        VnUnJAKpNfE3O3CU5lYEFeE9oJMIHSQ=
X-Google-Smtp-Source: AA6agR5QsSk9X22C7TpWpJAV6JJgmz4SG3K/btaJMMdAHGJ/8VtV7rrZAw0lKuksxdm8b9WCwyr3tQ==
X-Received: by 2002:a5d:5c12:0:b0:21f:1c6:c36 with SMTP id cc18-20020a5d5c12000000b0021f01c60c36mr1909021wrb.350.1659089154992;
        Fri, 29 Jul 2022 03:05:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003a32251c3f0sm4037067wmq.33.2022.07.29.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 03:05:54 -0700 (PDT)
Message-Id: <pull.1291.v3.git.1659089152877.gitgitgadget@gmail.com>
In-Reply-To: <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
References: <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 10:05:52 +0000
Subject: [PATCH v3] lstat(mingw): correctly detect ENOTDIR scenarios
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Files' attributes can indicate more than just whether they are files or
directories. It was reported in Git for Windows that on certain network
shares, this led to a nasty problem trying to create tags:

	$ git tag -a -m "automatic tag creation"  test_dir/test_tag
	fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory

Note: This does not necessarily happen with all types of network shares.
One setup where it _did_ happen is a Windows Server 2019 VM, and as
hinted in

	http://woshub.com/slow-network-shared-folder-refresh-windows-server/

in the indicated instance the following commands worked around the bug:

	Set-SmbClientConfiguration -DirectoryCacheLifetime 0
	Set-SmbClientConfiguration -FileInfoCacheLifetime 0
	Set-SmbClientConfiguration -FileNotFoundCacheLifetime 0

This would impact performance negatively, though, as it essentially
turns off all caching, therefore we do not want to require users to do
that just to be able to use Git on Windows.

The underlying bug is in the code added in 4b0abd5c695 (mingw: let
lstat() fail with errno == ENOTDIR when appropriate, 2016-01-26) that
emulates the POSIX behavior where `lstat()` should return `ENOENT` if
the file or directory simply does not exist but could be created, and
`ENOTDIR` if there is no file or directory nor could there be because a
leading path already exists and is not a directory.

In that code, the return value of `GetFileAttributesW()` is interpreted
as an enum value, not as a bit field, so that a perfectly fine leading
directory can be misdetected as "not a directory".

As a consequence, the `read_refs_internal()` function would return
`ENOTDIR`, suggesting not only that the tag in the `git tag` invocation
above does not exist, but that it cannot even be created.

Let's fix the code so that it interprets the return value of the
`GetFileAttributesW()` call correctly.

This fixes https://github.com/git-for-windows/git/issues/3727

Reported-by: Pierre Garnier <pgarnier@mega.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix the lstat() emulation on Windows
    
    One particular code path in the lstat() emulation on Windows was broken.
    
    This fixes https://github.com/git-for-windows/git/issues/3727
    
    Changes since v2:
    
     * Fixed typos in the commit message (I wanted to write "led" but had
       written "let" instead, thanks once again, Eric!, and I managed to
       misspell a function name).
    
    Changes since v1:
    
     * Thanks to Eric's excellent review, the reporter and I dug deeper and
       figured out the real bug (and fix).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1291%2Fdscho%2Fenotdir-and-enoent-can-indicate-missing-refs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1291/dscho/enotdir-and-enoent-can-indicate-missing-refs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1291

Range-diff vs v2:

 1:  2ebe899736e ! 1:  b4f08ee0d7c lstat(mingw): correctly detect ENOTDIR scenarios
     @@ Commit message
      
          Files' attributes can indicate more than just whether they are files or
          directories. It was reported in Git for Windows that on certain network
     -    shares, this let to a nasty problem trying to create tags:
     +    shares, this led to a nasty problem trying to create tags:
      
                  $ git tag -a -m "automatic tag creation"  test_dir/test_tag
                  fatal: cannot lock ref 'refs/tags/test_dir/test_tag': unable to resolve reference 'refs/tags/test_dir/test_tag': Not a directory
     @@ Commit message
          above does not exist, but that it cannot even be created.
      
          Let's fix the code so that it interprets the return value of the
     -    `GetFileAtrtibutesW()` call correctly.
     +    `GetFileAttributesW()` call correctly.
      
          This fixes https://github.com/git-for-windows/git/issues/3727
      


 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 545e952a588..3b85bb02536 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -471,8 +471,8 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 		wfilename[n] = L'\0';
 		attributes = GetFileAttributesW(wfilename);
 		wfilename[n] = c;
-		if (attributes == FILE_ATTRIBUTE_DIRECTORY ||
-				attributes == FILE_ATTRIBUTE_DEVICE)
+		if (attributes &
+		    (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_DEVICE))
 			return 1;
 		if (attributes == INVALID_FILE_ATTRIBUTES)
 			switch (GetLastError()) {

base-commit: 4b0abd5c695c87bf600e57b6a5c7d6844707d34c
-- 
gitgitgadget
