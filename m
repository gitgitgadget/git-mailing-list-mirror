Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D0AC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 14:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiG1OcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiG1Ob1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 10:31:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF36A9FB
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:29:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c22so1059487wmr.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LjSRJL5Z0/ElLBNLeXKvhOAxLP/BPBmtD8JWTxU6Bww=;
        b=f+EAxSvZ34anfbIVZKlbsfyoLub2Y72yWxenwHODN4jTmLljwRzWMVBoTMcI/Bks9y
         RmqdOkNyjhB5i65fNa6MVjcqq+1T9m8JS4pdzq+dgsnlyqcbNrNh4wsHeRgCHp+WGFh+
         ei6jxnuatNYEqKWYjqv0O8DSjNW5OqO8ysBJON5vTP7WRvtEINaT1mR+/FEkKttzltdq
         FzoRLn26POIJsjcYgOGcCk03w2G2RC5FW/E0aQHXG9GbEHbXTGAAmfXkdqNhEmHvXAG2
         7XdJ5ENTzm59VY+goZPJNOF9QJDrWz7DCbvLQadam1DLiGmnun5pU7wTTTS10ofq4eaN
         ib+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LjSRJL5Z0/ElLBNLeXKvhOAxLP/BPBmtD8JWTxU6Bww=;
        b=qf7mHaP97AOMYg0StOAMp88f5fJiBFGxfdtIefjk1k8CE/wc+facmu5XBLuEmXcE9i
         cuKvgYneTl8pkeDgYC1S2w3XC6a+740vs645rLWil9ereR0yQmjSLqvEwh9ZkkvECwIT
         lprgv1PK9S2X3bJjpmnGyNvtaAjIGYsTUkVx0xPU6F6GSM0qY9X5EzzmrLXjeyV+EyF6
         Sf+eqhexIiJsLkFdeyRM1tOHtiRPqnRHP9Bje9Ozes8n6tbjzkd51eUzqxW7lzwG2N16
         goJZp1g5/I/2JA9LCbE+cu3/1rE8v70Moh1y7oL8ESi+YDUv89Kc/zUBM0BQuyGf8m6K
         HMJg==
X-Gm-Message-State: AJIora++1C8FcIYh7vwQ0BNl/LqNEM085HA5gGUvRqQZz3w8YdnYwSxB
        Co5oBkoX8h9OxpjsldEcQHACmVzjauw=
X-Google-Smtp-Source: AGRyM1sqSfBaeDpxLf7bpqugpIieY7H+3sJ/2wtJu1BZYGtZNFWffSVJbXREgg27NIc/m/cxBkh4Xg==
X-Received: by 2002:a05:600c:22c2:b0:3a3:19e3:a55 with SMTP id 2-20020a05600c22c200b003a319e30a55mr6898545wmg.53.1659018560840;
        Thu, 28 Jul 2022 07:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003a30af0ec83sm5577663wmm.25.2022.07.28.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:29:20 -0700 (PDT)
Message-Id: <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
In-Reply-To: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jul 2022 14:29:18 +0000
Subject: [PATCH v2] lstat(mingw): correctly detect ENOTDIR scenarios
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
shares, this let to a nasty problem trying to create tags:

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
`GetFileAtrtibutesW()` call correctly.

This fixes https://github.com/git-for-windows/git/issues/3727

Reported-by: Pierre Garnier <pgarnier@mega.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix the lstat() emulation on Windows
    
    One particular code path in the lstat() emulation on Windows was broken.
    
    This fixes https://github.com/git-for-windows/git/issues/3727
    
    Changes since v1:
    
     * Thanks to Eric's excellent review, the reporter and I dug deeper and
       figured out the real bug (and fix).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1291%2Fdscho%2Fenotdir-and-enoent-can-indicate-missing-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1291/dscho/enotdir-and-enoent-can-indicate-missing-refs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1291

Range-diff vs v1:

 1:  c3d51a755ba < -:  ----------- refs: work around network caching on Windows
 -:  ----------- > 1:  2ebe899736e lstat(mingw): correctly detect ENOTDIR scenarios


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
