Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFDE1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbeIVCXC (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:23:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35323 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391318AbeIVCXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:23:01 -0400
Received: by mail-pf1-f201.google.com with SMTP id c8-v6so7039338pfn.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MBDgC0bSUmOT/SwVohS9qQegpVsmQ26X2ru/G8EyZ6A=;
        b=CBzhw2nuMUs89/AkFpiZZbvkAMilODF/O+pmPVIagyOt2EWzEYNfH5s69uTCP6PCEm
         /082FLB3q3RPdRhm1TCTtva2gb/hz2kxMFf8vK31RvKlbsJ7AH0bDxRhoTmyJtqvbFYu
         t14U5pz7hMsPIG8212F6WH0nvpl9HrQEfP2lHqpK+fNcr8UXgp53j5Btt0Hu5WrSz+05
         YHGqJE9/chWPnFKTULBmxHTUNmo6YBz+gamEg3djlDmhute112F8UmNt2UbtYw5tZ81S
         jZjTDMbD5cu0kd1GeSvoapUQCJAukc1dscHE59wK7QXZVM7TMWdee5rm+1mXUZr0RsbW
         ZeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MBDgC0bSUmOT/SwVohS9qQegpVsmQ26X2ru/G8EyZ6A=;
        b=PdMpwtZ6dZ20QpcOn4tnW3JOgkluT/msM8IokYY6MvaBNPzXrxHPV1fsV0aZ1IP6lW
         BM1XeL7aVo57eoAbbilQ9Qtg0s03gmgJcpUIYX9y403ykKeceyM175uBRYyihJzvGWAD
         baHHS92DitBWGlWjiViIqyacq7qUCe8LXtttJtrfrWa93wfSk3S/0+39Bi1fTB+u9iTr
         csRAOY1ja6fUBI9c+JvzWKQSCA7sSqMb3sdVKL9F//lpIy4Yrh7grYkLyV91IfZosdZ+
         eSHePM9SmST6g/o37Btw6A2ag/nwoJpr0zRDYZq9+8kU4JRC2N6MX6ZRJLK9gFQttjdr
         SqaA==
X-Gm-Message-State: APzg51D/rPNs09uBEl1Ttzu5kHss2Qw38yo+07jRN+vtQ63FkNrOYqP9
        aWigWJ/PMvATDmN6jxeq4myMIW2ivWCXmDgH/CusgDXzNc4yToAFjBZu08d2eJPg9OZ+T/vjItD
        1P4uhwA06JZj7KL82bI86oJoske0+nHVdgiRwAfLjSCqpixuYNVg/gJoAmxI=
X-Google-Smtp-Source: ANB0VdZkMnDdJV2/ajuMoDsB/53vivinVwPJulazwHbIsQIpwtUjZY21kKQkPzQXXoBYxttoJcdEmSdnkGuq
X-Received: by 2002:a63:a17:: with SMTP id 23-v6mr303369pgk.140.1537561950137;
 Fri, 21 Sep 2018 13:32:30 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:31:59 -0700
In-Reply-To: <cover.1537561420.git.matvore@google.com>
Message-Id: <0d1285a0ec412846e5417ec524a866f6b2c39d82.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1537561420.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 3/8] list-objects: always parse trees gently
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

If parsing fails when revs->ignore_missing_links and
revs->exclude_promisor_objects are both false, we print the OID anyway
in the die("bad tree object...") call, so any message printed by
parse_tree_gently() is superfluous.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index ccc529e5e..f9b51db7a 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -143,8 +143,6 @@ static void process_tree(struct traversal_context *ctx,
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
-	int gently = revs->ignore_missing_links ||
-		     revs->exclude_promisor_objects;
 
 	if (!revs->tree_objects)
 		return;
@@ -152,7 +150,7 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
-	if (parse_tree_gently(tree, gently) < 0) {
+	if (parse_tree_gently(tree, 1) < 0) {
 		if (revs->ignore_missing_links)
 			return;
 
-- 
2.19.0.444.g18242da7ef-goog

