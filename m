Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64450C43381
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 492BC23442
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbhANCGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbhAMWZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:25:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1DC0617A9
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:36 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 19so4433913qkm.8
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CpNdxqZGfiO4jb4DgI/7fB5wIx6DjqDt1SGCXFIuBIk=;
        b=toYqjJ4ETox707agmQhYEiNFCoQ2oeLw75uWLX6OeeEeZwcwHSi3SkJlNuRa8HAJkp
         w4fIRWWls2etuhDWxhQ31v3ry6T4qdBYQAt8b+oJb8VSNQYBNGQ0hQPams65u1VHbAIx
         +aunNYi7kKCLtg+z1Pw4v8xAdNZCS254+RquC8Z3ckRRJgx373Y6liMvK6lxm7Rpqn1+
         SBrjtynV0m43+4KbyLc5RS+ItH4wJ2TeS3hwG6ziO+RCyjWhTPLBfnU41WHPdwWzSZQW
         3j2Ouk8WmPZJWcWij2DsHgJrxfWGZ/1xn8Uqx+HfOpamYKmb7qttAGsQrbCGGVgrWvn5
         lbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CpNdxqZGfiO4jb4DgI/7fB5wIx6DjqDt1SGCXFIuBIk=;
        b=kP04XsUBZ4YIgPe5A+j3e6eMGWXKuRfEO43Qg4t150SctG65wqtsKDiKgKDU5XY3yg
         W35NsUBtEqg12j96tRtpOQqcTv4F3FiaLbrvR/cRoQrazE0wPnlM9Kc+TLfwerKfRP2+
         TZGMnTJJkaWz0UJoKWrtM34wH+Rzh5SNcGVccM1t14fwLc7u4GYVu+lrJiQUOV21rMIk
         hdosOr//CSvLiuEY/cXtsd+r6+DD8AutkgvWmiDRFbTwZ7vFFx5w/XIcEa7KviVEsCB3
         WKpiezdK5lLFYKkc08gYq+xJzizzYZmYHUKWRe+LmqKvCixl2dRI41qjzYW6pcPCSCLk
         d9cw==
X-Gm-Message-State: AOAM5308y/9e8m89mf6Iy+U25W1vR0sLhOsvDNK3rVld8YCKggnW9oHQ
        HL8/2p6mZKyXu3I8WH1xQBYScLdBWJQOdg==
X-Google-Smtp-Source: ABdhPJxh171rad7o8EQwZZx7wW3xPEbWf18/OQpEl0OUL8nZPZxkZuDc+3A13pJQT4aZ2m5aFAS/Qw==
X-Received: by 2002:a37:a707:: with SMTP id q7mr4479699qke.284.1610576675010;
        Wed, 13 Jan 2021 14:24:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id m41sm1918766qtc.28.2021.01.13.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:24:34 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 11/20] get_delta_base_oid(): convert to new revindex API
Message-ID: <98816377248b3112975d49d89a4af7c29d12554e.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace direct accesses to the 'struct revindex' type with a call to
'pack_pos_to_index()'.

Likewise drop the old-style 'find_pack_revindex()' with its replacement
'offset_to_pack_pos()' (while continuing to perform the same error
checking).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 86f5c8dbf6..3e3f391949 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1235,18 +1235,18 @@ static int get_delta_base_oid(struct packed_git *p,
 		oidread(oid, base);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
-		struct revindex_entry *revidx;
+		uint32_t base_pos;
 		off_t base_offset = get_delta_base(p, w_curs, &curpos,
 						   type, delta_obj_offset);
 
 		if (!base_offset)
 			return -1;
 
-		revidx = find_pack_revindex(p, base_offset);
-		if (!revidx)
+		if (offset_to_pack_pos(p, base_offset, &base_pos) < 0)
 			return -1;
 
-		return nth_packed_object_id(oid, p, revidx->nr);
+		return nth_packed_object_id(oid, p,
+					    pack_pos_to_index(p, base_pos));
 	} else
 		return -1;
 }
-- 
2.30.0.138.g6d7191ea01

