Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F5C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjEKRD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjEKRDG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:03:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3059D0
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:02:50 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38dec65ab50so4881660b6e.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683824568; x=1686416568;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFL/PIFfLfeEjXri0FeCL5gof+gpekEDzzQ2mGxBc3g=;
        b=OSP5ySDdZ9oyxiTsaYsqpr/nJfg7C0ZzXCky/ONpQE6KcRSXv7CMu8IMJ/PdNA8edS
         zSXBYjmhXMUGtGriqxPvWeeDofru7xSPO0gL+sOW4ZL5CA6gQKU+UpGiXl0QI1AaI6Os
         hMUOA+cgFNXWpAEjjxK3CQC/a9nouQZEns+59IuHS4JdecAnrkwjtPYms8I8Nat8FvSo
         eaP+8SNbXdaAs+VScsBM6B+g4253OR1bqhtVZBYPOs0g35OMbrnoF1UCGkfmkgqw065r
         3nY9XkTGtUZY5eyqrbreDduTYAqFKrcRqdrk77ltMTVM2np/rS3wJHDqgAut9zQzkTxG
         z96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824568; x=1686416568;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dFL/PIFfLfeEjXri0FeCL5gof+gpekEDzzQ2mGxBc3g=;
        b=H0tgXUm+rqxTyQL6th+2t4Mtv+PdJpjvhMjZyfIZfIuRf8Gn3y/2i/XMFCLuOwN0AE
         9DgBnzRP+6cV7PWJMhRlqoE68q4r5IAZKDubwQaywiKsKu62/v3L4T8VpOWn1fY+sE1o
         0T7l1dB+b460u757efv6/saJgdEcAzZI65rU565l2VE4g7usFrfcL6wX2nq71fU9tsYA
         MmAdkzCDFU6+7PSbkKmFRd2hoiwsgX65uC/ehsDhfy8bghvmCWSXBNHz4HWTrKWGhk16
         jqWTB4eDsQqeTbb6lziXJbp3up4IfEWcW06xmJrOCVBA6LAJOi3nb/vTxeLCV+yUokxz
         sKkQ==
X-Gm-Message-State: AC+VfDyZY1N7An4DsE9t3UhRr3DarXPX8+Zgc53LLL6CZ5EG8INJSmMY
        deJLQBTRf/E6cJw4tnP5Tjo=
X-Google-Smtp-Source: ACHHUZ7WgTdX9Jb2aGRT9iofLmybRakhDxV8w79EJ6lHWKpkesG26DhyUBsU5cOnAEE4zUKAvePJwA==
X-Received: by 2002:a05:6808:192a:b0:394:672b:229 with SMTP id bf42-20020a056808192a00b00394672b0229mr431861oib.3.1683824568106;
        Thu, 11 May 2023 10:02:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r81-20020acaf354000000b0038ee0c3b38esm3524546oih.44.2023.05.11.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:02:47 -0700 (PDT)
Date:   Thu, 11 May 2023 11:02:46 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, christian.couder@gmail.com
Message-ID: <645d1fb69e9e8_26011a294a5@chronos.notmuch>
In-Reply-To: <015dcb79-9630-e188-65cf-23b005184db1@github.com>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <645bfed357efc_3819294e1@chronos.notmuch>
 <015dcb79-9630-e188-65cf-23b005184db1@github.com>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 5/10/2023 4:30 PM, Felipe Contreras wrote:
> > Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <derrickstolee@github.com>
> >>
> >> The 'git merge-tree' command handles creating root trees for merges
> >> without using the worktree. This is a critical operation in many Git
> >> hosts, as they typically store bare repositories.
> >>
> >> This builtin does not load the default Git config, which can have
> >> several important ramifications.
> > 
> > For the record, I had already sent a better version of this patch almost 2
> > years ago [1], not just for `git merge-tree`, but other commands as well.
> > 
> > The obvious fix was completely ignored by the maintainer.
> > 
> > The reason why it should be git_xmerge_config and not git_default_config, is
> > that merge.conflictstyle would not be parsed if you call git_default_config.
> 
> As mentioned by Elijah in a different thread, the merge machinery loads
> the merge config as needed. I confirmed by creating this test, which I
> may submit as an independent patch:
> 
> test_expect_success 'merge-tree respects merge.conflictstyle' '
> 	test_commit conflict-base &&
> 	for branch in left right
> 	do
> 		git checkout -b $branch conflict-base &&
> 		echo $branch >>conflict-base.t &&
> 		git add conflict-base.t &&
> 		git commit -m $branch || return 1
> 	done &&
> 
> 	test_must_fail git merge-tree left right >out1 &&
> 	test_must_fail git -c merge.conflictstyle=diff3 merge-tree left right >out2 &&
> 
> 	tree1=$(head -n 1 out1) &&
> 	tree2=$(head -n 1 out2) &&
> 
> 	git cat-file -p $tree1:conflict-base.t >conflict1 &&
> 	git cat-file -p $tree2:conflict-base.t >conflict2 &&
> 	! test_cmp conflict1 conflict2 &&
> 	! grep "||||||" conflict1 &&
> 	grep "||||||" conflict2
> '

This test is doing a real merge, not a trivial merge.

Try doing a trivial merge instead--which is what most of our testing framework
checks--and your test fails:
 
@@ -14,17 +14,12 @@ test_expect_success 'merge-tree respects merge.conflictstyle' '
                 git commit -m $branch || return 1
         done &&
 
-        test_must_fail git merge-tree left right >out1 &&
-        test_must_fail git -c merge.conflictstyle=diff3 merge-tree left right >out2 &&
+        test_expect_code 0 git merge-tree conflict-base left right >out1 &&
+        test_expect_code 0 git -c merge.conflictstyle=diff3 merge-tree conflict-base left right >out2 &&
 
-        tree1=$(head -n 1 out1) &&
-        tree2=$(head -n 1 out2) &&
-
-        git cat-file -p $tree1:conflict-base.t >conflict1 &&
-        git cat-file -p $tree2:conflict-base.t >conflict2 &&
-        ! test_cmp conflict1 conflict2 &&
-        ! grep "||||||" conflict1 &&
-        grep "||||||" conflict2
+        ! test_cmp out1 out2 &&
+        ! grep "||||||" out1 &&
+        grep "||||||" out2
 '

-- 
Felipe Contreras
