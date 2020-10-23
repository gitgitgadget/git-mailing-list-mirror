Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A071C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF96720FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Ffy0Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750245AbgJWOAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750238AbgJWOAN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DEC0613D2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d78so1583036wmd.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GlvccKPW/RdUuG9NKhrLYpSY9nZzEMvWBUu2dHtP/mM=;
        b=Q7Ffy0Fd/GELpUxxAFh0EINCEqdx2qK3pCRudjgyfVv17iXkg5Pz2oafFSIVH0dw0G
         sn/CZx7r79cpPYGl1ltUmutQoD6SwZp5F5CRr4JGzQiVqf9d+Fce9XIEULVEtIhM9JQz
         SM8MOCay0Gd93HXV1APidR9GUF4UkpXb7kyw/4xDR7t8IK3jDCAN4RTbs5BLdwRvwdwH
         +t8kdTWlTK42rTE+t/sq2s4gN85DMOLblcpnLlFKVlIIQzYYreVZ2+YWxbS0263j4N9W
         usyJhynVDSq7N0krndphGDHfSlpr8v2dNDMn7OMFXp/gase5kYTQ1e0Q54QUFCrST57V
         TwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GlvccKPW/RdUuG9NKhrLYpSY9nZzEMvWBUu2dHtP/mM=;
        b=BGZvFdyAFRq0Ixklbu7XRrNAzrqPIIkjlvVVx0UyEq5gXTwX7N8Bg1rAVJEd2nyrMV
         ui+jmot2hygGmROi9V6JJrh66Giv0XQgRjRYWUKXqz4jecLNFep3BQeNX+dr6fz/7M/G
         +v8UfQZRI/DWLf/oM87W7ECLhCrFUO4/bUBvnsoLHnbOtkPXHqtSlforwDvWKhaLyDMj
         augvtusFotXcDBlqMzptfdzg5YgfF/n48unfCOzKWhoGDiUFi7P/hh2rA8s0XjWiowZH
         cHFQqVAfu2wlE+TZ70p/WmfjBXlAfnn7pXdMgDsg2fYNQyo7XREpJUFoFX5I14r4Lr08
         dzvg==
X-Gm-Message-State: AOAM531Z/jXjJ2eltfduIb4Mu+g/WO6H3PWgudkLEQxZ8cSGmd2y7FCK
        T1Z4GAzvssJ0yGwIqWJMXJjQmg3Nt54=
X-Google-Smtp-Source: ABdhPJyHtGSyW1xbG5YBk4xR0DLfxgAf8j0xSUL+rcSYEWeNWSGeMsuoR/+Y7lmHp8hu3y31BGW5RQ==
X-Received: by 2002:a1c:a749:: with SMTP id q70mr2617130wme.117.1603461611860;
        Fri, 23 Oct 2020 07:00:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm3296914wro.13.2020.10.23.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:11 -0700 (PDT)
Message-Id: <9bd0a89a79b6f771a3276ec3a3b70c6c636793b9.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:01 +0000
Subject: [PATCH v2 4/9] t6200: adjust suppression pattern to also match "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation to running t6200 with the default branch name set to
"main", let's adjust the only non-trivial aspect thereof. The rest will
be done via a trivial `sed` invocation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6200-fmt-merge-msg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 7d549748ef..f3e66eaf9b 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -556,7 +556,7 @@ test_expect_success 'merge.suppressDest configuration' '
 	head -n1 full.2 >actual &&
 	grep -e "Merge branch .side. into master$" actual &&
 
-	git -c merge.suppressDest="ma??er" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
+	git -c merge.suppressDest="ma?*[rn]" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
 	head -n1 full.3 >actual &&
 	grep -e "Merge branch .side." actual &&
 	! grep -e " into master$" actual
-- 
gitgitgadget

