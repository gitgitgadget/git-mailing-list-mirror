Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9BC47258
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F60208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBRPYqHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgEAPaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgEAPah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93603C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l18so1174109wrn.6
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=w5R3fvbChOogMJmaRFfwAONf/Hm4fSZS4S5dv4d04tk=;
        b=mBRPYqHf+yrWVTkBvHGWyFb0rAQRS62L0WnOmF1EKFbGWABd+zWndzVWYgueMdG72h
         pDGhC9ClDxPJHpW8EKhWbGk3PnY9Dux8kIculspMInUlMI72NepJrGisL+zojgtbGv5s
         eZKB9LJYn9Q6DntzpP8ZRLt+5ZSrcjfa5NktK12wgBW0DTgT3FswQoVJqch30PxSt7h/
         wnwVBkHnmvS0EOeoH3Kj12ibmKbYzmEHZbjaGzPm4QcEYIVIZqSIWFrN9/IvZpu/CG4T
         RdEZ4WMHLElU72k7ooUo8o0aPN2ytvbxGdmUGbCLgQCFHy1uM4kTvreNOCu+8OSsY8Vg
         tHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=w5R3fvbChOogMJmaRFfwAONf/Hm4fSZS4S5dv4d04tk=;
        b=NEsZql4aPyGkSxoTTBP/Do2leiUhAjzNyjgsDGyKaCcsgZtw5rqG3CID5eGtt5uIFs
         x3uZBnkvyB7lGyrl8QpyyFN4d91fEjgakZq/2rbObH5Lex1KNLUuV7TKjF/bINl5RvYA
         893pSyNZLYn1zoqQuwV78H7Sihd0yfS/QqDDQ1BMNhs4esV40yG4TrRVQfynJ5PZzUG3
         tjcemv5iPOQf2FwsU7wDq4BnE+k33aJwJ/NTZCXKhxI9VlauyegICleDFKiGNh2BsrKO
         ldZ8pz2bDqPSOecf6YehO8PW8Rpm/7cqTqNxSZmoz4RhfQ104n8C+QiyD/iXIUcRx/ZU
         upag==
X-Gm-Message-State: AGi0Pub2ZYcMsBwNMbMgHbxe3ebZq+XXeMH+ZY2xCIzgbKB8gpY/GWl0
        G/JHcOvfkIMTPnvTbZEVRewJmWS5
X-Google-Smtp-Source: APiQypJvEX3g9mMD2ZSYM0PJR3WUg2pPqV1GWaPjqFJaUjdFOK0kysTMaBCA6snwB35sY/eYLvQZOQ==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr595716wrs.350.1588347036186;
        Fri, 01 May 2020 08:30:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm4773826wrb.16.2020.05.01.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:35 -0700 (PDT)
Message-Id: <35d2901957efbb8727142ef633ae0953b613c0d1.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:24 +0000
Subject: [PATCH 07/12] completion: offer '--(no-)patch' among 'git log'
 options
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd0..ec6ff1d5fb8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1860,6 +1860,7 @@ _git_log ()
 			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
+			--patch --no-patch
 			"
 		return
 		;;
-- 
gitgitgadget

