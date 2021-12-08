Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F63DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhLHT35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbhLHT34 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:29:56 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC31C061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:26:24 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w1so3149244ilh.9
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=45b5OZ28kxa8EzBI/PjSHej87R7QMtWpBXzkBsBfmFqR6MauWbmdxadV7wGQ2dIvT+
         XdmO1q8MJyOpJd1qZ0LyX9VFYi/q3y/UKd8iesfWsFEh+iHxJDx/yGczW1R5fdITCCoE
         i9iAzZbvBqP2JuyUAYgeKc1BzmBX8dxhVTIZpaGztgwlyLh0fhKO1GTUssxgeWDXgZBx
         bfv24PA2SS/Ba1gN2a/g/yQ6qCTGoewy/bwJOJZDGODhTE3nTZrDJx2ulKLiT7Ywjp2t
         Ixg2ognSVyaRrUwwrFvu163wnl+CYg3LUs7sz6jslo3YfcQIpZN3mnC7If8r+MIpMCCD
         7+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=qmC6gMNR94GGclN2cwI43IQKslHu5ZKcYvnTOEnfIWGGlQcrrfTqklzS9ahIDM8QHI
         EX6O3f6tyCMWIIfJfr5UDzA6Qflk6RmJqfYqPF5RJ797iUIgqrlGyRXocj5+WJjlbgqF
         QJ2ip5TJgBQF5hfxhy96mPVEPFnAqUx3DxqeAy/7XD19fHd1EyEgnS6jRn0Qc328ZVIj
         AqC0ElvZ45Bkq0RWTKecmGB37KcFjtH3znhistF2PaR1aSMxZuV9na4B3fJWWZ4AX1F9
         npNIjcN/zzv4aj3Nnu7TSyIAxzjHxPsu2eLMHcNh9gtLuz+ebq1VlEIz3UyOQ/FaTj3j
         M0Zw==
X-Gm-Message-State: AOAM533J7p9cT4bWKLrxis/ZfBRpUqFagy8mpJIWnwBrrHFOzmVRteCn
        Wxak1hYeb2k9BC/mLRGwjkyfpBwcKejgZKl6
X-Google-Smtp-Source: ABdhPJwU29qJEFM0/fJ++TEHUSlJ1UNPKWqe/H+RRazZZjIhctkgusCsKppReV3vfmKlZUzy1V0F5A==
X-Received: by 2002:a05:6e02:1a63:: with SMTP id w3mr8071618ilv.230.1638991583647;
        Wed, 08 Dec 2021 11:26:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i1sm3137952iov.10.2021.12.08.11.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:26:23 -0800 (PST)
Date:   Wed, 8 Dec 2021 14:26:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH 1/2] t5326: demonstrate bitmap corruption after permutation
Message-ID: <ea91cebb6bfe43435820ea1ffd54271cf1d920f5.1638991570.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch demonstrates a cause of bitmap corruption that can occur when
the contents of the multi-pack index does not change, but the underlying
object order does.

In this example, we have a MIDX containing two packs, each with a
distinct set of objects (pack A corresponds to the tree, blob, and
commit from the first patch, and pack B corresponds to the second
patch).

First, a MIDX is written where the 'A' pack is preferred. As expected,
the bitmaps generated there are in-tact. But then, we generate an
identical MIDX with a different object order: this time preferring pack
'B'.

Due to a bug which will be explained and fixed in the following commit,
the MIDX is updated, but the .rev file is not, causing the .bitmap file
to be read incorrectly. Specifically, the .bitmap file will contain
correct data, but the auxiliary object order in the .rev file is stale,
causing readers to get confused by reading the new bitmaps using the old
object order.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index e187f90f29..0ca2868b0b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -395,4 +395,35 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
 	)
 '
 
+test_expect_failure 'changing the preferred pack does not corrupt bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+
+		git rev-list --objects --no-object-names HEAD^ >A.objects &&
+		git rev-list --objects --no-object-names HEAD^.. >B.objects &&
+
+		A=$(git pack-objects $objdir/pack/pack <A.objects) &&
+		B=$(git pack-objects $objdir/pack/pack <B.objects) &&
+
+		cat >indexes <<-EOF &&
+		pack-$A.idx
+		pack-$B.idx
+		EOF
+
+		git multi-pack-index write --bitmap --stdin-packs \
+			--preferred-pack=pack-$A.pack <indexes &&
+		git rev-list --test-bitmap A &&
+
+		git multi-pack-index write --bitmap --stdin-packs \
+			--preferred-pack=pack-$B.pack <indexes &&
+		git rev-list --test-bitmap A
+	)
+'
+
 test_done
-- 
2.34.1.25.gb3157a20e6

