Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D46C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2A62072C
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NComIScn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJaWJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJaWJt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 18:09:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B971C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 15:09:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so5984542wmj.5
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EnhZlmHg/LyUmY0ufbxZ3OF3pf7AZoZNYEDEB89lDaI=;
        b=NComIScnm1VYH3roYJcAxK735xqPraDehKj/7Zmqrla5quo5juTFS6V6DVd4p8kWMB
         Q1TWMt1PELFqy74ixs/mMXeA5VndgGO5N2+Ap37D20sU3DZGDIIewXjL1gwVtyDkGYTS
         33C8jYHbsfoDDP0GXGKLSSjJ5x5jFZSFrCGXRQmkYwu2Doi7rLQiQhv1IkwdMZLCpCC+
         VlC1XKpyHKw7Fu8raPVHsdrtpYy1jDe9xFDhwRXh+sASUg0rs9hI+WWQxu03T0qbh1sK
         5dQtfTDfHBhyI0gUdT2/lqcrISypVwDup9HcK91kLXiU/nXZswqjayjq6sAV4kfaGxSK
         WggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EnhZlmHg/LyUmY0ufbxZ3OF3pf7AZoZNYEDEB89lDaI=;
        b=tzsYQneiRsKOFHp25kUWnAndfB3HJvHQpVbRKC0zLsG00Z7gTcQ70v6cEDnQGjBXNc
         QO4L5pia1OwIMPisF/SZA0xyUN6yfDwHmITyUPlXd8Mc5qlM65t0tGmCJD8Y3NTOGAGk
         r85zcvCOvu82K5cnkXwIfRC+k2uIGyTrXKuIHGDKKZ68WoQrp1HQWBdwrk8FGdRuLSZd
         rxgai6eBz86uhpHoj/nsk24bWr94zZeDoG3qH39ItSMV9JUPVMoydGpPviJDGnURzsnH
         VGUQo5tbXL2GSEgK/9mkZThtWmcucDQoqlqkKe5dw3t40EbzBx0bLNxtbEE4lwIEuX2J
         ZsNw==
X-Gm-Message-State: AOAM531K8bCcodpmyIvIODmPOv+12gG9qmMbIX+GTgX1NZYIYRVGrSOa
        au2ttPBswODwRQxtpqEy1FzGwJGJ6gc=
X-Google-Smtp-Source: ABdhPJwQEsLAuLHt/+MTGLaEVXSTwsYu1mghI2JQ7voH4DCBnujdLCix3be+duD96aYtwHTmJj231A==
X-Received: by 2002:a05:600c:2155:: with SMTP id v21mr9779222wml.100.1604182188018;
        Sat, 31 Oct 2020 15:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm9585587wmb.46.2020.10.31.15.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 15:09:47 -0700 (PDT)
Message-Id: <pull.775.git.1604182187195.gitgitgadget@gmail.com>
From:   "Sibo Dong via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Oct 2020 22:09:46 +0000
Subject: [PATCH] git-prompt.sh: make `option` a local variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibo Dong <sibo.dong@outlook.com>,
        Sibo Dong <sibo.dong@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibo Dong <sibo.dong@outlook.com>

Other variables like `key` and `value` are local to this completion
script, so I think the same should be done with `option`.

Signed-off-by: Sibo Dong <sibo.dong@outlook.com>
---
    git-prompt.sh: make option a local variable
    
    This is very trivial, but variables like key and value are local to 
    git-prompt.sh, so I think the same should be done with option. I have 
    GIT_PS1_SHOW_UPSTREAM set to verbose in my ~/.bashrc, so option gets set
    to verbose in my Bash session whenever I change directories to a local
    repository with a remote.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-775%2Fdongsibo%2Ffix-git-prompt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-775/dongsibo/fix-git-prompt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/775

 contrib/completion/git-prompt.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 16260bab73..5116016d39 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -137,6 +137,7 @@ __git_ps1_show_upstream ()
 	done <<< "$output"
 
 	# parse configuration values
+	local option
 	for option in ${GIT_PS1_SHOWUPSTREAM}; do
 		case "$option" in
 		git|svn) upstream="$option" ;;

base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
-- 
gitgitgadget
