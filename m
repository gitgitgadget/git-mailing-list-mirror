Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C6CC77B61
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDHUy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDHUyz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 16:54:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F978689
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 13:54:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso8299590a12.1
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680987293; x=1683579293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwvxJmInRKPfyU/fZ77byEOqiV9iWm9TmhGpyeA2O6I=;
        b=O0INzfnRaHws8S1FJ6WDS3cS8y5nD0JeBpWL4YduX1dAZnm7329Brs53W+kPu0MkmU
         2YE27EFnzhW/4rcVXR0Zv6G68ER2fai7qaS8spJjE5CujET3u0hViRVlWb0nVMpaSR4z
         bmfSsWTwJfnX99Asvg1gp1ohVWKXKl1coKtc3CADU+2eulmsffVB7dnkTUUoawVCnw7W
         lfWaDISYERcmZ2pMmhWp24KmBh4D/x/qjJYn0z88TzYUsBTZZ2DbQaSBHNGO4HPousSt
         wY+XPXikaoIAkOcJuy1+T/kFFuSJTuyjBT3e+apl9BuAO7NfKrBkDC/FYYh05RcLVGrB
         0nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680987293; x=1683579293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwvxJmInRKPfyU/fZ77byEOqiV9iWm9TmhGpyeA2O6I=;
        b=A8UUBkZy3ATf72utBUAEZ4VJkQcAFN6s4YGGYi5o86r9aQnpqz63d3igdZYSmNn1w0
         mx/t5x06tla25bScnoCErW0Rm/wnFx+Zfjljqj/HTw4z+ZyCTv6SLINtgDAs77qiacqJ
         lUj7ndbywDjLL78gyy8Nqpe/bcQ8qrVPVpFUP9KmABYUPKM+XQgfmZQqkkFiGiucRLIv
         s3R8C70zTyKSC2qEdqIRAG1ipJK0+fzbyqGMHtIKVaaJ9Io1U9/bDiR/fcmbE323pqJB
         TZrRHg/lTNyBI2Tfg4M1PTN0HndYuHLzE5gynUVONc36hdz0ZYDqtZXUf4oIqHiNrb64
         i/Lw==
X-Gm-Message-State: AAQBX9foNX0vrbH1UOfM2YUEcRP7nwnrAMS3LPQ3kRiMW1cCXu/Dl8rY
        BH2KhH+0MaA4O32yJ/2TZwmT2KSSG/BdYQ==
X-Google-Smtp-Source: AKy350Zhl7Q2plPPa04mmbZVCvZnaIokFfyF7JilbPfkKNaV3vAhP7ci84aRtHzaq6S7Tjrho+FmTw==
X-Received: by 2002:a05:6402:782:b0:500:47ed:9784 with SMTP id d2-20020a056402078200b0050047ed9784mr4743503edy.14.1680987292676;
        Sat, 08 Apr 2023 13:54:52 -0700 (PDT)
Received: from titov.fritz.box ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id b20-20020a056402351400b004bf5981ef3dsm3130586edd.94.2023.04.08.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 13:54:52 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] t2024: fix loose/strict local base branch DWIM test
Date:   Sat,  8 Apr 2023 22:54:50 +0200
Message-Id: <20230408205450.569548-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
References: <230406.86h6tttn21.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'loosely defined local base branch is reported correctly' in
t2024-checkout-dwim.sh, which was introduced in [1] compares output of
two invocations of "git checkout", invoked with two different branches
named "strict" and "loose".  As per description in [1], the test is
validating that output of tracking information for these two branches.
This tracking information is printed to standard output:

    Your branch is behind 'main' by 1 commit, and can be fast-forwarded.
      (use "git pull" to update your local branch)

The test assumes that the names of the two branches (strict and loose)
are in that output, and pipes the output through sed to replace names of
the branches with "BRANCHNAME".  Command "git checkout", however,
outputs the branch name to standard error, not standard output -- see
message "Switched to branch '%s'\n" in function "update_refs_for_switch"
in "builtin/checkout.c".  This means that the two invocations of sed do
nothing.

Redirect both the standard output and the standard error of "git
checkout" for these assertions.  Ensure that compared files have the
string "BRANCHNAME".

In a series of piped commands, only the return code of the last command
is used.  Thus, all other commands will have their return codes masked.
Avoid piping of output of git directly into sed to preserve the exit
status code of "git checkout", while we're here.

[1] 05e73682cd (checkout: report upstream correctly even with loosely
    defined branch.*.merge, 2014-10-14)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

On 2023-04-07T04:19, Andrei Rybak wrote:
> 3. t2024-checkout-dwim.sh
> Test 'loosely defined local base branch is reported correctly' in t2024
> has an interesting validation of output of "git checkout":
> 
>      git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
>      status_uno_is_clean &&
>      git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
>      status_uno_is_clean &&
> 
>      test_cmp expect actual
> 
> which is fine, except that neither file "expect" nor "actual" contain
> the string "BRANCHNAME".  And this test was broken when it was
> introduced in 05e73682cd (checkout: report upstream correctly even with
> loosely defined branch.*.merge, 2014-10-14).  It was probably intended
> for this test to redirect standard error of "git checkout".  It should
> be cleaned up as a separate patch/topic.

Here's the patch.  Alternatively, the fix could be to just drop the sed
invocation from this test.

 t/t2024-checkout-dwim.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 4a1c901456..74049a9812 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -305,10 +305,13 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_config branch.strict.merge refs/heads/main &&
 	test_config branch.loose.merge main &&
 
-	git checkout strict | sed -e "s/strict/BRANCHNAME/g" >expect &&
+	git checkout strict >expect.raw 2>&1 &&
+	sed -e "s/strict/BRANCHNAME/g" <expect.raw >expect &&
 	status_uno_is_clean &&
-	git checkout loose | sed -e "s/loose/BRANCHNAME/g" >actual &&
+	git checkout loose >actual.raw 2>&1 &&
+	sed -e "s/loose/BRANCHNAME/g" <actual.raw >actual &&
 	status_uno_is_clean &&
+	grep BRANCHNAME actual &&
 
 	test_cmp expect actual
 '
-- 
2.40.0

