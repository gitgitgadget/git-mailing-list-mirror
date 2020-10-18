Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B3C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E9C22277
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 20:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtjbayOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgJRUsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJRUsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 16:48:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C83C061755
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 13:48:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so9176696wro.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KNSU3qSO4Ps3c3k0rjo8GQ0peBOrJLzah9glgLRkw6I=;
        b=jtjbayOdNu882AeJA3vW0Sm78RUOqotMaKMEkfgTcO4KWTspIBCpQj8Kh5S10415jq
         pe7TliielcBrhJUYoUqD011CwPfxiUWqQ+rLr/z5m6qLlRsPbjlIdEYKOSymeM5l5uiP
         FPREAsUf5NOXBsHCWX0LCBifdMToYty03SfJ3tJj4fDVGaCjSzTJyN/u5dTTgyjeEOMQ
         Uz98Uu9kUiNFhuiCWECuPR8Q7zES40zpzHIWny4Q+HX2CCEaoi0eX/4mmS0ZyatGta+/
         D3hrRQzpVGvhtGMs2l1KqpvWipQYvZC0wpkOdhdL/u6+bl+RCRgOfEXVvUEPZBxa3fVa
         CvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KNSU3qSO4Ps3c3k0rjo8GQ0peBOrJLzah9glgLRkw6I=;
        b=jQoXsUdwDchMWoQhr5BExFVrIfWs4D+HzIWUPKmG/lTfyhrooNFH06ZTqhpNy31iQk
         Vb1jKQrQ4yV0mAi3FohLXmsJ2kIEPfvenoLBzBBjIb3T1c6dSnH4fC7o4qUoffVp5iVd
         NtsLTe18x3IYL3vMhOK4MVjOqHa/qrteZy4Dd+VD7gUMpAWsWaN66LocSRN5ugqOwgFZ
         BaoL5DZ2WA77FyJm1Q6qfdXWOA40aFmJDwI8jxe78FD/IXCdp9r9MB44uj/fcPhXx8uZ
         5sKFMv7JPvtD67HmRJY3vtoZ2alWHVnm/FeQ20N1fKw/5vypYNKRjvei5Nj/NvhN1xxy
         lwJg==
X-Gm-Message-State: AOAM5320Pei+tcqrTlGTi0lY3DNXBlcikZqD07xTYiRdLvuAK5AvBlMF
        F48B08CWc6IfUroEtwkjxr+zwIWPeUo=
X-Google-Smtp-Source: ABdhPJzWb8sGRvJeshYPBRMSwAQA9+lGSxTSU34vWavUoOdUGwzxpjFaEH3bfl3cXiIbomxdNx59bg==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr16294716wro.135.1603054089096;
        Sun, 18 Oct 2020 13:48:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm13137154wmg.42.2020.10.18.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:48:08 -0700 (PDT)
Message-Id: <pull.885.v3.git.git.1603054088108.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
References: <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
From:   "Amanda  Shafack  via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Oct 2020 20:48:07 +0000
Subject: [PATCH v3] t2200,t9832: avoid using 'git' upstream in a pipe
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

Avoid placing `git` upstream in a pipe since doing so throws away
its exit code, thus an unexpected failure may go unnoticed.

Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
---
    [Outreachy][Patch v3] t2200,t9832: avoid using 'git' upstream in a pipe
    
    Changes since v2:
    
     * Optimized commit message
    
    Signed-off-by: Amanda Shafack shafack.likhene@gmail.com
    [shafack.likhene@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-885%2Flkmandy%2Favoid-pipes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-885/lkmandy/avoid-pipes-v3
Pull-Request: https://github.com/git/git/pull/885

Range-diff vs v2:

 1:  bca393e69a ! 1:  d5f508b055 t9832,t2200: avoid using pipes in git commands
     @@ Metadata
      Author: Amanda Shafack <shafack.likhene@gmail.com>
      
       ## Commit message ##
     -    t9832,t2200: avoid using pipes in git commands
     +    t2200,t9832: avoid using 'git' upstream in a pipe
      
     -    When a git command is upstream in a pipe, an unexpected failure of
     -    the git command will go unnoticed.
     -
     -    Write out the output of the git command to a file, so as to actively
     -    catch a failure of the git command.
     +    Avoid placing `git` upstream in a pipe since doing so throws away
     +    its exit code, thus an unexpected failure may go unnoticed.
      
          Signed-off-by: Amanda Shafack <shafack.likhene@gmail.com>
      


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
