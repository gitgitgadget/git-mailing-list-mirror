Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9CC433E1
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E6E2076B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 06:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEVkMRSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHBGdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 02:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgHBGdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 02:33:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456FC06174A
        for <git@vger.kernel.org>; Sat,  1 Aug 2020 23:33:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z18so27778015wrm.12
        for <git@vger.kernel.org>; Sat, 01 Aug 2020 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2AZQUN6wp1aycp+qZzVmMt6E6FNqbqAGtu9qSoEB2T8=;
        b=DEVkMRSqypzl3Bm+y9fje8HiMKqh9AxSz1blQGXiX9St+jLAj0G9t2q6k12eSFsPXZ
         CwwkgujTLL6ojrhZX8XXZjRmhf23jqChtuCXIweBvyFiXBopFywslh5AVOpCfLbQ3cFo
         T/ANu3amAb4k9qaRqyeGf7Os20CmcJs7n6rSMWXO9enKxi3hyoyXBfyAIP7TaCprNDPJ
         nf8Ea5M3JeEHRT8Dai4RtQ7NiM39CfCvOv84BLC1n1EuWuWQ5nFuSp/WST4VBKmcfvb7
         VkERRwIKUrtFs6N3cmm7LPq6QF7+bixYvBo/5s5W/0XJ0L8qV8VeMECdxJNeUTGbGWWQ
         s4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2AZQUN6wp1aycp+qZzVmMt6E6FNqbqAGtu9qSoEB2T8=;
        b=BWr7L+uKQs1ODBhxGjlcKIWMsK6XOYt6BdFaVZTUDW5EaqSINl6YLVfhbg5ichq69j
         Fk4OcdRhoTCIoAjWO457h8X+ofk01gIR4S7P1O1vkXV1mrzLiGsLYJ7Uoht38JYyo6m6
         tRsudVGOovUZ66QO6n3cbdyHZWQxGP0eV1tKiRa+EHdYbG3yqDo0+/WDvy8DoleWE7o9
         RwQpD6yehCsDAbX/Zcdbnf+D0acq/mDhP6tnWdEHEj6u3/xw/CN31LqoGavjKk88/2bL
         xs/C2gO+OIArzayXwK4ihwf3Y81VT1Ag3CnG+kN9KwQZ6NHlUx9mUWOgPskM18a7IfoZ
         jqvQ==
X-Gm-Message-State: AOAM531M6DVOzyY2SJZCx52F0fSq0AEWOiaQTCosZUoDr1z6Z/m6HtIs
        aq8A+87XAgCKrt8Mnh43P0R08rWK
X-Google-Smtp-Source: ABdhPJwLg9tuzwiYx51EQ2pKcmpIlar0sVNuJA+r/F8cr4kc3ppTHlzIViwvXghr2zx7GAQVviAZ1Q==
X-Received: by 2002:adf:d092:: with SMTP id y18mr9445570wrh.145.1596349989490;
        Sat, 01 Aug 2020 23:33:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm18977701wrj.94.2020.08.01.23.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 23:33:09 -0700 (PDT)
Message-Id: <83a50f7e0bbfd19cffc5cffb9f17484e86443d0a.1596349986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 06:33:04 +0000
Subject: [PATCH 2/4] t6038: fix test with obviously incorrect expectations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6038.11, 'cherry-pick patch from after text=auto' was set up so that on
a branch with no .gitattributes file, you cherry-picked a patch from a
branch that had a .gitattributes file (containing '* text=auto').
Further, the two branches had a file which differed only in line
endings.  In this situation, correct behavior is not well defined:
should the .gitattributes file affect the merge or not?

If the .gitattributes file on the other branch should not affect the
merge, then we would have a content conflict with all three stages
different (the merge base didn't match either side).

If the .gitattributes file from the other branch should affect the
merge, then we would expect the line endings to be normalized to LF so
that the versions from both sides match, and then the cherry-pick has no
conflicts and can succeed.  After the cherry-pick, the line endings in
the file will change from CRLF to LF.

This test had an expectation that the line endings would remain CRLF.
Further, it expected an error message that was built assuming
cherry-pick was the old scripted version, because cherry-pick no longer
uses the error message that was encoded in this test.  So, although I
don't know what correct behavior for this test is, I know that this test
was not testing for it.

Since I have no idea which of the two cases above provides correct
behavior, let's just assume for now it's the case where we assume that
.gitattributes affects the merge and update it accordingly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6038-merge-text-auto.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 27cea15533..39413d5b48 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -189,7 +189,7 @@ test_expect_failure 'checkout -m addition of text=auto' '
 '
 
 test_expect_failure 'cherry-pick patch from after text=auto was added' '
-	append_cr <<-\EOF >expected &&
+	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
@@ -197,9 +197,9 @@ test_expect_failure 'cherry-pick patch from after text=auto was added' '
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	git reset --hard b &&
-	test_must_fail git cherry-pick a >err 2>&1 &&
-	grep "[Nn]othing added" err &&
-	compare_files expected file
+	git cherry-pick a &&
+	git cat-file -p HEAD:file >actual &&
+	compare_files expected actual
 '
 
 test_expect_success 'Test delete/normalize conflict' '
-- 
gitgitgadget

