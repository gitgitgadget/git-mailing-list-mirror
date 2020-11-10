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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFF1C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9963220809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn98k/Zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgKJXmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732493AbgKJXm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE4C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so143824wmd.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xkBYrD8bcxEnHBhLHEAXw4mp/SsWUlfPpyOGpP9cIBM=;
        b=pn98k/ZxpeunF2WRkW2AFqYBRVQ7He2gAWi3Uvx7lJV9o/wP7dB313i9U+py/hCuSB
         WM9bxXFbUnQhcU4AAG6Y48aa21L28ih4e6DB0F0BtZBuSyaBwFliyeJylhOZ18mTK+xa
         4r/BB1dfsqICRFPmCE3K2qlFa8aN/q20ubuYBM4SCOzvi+xdY6Bl56fqhsPVN3hmDmT7
         R/W8v4u7p/01LZJOdtn6vHHbdCVyD5/tu4HaEKR+xmzzDoK01GrWZCsOeJHG0Fwi5gqC
         95K3BHHmepw3dyrasfwmMc4Ag3L4TZET3BRkkTO5yK66TJyUURBAaE0FDc8scoQhRlxh
         gbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xkBYrD8bcxEnHBhLHEAXw4mp/SsWUlfPpyOGpP9cIBM=;
        b=fWyeo35akiRBNyBNNJGY2lI0KdYsPXbaQeJh6WOLbUAapBHjb44UdIbwUEwMUCkUpb
         RsmGdjvK+RfYm1xGvtkxWSIk9fzugx6MbmPOzz/lKRp+r5O9kvmbI9fwy6E0+kbmob+F
         aYUHPdhCGSwHlv94EifiRgyymbjI29Lf/uF4lGljo9H6hyOtSbxKVJrXLxAXOMVpflJr
         zm5w62JuOY4Rq7heoOyEehjphdByHLXCxEJAv7E0QzsVl8ABs1sIAKatTtvfzWThyR2O
         FvLxzNk0XQs8mxm7RO2FN5rHbyUGxvS8Xj+/C3pdiaJSk9Ge6VB8Q5S0gZaOJKhA4cxd
         aSEg==
X-Gm-Message-State: AOAM530C/ozbwrH2oUTFDmybbMCojgAz46Q1tOduSP3ULP8ld008ikJm
        XrZiO9pwwPV+WV7jhXkEDbsuRJDoHFw=
X-Google-Smtp-Source: ABdhPJx3Y0w0KEZjAsNZl9Jcj6M+VMilB2eJpLSOGkPowdwRkhj1SsQS60WLETOI2PHHHEa1rybwUg==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr583152wmb.122.1605051746740;
        Tue, 10 Nov 2020 15:42:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm296452wrn.33.2020.11.10.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:26 -0800 (PST)
Message-Id: <42113e20dd7f2a80bbe09c01f1aedfcdfdbf6ae2.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:18 +0000
Subject: [PATCH 8/9] add -i (Perl version): include indentation in the colored
 header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

