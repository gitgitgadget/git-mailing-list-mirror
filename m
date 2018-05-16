Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B791F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeEPW7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:05 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:54715 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeEPW7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:02 -0400
Received: by mail-qk0-f201.google.com with SMTP id c8-v6so2263367qkb.21
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sjTzO6dLyFs9xOE8UdF869oPr3e1GAtbcZVGuMWc1s4=;
        b=gyqgdHVOufpCUIfUQuDkr3RiFq3npcoQ9IUTY+DqbnJexpHqVd8bcDdxAQ3xZe0GxB
         mY2IALWjAT5xyoY8P5YrgXHNEVhhTlgx3CqA2bSvXfcDYeptj451NqW64QMA+fGfFJId
         f33VFweCCP7uJFSTmF6cx/stvAWRKrQGf/q6bZsu4CQIijr3dTsh78CpzMKmOzsZ9QnF
         oVJIU9Ons0YmpnF7yALnMzgegM5XQ43SJjLFXtB+a7po0wOwRCnsQVH2jinuOZVhqwuo
         PAgMGRxPEbwTQ6iAp8s7RBTOcqOQP49Gd43jcO67lmSodwZQn5s3AS7IDau9qsLoXYdY
         d7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sjTzO6dLyFs9xOE8UdF869oPr3e1GAtbcZVGuMWc1s4=;
        b=YB1QPSegIQl8abIFPuCd5iBVQbVlu7brxNQEl4W/hr5ToMZ6vcqGpLHJxSSyhr1ggm
         B1amfx6Z9i1Bh9S4guAFpWsixy2w8FmpbviywGLQWI5Aa1q+LcKU1RNcy8q+An70O+FS
         BPRXAs1N7+MZk16REFmFzGJ7r3U+m4qMrU/lc0zdCyYEpOZ8WHHSUxs9aGSriqKbg+qx
         uYyLlDmFjbHHFug0IqRe3atS3q9lF4U5FmHWqUiwbaz49Iiwt1BAyR3kTnDoBUGu7JDm
         eCdFvqBfZxTbfc+F64iglIBtl1V95HRCO9YPvThC1QYHTd3ULTZg38DgtwP/0yfy/iKg
         HIVw==
X-Gm-Message-State: ALKqPwdXSBH4vTl7L4W+9g1Xg6YZT3DeCD48Aa0WKUTjVl5lxvUtj5k+
        vBBb441OT3H57VWS9uRjKeKgoxtJRcEyB/jo0lkLUK1r9I2WQTu49+tpZXwh2D3t/eDr06g+NCY
        yXVsyc0U8+6yEf2OS0FbIaGw5GcIq8i1vU7D2JAQTMgkhSL+1McRxKx19bA==
X-Google-Smtp-Source: AB8JxZqgoreCBMoKjxpjejKynZaEJAzfNs1soBYFXsKQYjSx8TSCVF0Vk8WkyzZsnaAGMLs/loHa7LTCWhc=
MIME-Version: 1.0
X-Received: by 2002:a0c:88c1:: with SMTP id 1-v6mr2921173qvo.29.1526511542153;
 Wed, 16 May 2018 15:59:02 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:57 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-11-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 10/36] remote: convert match_push_refs to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'match_push_refs()' to use struct refspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 191855118..bce6e7ce4 100644
--- a/remote.c
+++ b/remote.c
@@ -1312,7 +1312,7 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 int match_push_refs(struct ref *src, struct ref **dst,
 		    int nr_refspec, const char **refspec, int flags)
 {
-	struct refspec_item *rs;
+	struct refspec rs = REFSPEC_INIT_PUSH;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int send_prune = flags & MATCH_REFS_PRUNE;
@@ -1325,8 +1325,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		nr_refspec = 1;
 		refspec = default_refspec;
 	}
-	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
+	refspec_appendn(&rs, refspec, nr_refspec);
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs.items, rs.nr);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
@@ -1335,7 +1335,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1384,7 +1384,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(rs.items, rs.nr, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
@@ -1396,6 +1396,9 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		}
 		string_list_clear(&src_ref_index, 0);
 	}
+
+	refspec_clear(&rs);
+
 	if (errs)
 		return -1;
 	return 0;
-- 
2.17.0.441.gb46fe60e1d-goog

