Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB1C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAA6120D
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhJGDjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbhJGDjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:39:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C647AC061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:37:54 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z15so3335164qvj.7
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=Ie48untrT9JfnvnIsPAlkS2meQOABMTw63ZE8PLDFc0QQjKLbjohET9QOYtivjTB4H
         d79rPilItf7cqsAxXba2S3xDD64y3dkyS+DpZXDUzopEwY6+Fh81JY6dFIXCZ+S8prDO
         XWMGUWLPlx1jN55f4ywT551C1DhMgcv2KjbyX4AMzLrRXbIjJ97l6g1/xH6H9DFKAmad
         qsiYHz/pfSGKPl3+g4btENWwxDdsgSwZZPFOOuLSHkZgHW209o7OPbUo7QL5yzohweHL
         OwGO0tOWzoaruKjW5ZRj/wH4J0v6nBc5y8S46+m2+kV6/Kg9d1Voo8fa6+G0FeNGyATI
         nFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=0n3bLvM48yO8GXNjnsNNe+pZTycz7VscnhSmyinvsPdYsRa33AHMzRgO6q0V0Xis2k
         WZPt93oxXtoNcj6XA0TJlTMbxV5GFI+ciFSCNH/QW5lBCSCGYJA3AeGLytWo236rJ3oC
         7Umlszpn3fPJlkNYKRDap7NRVvWniEnqAjVto36y2xIjNd+2FZd0R/vGnyg6qDyvxZDc
         1NOVYorYtXbeK+SGlVrDBgkhI9lgusDIQ8r+Mhtdb9eSkpush3iNEdDV/iWByJU5eE5h
         AFpMWVdXl5ASGbcxykmZ680KvNHtj1vgecZQgMwGf9wvwdboCnIN3hmoSF59xq9JsaZ6
         qzbQ==
X-Gm-Message-State: AOAM531MfvGVfKSirNh6bT+I7TBAY0nFnXPS2BE/m76fZbKA2HZ5l3+r
        kZfMsEnAxezdnLPm7go6h38=
X-Google-Smtp-Source: ABdhPJyY0Koqryi606H+1l00H4dXF/5X1kUBg1Zo0UMspXQ14JqpJ4pQ5TD6NdATXo24+JarAfuDfQ==
X-Received: by 2002:a0c:de0e:: with SMTP id t14mr1752508qvk.41.1633577874005;
        Wed, 06 Oct 2021 20:37:54 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id x6sm13892860qts.79.2021.10.06.20.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:37:53 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v6 1/3] send-email: terminate --git-completion-helper with LF
Date:   Wed,  6 Oct 2021 23:36:50 -0400
Message-Id: <20211007033652.80793-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
References: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other Git subcommands, "git send-email" leaves its output an
incomplete line when "--git-completion-helper" is asked.  Be consistent
by terminating the message with LF here.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..d1731c1755 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,7 +114,7 @@ sub usage {
 }
 
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
+    print Git::command('format-patch', '--git-completion-helper'), "\n";
     exit(0);
 }
 
-- 
2.33.0

