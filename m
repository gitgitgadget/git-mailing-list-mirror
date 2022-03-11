Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C49C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiCKXLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiCKXLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:11:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA4151366
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:10:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r65so5964118wma.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uMvmpthBD+YkEiNfWbv6iDH+Be+JkEDi5FxHaWGa1Fk=;
        b=i3PPkers5kpH0+L6QakoYHRlUxCgTFU83hPGuXDc++xoagsD++odlrnn6+FIfwZ/V5
         UC0KmswVe/ku2+wQgPRiKkKizIy9aVINCWQWsiGTgKjiQ2h+Cbzkpng5fmHk3H6fXOEZ
         mitljdBPEb5snKaNatEygdSg/JOsDZH6OTsdX920VILywENfNngHrBXtN4SENjdq9wvH
         /CUR2mMzwTu8GaCOMirU2jZeYl4LEF8wKSjPjPTZwTolHK+vHmC7pHnq6+tFL3gwsddB
         8+L6T1qYgv54S5MP55HgsAzuq8ZipuQXnq5KkIZmApyV8haK5Zx8zhFRHQUK9ZDmc85B
         zsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uMvmpthBD+YkEiNfWbv6iDH+Be+JkEDi5FxHaWGa1Fk=;
        b=pdHliHJ8wKUv00p+09uXQJJd8NCU8qkaNzZrUZEmuBpIu6zn6BXTJ/9IDvvwSmkaEg
         mdAa+rkg4jQyF9I9sD4Sw7Jpn03PL+vdSLdPskNv8YDzV4gOPdE2EaKu12KYtGpGvKMa
         GmpMHo6+hUoZ7hQZEYkQnSmvOMV1vFlr2rH0Wp0/sF+6OWopn+iOzadPpBchLgfLExUX
         tpkYHYgHa5CjTksnsw8nQ3DH1Z/Bl/jZ1gzVxJWVlXNKK7s50zAiTWs9S3/mYGyV4PpG
         aDK7Yn1NVHA+zHkWmXvOknhq30XxpCrESmDGxFfBEGRgLkUR98oGt3XZeZuKMKw4jbsT
         G8LA==
X-Gm-Message-State: AOAM533nQlhssvmEl2VAOC4xVoI5t2IHUmMFAo6OigvUOJ3wEvVuVomi
        wZ3Ltrlx6J0gJ/es1oww2LYy3EK9IHo=
X-Google-Smtp-Source: ABdhPJxfXkEqwSyg4pvIN5RlxGZp/T7cqTIGARyR1qzJhSoMCDT0f8UDOlegUDroF0aQ+D6Z22dz1g==
X-Received: by 2002:a05:600c:34d5:b0:389:a209:24ca with SMTP id d21-20020a05600c34d500b00389a20924camr17073532wmq.195.1647032858000;
        Fri, 11 Mar 2022 13:07:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm7827743wrw.74.2022.03.11.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:07:37 -0800 (PST)
Message-Id: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
From:   "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:07:36 +0000
Subject: [PATCH] tab completion of filenames for 'git restore'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>,
        David Cantrell <david@cantrell.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Cantrell <david@cantrell.org.uk>

If no --args are present after 'git restore' it assumes that you want
to tab-complete one of the files with uncommitted changes

Signed-off-by: David Cantrell <david@cantrell.org.uk>
---
    Improved bash tab completion for 'git restore' - adds support for
    auto-completing filenames
    
    This adds tab-completion of filenames to the bash completions for git
    restore.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1227%2FDrHyde%2Ffilename-completion-for-git-restore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1227/DrHyde/filename-completion-for-git-restore-v1
Pull-Request: https://github.com/git/git/pull/1227

 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 49a328aa8a4..7ccad8ff4b1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2883,14 +2883,21 @@ _git_restore ()
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
+		return
 		;;
 	--source=*)
 		__git_complete_refs --cur="${cur##--source=}"
+		return
 		;;
 	--*)
 		__gitcomp_builtin restore
+		return
 		;;
 	esac
+
+	if __git rev-parse --verify --quiet HEAD >/dev/null; then
+		__git_complete_index_file "--committable"
+	fi
 }
 
 __git_revert_inprogress_options=$__git_sequencer_inprogress_options

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget
