Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C02C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBDE2311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDuPP26j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgHFRWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgHFRPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:15:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89FC00868A
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:28:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 3so10093706wmi.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ey32GJGslUi7f83gdHUjFT0YDn6+OGuxRhLhRJs0x7Q=;
        b=kDuPP26j4gYCY0gVxkK50fAhA12XR5X6v+AXr3lqfIzGx9Krsg9jO3d5XVANAkXjA1
         9+4QOYWrUlUprUygjAK6OQzxOEg9JABkRfYIWqk84eqc2kUsKBAiULYgpeTQdfPZ3lrY
         yXB3Bc0ZZf7yQMdujvIzfLTKYp18JrYSAJRt+ensNIuC0G/ZU+vhREPEEQV2ZBW92Aco
         pNlLBCl+2Wgav3n1GjF85KgziknwCXp+O+zlz5Lu2BuB+5mdP6be2sPpVIV7S0tH6Upr
         kahd0AmzcNELCgzGy3bJnZoShxlPvf29lSiwHIt3hB85i4zyzJyHNw1ejfSuj0xqUBq1
         +HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ey32GJGslUi7f83gdHUjFT0YDn6+OGuxRhLhRJs0x7Q=;
        b=V1AlYqZS32o5uKE2ryO3vOrAuIXFzwKaFHv07jHrjmtXbWnr7LzB9Lgj0WIG6b3Ua7
         DBjHRHU1On3f3rcATazx4OOX+PDxzZuOeizj5/wuhGcX5MOq9hBtoq1WZR3l9cJKSsNB
         hGTNYMQI89u5n4hBuyZLitQhkQEq1hQ8q7wyox/m+Wo1lp84YBXDi3pl2MQPpAxEkea9
         BUDb7fT2BcyTl+dO4ssYvv0m/K1qsKI7F1uS+n9ufHOJzXivz5RWBmcWewURN1rdDIAn
         8RKcPUTKA/GPEmKLWUcUpvQCxmd0XHL/ZQ3rxHOBVWJp7CvtvEjEtzoZcJFPHBuZp1Cw
         CQvw==
X-Gm-Message-State: AOAM533qHs6xYdyS0MNtNqrbOiYqzT/vs7wZk8h9+dfYVKY7DpCMQrtS
        vRYD3AZI/p5QHmnO1utOr87wiXhK
X-Google-Smtp-Source: ABdhPJxP9o9D57p2kQ8uxCfBW0vytrHZiIBhB4iHDTsuM85hjJpXagFtcmaPVeSCsaOzc1uthymCUA==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr9069417wmi.65.1596727676346;
        Thu, 06 Aug 2020 08:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm6894748wrw.78.2020.08.06.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:27:55 -0700 (PDT)
Message-Id: <c18a5edf505cf8421f4465c9f6e26bce8d94d107.1596727673.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.v2.git.1596727673.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
        <pull.693.v2.git.1596727673.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:27:53 +0000
Subject: [PATCH v2 2/2] mergetool-lib: give kdiff3 priority in KDE
 environments
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
 git-mergetool--lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f9d8f309c8..ac6695ea26 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -289,6 +289,9 @@ list_merge_tool_candidates () {
 		if is_desktop "GNOME" || test -n "$GNOME_DESKTOP_SESSION_ID"
 		then
 			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
+		elif is_desktop "KDE" || test x"$KDE_FULL_SESSION" = x"true"
+		then
+			tools="kdiff3 opendiff tkdiff xxdiff meld $tools"
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-- 
gitgitgadget
