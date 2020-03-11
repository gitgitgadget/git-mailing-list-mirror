Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E0EC10F27
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE40208C4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 05:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkkvWWks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCKFNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:13:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgCKFNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 01:13:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so908563wre.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cqrZm8Vvb0fGSVpl1B/b18OJcUhKsxw2q15GVnGgkkE=;
        b=gkkvWWksrkFiTaptVhBBeU47WxgbQJCE5Cvjr7mx7YmGVF5OmC14CT3ttBzfd7sNUD
         F32MLVcACfoI3mU6Bp9eys9z38oiOXqTobcOm27Y6TBrwfKxsRMJx1IaBY6i3KlALwJL
         DxrZUebP5bAVJUYKIqmHOkRtP4/MY5BXd6IHQx1Jj0fKFAKx9oJkoTMQCHdTntqhnwkU
         q9fl3H/ETHKAo0yInhC+98wydWDMxZmDyFNx8HkGb2/Nbkx+Gd+hWaWqtDTBeQCs+hPF
         fvavT8nu6waXFAYdi0+FwDPb4z30epjoSvLDHteSnQRDV1e6Wv5gp1iQn7huLVElOBh9
         eWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cqrZm8Vvb0fGSVpl1B/b18OJcUhKsxw2q15GVnGgkkE=;
        b=RJVvHBfh/cGQ9DeE8lHoxewBt6N5RHlWZIvNt+K8vF090+l8Bk8GoJCNoJE/BnTKxP
         3z7kLuLul4RtZ+826t8HLJJu2qjR4QoZrpFbEhH0nRem+Dj1tz+TCXppnksFG0nf1fPy
         +VsuKxAhebEAA4YjlHyU98LyBTu8dy2ogTZ2/ddxosQEu3oEuPZgr6FM2/91xX+om4FN
         439NtMSPeGOGa4DWnlbtfxDwf5H4O3Wja8LWq25s41mYPKdsvWmDXB+BqGUjF8lmJCH5
         yJgQDxllTiXPpVlv2E2nAmzeWBrawGJb/H7zSx4rnAMVPEczKKIhS3m6o8UegjffhFL/
         sl8w==
X-Gm-Message-State: ANhLgQ0L18QYhxPNVN3P0juB/u2IrxhlVTU6TKQFDAeUb5vqHzcXV5Fa
        BjgjEZ0S5QFEdeYbpe2TA2GSqxAp
X-Google-Smtp-Source: ADFU+vvDwf4SR0r72cYfMvJMrl6EbFBNarNaqGCZd3uxvCPD/kxrpuIM3Sny/46/JFOjNh8vfCmZcA==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr1980177wra.126.1583903624612;
        Tue, 10 Mar 2020 22:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm6371649wrq.22.2020.03.10.22.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 22:13:44 -0700 (PDT)
Message-Id: <12932b847ef9d6c60ed338f68d4a32706d68891d.1583903621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 05:13:41 +0000
Subject: [PATCH 2/2] git-rebase.txt: highlight backend differences with commit
 rewording
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted by Junio:
    Back when "git am" was written, it was not considered a bug that the
    "git am --resolved" option did not offer the user a chance to update
    the log message to match the adjustment of the code the user made,
    but honestly, I'd have to say that it is a bug in "git am" in that
    over time it wasn't adjusted to the new world order where we
    encourage users to describe what they did when the automation
    hiccuped by opening an editor.  These days, even when automation
    worked well (e.g. a clean auto-merge with "git merge"), we open an
    editor.  The world has changed, and so should the expectations.

Junio also suggested providing a workaround such as allowing --no-edit
together with git rebase --continue, but that should probably be done in
a patch after the git-2.26.0 release.  For now, just document the known
difference in the Behavioral Differences section.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8c1f4b82680..f7a6033607f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -699,6 +699,16 @@ suffer from the same shortcoming.  (See
 https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
 details.)
 
+Commit Rewording
+~~~~~~~~~~~~~~~~
+
+When a conflict occurs while rebasing, rebase stops and asks the user
+to resolve.  Since the user may need to make notable changes while
+resolving conflicts, after conflicts are resolved and the user has run
+`git rebase --continue`, the rebase should open an editor and ask the
+user to update the commit message.  The merge backend does this, while
+the apply backend blindly applies the original commit message.
+
 Miscellaneous differences
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
gitgitgadget
