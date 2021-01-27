Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78BC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 922DE64DA0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhA0QkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhA0QiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:38:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701BC061788
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m187so2066637wme.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4myo4TcamtlWWjUMi2KsBzOmibuHazva3oGSYdNTraQ=;
        b=XuAc44qXSuFD9wZS5u+E4JmbhLp3j8q27hKw+2eqoR6NCawMMIZ4/Uf8lSKxQEWxpO
         LNZzZU69k1GWozDXvGp2CU1NzJEgyWlx1FdvHHSRp9jKe3TakhadVHtH4ayuBOVlhFgn
         mTffdDjS1M3sn41XTV6lkWqMh94FFtK48SwGrPSXzt6iuImwhpM7b82GkLsje9IFDwOp
         Jcuh8BUK9fFdTyqORfw3wYtVZQ4qyq00B/BvILsRse0IOtpVl8vDtjACTss5pd7+tkHG
         XdvjMMtVSCJbC7sgm4endCHUEZsrxQ6eJQLLBFg/d4NCp3/xJktF5QOVH8J9TGqxrgE5
         BGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4myo4TcamtlWWjUMi2KsBzOmibuHazva3oGSYdNTraQ=;
        b=Dt//VbXTMtCe46vh4FhjZyVy6BPSAkyRTGyeospsM980DGFbHoyIkIpsmEiLy5GvWt
         Ux3+NIgygm0SeAqwVnbm4/JT4OczR8BceDrV86U9sEiqi8854F3H2O1S8yVQ9ZEAq9bH
         QmHpcTewPvFkWYPRRpDPWhJQcy95odDyjNfuCDZt62oyc5YkJmPqNMyJ61DJGijWHRDb
         mrcHWlUOYPc/iea7rZCNx7d2hb2arQmWuhdDlzXoDMNMpH2GhsrOLh3xwi/959DSLPRb
         tQXFMgn9rPydwamS3Oia8Tpfjt83jPxiNJwSp8n1nwIvmIy8PQev7hyF6RKvTqr75ICV
         kbbw==
X-Gm-Message-State: AOAM530VhK/QQplvrV1Ze+OgC/uPOc2B5hebQaLuxSk0dRqbnHUijEty
        q8OUdmwMVX+zt8kQNCf8pLs+z3kjXJU=
X-Google-Smtp-Source: ABdhPJzWO2nrkKEcTDBoxF4vvDvsSOjoyHOTMA+Tu9svV6Ni0ARjjVje6NmIfWm7v76ZY/01nWSHCg==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr4992742wml.110.1611765449491;
        Wed, 27 Jan 2021 08:37:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w20sm2948884wmm.12.2021.01.27.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:37:28 -0800 (PST)
Message-Id: <5ab9321a34ca15b4f532022ad0bab431fb201b07.1611765444.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
References: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 16:37:24 +0000
Subject: [PATCH v3 3/3] range-diff(docs): explain how to specify commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are three forms, depending whether the user specifies one, two or
three non-option arguments. We've never actually explained how this
works in the manual, so let's explain it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 9701c1e5fdd..14bffb272a0 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -28,6 +28,18 @@ Finally, the list of matching commits is shown in the order of the
 second commit range, with unmatched commits being inserted just after
 all of their ancestors have been shown.
 
+There are three ways to specify the commit ranges:
+
+- `<range1> <range2>`: Either commit range can be of the form
+  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
+  in linkgit:gitrevisions[7] for more details.
+
+- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
+  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
+  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.
+
+- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
+  <base>..<rev2>`.
 
 OPTIONS
 -------
-- 
gitgitgadget
