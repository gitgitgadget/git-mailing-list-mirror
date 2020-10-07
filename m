Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F9C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83722083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks467bRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgJGH4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgJGH43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:56:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F051C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:56:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o8so597166pll.4
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gBO5fykvGQ+RmuON1CwFXQzWBEFVVNtnRsGW7Oa/xDc=;
        b=Ks467bRxMJPXaE6aE3+5D4BjZLRDrDrTsF8+3h4vD5adQB9J1qpAcww2Sf9fbIsej1
         71fEJyne19vZJGZnVuSwsddgNvG44awukVAJryfzaVfeUE3B/XMtftlWpjY+dJ+JOr7M
         tVXKt5p5tPjFxsWLDNHQHyzFKhwN97ArgSJj6Fk7tkW9kiPmBDidkaISLEuuIuH08z88
         mYS696+xYnFkCmuURkwwMrFPuNn32Ay8E3lyPeJ30CYG/KKW/KhrZl/L4cwxRdYafMxv
         tj2PqdEsU/b8o1GMkQfqrJukrETSYXnmrnuCsBad+3w1kMvjRImog9oSPSGfNRoHlnqA
         c9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBO5fykvGQ+RmuON1CwFXQzWBEFVVNtnRsGW7Oa/xDc=;
        b=YjpJlFmWPcsImgKfD/fgi+HqhGzxQIYVcCSt1joihxwOL6c1uiQ6Foe+Psvg0+aLYm
         vrxl0rAEsXUgThFuROW69IFul9F3BaUSa0lh2LjCEQATmsb/XFW42tad54tXCmJtwtss
         F4UZJm3Y1RuC+18cFQ/LWNAfq+G350gWy/jhOaXPfIBwpdShxeu4PeqIo9DLXVBOE19d
         JOTFtGEFbexDN799nQylHa6GA+g6UYY4EfmQ5ia+NwlzBfSEKZxlB+Trad42fDam3sAu
         IqO/oR0aiEDxe9Ylp8YMNDNQBidNiSFwWnI63Mde6hfqQeGjeFOzSRgU+s0oyrrQzZvd
         pbCQ==
X-Gm-Message-State: AOAM531KirjLqXmGbwl16QCoKLHneyrT7PUaOHmBbF4XHBo9CaaaBwZp
        /0kTv6LYnKwqV3fnsidb0i91lNm3s6g=
X-Google-Smtp-Source: ABdhPJwbwpmiu6JesMr8h8qq0UMkIB6mxx4UDN08/AHxAB7QRIqdAF5ovEgSTdrMpkJYFwJJbM9H5w==
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr333077pjn.47.1602057388838;
        Wed, 07 Oct 2020 00:56:28 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n9sm1909950pgi.2.2020.10.07.00.56.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:56:28 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 3/4] add-patch: add NEEDSWORK about comparing commits
Date:   Wed,  7 Oct 2020 00:56:17 -0700
Message-Id: <44ee78450e1cfe26b47cc4343c5d445df2b96d7b.1602057332.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602057332.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com> <cover.1602057332.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two versions of add-patch has special-casing for the literal
revision "HEAD". However, we want to handle other ways of saying "HEAD"
in the same way.[0] Add a NEEDSWORK to the add-patch code that does this
so that it can be addressed later.

[0]: https://lore.kernel.org/git/xmqqsgat7ttf.fsf@gitster.c.googlers.com/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 add-patch.c               | 8 ++++++++
 git-add--interactive.perl | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index bd94bd3a7c..be4cf6e9e5 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1695,6 +1695,14 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
+		/*
+		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
+		 * compare the commit objects instead so that other ways of
+		 * saying the same thing (such as "@") are also handled
+		 * appropriately.
+		 *
+		 * This applies to the cases below too.
+		 */
 		if (!revision || !strcmp(revision, "HEAD"))
 			s.mode = &patch_mode_reset_head;
 		else
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8a72018712..e713fe3d02 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1830,6 +1830,13 @@ sub process_args {
 				$arg = shift @ARGV or die __("missing --");
 				if ($arg ne '--') {
 					$patch_mode_revision = $arg;
+
+					# NEEDSWORK: Instead of comparing to the literal "HEAD",
+					# compare the commit objects instead so that other ways of
+					# saying the same thing (such as "@") are also handled
+					# appropriately.
+					#
+					# This applies to the cases below too.
 					$patch_mode = ($arg eq 'HEAD' ?
 						       'reset_head' : 'reset_nothead');
 					$arg = shift @ARGV or die __("missing --");
-- 
2.28.0.942.g77c4c6094c

