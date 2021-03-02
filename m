Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4EFC433E0
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F29E64F30
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384594AbhCBPUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbhCBA6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 19:58:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE01C061788
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 16:58:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so814151wml.0
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=A21SxSl/ouH8G0fy2y9KXQaZA0p/PKHZ2c1ZboF5sFk=;
        b=PAPK3sdonSlzCdgTfsuw2xiYBS52KUM7FFjyYSW34MO4GNDH7uUqA4sKw+8Fx+nTT4
         BzZ4Mun0TRkanzm8mEMwS8Z8fivmaDwBhk/slyfNO/i+sSK1xOtSVJWp6p6WLtaXOjz4
         87ifCpPV/OC4CLNZfh7npSAZpKPYyMqz/YnhyGfvfQD0XG/Sj0ueZZk1dLiokUxAm3aP
         rt9LTNfqExf1u47ciVYndor5L95PEsjipcVXy+8/ivQWcDAHRPnNcSJpoNF7CMZUsReO
         yJDEiA4/27tppzdbGehhFrQc+g8Kjn2Sk1J/yusKNoSyUcXiFtz2M+f8ZCieRk2PNpa7
         8+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A21SxSl/ouH8G0fy2y9KXQaZA0p/PKHZ2c1ZboF5sFk=;
        b=IZEUNAwd7dlcHs3jHKhuQNmPDQisK8Azuk8dTz/VH43qoMbJgY/ZE6S9Kj9CHRcP34
         p0nnBN9cKhn4oQZWmjqiEovpjcLc3s3pFPeOLqcUW6hHou+EjzLRfrNgmDC6AhIRMTeS
         OEIbhxQj4Fe+V/C3ixmerDuGKjJb/5If3yoAoIStthu9NdMuMyWV81npIpHerCnqr0gZ
         LxXYAdhPg0QJ+6gKitNa7LjWLGXo09RNr/vdOrvA7LmQ5LPwS3+xDySW54ZOYk8DNGh5
         P1HCHs8Ji6RxHvmOmbCZpv2cAu8WcD40vdmu4WkHEQm3KtPXnw9Zut7hLHROiB4z7xOe
         a5Ag==
X-Gm-Message-State: AOAM533WYBVjz4GfW8rS3XF9x0njS0/OSYkfAMiZd71D27RQC5cBSGxX
        xEQAk1+iqDmn75kGAbonVPtfMB1sUBg=
X-Google-Smtp-Source: ABdhPJyHidm/lw+0mRk3gepNSNcWircFiBuOSciri9Ax0N0e4ROV8m26QF1EtNrxNQ4g8a3sx/19QQ==
X-Received: by 2002:a1c:e905:: with SMTP id q5mr1335495wmc.84.1614646690553;
        Mon, 01 Mar 2021 16:58:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p190sm889785wmp.4.2021.03.01.16.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 16:58:10 -0800 (PST)
Message-Id: <pull.971.git.git.1614646689506.gitgitgadget@gmail.com>
From:   "Julian Verdurmen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Mar 2021 00:58:09 +0000
Subject: [PATCH] Add support for C# record types
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Julian Verdurmen <julian.verdurmen@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julian Verdurmen <julian.verdurmen@outlook.com>

Records are added in C# 9

Code example :

    public record Person(string FirstName, string LastName);

For more information, see:
* https://docs.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-9

Signed-off-by: Julian Verdurmen <julian.verdurmen@outlook.com>
---
    userdiff.c: Added support for record types in C#
    
    Support for C# 9 records. See
    https://docs.microsoft.com/en-us/dotnet/csharp/tutorials/exploration/records
    
    I will try to use gitgitgadget [https://gitgitgadget.github.io/]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-971%2F304NotModified%2Fcsharp-record-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-971/304NotModified/csharp-record-v1
Pull-Request: https://github.com/git/git/pull/971

 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c5e..2803683c3117 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -212,7 +212,7 @@ PATTERNS("csharp",
 	 /* Properties */
 	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */
-	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
 	 /* Namespace */
 	 "^[ \t]*(namespace[ \t]+.*)$",
 	 /* -- */

base-commit: 328c10930387d301560f7cbcd3351cc485a13381
-- 
gitgitgadget
