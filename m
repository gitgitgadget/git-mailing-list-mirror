Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574EC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050DC2074A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdjpZtLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD2Jij (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Jii (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 05:38:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D7BC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so655420plt.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYcv6bUsEWW8kJqO7zccR+ZGgmy0C08FnPuZ3DRl7+Q=;
        b=SdjpZtLl9y4zyc/GoowtYyV2qCyu8J45ETbiSdPL014hUsVcgsOL/blsouNB351pwg
         mN8Blpzm2B4Z0gdVhZZeTbh+Bw98iWX1fvOnyMbaFurDDyzYWc1j93Mf0jayNBWqkbFm
         gbmuWE5In+doNq5XyKIDTTPV2yJineo9XCxGxsBsm3eaPdBv2SOKlQrVOfU7NkBZQlmP
         5RbxwCerLcqPwzLVPI39mcVT9FwQh8kMqRaCH99L72PZGr/JLCkt1NDSLN8aneHrnaHO
         X8mIWm7vp8pKmt0/o5X2HAlzd2WRymQplvq1Ww1e+T0xqcz0ry0k/cZoPcrt5Keo4xxu
         YJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYcv6bUsEWW8kJqO7zccR+ZGgmy0C08FnPuZ3DRl7+Q=;
        b=WFzjSEk+AMMWBPU0/LxgmkjZNi+t85VYQF8E1o/qajhI5eZD+VzgMgVF2MKinQFtzE
         dpj6v0iKtyYp2ZBWf7oTaX8g9fmIbuJWieL//mLf/cVlcu5r1Fs2h5/xAWzz6Cu6HrCB
         CoO2mvSlDQlKwIelAXhNVizIwQBJYwqdZPROShHjvoXFajeb86+GyrOzROZT7AZsZK5d
         sYkZ99pxZkP9tzudZnjerFI6nhduRO4roEIVtMCtEuxTWDkQt0u/YbEPFA3v4Ia3okBQ
         a7ZmeEAx0UDZ0k5OZmAsGF2YhMY+/Kydz+z1HtINNaVy1euaCp5cTgNa/btomX4EP7D8
         uxKw==
X-Gm-Message-State: AGi0Pua5l//osfRhZnMaddsqCez09WwZgMiFpS6gf6/3c7xwsTqSTvTa
        OJk6KYGKtiHjMoQEy5roXuYfd20Yjzg=
X-Google-Smtp-Source: APiQypJIFbA+2dFNOApJiqyikCGmUCYmMqE2R0CKVVn+g66vdxSblK6bCTJrXWL1gR/FoKCPQQ33bQ==
X-Received: by 2002:a17:90a:b106:: with SMTP id z6mr2069686pjq.114.1588153117642;
        Wed, 29 Apr 2020 02:38:37 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id o30sm667721pgn.12.2020.04.29.02.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:38:36 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v4 2/4] gitfaq: changing the remote of a repository
Date:   Wed, 29 Apr 2020 15:08:09 +0530
Message-Id: <20200429093811.8475-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository, covering various cases in which
one might want to change the remote and the ways to do the same.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index b1e758ffd1..7d294306f9 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -232,6 +232,17 @@ I asked Git to ignore various files, yet they are still tracked::
 	it is advised to use `git rm --cached <file>`as well as make
 	the file pattern is mentioned in the '.gitignore'.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any). There
+	might be different circumstances in which one might need to change
+	the remote URL (see linkgit:git-remote[1]). To change the remote URL
+	one may use: git remote set-url <name> <newurl>
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.26.2

