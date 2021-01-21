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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A73C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E723A5E
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 22:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbhAUWWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 17:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbhAUWVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 17:21:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E4C061786
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 6so3263153wri.3
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a0l+HITz6SzitgtYi+GV15d+1DsaJwoOm5MRDPNWvgg=;
        b=hAMjwnr1Lkh6VjoQxKydmSlFVuB2O6J0x5Z9ALvPpWcgj1iLLseBEUYScnskAUKfTG
         sYAKKgKIjJl/1sbiRPUZfyCAgZ+8WXtrzz9mSJYsaHbb6zSqj9qS1sJA80gT84wEpwfb
         xiHmOCbb1WAPjleIH4bG/p3jdmPriGJBMKU9x0Zd8QKD33h/ApSkSECvbwUGiVSwWNdt
         HjduOdj+DrIV9pjdAhEJJEs73TKgF26k1VzYyvdKElu+USrykaXQex8di5vMV4TdPWrO
         ahBCeGMSbrrzVEfARjDIGrGq9vqu3b2zxy5Xd0JeX/mVoRLqv8J6PnigJmo1NRsCrSW4
         wXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a0l+HITz6SzitgtYi+GV15d+1DsaJwoOm5MRDPNWvgg=;
        b=YoBWwGwH7w7lMsi78l18Bk0vx32VpI/xUni2I55m922C4V51dCe4QJVKUX4iHwMP9s
         dzbvxXKuDeOP6XoG/86otmMQOBnI+EFh8Zzy7N+o51heX/fix1iJy0+4qfp0gXCRqCRV
         MD0v62Ojmj6uSodhNr7FIFQJK2EIDtCJ8WeYyB6DyssIq8K1xyXc1XMaCwQADTBbXw4W
         c4+Vdrsvw5gSQpynGUEPxUccWCEbeQYenxsGdI4tmOpy4RYb5TtUR+xzRlLLkjnPo4rD
         dcxB1Cl8Ri4dwNF64UBBuKUW7oFh6xR+/PUYlUoscPAdqLKxRMZWCa4VsRmHPxIK00YW
         UC8Q==
X-Gm-Message-State: AOAM531MD7f/+J4SQIb45Ya8YC9ojMFZsdiP0j15xHCUzEN3qAMfs93W
        +zfUPNSEWUaqESPheJiplqyg4PCor1E=
X-Google-Smtp-Source: ABdhPJx9g6hGMo9sjegGfrjMo1MjK3xeDQGGWp6lMwSI9ODCKtlznK/t9fVeZh1B0mb3eJ1xG0YWrQ==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr1463023wrv.363.1611267642586;
        Thu, 21 Jan 2021 14:20:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm9970262wre.39.2021.01.21.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:20:42 -0800 (PST)
Message-Id: <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.1611267638.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 22:20:38 +0000
Subject: [PATCH 3/3] range-diff(docs): explain how to specify commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
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
 Documentation/git-range-diff.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 9701c1e5fdd..76359baf26d 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in the order of the
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
+  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
+  merge base as obtained via `git merge-base <rev1> <rev2>`.
+
+- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
+  <base>..<rev2>`.
 
 OPTIONS
 -------
-- 
gitgitgadget
