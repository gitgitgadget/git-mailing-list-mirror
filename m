Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8488C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919E12145D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+CPvzg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIUKkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUKkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3091BC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so12188647wrr.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yshak7faj+mgi2Ksx8OWsWf5zigXj2q6IE0U4MdfFbs=;
        b=S+CPvzg5DAHmzD1rFwrK/lfqz9R5UxVKtcntnuDuRY4J2HCOeX9IM+x2CT8pIwYVlf
         AwoIyvps9eedzatrB8iJe4yUlkmBdVypLhr7csYlPeeLvdtony/iZvUX/Y/saPGUnAkE
         UDHvgYXg77CzYInKxhoX5X/WWtP01NyCSrk5MajEvQu+4e8SwuDFukBSb6J5SiNcvA2I
         udP5D5jgRQclxdSzmnI3RZONuQZzFmc/oA6I/CWO5S/MvYYuzhbJxh//hRb1FwMQp0g+
         UEL7qbzdT6O6QKPsHE8p4qG0vAJy3c78CO+1jyJthrScJWUs79SaaKJnXzywo7JEt57y
         KwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yshak7faj+mgi2Ksx8OWsWf5zigXj2q6IE0U4MdfFbs=;
        b=tkUuFO56z2LFDrZa8Uw+Rd4zX1g6aYxtdGrXGlkCEMBagfhJJe43mjvlZNlT9ji/gO
         +jvVpiEtmy2kjVZxr4KU5W5RKKtNqT1dCYou6MYGPXQBR1rTE+QTwFswfzrdLgWLDAEw
         lQp5TIeLSblB22bcfaflq+vfZ/f0lbkARC2OZ5Mu+i30wjeUfueAwamCCV7CWDtAHLvw
         4Wr/JB5ETcoPC8muZp1m+3pmMcI99GCP9dP0DqT5GBzgn21xJWXz0LYm4jZr0i+mrgW+
         8p/oll8XgmtSO7ZhxzRZyG2OIWnrWz/xIoBXGOiFqf/qa8MxKZCRWcM7Y4PeSFRYDazJ
         yiUw==
X-Gm-Message-State: AOAM531+SsazPVaywzDyJa6zXiktYlYcXUD4Dbo+Uj0DhmijV99P6KK3
        jGclMh3rSaws6ZlbFDk8wmVwR0slaD1Sbw==
X-Google-Smtp-Source: ABdhPJzB+FqZk8VL8u4wNdrMyDVgTFrYRLqZIV9EOIhs2d6a0HL9sv21olP9p6fbxm0ItXloiuvhOA==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr51001495wrm.120.1600684815677;
        Mon, 21 Sep 2020 03:40:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/18] remote-mediawiki doc: correct link to GitHub project
Date:   Mon, 21 Sep 2020 12:39:43 +0200
Message-Id: <20200921104000.2304-2-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

