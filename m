Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B901CC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CFA22250
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhNp7DuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgIPMvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgIPKae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3BC06178B
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so6343903wrs.5
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yshak7faj+mgi2Ksx8OWsWf5zigXj2q6IE0U4MdfFbs=;
        b=qhNp7DuBDyz+pN+0ZsLjAW5l3iHKCgw2qcUV2NAvXfhMFCKgVpc3a9Y2DCxWs2Kscy
         pETsvMjn1yTM5MUCeJ7bZZj2VUUx9Tlg2HOGaHjNG7IsdAynpP+1kKvSTDFzQ9Cox0vx
         A9caFG8C+V2xdzIoB5m047bK78cw1VEnSgBgVKbCvYyCqc5yekEo1+ScQfYevLV7aBYO
         Cop0UQPuLpfXpdutlW6H2iq0gJgDfqCOYuXRjZqv9VCXF5ZDXmiNqXYYQqYhJS2n55Ir
         j3RWVtY5zAXVsNCSig++KvDqa/a3rbUEqSxNgI9KAOJxctYOPGHIBeyGCIrFaeSYIsf2
         GhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yshak7faj+mgi2Ksx8OWsWf5zigXj2q6IE0U4MdfFbs=;
        b=VHxUGtp/o7vQTP+2N0XuMDDS5m8eoYVLZskQD1vgVNV/WMiGKs7RCEllAyPp+KfYlt
         S8qJcDSE7uwW68ezB+tSVxVQT/MCIns7QSvid0XPWEHXg72E+f/rZYI7G8PHXp6BR2jx
         xef1VwIVaDtZ9xPue95nbxYrJHcA1HcVsVfZpuTojmJXHe5pdDs+fSvpKnwfsMl4qKn2
         PFgCWvPr7et9DDR6zfLGIKyI9XTkertPgSB9j7xxupsrg0eeqT+NRdcezTK41iQXKnYT
         2jFY3gwNgSsPuQepCrM77NRmdulJPKNKIRxLs/SeqwsDzZSsMNhLFbY09reb3PlJcjE+
         wN7g==
X-Gm-Message-State: AOAM531U1LN9vXSU6OxlA6+6rakJADh4kbN7Kd6aiq6D7bJms99PR9NK
        RKiSZRFdgpR2Rh9BNEauE/yXdpi8PcyzjjLT
X-Google-Smtp-Source: ABdhPJxCT8a0Wntr1hh073C7O7QbttyVzBi7woYkM7tiS5xselcN/Q41o73k1sUw4A1+OXUpgyatMQ==
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr24531806wrm.147.1600252199957;
        Wed, 16 Sep 2020 03:29:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:29:59 -0700 (PDT)
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
Subject: [PATCH 01/15] remote-mediawiki doc: correct link to GitHub project
Date:   Wed, 16 Sep 2020 12:29:04 +0200
Message-Id: <20200916102918.29805-2-avarab@gmail.com>
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

Change the link to the canonical one, the old link redirects to the
new one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/git-mw.perl               | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.txt  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
index 28df3ee321..eb52a53d32 100755
--- a/contrib/mw-to-git/git-mw.perl
+++ b/contrib/mw-to-git/git-mw.perl
@@ -6,7 +6,7 @@
 # License: GPL v2 or later
 
 # Set of tools for git repo with a mediawiki remote.
-# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
+# Documentation & bugtracker: https://github.com/Git-Mediawiki/Git-Mediawiki
 
 use strict;
 use warnings;
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index d8ff2e69c4..08190e23e1 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -9,7 +9,7 @@
 # License: GPL v2 or later
 
 # Gateway between Git and MediaWiki.
-# Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/
+# Documentation & bugtracker: https://github.com/Git-Mediawiki/Git-Mediawiki
 
 use strict;
 use MediaWiki::API;
diff --git a/contrib/mw-to-git/git-remote-mediawiki.txt b/contrib/mw-to-git/git-remote-mediawiki.txt
index 23b7ef9f62..5da825f61e 100644
--- a/contrib/mw-to-git/git-remote-mediawiki.txt
+++ b/contrib/mw-to-git/git-remote-mediawiki.txt
@@ -4,4 +4,4 @@ objects from mediawiki just as one would do with a classic git
 repository thanks to remote-helpers.
 
 For more information, visit the wiki at
-https://github.com/moy/Git-Mediawiki/wiki
+https://github.com/Git-Mediawiki/Git-Mediawiki
-- 
2.28.0.297.g1956fa8f8d

