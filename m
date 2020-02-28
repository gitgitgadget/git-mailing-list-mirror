Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C5C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00983246AE
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO+V6GRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1KhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:37:23 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34887 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgB1KhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 05:37:23 -0500
Received: by mail-wm1-f44.google.com with SMTP id m3so2657007wmi.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eM6Ruhl3CDlqYrO+dkwf6BlMzLADKwfvnbKRJcpLp4c=;
        b=MO+V6GRNspGl2LAVIRKPuYHg5kzynsH/muGLmDCWzU6Vf2HpC1+nIuoM2fiLCS8Liz
         YjjyMbomqIxpa7Ee6kQiriwGsqhZDw1n6mG+l8ddRCrt4Q2PxBimewVX2ertqCMb5kPR
         05tfWr/9wvNRwL2cn0kB5VRooBzhCA8qcBuHoXAwc6M20pbbsMXRwP5UoSARcoJ4KYcV
         b36AVpyYHRJKL8EoJ2MC+nVW702SoIqLgjjDncuNJg1UeLpw+qztKtLguLxStcnn0ST+
         SGUecEwOt9SipHSXemMQPnndSWDDmHi9IXIA0P7v8LWAok2NzxR24Y6z/SyGU7LEcX32
         Zhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM6Ruhl3CDlqYrO+dkwf6BlMzLADKwfvnbKRJcpLp4c=;
        b=YDem3RQAbhVEzeRUSvoLvuJE8KkLMeJBQeXjzkh/vvMRHVdwv7tWlAqw/DTQ/ltLkN
         53e1mr0o4eAvp7MWVxElOoHOGXm7TTf30P3TJEPwTVGEMuIKHToZxjom+nY3CqZoMYbN
         Dcqk8K+m0daboIjARRmKpRz3wHXcSwKe2+SxniHQ4qRoDLLYSn0hP0ILP3l3jtioCkd4
         qh1alGlH125IW1/N1E9fETfxWED3au5arFOjqxc/XS3CZsGX3lkpgPrJcT2dzbEc2oKk
         8Wp94noT3b+tW0Q+lUoO42sm51tDfnEj5OmDp4VL65E9CJdu3aGjRgcQF1VPYM+lg/u/
         uPgg==
X-Gm-Message-State: APjAAAUBRscsSlvKvWxMZpDXAq29gUKzJGrqnEpz1duUdQ4opqJOwuMa
        7IpfxjMYARpQ9gK4N9YC17oy790HM/I=
X-Google-Smtp-Source: APXvYqy2tWWBs5XI2mnHEwJyHKoqXpVC2Y+Els2citakrm0AdCguRuU8ConUzAMzJMW8BVmP+M1Pcg==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr4316434wmc.4.1582886239778;
        Fri, 28 Feb 2020 02:37:19 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c9sm12089032wrq.44.2020.02.28.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 02:37:19 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH 1/4] doc: list all commands affected by recurse.submodule
Date:   Fri, 28 Feb 2020 11:35:55 +0100
Message-Id: <20200228103558.1684937-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that `ls-files` is not affected, even though it has a
`--recurse-submodules` option, so list it as an exception too.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index b33177151c..5962f41ead 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -59,8 +59,9 @@ submodule.active::
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option,
-	except `clone`.
+	applies to all commands that have a `--recurse-submodules` option
+	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
+	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
 
 submodule.fetchJobs::
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

