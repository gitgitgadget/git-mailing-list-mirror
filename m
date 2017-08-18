Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0527220899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbdHRB7v (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:59:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35213 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753895AbdHRB7p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 21:59:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id w199so5386019lff.2
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 18:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=M+B+IDXEu9vpJ+6KtyeelBTohNFX4RGTL+7LaaR2NV8=;
        b=knlCeq2XImcTRRiExfhy6ic+coyWxDq2pTMBxIJTp8HCxMQyyBnj6FwKDdorbDzgAz
         CTEF6YDGL1XIUmwlWEVN9SPjyla0Ij0TJGbxkW+5ErDbhT8a/xHbAZX3Ea6pftJclBYL
         5EkDPZGdEIcLZzbcR0n4cOI0k58/zKQwwjvUXLWnNlPrbO58ZxGMDDNoIQBV8LID33Vd
         Lk+fC8OHXz6jeQd30kl1UYn0qKhvTUjcMLgQCGDv32pXrsvh2xnU5ue8nuBMiHNYCN9R
         c0XR0YfBKAxz4OHUzObOcmrRiVTlLz8aPMMtupKJYOrZLxthFsM2HBHkZThNd4VAv/q1
         d2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=M+B+IDXEu9vpJ+6KtyeelBTohNFX4RGTL+7LaaR2NV8=;
        b=jGsYvL8ObgtCZfHlsOFZ80PyRjz68dN/k/V+zTRgQbe8+t/LckzrVK4Bg3xi8Ae9FM
         /CI+x+fwcPL+D8PyJ0dDtiRPUPPWXhFxq2vwOY/zfjrBdbmltcBpNDfodQaWSxneu8+l
         8Mf+ZLDDCDvwmR/y3P//o+U9tBWWyQ0TgyPF8s2k21Ep5YO6aIny8xPpmV2srqbfWyjl
         42LQTrGGCfdKxSWYLs1VTCDjxgvJK/aPjkOJH3Fh/5fFdwdpnsmphlWbMKTRPZij+T16
         88anZJ03dq1XCsrovNpB4z+0rJTZGGeUBzwl+LE98dQpc58amyD88zOIqsY+I1ZRtqY1
         vDcw==
X-Gm-Message-State: AHYfb5hdTYCsF82fM3mRWaCN98qWL/TW0AhwvurGpjvpBfb6EXojxOLT
        LxGSqgb3KcE0WuCVqh8=
X-Received: by 10.25.163.9 with SMTP id m9mr2543936lfe.77.1503021584530;
        Thu, 17 Aug 2017 18:59:44 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c23sm363156lfh.79.2017.08.17.18.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 18:59:43 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] commit: allocate array using object_id size
Date:   Fri, 18 Aug 2017 03:59:37 +0200
Message-Id: <26cb2ccae6c5b66e55dc3868e47b2f1473acae07.1503020338.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
 <cover.1503020338.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct commit_graft aggregates an array of object_id's, which have
size >= GIT_MAX_RAWSZ bytes. This change prevents memory allocation
error when size of object_id is larger than GIT_SHA1_RAWSZ.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 019e733..61528a5 100644
--- a/commit.c
+++ b/commit.c
@@ -149,7 +149,8 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 	if ((len + 1) % entry_size)
 		goto bad_graft_data;
 	i = (len + 1) / entry_size - 1;
-	graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
+	graft = xmalloc(st_add(sizeof(*graft),
+	                       st_mult(sizeof(struct object_id), i)));
 	graft->nr_parent = i;
 	if (get_oid_hex(buf, &graft->oid))
 		goto bad_graft_data;
-- 
2.9.5

