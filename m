Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061ECC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiADSPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiADSPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF85EC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:48 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id i187so33581954qkf.5
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=StB/LK9blxjkJOwppFu/JcsUXmSSKIHCZYIhAhYeOQM=;
        b=LFlDh/H+BCTRi0hbHD8SlS02+326P2aMvfb5sxLa/3dHuk1WXWA9tx6bwP2hwVs/3N
         iGwaJsX3gk0iiHjqiwhkjH+ODVc2ZugSN0eh0aDoKp/9ecFXgrvCWy8uKG968FZ/2qYX
         ZNAMRh+vF0bglZV9xfrhK0xMQj1XxIBWAR3+d8kx4OCsHzA9xhB5hMAE8CmWW6mxX4Rs
         tH0WRssAerpsfKDlWoQKqrVw47we4078/yCDsz7wkY7eXR23ia0sCEy0WNW61l7eUCvm
         YK1IE7Kh/jiprBFSjDCKQcH8n1OaZ+nYKMPjdPVJFkuDlk/cB7Va1Xm6dvC5dqwnlalI
         BiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StB/LK9blxjkJOwppFu/JcsUXmSSKIHCZYIhAhYeOQM=;
        b=4A70akzm1crC7c0sn58Vex8LAt8cLLaLIiQIKncbr4C0UFdkeqc2mtlBLO5p9XE1wN
         LhutoE77glRyvW5/LgUWbj0NF/3bhe2tK5BSuDOPG3RUUqBCKoktgqz0+RAfqSRs9paU
         b9y6kfRRy5x/va6pbfqLOTV08RaF8K61xfFbr9lj+l2w/JFrvBpad7g5nN3yuxxfZBiR
         AdY8q9JdC20ON/ZoMBnKC3ZCnoZ9UW3F0D4hNXnzs96be3b4f0d9HC+nhgpbI5XAcYVG
         La4iEY95Pwb6X5MQFVTX5AEFxf7sIdEkaWOVeRvXfbkX7Fk3lzV4TVao7VGzwsy6RvKB
         P3gg==
X-Gm-Message-State: AOAM532c2PYN+Rhykma5ZfE0giOXGDe+fkdfQ3PUxSEz/vq4ebvwvvTP
        VZ9VEoro+V8X1bkzMtOnGfTckZx9vqqHuitN
X-Google-Smtp-Source: ABdhPJyl7Rz7LwV6+2tM9upekPBH12Ayc938sv6OyO19grNJ6MWgLJg3EsMwnX1AyZIUhNMfP+V+rA==
X-Received: by 2002:a05:620a:2848:: with SMTP id h8mr36357956qkp.610.1641320147660;
        Tue, 04 Jan 2022 10:15:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f12sm32201281qtj.93.2022.01.04.10.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:47 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 3/9] pack-revindex.c: instrument loading on-disk reverse
 index
Message-ID: <3279e2eb9b7bbfcc930e4ee146a3bd2476ef91eb.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
source for the reverse index's data. But it will be useful for tests to
be able to determine whether the reverse index was loaded from the
separate .rev file, or from a chunk within the MIDX.

To instrument this, add a trace2 event which the tests can look for in
order to determine the reverse index's source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index 70d0fbafcb..bd15ebad03 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -301,6 +301,9 @@ int load_midx_revindex(struct multi_pack_index *m)
 	if (m->revindex_data)
 		return 0;
 
+	trace2_data_string("load_midx_revindex", the_repository,
+			   "source", "rev");
+
 	get_midx_rev_filename(&revindex_name, m);
 
 	ret = load_revindex_from_disk(revindex_name.buf,
-- 
2.34.1.25.gb3157a20e6

