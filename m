Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42791F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbeIVCXK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:23:10 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40308 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVCXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:23:10 -0400
Received: by mail-pl1-f201.google.com with SMTP id n4-v6so6561685plk.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H1YyALbrZqOs0ZmlI+UqYUl/H9MNngc99B3IfB/8IdA=;
        b=X0YiNk5wj/zei0p668rebqxOb6olkfVRoNKSZzl0IuZXEn9Qifx95IsCeX4B3SZ40n
         mtf5n1bfmIm3z3/mfs/A6sxTA1h8j7xQ6cDT70SrmmXS8B4Iuk9CPE+pnr1VesOMyLby
         JGQWKPsjIVYQ4EGOv9SaYBQvmdwklnhEovX54xi9nHE08KHqxcuwBCYtD8aMd0gY5api
         shjwgohIIH2FcjDsnOJVXNUOztrrtYe0NL451zVVVSVsKy+pgVOZAgMOcnqKxkp/qWQa
         v8rjP3MI+FLERhmQNeUspeTDkOtskae6dbdjk04mM7e0RUmvMYPO0kFkBwTzvx5SjAtz
         YFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H1YyALbrZqOs0ZmlI+UqYUl/H9MNngc99B3IfB/8IdA=;
        b=OtLW3OYYyZ856uMDFOtesZEW+mVLeTLiUUQClHFjy65rznfOgslWVHK660lxfA2JYF
         +O8RTtXWcMGkdhuTaZEoA4JckrzB7SifNm0FQ7C2rGIf/Lvu3cRHMncjbNmK7CLg6RHG
         u7blheTbdehiwE064BKO2neUd1zC5aTw1T57YF1QH6EGzFGrW2+Oy0KxhaD7adkp++k/
         Lvn7hcyWDdPZXg2aNbEeg9G9g4073wDfdo2EpTtG91JFcA1vJceZfC77kmBvWeG5raJw
         /pFfOHOIwkW+7dp6NSMc1aMJyesLfTL4nl+h7f3f+1S04qfroGyQ3ErXOOXD8ORnbI/J
         FsrA==
X-Gm-Message-State: APzg51CDTB3Sqrh/lfv3EoFCN+0KY2tFb+KtEnq0YG8MUlYBwzg/HX44
        CWWTiQEf2gQ39LCGrIED3JRxgPd6spcjKFXSsxM4V0xH/XsHed10wZlYHzYQZBuxK9ItM4J3Kol
        ptTdR+2NMVjmrKFpbR/RJoYuNklBk29SZHf27J3WjPtmixQ73sjlB84/YPrU=
X-Google-Smtp-Source: ANB0VdYOUM8yXUdDX4yEt+rBEgatB3vtC/WgMC2LJ1kiqX1rw5UsdGvRMV0uoC7H5VmwjYZU2zttx7meG/p0
X-Received: by 2002:a63:7f0c:: with SMTP id a12-v6mr2114787pgd.76.1537561958895;
 Fri, 21 Sep 2018 13:32:38 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:32:03 -0700
In-Reply-To: <cover.1537561420.git.matvore@google.com>
Message-Id: <4d9bbf5c8af670a969a5b11876a65f0505b1a1b8.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1537561420.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 7/8] list-objects-filter-options: do not over-strbuf_init
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function gently_parse_list_objects_filter is either called with
errbuf=STRBUF_INIT or errbuf=NULL, but that function calls strbuf_init
when errbuf is not NULL. strbuf_init is only necessary if errbuf
contains garbage, and risks a memory leak if errbuf already has a
non-STRBUF_INIT state. It should be the caller's responsibility to make
sure errbuf is not garbage, since garbage content is easily avoidable
with STRBUF_INIT.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a0..d259bdb2c 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -30,7 +30,6 @@ static int gently_parse_list_objects_filter(
 
 	if (filter_options->choice) {
 		if (errbuf) {
-			strbuf_init(errbuf, 0);
 			strbuf_addstr(
 				errbuf,
 				_("multiple filter-specs cannot be combined"));
@@ -71,10 +70,9 @@ static int gently_parse_list_objects_filter(
 		return 0;
 	}
 
-	if (errbuf) {
-		strbuf_init(errbuf, 0);
+	if (errbuf)
 		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
-	}
+
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
-- 
2.19.0.444.g18242da7ef-goog

