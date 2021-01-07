Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9BC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084ED23432
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAGQc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhAGQc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:32:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E064C0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r3so6263892wrt.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TlE4Wa/PmXo18jG1onlTnDHaohvuR3hpK+GpRAAFDa4=;
        b=WkY2k0UQRRJs6TmsNu8Zd/gED+yVCk5hHzaw8jT0QZsPzxH5mAbYW/MiGxQV/UZ2H7
         GTlGVgA8tc0bVZpfzDWWdmOvyp4oTpY6eU26ycZlJK5Pkkd3fliCX9nmA2XMLO9Rfaue
         76xEyU9+XOP6KAMehbaueU+UBIjZkiuONOunKAv7p8lT9NZmrvbx6RCFRQYXAAE3Zhbw
         MLmx2imhJILiCOmyCbvaBqOvejD+T2LN3FY1IAbY+6EQSO3sMQ3MaXRDYL1TWvy6NDbe
         yKp0VT0xBfoHBdrew2ugT4uKMzfTGAhltzwLKt9SvcooH7vaNLCLD0JCAf6KXOEcsE3H
         M4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TlE4Wa/PmXo18jG1onlTnDHaohvuR3hpK+GpRAAFDa4=;
        b=b2rEL9uix20JzPBVqTRkGdzqp6wVI5lVhMP2sk/tSCP1CoMw91XJq7bV4GOaHbR13z
         sl9Qa6/HbtyQ78AIr1TngUH8ByqGEB9T/wIIJb4ySISJcptWEf/OJ6FasAh9XFM1uYDZ
         17Ls/OIdo6aKG3ThLHVcHjOiR0oUEh/hJvLm5wfqZKZE430Mtl8EkDOrxeF5HXxpWNCk
         QYcnxe+3G5Bk8vyX/+74DwjxUrzjm+aKBXswtRB/SAoLMfTFLHfB3pgzvtMQjQ4tLt90
         R3dyNTk1KKiy+zN4iiTCDVTpeagr8BfVWQYGV315uwenWtz0U2YbVOzGTqB+ypCw3qUj
         ddKQ==
X-Gm-Message-State: AOAM533DnEQy0Kx83XwY9XIBYg5sCcV0gQehlyAe6vvozo2uMnt4Ox35
        AhSskghjYw+Ug2cbkr39lRfIXpPdJiE=
X-Google-Smtp-Source: ABdhPJxRVbGmO7rwMlpymdQNARXGdmGc7yrp43QatYd72GEG+UxyMtcyJf1I0knN6JEWBb2ocvvvJA==
X-Received: by 2002:adf:c6c4:: with SMTP id c4mr9947196wrh.348.1610037135215;
        Thu, 07 Jan 2021 08:32:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm8297390wmb.41.2021.01.07.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:14 -0800 (PST)
Message-Id: <4157b91acf8009ef2136c0856b6b61833d82873e.1610037131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:03 +0000
Subject: [PATCH v3 02/10] unpack-trees: add trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The unpack_trees() method is quite complicated and its performance can
change dramatically depending on how it is used. We already have some
performance tracing regions, but they have not been updated to the
trace2 API. Do so now.

We already have trace2 regions in unpack_trees.c:clear_ce_flags(), which
uses a linear scan through the index without recursing into trees.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 323280dd48b..af6e9b9c2fd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1580,6 +1580,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
+	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
@@ -1653,7 +1655,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
+		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
 		ret = traverse_trees(o->src_index, len, t, &info);
+		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -1741,6 +1745,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
 	return ret;
 
-- 
gitgitgadget

