Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E9C47254
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7BE206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="igQ0fOFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEFAHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFAHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFFC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so1512467plq.12
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yn/llej/jTolC/XlId/Yu+ZvA9EsPYY1FRqM7XVwbno=;
        b=igQ0fOFrO7nqGjNseTdOtLWPvGQJ9jM+HD2BCo28TMKiy/J4RS9VQ6pm7q2FURL3yc
         3KICppwk8CEgDYeYqrUD3QWh0t07V5yullYX5aBoqW/3LRRlIpwuVOAVMK1KgsZo+YS4
         lrJqg4Uni48cTUvfo06EQ5N1pE7RGxnQs5N7unbQiVruA3DCacHRuLd14ZOAGohiFvcs
         BA5ys5/jm58vUYk/zFBcnBsbw1+xh7XafHtgtOOxCthn35S890Z2QxlF0i7WLvrpwXqH
         VX7dDiS9syDuBZcSIOaRvszW+njo7/IZiv2bFcMTRFZgK5/W0mhK0wuHBnrz/Gkk2Dn5
         mkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn/llej/jTolC/XlId/Yu+ZvA9EsPYY1FRqM7XVwbno=;
        b=f90EZyzEaF/qVt11iW31g6Cyr7svdOxLCRHoTqB8yE77qa/SNG6lIGip13P5KQiT+q
         kThDnzGzQBXGUu0Orx9Ip2RBRt/cZhm+MjpHeNmJRcgLfVvz1kTp0hdYUv6B/sg5ndLT
         f+o8RPoqE2hXa9vxU9LuLX8X1t3Lu84FY73K8NWXe+bj7WAwGluU5OL87EDWfrG1lyjG
         BUnEwuSEl/KFMZ8Q33beKKhP6Kt03yKFjtbHtR9N7yjyEcTFFBLR8kWuXD6F8JfxJyRt
         uG9cVOfzZ492rQFkD/P1GAwLZoOTzL391jY2UcRkfmuGquhIjt8Zs7/BsJcMIJFw/jx3
         bx1Q==
X-Gm-Message-State: AGi0PuaM0YPyDcvlRjH4V1oJamqJhMYJQybdsTd5if3vruf+eK66/R7y
        yUeuPvRe3JG8nY/FGe8vxaiaLm0ARV0=
X-Google-Smtp-Source: APiQypL5ZDHlUqrRW39FlUBd+rPlQ24z3hmxHRv8sx49FZF1+RqvfRljXC+4JG+wwGIiAbZlyVNjHg==
X-Received: by 2002:a17:90a:2149:: with SMTP id a67mr6251768pje.43.1588723653400;
        Tue, 05 May 2020 17:07:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d12sm2957264pjx.1.2020.05.05.17.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:32 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 1/8] commit-graph.c: extract 'refs_cb_data'
Message-ID: <43286c3c45b2dcef8d9d39b4998c17f364eb1060.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent patches, we are going to update a progress meter when
'add_ref_to_set()' is called, and need a convenient way to pass a
'struct progress *' in from the caller.

Introduce 'refs_cb_data' as a catch-all for parameters that
'add_ref_to_set' may need, and wrap the existing single parameter in
that struct.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6dc777e2f3..00da281f39 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1318,13 +1318,17 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	stop_progress(&progress);
 }
 
+struct refs_cb_data {
+	struct oidset *commits;
+};
+
 static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
-	struct oidset *commits = (struct oidset *)cb_data;
+	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	oidset_insert(commits, oid);
+	oidset_insert(data->commits, oid);
 	return 0;
 }
 
@@ -1333,9 +1337,13 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 const struct split_commit_graph_opts *split_opts)
 {
 	struct oidset commits = OIDSET_INIT;
+	struct refs_cb_data data;
 	int result;
 
-	for_each_ref(add_ref_to_set, &commits);
+	memset(&data, 0, sizeof(data));
+	data.commits = &commits;
+
+	for_each_ref(add_ref_to_set, &data);
 	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
-- 
2.26.0.113.ge9739cdccc

