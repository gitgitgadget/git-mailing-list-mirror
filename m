Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C7AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B79207C4
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 23:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxik+DWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgFPXdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFPXdi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 19:33:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D742C06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so106877wmd.5
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cjvGzZpo8HDWBL0rv5XXQnQTnZ6bb5QILLsOM5C19hc=;
        b=Vxik+DWYWQyKE7lij0y+A0y6+uMx0To6TgJ1ojDuYuYTcowC/0bOIFDvfocNHui9po
         w0Zlhgw/FsEnIr2bs8Z/X8YGvasENiRRL4KFw0qOMkGtfIhEqRZggsuvY5zs8leIOlme
         5zrSKkFjMNkWnVFVvWG7AOybTX+duk8amZ8rSArpOyAJS18idaNFjLs6lDH9ZQ+1jBXD
         T1eJ/QN2+wRoSY/zDH1GMZAm0zxZ30coTmNb7dk3JxDgM+AGTUzC6ZqyIdGNGqyg5bGa
         DNdog/A917a1s1C+LoT7+vOi4mP9QX42Lrojf45A7mUO7LRyjJBSaYUd3XoqBu56FjFl
         ShWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cjvGzZpo8HDWBL0rv5XXQnQTnZ6bb5QILLsOM5C19hc=;
        b=PTczjtPtSdwH4tdvuuGCspNgj7EIFi7FS/qI1+rxsE37hNeE8e48uk9eJmCbm/l3Pj
         u2tlh6vwQQAjwrPiZ1QWALIfRRGSjncvvqxktLKJuTcI3fO6ow+2u6aqHKSQBtayhTS4
         XY4kIvmOlf/yCPA3h46vws2CXDGcOmLmXJd9s8ZE/Mgn3YX8jCqAoCUmi8Fa6oa7mEHy
         xdQ+/IlwAApkkfzgaUfVjjDTW6b9I0c2vFPTJSD1m7qrRRIqpb1hJa1jnSUlTuivfetk
         95YUKUhx2tFtdm4rGDr0t+PhhcMpDP6ORD0nIVA/LrN8dOSUeaI/aG3m1mbDqJXtCSsO
         mDzg==
X-Gm-Message-State: AOAM530OkT+TdRB5SellkDk7n2srjC0ZJYgq+vsoL2lKuTzQthtIKcFN
        4CsrM6BZ0eJe2KT/OshBsfHUWAds
X-Google-Smtp-Source: ABdhPJxNLW/Xo3G+O3JSVc1hqaSdJ2Skn0A9hUwU0paM2hodmFOthCTt6SU01iGkp+XoEICzPNDH+g==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr5788624wmm.189.1592350416684;
        Tue, 16 Jun 2020 16:33:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b185sm6819868wmd.3.2020.06.16.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 16:33:36 -0700 (PDT)
Message-Id: <64613ad7ad6e5224c9d36fd1fd6222cbd3538705.1592350413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 23:33:33 +0000
Subject: [PATCH 2/2] [RFC] git-prompt: include sparsity state as well
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The current git prompt includes a lot of possible state information, from
various flavors of rebases to cherry-picks, or merges, or bisects.  Add
sparsity as another state flavor (though one which can be present
simultaneously with any of rebase/cherry-pick/merge/bisect).  This extra
state is shown with an extra
    |SPARSE
substring before the other states.  (Sparsity is probably not going to
change much within a repository, while temporary operations will.  So we
want the temporary operation related state changes to be listed last, to
make them appear closer to where the user types and make them more
likely to be noticed.)  Thus, for example, the prompt might look like:
    (branchname|SPARSE|REBASE 6/10)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 014cd7c3cfc..3e7344a4014 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -421,6 +421,11 @@ __git_ps1 ()
 		return $exit
 	fi
 
+	local sparse=""
+	if [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
+	    sparse="|SPARSE"
+	fi
+
 	local r=""
 	local b=""
 	local step=""
@@ -543,7 +548,7 @@ __git_ps1 ()
 	fi
 
 	local f="$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}$r$p"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
gitgitgadget
