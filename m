Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF5C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C1E2084C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/foLPxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKKM2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKKM2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:34 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC9C0617A7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so2315557wrc.11
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkBYrD8bcxEnHBhLHEAXw4mp/SsWUlfPpyOGpP9cIBM=;
        b=d/foLPxcCNwbrAwuZwF39jOy/IPCSpiJ1MFxZQeUtRkEkEaaLwJfH81wImlrDAe5QS
         2GcQ/z7mcgRIvCrPQoFoz006jRKUGlgq1Oe0oLU/nXAeqodE9Vl4ROBaXlZjBNp3vgRg
         27f/wcXEdCENqDVL4l98/kvZun0P703hMh7SL8hrjo9rKXfECBUk3WaYNEcs0O1/u0cw
         syAX7bdsfNb4KR+/ths6UDkl0H9lbc4THtF/6n4gfQyponY4lQcUwyBUcJ/yQYFEHMDi
         QWAwzSyoYZqS7U4Pme2c5OBvtfJj6Ou1zXGhplPzcwFufPoplgxUsB1GwTeXJeCg648A
         qCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkBYrD8bcxEnHBhLHEAXw4mp/SsWUlfPpyOGpP9cIBM=;
        b=BurIQ1A88rKDrP4Ks8WwbLr5SRvVQOYkniSP8GxkToBpRdhDBDlmwKNrVHmARfaQ4r
         SW3y8HRUQrcpbn2HgJW1kZGkxElcBAhDmEa7mx6PM0Xe5PIEGj1U4SBbyrUDyX2O65MG
         N4U9fh1/Za79icMYdkgiBhO0KbT2EE0+niZcfHT9weNdI2iqWcmy23XAv3irkt5s/4ae
         03TsBRBSOJivQgoHkJ0HKbWUFVK2vmpmkLnAr78uGBHDB2VrAIZOwHp+fv4xCf74+gY3
         4OqwclZ/WVUtGi8UxP+dclrG7Kcfr4nBomxQRiLXS6KGeTcp3PVfpzpHhDSIy03n3HB5
         u51A==
X-Gm-Message-State: AOAM5337XKBQNnVFYnIYeyXzU5TQY/fg+OfPzgyVDunAgg5giQMxw7Ii
        SBoTxyV1TZ31KQEVU75H3u8n856vxHo=
X-Google-Smtp-Source: ABdhPJw1FC6hu/3SWyio8ByVs+gbFW+NcJr/sn7rsHtlgmuKweopn68BRWSfUWWIf26cIZxu4Tc4OA==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr2499402wrt.372.1605097712619;
        Wed, 11 Nov 2020 04:28:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm2536969wrg.95.2020.11.11.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:32 -0800 (PST)
Message-Id: <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
        <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:22 +0000
Subject: [PATCH v2 09/11] add -i (Perl version): include indentation in the
 colored header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The header is formatted by padding each column heading with spaces up to
the length of 12 characters. These padding spaces are naturally included
when coloring the entire header.

However, the preceding five spaces indentation for non-flat lists were
_not_ included in the Perl version, but _were_ included in the built-in
version. Let's adjust the former to align with the latter's behavior.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-add--interactive.perl | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e713fe3d02..adbac2bc6d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -483,10 +483,8 @@ sub list_and_choose {
 		my $last_lf = 0;
 
 		if ($opts->{HEADER}) {
-			if (!$opts->{LIST_FLAT}) {
-				print "     ";
-			}
-			print colored $header_color, "$opts->{HEADER}\n";
+			my $indent = $opts->{LIST_FLAT} ? "" : "     ";
+			print colored $header_color, "$indent$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
-- 
gitgitgadget

