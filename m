Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16550C2BBFD
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA47A2072C
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4DwC3UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgDMP0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbgDMP0F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:26:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E53C008748
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w4so10736939edv.13
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qzcMJa+mkLK1M0dyKPSed4/B6s0GK+ogulNk4HwyAQY=;
        b=D4DwC3UIKopZcPhlh1+AobZoY5KppvSjHppKSS63lI5UoP6G2ssJUYaiwFB7zBPzy5
         YsoYEuM8zFPW6iZSJiNbLJh30XjYdgocCcMUEqvYp7MnT96lVTMGjvRTMllznXYPfUT6
         JQmCzRZOKcYPpbOeKNQbcGRAs1uW+HQnElypWg2XWZY4FKqOc7E4eBuJsuez3N7rsxBv
         fYkvhdwEzSlaO7JyLD0GlNj9lD19l8YbcwMrsduQLDC5tlm4y5HfF0roUm0Dh/pBhVgZ
         eata9+gBXrB/7nBlbqfDvL5fT00zaczRtE5T5qKCOTWsja7Zym1aQJ9/p+CowsIpREye
         65Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qzcMJa+mkLK1M0dyKPSed4/B6s0GK+ogulNk4HwyAQY=;
        b=TuQMZSz/g5/XrUnFPiuztRKKcG3jW/zMFeBZf51GSwp2Eo95ExPVB4bnguRVvONtdF
         jMOxzsWCe34G9u9scYw0btqFUdjmBqf45jUY6hC/FUh66QUrZGTGPxNQ/jtd/z9mh4T6
         dbj3LdypUrbHw3058PtZ+bz/YvRFxvMcJfyKRSNguS0KEt0+9GC9C5u8xzLpT7FBQRHw
         QjXqr6JbJzW9Yw+yzpFw7W8QjEKJYtjx3HlnLYIvb4nK/Q/oq6XGBA7aOnpfFjVEz96x
         RX4rIARpzpk1VJ49XKlB1nuBLttLEhBylKn3fhdAKl0T0TZecHN6ISJRs8iZSSVUBp/k
         l69w==
X-Gm-Message-State: AGi0PubEV74WsKgY0WEAbUZ+jMiqQ1L50zPlP1pzGXBufYEDe070tQYr
        QG1HbueE/9D7S9UdnxfcKejWJzbL
X-Google-Smtp-Source: APiQypJKabp16nt7UK+YxreNdUqPTpDlYs24vJ1MtM+rkYMeu3EWol/Ht/kRagepweAChNazcrQp4g==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr15723596ejz.172.1586791563762;
        Mon, 13 Apr 2020 08:26:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23sm434310edq.89.2020.04.13.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:26:03 -0700 (PDT)
Message-Id: <9baf4c8ba383414e41d3d7726cf40c39cbf197e7.1586791560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
        <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 15:25:59 +0000
Subject: [PATCH v2 2/3] clone: document --partial and --filter options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change added the "--partial[=<size>]" option to
"git clone" equivalent to "--filter=blob:none" or
"--filter=blob:limit=<size>" but did not document that addition.
It turns out that the "--filter=<filter-spec>" option was not
documented anywhere in the "git clone" page, and instead is
detailed carefully in "git rev-list" where it serves a
different purpose.

Add a small bit about these options in the documentation. It
would be worth some time to create a subsection in the "git clone"
documentation about partial clone as a concept and how it can be
a surprising experience. For example, "git checkout" will likely
trigger a pack download.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bf24f1813ad..eafa1c39927 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--partial[=<size>]|--filter=<filter>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -162,6 +163,18 @@ objects from the source repository into a pack in the cloned repository.
 	of the repository. The sparse-checkout file can be
 	modified to grow the working directory as needed.
 
+--partial[=<size>]::
+--filter=<filter-spec>::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied `<filter-spec>` is used for
+	the partial clone filter. When using `--partial` with no `<size>`,
+	the `blob:none` filter is applied to filter all blobs. When using
+	`--partial=<size>` the `blob:limit=<size>` filter is applied to
+	filter all blobs with size larger than `<size>`. For more details
+	on filter specifications, see the `--filter` option in
+	linkgit:git-rev-list[1].
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
-- 
gitgitgadget

