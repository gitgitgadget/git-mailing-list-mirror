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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1712EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBE564E7E
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhBKKtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 05:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBKKqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 05:46:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88BC061797
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m1so5245680wml.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZi+bpYvYc4vCCvCSITEs+55jN+gkgahoKNlYmqS9kE=;
        b=uDsUWnJ4biRtBIBixNqxiecO9mYpRQJUJauqB13d391vlt0PLmMocDM1XrzjHWzCuH
         hlG9IVH8BbUopRkmvN19lWjIXQrEoE9HmCyWsTW6S2fsWSpGBULgvHOPnGSvJt5Gf6C9
         6ZvcQCO9as3YJg9HClFmioKOYSpkyNPoBay+G9+weyRFxEYbUD01Y/5DSp6qtqsrRqw3
         ZVIh8dLZKwBIgdi3Y1pUlHhIsW9omBieMdST3i/2T/uOfTPnnw2ZPjrdiIgxynWGE8j5
         KhafVnHT4RXgXStC6Zr6ojM1jkcR5+PekLJryKf425oyvJQ+wrwp9oHq7ZoC8ON4Qqbu
         r5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZi+bpYvYc4vCCvCSITEs+55jN+gkgahoKNlYmqS9kE=;
        b=ABPq8vdAxbsrN4vG38YiecGCdfMMFTrXIc9MyyEEyu0c/b8dXaK/Rd3et/0Kh+/w8w
         4RWVVFz/NRVS1XIjdb3nEbVSvO2h58G4HTNLSz4fej5ixerXciyiRBZ5beVL6ZHnXtUP
         ww0wdRt8vpM8DxNjldG9Iijw3pDYpicmlbqU92/Weo/s98CCT+AD/aenG3wq/240KjsJ
         eyT9BND3/vUvf728TuFbY52HZvH8ZgRhK8Plwy0uNYhyPUtTHvIuMv2EI27jIJ4qlqtO
         TvUwEIKifn1wmRP9FSMx1Tq24FrYVMGm3Q86JuNGnkui5AODj3Ki7b/lYLccedgUV+dk
         RYhA==
X-Gm-Message-State: AOAM531yHL62Rnee/umGT40ndBIKQm+1pUTL2xeK5mCvWDkLfI9eB5O2
        yhhS9szzQZtTBzWvB+hdPDZbdx7SWt8djA==
X-Google-Smtp-Source: ABdhPJxBRNW9N1Os2QEJVz48c20h8yr3/u/z6Phh7sHnP7/FxRaJ/XBdDSYEu+rfpMnyMSF1bBnltw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr4574464wmg.154.1613040340453;
        Thu, 11 Feb 2021 02:45:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s11sm164767wra.82.2021.02.11.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 02:45:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] diff: plug memory leak from regcomp() on {log,diff} -I
Date:   Thu, 11 Feb 2021 11:45:35 +0100
Message-Id: <20210211104535.16076-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
References: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in 296d4a94e7 (diff: add -I<regex> that ignores
matching changes, 2020-10-20) by freeing the memory it allocates in
the newly introduced diff_free(). See the previous commit for details
on that.

This memory leak was intentionally introduced in 296d4a94e7, see the
discussion on a previous iteration of it in
https://lore.kernel.org/git/xmqqeelycajx.fsf@gitster.c.googlers.com/

At that time freeing the memory was somewhat tedious, but since it
isn't anymore with the newly introduced diff_free() let's use it.

Let's retain the pattern for diff_free_file() and add a
diff_free_ignore_regex(), even though (unlike "diff_free_file") we
don't need to call it elsewhere. I think this'll make for more
readable code than gradually accumulating a giant diff_free()
function, sharing "int i" across unrelated code etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/diff.c b/diff.c
index a63c9ecae79..bf2cbf15e77 100644
--- a/diff.c
+++ b/diff.c
@@ -6342,12 +6342,24 @@ static void diff_free_file(struct diff_options *options)
 		fclose(options->file);
 }
 
+static void diff_free_ignore_regex(struct diff_options *options)
+{
+	int i;
+
+	for (i = 0; i < options->ignore_regex_nr; i++) {
+		regfree(options->ignore_regex[i]);
+		free(options->ignore_regex[i]);
+	}
+	free(options->ignore_regex);
+}
+
 void diff_free(struct diff_options *options)
 {
 	if (options->no_free)
 		return;
 
 	diff_free_file(options);
+	diff_free_ignore_regex(options);
 }
 
 void diff_flush(struct diff_options *options)
-- 
2.30.0.284.gd98b1dd5eaa7

