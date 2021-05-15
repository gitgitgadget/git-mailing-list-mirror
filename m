Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC745C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D4461354
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhEOL6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhEOL6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C0C06175F
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:03 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x15so2027112oic.13
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQNgCPhzxzCFTTlDUt00GfHjGdusv/qaDXTiOv2Fkqo=;
        b=DZFpKBs/hI+WcNt32HwXnVRAkghXi+64aWp8QpPVsH4fmaOaWeA7u9g8yXdnd0/ADA
         DceO6HEwxBW/s4CyF8Y4sKupB5YPug26IMr9DjTvRYG7YcYT57hvYGhomWAzm/gfeNWm
         xXHRcZGsCaB3qfCK8JoxlbTuqafkZTiTZVjJ9GOpL+AYxnKI3GOqbY8iOnJVXsp9fyk1
         2u+Umgr4E/JaO7abb0Da43v0irsJqKZW/+O2prTHSr+CbnO8LcQoK2x/eVA4+5YO5ppQ
         FQbTUC3R6og86/NgnjS1LWcUVhWfIkvkbLyFvfQlfG9Pws8VKirqC6ZmRlhhYrZrw5yK
         vJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQNgCPhzxzCFTTlDUt00GfHjGdusv/qaDXTiOv2Fkqo=;
        b=P63e5ZvUNXb6ZZNwipphso5Halo67syevtvljmTr9TCl8Y1Xa/p/XYoP6DAyxge5Uy
         KVfGheGuDYmnsTmhTCpqe3eqNK+kpWfHqhz3XRQU3Hbto/uBwWU7mkvFiKzdboy8g1TM
         ijoUHDDWvHDBcsEIulvvqA5oryQqaiU2sMVpvG4t8Mi8utDLC2uMJX32yvvOzNKDSY51
         flG7IfmZN6CJaEu/B45+p9zBnzKJO6btVqBeSg05MGIPRgyxLZb2D1IuNyNyfL3sTZUP
         25oOhSFjElezo7n5v/lO2Rj1DckK1X0LgwL2MhFVI03fPom/nrv51BRhLCbffTS0fCuN
         SbLw==
X-Gm-Message-State: AOAM531mHq4a3X+RXsGa3TGxGRupd+JDHhfaUxzub1aU6WC4gLzEOYeH
        CYqxW352ImvfAyRRpPgLTe8og6B0pkQpJg==
X-Google-Smtp-Source: ABdhPJy5aE2N5Xgomjww1KPXrMaAHvQwMvuhHwak+nx2TgnRYbwPP0CUyWs6WtAchCy74fF9AC3W4g==
X-Received: by 2002:aca:4752:: with SMTP id u79mr20829068oia.86.1621079823110;
        Sat, 15 May 2021 04:57:03 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id h81sm1709159oif.53.2021.05.15.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/12] doc: asciidoctor: remove unnecessary require
Date:   Sat, 15 May 2021 06:56:46 -0500
Message-Id: <20210515115653.922902-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This file is loaded by asciidoctor, the module is already loaded.

In addition to being less redundant this fixes a problem while trying
use a development version of asciidoctor when the gem is available:

  $GEM_HOME/gems/asciidoctor-2.0.15/lib/asciidoctor.rb:51:
    warning: already initialized constant Asciidoctor::RUBY_ENGINE
  $HOME/asciidoctor/lib/asciidoctor.rb:52:
    warning: previous definition of RUBY_ENGINE was here
  ...

That's a bug in asciidoctor, but there's no need to trigger it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 70a0956663..423450392d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,4 +1,3 @@
-require 'asciidoctor'
 require 'asciidoctor/extensions'
 
 module Git
-- 
2.31.1

