Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A709C2BA1B
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD62072F
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhb44B5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDEUQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:16:53 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39347 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgDEUQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:16:52 -0400
Received: by mail-wm1-f45.google.com with SMTP id y20so1724083wma.4
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GczwqmMhMlAsF6vOl+pzB+tlGjL9CRkkYe2i+lVhiBo=;
        b=Lhb44B5ensr6Mt9U5U5S+BSYgHKzc7MCR2tL+m4cqS+1ubKCYwYw2aZPm9c4o3GKyN
         GHQ5JJkS+lWtr3252D71rq3fkn4+X7kFQCCUeDm0GlZhoo081KWg24Ag6oSbQh92GCJY
         cWBxcL7Td5aiCoKkIw+DLfwxs00H53IrCUj+I9EFBQFf455aj/PvfTIzFQwkbUj+TQ/f
         if9ReNHx5DbW997+tAMTgj85Lq9e+xsop8zkn/7qTyqBy/f52nULphi+G4LHAZCbu35E
         6ac5DFkQPxqVi2cmBU/N8wcG1iycUUlLoylpr82M/LPMj6HiCdUjOCNM2h9LEUhaPhTn
         ytdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GczwqmMhMlAsF6vOl+pzB+tlGjL9CRkkYe2i+lVhiBo=;
        b=uTbP4ZaEva65VyKMcZ03SLFVtOnatbWSudTCZtv3fE0O1c7p5RxiqxQdD4kM90xEaH
         GpoBiXpumTyBsFA2kAimx29D6mYxpu2pBbqsperLV5GDPszasZpHYcP9TtdKZSktSSbS
         WzKJ/E4buJ5iA2hwRrKvLVK9sSzcv8+U1dh+/fK0YP9dfIW+ur6hNOc1ZtwLC974KZt7
         FouLFPzKkuV80Bnix3t11fW2KXLq1CO86dUbow6xtEHHcb5yA+5mgEFRsIOZM5kQZdT1
         ZOu5TQ2rtysgkJs0Pcj4G/FogrOQeoRsW/uPpibNHvEDAFHeQe3RrOzafIzv2yxZDNUE
         VZrQ==
X-Gm-Message-State: AGi0PuaZd62zmX9m2I9g5M1FHnAv84fnt5pyb2Jv4mNY88pPSplmq6dO
        ypteYPmweANQcdtRjpvQqLjtJIeYGmy0xg==
X-Google-Smtp-Source: APiQypKtp5RHjGzPXGRKVXFUZUikhGYLrd1Trkaavjn0EM7iPQFkWvJhwDD4gB9ngcCJwRiUUtBH2w==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr10341962wmn.46.1586117810479;
        Sun, 05 Apr 2020 13:16:50 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id d7sm22468921wrr.77.2020.04.05.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 13:16:50 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v5 1/5] doc: list all commands affected by submodule.recurse
Date:   Sun,  5 Apr 2020 22:16:29 +0200
Message-Id: <20200405201633.704987-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
References: <20200405201633.704987-1-damien.olivier.robert+git@gmail.com>
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
 Documentation/gitsubmodules.txt    | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index c476f891b5..f9f4e65c9e 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -271,7 +271,8 @@ will not be checked out by default; You can instruct 'clone' to recurse
 into submodules. The 'init' and 'update' subcommands of 'git submodule'
 will maintain submodules checked out and at an appropriate revision in
 your working tree. Alternatively you can set 'submodule.recurse' to have
-'checkout' recursing into submodules.
+'checkout' recursing into submodules (note that 'submodule.recurse' also
+affects other git commands, see linkgit:git-config[1] for a complete list).
 
 
 SEE ALSO
-- 
Patched on top of v2.26.0-106-g9fadedd637 (git version 2.26.0)

