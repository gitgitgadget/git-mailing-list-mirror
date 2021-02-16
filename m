Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A889C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DFE64DA5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBPMCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBPL7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A2C0617AA
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so12549362wrr.12
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YV+e4hN9WG14es5aVMXyFgN6kFkSqjt5J2v4KgVmkI=;
        b=iG2WEWQ2ZOzZJw3GCdvKLq4oOtvJ024lrrzNLpj0g1V1uRgMNSeeGd//HfG8X+nLq7
         hf4rzI7QD0kKLGrhhMwosFNO5GrPeNgO1jQcLJ30CTK358DOZpJ3+L3m0ADB3vc7fHNY
         5suSsZTkZmwxqablQWRgi4FLdD5G8M8m4wnW6EAgQyPZnz9MIrZjHcPXV9EzGTqGapPo
         Eq6lCel0HsTysw4lNyXkB/ryQJUaefOFTcKA3Go917hsZIPw8492Y/z+qNKt8Ms/tBDx
         SazdM12tq6ObveSWIywrptV6g4v2w1+KLEabxJL6wOoxn7xSWqnVceOPFA+bqMbBjW/C
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YV+e4hN9WG14es5aVMXyFgN6kFkSqjt5J2v4KgVmkI=;
        b=JUExLDilEs9DmnBIf6skAFmd5L7IVjjldLmS9Hdpjt13PMsKZKD8OXW1P3FtOagosO
         r94VdDuCyoFTNKa7NTct7o+auaNLhYyPhNIUB3kVeQdd38cm5Rz1tTudX6i6hTii0I+8
         Gbmics2yjU9EcCw1ViA81D0T/oGUfz2FdNX/1w+Ef4I5VsOcMMEJhako/hwXFTc+9T2w
         Z1KmXCx1eJiJIFN6ysTAeZYNL9ZDJUb8nxkjxXnCOxVtBaXhnbuwcZyVytB3Js/PQy74
         IYhd4jJJxjxDOS8utfkhtHDS4PaOXAmu84taVuxM7cu9LwtxcoExGCRwToV5n2dZt/n7
         Eo0g==
X-Gm-Message-State: AOAM533dmgspDi+O9XpBlnL/KGwNY86CW1P+e3lxvCSpVXJydVoFL/Hx
        tTa36Fq4pTlv582obXJAXk6WQ2E89k6amA==
X-Google-Smtp-Source: ABdhPJxOwouwwGM9QDAUEJoDgS3Pu2QB0wWB78DvpGE9cOe4H+SSCh+scMignoUBNDQxa/Slc9BF+Q==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr23904407wro.218.1613476704954;
        Tue, 16 Feb 2021 03:58:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/22] pickaxe: refactor function selection in diffcore-pickaxe()
Date:   Tue, 16 Feb 2021 12:57:53 +0100
Message-Id: <20210216115801.4773-15-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's hard to read this codepath at a glance and reason about exactly
what combination of -G and -S will compile either regexes or kwset,
and whether we'll then dispatch to "diff_grep" or "has_changes".

Then in the "--find-object" case we aren't using the callback
function, but were previously passing down "has_changes".

Refactor this code to exhaustively check "opts", it's now more obvious
what callback function (or none) we want under what mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a278b9b71d9..cff46f9f8f7 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -228,6 +228,7 @@ void diffcore_pickaxe(struct diff_options *o)
 	int opts = o->pickaxe_opts;
 	regex_t regex, *regexp = NULL;
 	kwset_t kws = NULL;
+	pickaxe_fn fn;
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
@@ -235,6 +236,14 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
+
+		/* diff.c errors on -G and --pickaxe-regex for us */
+		if (opts & DIFF_PICKAXE_KIND_G)
+			fn = diff_grep;
+		else if (opts & DIFF_PICKAXE_REGEX)
+			fn = has_changes;
+		else
+			BUG("unreachable");
 	} else if (opts & DIFF_PICKAXE_KIND_S) {
 		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
 		    has_non_ascii(needle)) {
@@ -251,10 +260,14 @@ void diffcore_pickaxe(struct diff_options *o)
 			kwsincr(kws, needle, strlen(needle));
 			kwsprep(kws);
 		}
+		fn = has_changes;
+	} else if (opts & DIFF_PICKAXE_KIND_OBJFIND) {
+		fn = NULL;
+	} else {
+		BUG("unknown pickaxe_opts flag");
 	}
 
-	pickaxe(&diff_queued_diff, o, regexp, kws,
-		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
+	pickaxe(&diff_queued_diff, o, regexp, kws, fn);
 
 	if (regexp)
 		regfree(regexp);
-- 
2.30.0.284.gd98b1dd5eaa7

