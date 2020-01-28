Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E0C33CB2
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F562467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4o7JmGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgA1S05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38554 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgA1S0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so17220369wrh.5
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=D4o7JmGBs/N4W9aftDNt8RxPNjkdXwV3DAd7hAsHjyfeiIWKAtl3PEb1Tk2+05+dQR
         ASfu72IIUk5usp0jlv0cPFB3cQFQMKqBC2ZJ6aXHBx8qcAALvd0vQWM+7iSrFUUd/cN2
         sI1V2P7e+KwVi9hoyS/f8kk3sWICVpHKUVPc2HZvmhuNTVNhvexfjDpcNK3sQrhOPIOg
         U1GHr83BiR9d+x9aT+KdfSlkbRr03QisGBPPUQuj6/oxOb/Xz7xXh/EiEhGu2ChjLr0K
         erMkMK6yJKwIBWOXQjuo/EokrMll06V8Peom+kpsireR4x2kcCWZyhQ677CCI0K1qaU2
         hrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=osg1m7Rl4C5QgRfkdHsdnXAljMuvJkUSWazJih795l8cXNgVe+kzMJtUJ2woouBEGL
         fnEkMRIJBla8tcQzIjjtaLb268sDjQUucvukH7Al+bQ5LiTQ5lcEPxDTzq/qv9gJG4nn
         ET8p5OreDN3h/M0sFwLtupDNT8Pn+K0g2KwLBdPeiYtplo19dIw+nkTge7yTFkHtyNCD
         RmpRXzJJ70LyKZAJJNfDCw8OnlU0nBO5Ma6TkcvATHIIGLFgDoPAhSxa5sXB3NlP4kyt
         BeIDvIe5GZFviX/4KFz9P6rgUXDz4fDLzj74a7Ts58svvFl2l0xPMwxXjawZ4CRWBI4y
         VScQ==
X-Gm-Message-State: APjAAAUi3cY3b33a+uKwkldrp1OppMpHES+sEkR6u8tP1yIlVow1dbd0
        6cucPoIWGY2pK5WtapOCv+ZO5E9F
X-Google-Smtp-Source: APXvYqwxYEjV3NWa6dYwscMzzkpCLealXTi1YqRVOEcfsRUtR9tuy5su7T3bn8ZqY3wc187gdQ829Q==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr30769982wrx.90.1580236013504;
        Tue, 28 Jan 2020 10:26:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm4236185wmb.1.2020.01.28.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:53 -0800 (PST)
Message-Id: <1867746d97c5e3d5d738f12aeb0e1ab739a6b8c1.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:43 +0000
Subject: [PATCH v3 12/12] sparse-checkout: improve docs around 'set' in cone
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing documentation does not clarify how the 'set' subcommand
changes when core.sparseCheckoutCone is enabled. Correct this by
changing some language around the "A/B/C" example. Also include a
description of the input format matching the output of 'git ls-tree
--name-only'.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 4834fb434d..0914619881 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -50,6 +50,14 @@ To avoid interfering with other worktrees, it first enables the
 +
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
++
+When `core.sparseCheckoutCone` is enabled, the input list is considered a
+list of directories instead of sparse-checkout patterns. The command writes
+patterns to the sparse-checkout file to include all files contained in those
+directories (recursively) as well as files that are siblings of ancestor
+directories. The input format matches the output of `git ls-tree --name-only`.
+This includes interpreting pathnames that begin with a double quote (") as
+C-style quoted strings.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
@@ -128,9 +136,12 @@ the following patterns:
 ----------------
 
 This says "include everything in root, but nothing two levels below root."
-If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
-`A/B` are added as parent patterns. The resulting sparse-checkout file is
-now
+
+When in cone mode, the `git sparse-checkout set` subcommand takes a list of
+directories instead of a list of sparse-checkout patterns. In this mode,
+the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
+a recursive pattern, the directories `A` and `A/B` are added as parent
+patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget
