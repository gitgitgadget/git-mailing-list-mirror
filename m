Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16046C43217
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38EF2360D
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbhANCFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbhAMW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:27:01 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1BCC0617BE
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:10 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id h1so1543504qvy.12
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1BnFTlplhhpGCXeXRc1kNQSrwdBZw4WL4WJUUVbtRd8=;
        b=sMZvlp94ilZZcH/niq4bnV0Nlq4v2lm+lAcCqkEz4MtcJ6scEvBIkB/9AzjzS+IfF5
         LrGOQyf9mmBN7/OU/hXtdk9QRy32BBGcp/ZXy1cpj4GG5KFrondK955N6GZtk5jlXOZa
         /XnNP1bx6qS1XdxExvFfQkBDf7wxzKnoyhv/K/1QXaXX8a7ewtjklgrmL4VdTscBWfDd
         jOVcPXwiv0RuvVVT7KpNBPhNXwOpI5uE1hCbFxBaMLaHYE9I4+RvBOTh3r60R+/DIjDT
         yetHBhr/iAkp/D6ukD8G3qtwpsF2Eu1wc3R21Pck2Es0Gql9hqyAoWCJQ4leiy/FPEDE
         Y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1BnFTlplhhpGCXeXRc1kNQSrwdBZw4WL4WJUUVbtRd8=;
        b=Ive1D5K+UuXsKVQgBW+E9rkot8ey95+Kv4wqKscus6G7kASEl7PO9UGpmrv4ClMpQs
         3hZpSHMXBXUzUeeJpbWOmNQymcUAYL609OaviG9VP6p1IQ9K7GuSqKLqC4ZbqS+vpuL8
         wCQ0TRg9w2OmyfNhtHUtTmm6CqXcBHNkcBAAW8sAIF+oRRX40qzFu3G6ZYwHu94Ctv22
         +jPOhtxqa1NuR0Crt2BWchPG6lRvKhV2NuE+EfPYYKu6KZPhvpKXwK33gNGk7BSLwT/e
         6E/dosizV6pC0cu+GOMjfnhsD4XTpRKlcH8bnwA9NoGcIzowtmtLtVxe1OsInVPrOapL
         k4Ww==
X-Gm-Message-State: AOAM533jJV4/wFxIrKgO9/DaXdx5LW77cnf3l0MNZ9JnFlHR31tikIlI
        ZcJxu6kuvPpRQzHLI97gVfaYy/umbPfTrw==
X-Google-Smtp-Source: ABdhPJwRdy7dHTypjI9oqBL3Z/ck/MqDATE6RKnlwYmhwr1hqZCNfPqHblIqQ3eE4NlbnkRlGRUNfA==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr4591945qvs.62.1610576709162;
        Wed, 13 Jan 2021 14:25:09 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id k7sm1830808qtg.65.2021.01.13.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:25:08 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:25:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 19/20] pack-revindex: hide the definition of
 'revindex_entry'
Message-ID: <cabafce4a105d4a09e561c05a0a4e14581e0e04f.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that all spots outside of pack-revindex.c that reference 'struct
revindex_entry' directly have been removed, it is safe to hide the
implementation by moving it from pack-revindex.h to pack-revindex.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 5 +++++
 pack-revindex.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 282fe92640..a508d5f0a4 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -3,6 +3,11 @@
 #include "object-store.h"
 #include "packfile.h"
 
+struct revindex_entry {
+	off_t offset;
+	unsigned int nr;
+};
+
 /*
  * Pack index for existing packs give us easy access to the offsets into
  * corresponding pack file where each object's data starts, but the entries
diff --git a/pack-revindex.h b/pack-revindex.h
index 746776be7f..6e0320b08b 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -18,11 +18,6 @@
 
 struct packed_git;
 
-struct revindex_entry {
-	off_t offset;
-	unsigned int nr;
-};
-
 /*
  * load_pack_revindex populates the revindex's internal data-structures for the
  * given pack, returning zero on success and a negative value otherwise.
-- 
2.30.0.138.g6d7191ea01

