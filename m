Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4A71F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfDXPOz (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34045 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfDXPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so1441412qtq.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kq1FZu/0A6AKTssjPN3Fdz3QYTxlpCaOsGQ6vC7y6Y8=;
        b=j1Z6vrJsAe7E/xki63M+S8MW7CmY0GswfXilbpcEUJfTyeKpBhL4WVCHdIwtjxklGL
         ukTA05jPYab6nTcOtpOkaqtxMrSq3diDoQJRRYqBCE1KZEDREAnhYHQ52CNlDaIcBYQ2
         O7LiTUpUmVMfmI70g8wyuzjaEEVW/vbDdQsazUHztQkI3nj1ZcuybjAmnjhgsOpzdj2l
         +QocIX3h3IZVUNcTPgAswDn40R7RoVKWAXKk75NRDDkc9VXr1LW4KsJWAU4n7d2XRWCD
         tiDYB3D17ktLrPZn5Cli+rwG3RbXC3xPhAvcrQapu5g10ziqh0OoO9efa87WgmGG3BI4
         gcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kq1FZu/0A6AKTssjPN3Fdz3QYTxlpCaOsGQ6vC7y6Y8=;
        b=FKSgXvJcBt7sGCabxdwBYIk7Z9dlfGsKjsVJkcG/dUjW1RoHSmTjfVnHig8bnoxLWX
         Y0zeo+mV+ebEmvIpu9CJyIyR/IQ2O/cMF3A2kx7RwWPeRUHlxPqiY7iHALFzxqM0FRhO
         OBSB5foYOsQS3MP7dg0I41f6f7j12NyKlbvu7pPY7MnpXbJA4kZLQa8YwbAymfZj2/Ie
         w2wcHxc55I9lFY6cqgFlk5UyiMVWaLXkjLxgdsW6nqANxHpm4EziFNm/Bc3IMZaY3cTt
         MWq/gKG04jzmgF6XsXo6WWpX4Eg/ge3QwEsnbyz5Gs9dkvkA9z+fDwggE3ab2KXvlayK
         X8Nw==
X-Gm-Message-State: APjAAAX8ge3k41tobR6SjBjnxhaucDCUxNGaYhNgglPEZoH0MM7mXFfw
        XbsGFD+0e7h5djKfZqcXToE48RxA
X-Google-Smtp-Source: APXvYqy+UkQM2t1lqVaK55pqf4s62HmRz8tEFuhmom3FvcioYevclD2X7SJI/1FMm+xefx44DMrXDQ==
X-Received: by 2002:a0c:c491:: with SMTP id u17mr6484688qvi.70.1556118893308;
        Wed, 24 Apr 2019 08:14:53 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:52 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 09/11] multi-pack-index: test expire while adding packs
Date:   Wed, 24 Apr 2019 11:14:26 -0400
Message-Id: <20190424151428.170316-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During development of the multi-pack-index expire subcommand, a
version went out that improperly computed the pack order if a new
pack was introduced while other packs were being removed. Part of
the subtlety of the bug involved the new pack being placed before
other packs that already existed in the multi-pack-index.

Add a test to t5319-multi-pack-index.sh that catches this issue.
The test adds new packs that cause another pack to be expired, and
creates new packs that are lexicographically sorted before and
after the existing packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d6c1353514..19b769eea0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -463,4 +463,36 @@ test_expect_success 'expire removes repacked packs' '
 	)
 '
 
+test_expect_success 'expire works when adding new packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/a-pack <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/z-pack <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index expire &&
+		ls .git/objects/pack/ | grep idx >expect &&
+		test-tool read-midx .git/objects | grep idx >actual &&
+		test_cmp expect actual &&
+		git multi-pack-index verify
+	)
+'
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

