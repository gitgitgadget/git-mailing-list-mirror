Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2161C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5E365093
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCEPWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhCEPVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:46 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E490C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:21:46 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z190so2259253qka.9
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqZE+1NU2pbwR6Xfi6vWCpphssMaMePk2IJI5dO+HRg=;
        b=pm4o4UuopSUzPnxx97/mpEj9F6tT4gqBgYveobiGuQBdUFl566kzTNUs+MRnS9vOev
         qr5CwfJaU5EOfXj8RgfyZcSagyTo7ORkuWtUB2bq6c/0pjcfQr/E4bbde8sx3OioxbJp
         DH8HIqREUa0pV9waorRklH9A2kQ+ryyVsufFeLxgDXQuuRqYRKNgaWXUcPIQbIsF8Jds
         aYJp115PEsHwu6yo1HrJl9Sz1Ei+rs0pAF3HqH5DC8bpGSGZBYswjST8X/rjsRNpsaJK
         0fBlpCYV+Ziap+gyqpnpKUaIHaAPo5fEjiMfhqUc9W4NirPkNX/g6r3W84c3gC1tzKBD
         b8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqZE+1NU2pbwR6Xfi6vWCpphssMaMePk2IJI5dO+HRg=;
        b=pg2mcm0SjzqT+AGK3hMzFCxkTKUEC4ESGWmouVl5mGk/+ValYg9IuF+homfPOY1AdM
         D2kqGPyYO1u/6RV6JmOLGqXrik3d5Vbl35YEvidbhiiaY+QDH6UQGGyZh54GobTfzb8J
         /GyKukryZUwkIMMshlk5i95jEMZgw91xrMDd2CViFZjvNwW6jC7xyOdOGamu45Cv8Xem
         G6k5F3kXNrIpSNpbwsUzv0DVw42d1KReoelxDTbhhSe7/fQoBgEXdvx98m5XpV/mHGD4
         +yk2xQfc42tRSsOeqnJb3Qr8rzstohfJBZVKsDw4jmmLBRLB3dYkW55JjclUL2zx76q5
         b/MQ==
X-Gm-Message-State: AOAM5324JFiGOYHzQhDrY3kLOT8HEpLEPodZlh0fUjYTU3hFDXgqcu04
        h8PmaZyjY28AlujnBq2En0YVNMQyF4JGcq6y
X-Google-Smtp-Source: ABdhPJxKxKIidGiHQXuNSuTZU5HeNQwfQxca8VRqBiKb4mKi88VzX7oLclwp4jRUgY6T+fRLUiGRhQ==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr9504626qkm.355.1614957705229;
        Fri, 05 Mar 2021 07:21:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id g2sm1868516qkd.124.2021.03.05.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:21:44 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:21:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 2/5] t7703: test --geometric repack with loose objects
Message-ID: <ad516e78690913843416b22d184a04fc0362a24d.1614957681.git.me@ttaylorr.com>
References: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614957681.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't currently have a test that demonstrates the non-idempotent
behavior of 'git repack --geometric' with loose objects, so add one here
to make sure we don't regress in this area.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7703-repack-geometric.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 4a1952a054..5ccaa440e0 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -54,6 +54,37 @@ test_expect_success '--geometric with an intact progression' '
 	)
 '
 
+test_expect_success '--geometric with loose objects' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# These packs already form a geometric progression.
+		test_commit_bulk --start=1 1 && # 3 objects
+		test_commit_bulk --start=2 2 && # 6 objects
+		# The loose objects are packed together, breaking the
+		# progression.
+		test_commit loose && # 3 objects
+
+		find $objdir/pack -name "*.pack" | sort >before &&
+		git repack --geometric 2 -d &&
+		find $objdir/pack -name "*.pack" | sort >after &&
+
+		comm -13 before after >new &&
+		comm -23 before after >removed &&
+
+		test_line_count = 1 new &&
+		test_must_be_empty removed &&
+
+		git repack --geometric 2 -d &&
+		find $objdir/pack -name "*.pack" | sort >after &&
+
+		# The progression (3, 3, 6) is combined into one new pack.
+		test_line_count = 1 after
+	)
+'
+
 test_expect_success '--geometric with small-pack rollup' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&
-- 
2.30.0.667.g81c0cbc6fd

