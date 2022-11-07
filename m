Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C198AC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiKGVXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiKGVXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7324102F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so33615542eja.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liLb5m7Gxdu1jKhTpbICJkV/eOHdcvbuS30xiZ1dUVE=;
        b=oaQzt+0vixlm4TtCJD6HA7Rs2GkRzrUby7tHXX8fTn8ddAYKG/8u/QvenCgKNOz88T
         M6MPvA7VwcL15vcHXUaVzN7jfXO6asYfLwMkECLrXbLAL0GRCF4lahZDap/u+9b97O+h
         irVZJRnUw1h6YdBGG6G3OqGa4iz64iCtnzWX+vczJ2h89f/O7bPUzJROej2ZVq4aKCBk
         YshL46m4ErJx7WsFPp66gvbnxurx4gdK6QITLYEqs8vypnMWHdGYSbzKrBb0ytU2pTv1
         vvv89czX6LtgnNlL2alSZZpAnKBEdY5aWTsUty/DYuBd3AJpy6WcDFA1fnvvOFi98L1n
         d9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liLb5m7Gxdu1jKhTpbICJkV/eOHdcvbuS30xiZ1dUVE=;
        b=gjE04zjw4bvqAufnBh6yAIac7jfQoya3rNPy215XUTFFKTP0wGYbEvWDCI+HzAEL3u
         HQhWhoTWeg6c6hPbkhqhXhArtclLoP0/E2fuLI2A/kkZrZEhU+brDgI5g2hcNSy6y4Aa
         SINK10NdO/syrkxrVDYbDLGf1445gAqLSHCktmLZGhprrRd4bJaD8WvLX6prbe8Yz9xt
         /xrGt3/9JkCUKdu0WuAT1Muj97hkXinJkkbEDoQO75i0Es5ZxZdB/tpeXFlevyJZQ8/l
         IhrZBjyOYDIGJolgCiSCmbONs5wfP5UatTTVw/l7xeoOmm+aPJSCFuldjzjEKN74iraR
         viZw==
X-Gm-Message-State: ANoB5pl50aAM6BnvNGcXMZyODu6oBroZ2YNw06lYzr1d7ioHBLm2dKW2
        8OiecfI3Bgoj2CnDB8PZLaMXeYV9feTwEQ==
X-Google-Smtp-Source: AA0mqf6cooZzwaId7yLazk45hI5cVtcrSuHZfc+0UIkSDtqZKK1t3KqTinchptcMEqoBFQ5zVvS44g==
X-Received: by 2002:a17:906:5dce:b0:7ae:5b86:58fe with SMTP id p14-20020a1709065dce00b007ae5b8658femr10991738ejv.641.1667856197630;
        Mon, 07 Nov 2022 13:23:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/10] INSTALL: remove discussion of SHA-1 backends
Date:   Mon,  7 Nov 2022 22:23:04 +0100
Message-Id: <patch-v5-02.10-2f6c37b90cd-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The claim that OpenSSL is the default SHA-1 backend hasn't been true
since e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17),
but more importantly tweaking the SHA-1 backend isn't something that's
common enough to warrant discussing in the INSTALL document, so let's
remove this paragraph.

This discussion was originally added in c538d2d34ab (Add some
installation notes in INSTALL, 2005-06-17) when tweaking the default
backend was more common. The current wording was added in
5beb577db8c (INSTALL: Describe dependency knobs from Makefile,
2009-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/INSTALL b/INSTALL
index 89b15d71df5..33447883974 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,10 +133,6 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.
-
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
 	  git-imap-send if the curl version is >= 7.34.0. If you do
-- 
2.38.0.1464.gea6794aacbc

