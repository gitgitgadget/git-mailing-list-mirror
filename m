Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3642C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6292D21D7F
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZyUZGnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgJROmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgJROmK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 10:42:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB4C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 07:42:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e17so8514174wru.12
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q+x3R8GDedm+75e8kmmBgPEsn8hRqiR1GHTNnI5Zjpc=;
        b=iZyUZGnpnH1rZy6IlZUymWx90ztIK5Y46sJ+Y6glbnsDT1/t4UbGJz4CZWF2QmWKSs
         QFMyIIIzr49hhXe+yPU4aqN5iWamNHEzWqHpEnMT/mVcXimT3WMgorV3rLvcxJKCdE+H
         OyPemPEeivrcgihaNfTyhkKlkLaeE1emqqxQXBjEV/5YFIoL213aFr7EQfHIT4HPDEJD
         Rq/ATx8mKql5FnSKVmkYaogp9YOf6du4Mba7/0dk8e8kNpOPrnF5dx13tUdAzEAl3NvN
         61EE8hzZsvyDrzJbTmesmVnaI3LXgH4WCRfqWLGWl+R2CtDM88tliGtq26wHiG6DkJNo
         oAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q+x3R8GDedm+75e8kmmBgPEsn8hRqiR1GHTNnI5Zjpc=;
        b=NTTNK5kk+tqSgUT/rU5iHrZ0J08Kg01utCSj7518XPXpef4/MGmzeECi7NwuCi7dSJ
         xXcexBexGlI6KG0lNFFOXbn0Y9BFMJ+8FCQW+m0xdB3i89/BYROCF7WjrNwd9JlSkS+1
         0KmPZPUotZZhnVtltAGk+6VW2yR3OB5j2ddWC+cdasPVKmnBhwqMUj8GngtGPxmRFj0E
         bCUA76pXlZgz6eQHqi/SU3xX9CtWca86K05nodgNvVe0Wt6Cjg2dNu6wHS1CSTiSYzWq
         /LVLACMvEGdy607lw2hGkGfgPvcGR4ImnRzJbRTDSUeBkrn+I5xc4OxG5SboaPcdNaUX
         Xz4Q==
X-Gm-Message-State: AOAM533zk2DBzHb8XDxL4SPigqCw0PyfNU6X59sXqgGyOMO8DKsk3K9a
        B5nHyYO70DIO64DKsBuxfeu3AAK4bvk=
X-Google-Smtp-Source: ABdhPJxThk81Mio4ddjHZgA8oAo5nDcSx8rD7K9IXZOpuVfkIjOXA/8ct/whlx6fajwXSi7d8J8Kvg==
X-Received: by 2002:adf:de89:: with SMTP id w9mr15161914wrl.212.1603032126061;
        Sun, 18 Oct 2020 07:42:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm11966049wmg.8.2020.10.18.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 07:42:05 -0700 (PDT)
Message-Id: <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com>
From:   "Amanda  Shafack  via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 14:42:04 +0000
Subject: [PATCH v2] t9832,t2200: avoid using pipes in git commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Amanda Shafack <shafack.likhene@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Amanda Shafack <shafack.likhene@gmail.com>

When a git command is upstream in a pipe, an unexpected failure of
the git command will go unnoticed.

Write out the output of the git command to a file, so as to actively
catch a failure of the git command.

Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
---
    [Outreachy][Patch v2] t9832,t2200: avoid using pipes in git related
    commands
    
    Changes since v1:
    
     * Merged patch [1/2] and [2/2] into a single patch
     * Revised commit message
    
    Signed-off-by: Amanda Shafack shafack.likhene@gmail.com
    [shafack.likhene@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-885%2Flkmandy%2Favoid-pipes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-885/lkmandy/avoid-pipes-v2
Pull-Request: https://github.com/git/git/pull/885

Range-diff vs v1:

 1:  fc2da014a6 ! 1:  bca393e69a t9832,t2200: avoid using pipes in git commands
     @@ Metadata
       ## Commit message ##
          t9832,t2200: avoid using pipes in git commands
      
     -    When the upstream of a pipe throws an error, the downstream still
     -    executes normally. This happens because the exit code of the upstream
     -    in a pipe is ignored. This behavior can make debugging very hard
     -    incase a test fails. Also, pipes are prone to deadlocks. If the
     -    upstream gets full, the commands downstream will never start.
     +    When a git command is upstream in a pipe, an unexpected failure of
     +    the git command will go unnoticed.
      
     -    Write out the output of the git command to a file, so as to test the
     -    exit codes of both commands.
     -
     -    Commit c6f44e1da5 (t9813: avoid using pipes, 2017-01-04) noticed that
     -    the exit code of upstream in the pipe is ignored, thus using pipes
     -    should be avoided.
     +    Write out the output of the git command to a file, so as to actively
     +    catch a failure of the git command.
      
          Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
      
     @@ t/t2200-add-update.sh: test_expect_success 'add -u resolves unmerged paths' '
       test_expect_success '"add -u non-existent" should fail' '
       	test_must_fail git add -u non-existent &&
      -	! (git ls-files | grep "non-existent")
     -+	! (
     -+		git ls-files >actual &&
     -+		grep "non-existent" actual
     -+	)
     ++	git ls-files >actual &&
     ++	! grep "non-existent" actual
       '
       
       test_done
 2:  0a1550cb22 < -:  ---------- t2200: modify code syntax


 t/t2200-add-update.sh | 3 ++-
 t/t9832-unshelve.sh   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index f764b7e3f5..7cb7a70382 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -179,7 +179,8 @@ test_expect_success 'add -u resolves unmerged paths' '
 
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
-	! (git ls-files | grep "non-existent")
+	git ls-files >actual &&
+	! grep "non-existent" actual
 '
 
 test_done
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 7194fb2855..6b3cb0414a 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -68,7 +68,8 @@ EOF
 		cd "$git" &&
 		change=$(last_shelved_change) &&
 		git p4 unshelve $change &&
-		git show refs/remotes/p4-unshelved/$change | grep -q "Further description" &&
+		git show refs/remotes/p4-unshelved/$change >actual &&
+		grep -q "Further description" actual &&
 		git cherry-pick refs/remotes/p4-unshelved/$change &&
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&

base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
-- 
gitgitgadget
