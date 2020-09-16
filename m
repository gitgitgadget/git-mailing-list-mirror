Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E271C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086162224E
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUJy6Lya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgIPMif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIPKae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC45C061797
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so6290768wrw.11
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFBy6wythJxlomma7uaGba6HKNaFfTf5uK/VLYcTzlM=;
        b=uUJy6LyaDkyAdxTfeFAszWjV7T2ojTcqYyM3v57Ktcj0k2Em0UZrn9Q4SwYIlouGrE
         AlCzM3v1llm/TwLS3Dc2i4WRGbyVoXGRB6N5ylUq4MIXOKpnCR/uk/1L825aTfxUglUO
         zfPFzaX1pKh4VWjZufmi6N0kL9naQ09uMbf3Ky8GcI/6RQzKcOMCLrwcVzOABKyG7ZMF
         LZZRJseqKUYLv3GVSJ4gTdVk4Vbky4FNuT8tNraTjf2DNZkYpdgDn+psORHqvkmYcWAP
         1F5z0JM2iBEklEuzYaw+QQkTet+X4Iq2LcMjXDeIhbBMQedVZhBl+cNap2AKni7YGoXf
         Wk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFBy6wythJxlomma7uaGba6HKNaFfTf5uK/VLYcTzlM=;
        b=Pakinf9gfD/kiIs+kORST2XMjJGNUFTLT34sV6hBNhSxLvQFWKOnJicwsb4NQKqmww
         k+XjeYEOAbY1ApooQoj5BOqW+TVduvzfkK0KhRI3pdVh5xfpnQbmy0IfIf2be7nKVawY
         hzrMj4eYNOuOqJ47+pWwdvcr4DhA2mNvdG4EXF6yBTtQ6Tfg1XSL8l/PdOKfZX2nbqIb
         BK+wYDoVhqCOybKejQe7WDLbm5Wo6lujIrn9NG4aoxsoNl+xLHVgN0NsXK1CVzT6ANQ5
         0GEDiKxvqTGfnI4B6hvzBQKsk5KttJBNbwWJDciNv/bVDAQYgqsUZuaIK7mJxjH0aOk/
         Y6Cg==
X-Gm-Message-State: AOAM533LbIGAgyyJ08IDm4k/S3cAJZzrXlVMk+0gFo1oiEBd0Y295zqW
        xOPW2y9NrBFEFb93GZjM1Bq2HG4ebTvFPIBf
X-Google-Smtp-Source: ABdhPJxkM06TXEBrBMfDhOylCFkLf25IuWQ25xtpfTveZlm+vuce8r1dBKxWeyd/qpXG3GmvN3Lx/g==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr27677547wrt.166.1600252202340;
        Wed, 16 Sep 2020 03:30:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/15] remote-mediawiki doc: bump recommended PHP version to 7.3
Date:   Wed, 16 Sep 2020 12:29:06 +0200
Message-Id: <20200916102918.29805-4-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the version in the documentation to what's currently in Debian
stable. Ideally we wouldn't have to keep changing this version, but if
it's going to be hardcoded let's use something that works on a modern
installation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/README | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 2ee34be7e4..d9c85e2c63 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -14,11 +14,11 @@ install the following packages (Debian/Ubuntu names, may need to be
 adapted for another distribution):
 
 * lighttpd
-* php5
-* php5-cgi
-* php5-cli
-* php5-curl
-* php5-sqlite
+* php7.3
+* php7.3-cgi
+* php7.3-cli
+* php7.3-curl
+* php7.3-sqlite
 
 Principles and Technical Choices
 --------------------------------
-- 
2.28.0.297.g1956fa8f8d

