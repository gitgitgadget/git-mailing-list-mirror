Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE730C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C422250
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO9hTaro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIPMpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgIPKae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DEEC06178C
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so2442780wmi.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvZ1fVsxMLyCcJ8zgy4iF9eMczQzBZxvlPawMLZwE/k=;
        b=DO9hTarob7PJddFfbUoypx0A+IK31EudCoXPREjLHKvep+3uMAQfbexjE99f6QJe92
         sjPKY5yRLPsm4wuzgHGPfvSJ3gWIC+QwQOJp4xgQftdFheSa1ufDgm4j/STuYzQ8St68
         CozEWTy3YNXN76oO1Box3FekWS5sjq5N3MMSiR1gxl57gQFaHBkghJ2UuqamdPpgbWaX
         DuLiotdjWHtkK4EYP0jKByveAgV3ctR81E2w/AUTUHABQJO41V3Qz8p+d7ryuSUwp32e
         mF9iTEBkeuszj06Bvz//c/QTuEEOONOM+fmWLhEio6hvFauZPQ2FjBXgj4xfcpJcLDXs
         l8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvZ1fVsxMLyCcJ8zgy4iF9eMczQzBZxvlPawMLZwE/k=;
        b=rUDJdw26fOYaA4eeRFYDlUlcT7ZRuCp7UVV8Ked9sRmyxCtXWveP7ZEiAN1I2tWfAX
         Ndo0scmqke3qX29Amp5GuTRs9+/cwNhfnGmXOF+rhNWn7gzUDWmjo8/H3jX7rLY9/O/6
         KqCjL20yew64txtkPweIsp4ZE7lplJrwF2IvirRQd+hZBqCSFsuoDqIYKDX1aB2p3/E6
         IQholOoEpXFltJqm4qlxxkvYEORg4pEvWPACInEiUHLCBwQ/1JGJyrjHO3+k3KGxS8Pd
         MdqD00etwTR2Q0eo4EGvotus7hD1DwKO/ArwcSO7/RX2yFK8tOZWVN25TMIx4btYbQt5
         8CWg==
X-Gm-Message-State: AOAM531Vz3jdnFx9TSe8bVpOF56DNFtZ3Bl8C0ynHEiyiHbO7pwP3tji
        JUG5dlHfDrz6Xlx2M3qwTZjTRNcuEpCb3l7T
X-Google-Smtp-Source: ABdhPJypp+Ve5A9hAPu9leeuLN6iu+HtwDWA0NCyew/eqvLYOhVUVMI30yDK0Dl3j2log2aVzIkHCw==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr3381365wmd.104.1600252201306;
        Wed, 16 Sep 2020 03:30:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:00 -0700 (PDT)
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
Subject: [PATCH 02/15] remote-mediawiki doc: link to MediaWiki's current version
Date:   Wed, 16 Sep 2020 12:29:05 +0200
Message-Id: <20200916102918.29805-3-avarab@gmail.com>
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

Amend a comment in the test.config file to point to the latest
upstream version, which makes it easier for the user to tweak this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index 5ba0684162..b6fb0b3993 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -31,6 +31,9 @@ WEB_WWW=$WEB/www
 # The variables below are used by the script to install a wiki.
 # You should not modify these unless you are modifying the script itself.
 # tested versions: 1.19.X -> 1.21.1
+#
+# See https://www.mediawiki.org/wiki/Download for what the latest
+# version is.
 MW_VERSION_MAJOR=1.21
 MW_VERSION_MINOR=1
 FILES_FOLDER=install-wiki
-- 
2.28.0.297.g1956fa8f8d

