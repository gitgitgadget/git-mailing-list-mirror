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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB1C433FE
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7426A60F6D
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhIEHf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhIEHfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:35:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DFC061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:34:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u9so4849207wrg.8
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvkwsKr5XleAviAlzlYPQOvJ2WjasiiWFItF3dgOLAI=;
        b=V57IF4YYuv9bcF9AzS+cppMqQfvNNNBt/OwYJcyplXf1rYJdYOdONQ6kkFzGa2Xmv9
         gWPUECVTnN5N2Y2FcoDCB2u8KJsFnilirpLZz17VL7cU48doVwmJ/gXLsfeArrwF4I7t
         j3Lls6j2Ma66JJIdJdZMLsvENBFQcWBWStvGyHVns762ZHtXY0QS13+GDS98L5h0QzQ/
         6XPXiTZLPrTiMBrZYQI4f/h/EmnUIE3tRovrFrJEX1z+QHYlropjvhWrVUs/0tyUfZgZ
         DBLVIqGx6oTka2WT2u0CfMmWNC1VFzk6/wvpBVibqwj8qPnftBN8hgX1SFwMIWjtx+Uf
         j9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvkwsKr5XleAviAlzlYPQOvJ2WjasiiWFItF3dgOLAI=;
        b=aWibpy0+OaquNiOO1k6zTgYBLLh8Wb75V4hVgubKXBOMLB76JW3kmZWt5NC1zoTthu
         lO1ckM4c8KeqBMN3zL2OsQNPSOeh1uWdXHVNUO/gA/VPa1I3/aE5NlnzMO7JpUhXIGYQ
         SBOBLhTAYUv/mSYv33tIZfg5H+Lnz3cMWzL8KCItuYS6yGYeeMJjF+rAn+SNzYaR0Dk8
         mhy+f5D0FmNeKNKdQuh33dn8VhcCEOLErmGbJF3WNCTm94HcBKSphFNFMsVoDCTbZ5+/
         /FI2YnaPKE76i6Q/m3M9zavDo9p8vzcokhyZzFpYe8/DKDEQSVGLgJH9VSBf9h47rjEa
         23EA==
X-Gm-Message-State: AOAM533NJDOC78f2cD7EMVERLHYVotKYfDNRDNObl9t7N4FEHv0JL05x
        7gW6QvzFYxauRouJvMqQKmZdYx0RWklbKA==
X-Google-Smtp-Source: ABdhPJy+o2W5HwiRlMk3WRN5XZAF2PL7IJAn6BVACZ8bZfyYt1I4DXVXTe3YHF5cWeIUJ5klbtCLwg==
X-Received: by 2002:adf:90cc:: with SMTP id i70mr7140110wri.408.1630827290185;
        Sun, 05 Sep 2021 00:34:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm4218734wrc.31.2021.09.05.00.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:34:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] bundle API: start writing API documentation
Date:   Sun,  5 Sep 2021 09:34:42 +0200
Message-Id: <patch-v4-1.4-05be8cb0fc3-20210905T072750Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.813.g41c39388776
In-Reply-To: <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210905T072750Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no other API docs in bundle.h, but this is at least a
start. We'll add a parameter to this function in a subsequent commit,
but let's start by documenting it.

The "/**" comment (as opposed to "/*") signifies the start of API
documentation. See [1] and bdfdaa4978d (strbuf.h: integrate
api-strbuf.txt documentation, 2015-01-16) and 6afbbdda333 (strbuf.h:
unify documentation comments beginnings, 2015-01-16) for a discussion
of that convention.

1. https://lore.kernel.org/git/874kbeecfu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bundle.h b/bundle.h
index 1927d8cd6a4..84a6df1b65d 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,6 +27,13 @@ int create_bundle(struct repository *r, const char *path,
 		  int version);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
+
+/**
+ * Unbundle after reading the header with read_bundle_header().
+ *
+ * We'll invoke "git index-pack --stdin --fix-thin" for you on the
+ * provided `bundle_fd` from read_bundle_header().
+ */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
-- 
2.33.0.813.g41c39388776

