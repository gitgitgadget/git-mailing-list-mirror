Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CCC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304E020708
	for <git@archiver.kernel.org>; Thu,  7 May 2020 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuuSR9KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEGNR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgEGNRx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 09:17:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D0C05BD09
        for <git@vger.kernel.org>; Thu,  7 May 2020 06:17:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so6481998wmc.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6oUMy9+0pcbJlA7NWDN/AiA3FX5vH6btDVtujKVxPgE=;
        b=uuuSR9KMuKZgFhq2nUWWLnBrIX/Cccqv4CMsXPKcvpor4lssSIbM60jUek1G6p228u
         08bQTkjwISRyJ0j3WPZgklu58joA6q12aNK/QRXFMacAwQaIZs5GghEgn9p5hjLoESVC
         hiWFHQ3D+cEWnWDEmecdTkSXI5PIk75xwJgwQ/df9vnxR97eqMshU5xcyGmmehwn3YYJ
         VXDzRdbfQaE1ugjCcErBKr9mo88YXib9DMWK1kVNfQCkZGXOFyw3h/XY78yxcdIw8fZ+
         4PddZY98297zR09mIdmxzMV0yU+vl6N3s84TdYrsZyz0OSOggtIHNS4juCnXmdHfx/kW
         ooDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6oUMy9+0pcbJlA7NWDN/AiA3FX5vH6btDVtujKVxPgE=;
        b=Vpc2UUbz9W5xyj3U11UAHIp3r2QZb1rSJYHEyb2ycLgIjONxzd1FKWK6LOKfw4iYMv
         cJwMVZFv3RKunDNe83M6YXddNuUk4BCCAvRx3OaA+/SbGwyBB9lRcqh78rIdGoUBLj1U
         v6gge6x5AN2HJsC5xLA4HsQRjaFhIZFZ8dNVhAx4SMjgX4kjpfH7adibv69V2upJ4Opf
         GA8ZSheVa6Fg5MtiyWWl/oosi+PjcV1cd0I0QW6I3TS12ayN4XIRldeaFBaZ2QyxDeCl
         XfKMP/ugchqBldiUVet5O3MyVRk1Oy7FMV+DJLnZWcivHguJrseCyAtMHj6qDabJCeu+
         OxuA==
X-Gm-Message-State: AGi0Pua/SUmoEb0bd4M2G38f+pnKeZZZcVigTh3FFbq2MSsePDpuwryF
        2B8HwOz6/W6lHYAVPHgtoFppAOyB
X-Google-Smtp-Source: APiQypKSDT7da/xmI7eoj8o6gc/SfEQg3ZJYgQpyDl4rqSd3kREV4F+kVMilu9l+Mez9W9bZYVo0nQ==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr11079446wmg.65.1588857471350;
        Thu, 07 May 2020 06:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g74sm7945867wme.44.2020.05.07.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 06:17:50 -0700 (PDT)
Message-Id: <9078d0872831bd51157b7623070412a3d6f3a1ad.1588857462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 13:17:42 +0000
Subject: [PATCH 10/10] .sparse: add in-tree sparse-checkout for Git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmaill.com, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The in-tree sparse-checkout feature allows architects to adapt their
dependentent subsystems into sparse-checkout specificiations. This helps
the typical users who do not know the full build system to use the
sparse-chekcout in a pain-free way. In particular, if the
sparse-checkout dependencies update at the same times as build
dependencies, then the users automatically get new sparse-checkout
definitions as they switch branches.

For the Git codebase, it is not immediately obvious which directories
are absolutely required for building Git. From my estimation, the
necessary directories for building and testing Git on Linux are listed
in the .sparse/base.deps file in this change. A few more directories in
the compat/ dir are required for building on Windows.

This presents a new possible workflow for Git contributors, especially
those that want to test several new features in their workflow. The
following allows a user to set up working on Git with partial clone and
sparse-checkout:

 $ git clone --sparse --filter=blob:none https://github.com/git/git
 $ cd git
 $ git sparse-checkout set --in-tree .sparse/base.deps
 $ make test

Perhaps there are ways we can further reduce the size of the "bare
necessities" by rearranging code and adjusting the Makefile to match. In
particular, I noticed that the vcs-svn directory is required for the
build. It could be helpful to create a way to build a very small version
of "core Git" that doesn't include integrations with other version
control systems, and having them automatically disabled if they are
missing from the sparse-checkout definition would be a great way to make
that more accessible for contributors.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .sparse/base.deps    | 19 +++++++++++++++++++
 .sparse/windows.deps |  3 +++
 2 files changed, 22 insertions(+)
 create mode 100644 .sparse/base.deps
 create mode 100644 .sparse/windows.deps

diff --git a/.sparse/base.deps b/.sparse/base.deps
new file mode 100644
index 00000000000..b0682175dc3
--- /dev/null
+++ b/.sparse/base.deps
@@ -0,0 +1,19 @@
+[sparse]
+	dir = Documentation
+	dir = block-sha1
+	dir = builtin
+	dir = compat/.depend
+	dir = contrib
+	dir = ewah
+	dir = gitweb
+	dir = mergetools
+	dir = negotiator
+	dir = perl
+	dir = refs
+	dir = sha1dc
+	dir = sha256
+	dir = t
+	dir = templates
+	dir = trace2
+	dir = vcs-svn
+	dir = xdiff
diff --git a/.sparse/windows.deps b/.sparse/windows.deps
new file mode 100644
index 00000000000..6c9bf1df335
--- /dev/null
+++ b/.sparse/windows.deps
@@ -0,0 +1,3 @@
+[sparse]
+	inherit = .sparse/base.deps
+	dir = compat
-- 
gitgitgadget
