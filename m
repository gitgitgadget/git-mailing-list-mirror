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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D61C4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE086054E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhHZOGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbhHZOGp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:06:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38A0C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so5277085wrr.6
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tzrIxU5v6V3L1HK6JGmMguPaPGPiU/TLevxFGLgGko=;
        b=Qs+w0WVcIsBjvAg7pbuzJizeE84Fpg280IHtTQgplf+rZIOvHSYmruOuO3C8o7ZuP9
         +1DYRuI3P3dUco72YdG1w8yBZF1bfcUNrDnV+wLQoBDcl9tSOC5NU8E6cF3WZbQmoi0i
         JlSxh09bkCMB2YlCAE7fDMu7HcbTlCJ1NGXpxasHF2q8D5xW84YUtWh212d+/5YipKin
         9bXAUnLZP7A9oxqMRG3VjT9M12WsU5vrSmyPv6mt+jPvIAASY9SI83czejQzvesSDRsv
         RqNEeSH0MDgir8mKjUnbI40oPAkHHHYuVbDh6TkADuNufXJbaQ4AV+EY7LPCdflTeuvC
         rMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tzrIxU5v6V3L1HK6JGmMguPaPGPiU/TLevxFGLgGko=;
        b=hsVgDKAt2U5k5VLOucwVg0dRxW80ZnNxL6aLyp14/+724JVZ7vEpE6z22KVj8d9znZ
         zAc+Vp6uJJ8JPCSiaWQLKoBAgQ56V7VNvxOEMfFoud8PMXq6+PezG67FMpYWTo9uQPak
         fGvS9ptyy/r/olnGxxgWYtZYCRZVKb6Pv+p22CXI2dzPBwtRkAA0U5UcE2TQxW5qaajJ
         e5Xi2oOvnk1TswdAY+7XXOzMcuqOVxO3m7osAZTTXRa9VIMa32X+AplrSuPOgvWOBpJY
         3pyXs6m2rOvG7WlToHHW3rvdFPp9Y41j2JRkoikB05RXIlhDvNtSj0fUcVugf0mOptbH
         UrBQ==
X-Gm-Message-State: AOAM5304PJmxrQuoIgTNTBokr4FakDucJUk0QdXHisjswmGcAyOuvSqq
        aPe2Jip4RfPIWbnKL09msUxD8thh87ygSQ==
X-Google-Smtp-Source: ABdhPJx9gPfFq1D4RX8wySn1G4RleC21256yZcyj3a8e/16kH+SxEoswS8wFu9e/Gi87AK7zdVD1YA==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr4180354wrq.212.1629986756048;
        Thu, 26 Aug 2021 07:05:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm2471987wms.33.2021.08.26.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 07:05:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] bundle API: start writing API documentation
Date:   Thu, 26 Aug 2021 16:05:47 +0200
Message-Id: <patch-v3-1.5-9fb2f7a3a80-20210826T140414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
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
2.33.0.733.ga72a4f1c2e1

