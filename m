Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D25208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdH3HDd (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:03:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36599 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdH3HDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:03:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id k3so3805284pfc.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V5GZdjuo4nUmdMTlWgXWv3TobnFkQPrGgc3Cc5SsCp4=;
        b=IWEzw8d25ZhgIwq03hu+a0gpMHUiQebA7/vcM93A2ntAATXgnP4mwrh5Un5lgu+kiC
         aBWsnXq5Wza8Xh31XSfb1e7cYEfkA2Qt/1qhiiRbBWqcIzFWSn6eiY1glcc0XqwMRwCb
         r6cBaeH8T9OBM/uDHJKRGD2wAdMX9sVDtCQ7LaI0KOcsjiKRHBn5Bq5qn6Y+qwqXySag
         o56qRCIgjmGqawzasb8cQQNho/QU6WZ+TnTTExOmxB+QuVJ/OetsAKiOGj3Y1JK8DxUs
         fGT+CGrfiB7Q8Yv0bLmdJm/8DRBTi1GGNSfxX70MMUyyf3SSRcBfr+OYxMr9dZD5Mhak
         0miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V5GZdjuo4nUmdMTlWgXWv3TobnFkQPrGgc3Cc5SsCp4=;
        b=Xca1m58mKoROb65q82scS0aRLl18VrkpFmBWIPj1/JYnvxH/NgwXeA1UPLbG6cv4cm
         DaXlWT86+SyQzZbYfILn2PpV76HIgOzH4qb0m36GjAVr5NAtHyKgJpGlnIAXAoLPsEeU
         9ZNwatVSRbUz9e7wb6FDcaj0rXRenJBx54h9QtObWNnnV7TloUyyGXbgsFfpcAB9WnfL
         twl7+IBvn3/guQskGSw0jfvISzKfYVLEhZqVvP3YIkxh15TfX8ou5wz3J5ss0AwtCf9B
         71i6U+QQGB06as2eEVUZc81WuV8WkFwpCWbYOjb3RRXK/EwKUqI60Q2lf9Rl++6xFMdt
         QnGg==
X-Gm-Message-State: AHYfb5hEdsQRhMbJwbfWKV8pjh/etqx9YBOprBC+RULF6t/3Toijatg1
        kSsS5w1G1rOBUydbSlc=
X-Received: by 10.98.57.135 with SMTP id u7mr632509pfj.220.1504076611477;
        Wed, 30 Aug 2017 00:03:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id l30sm7828566pgc.61.2017.08.30.00.03.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:03:31 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:03:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 18/39] pack: add repository argument to prepare_packed_git_one
Message-ID: <20170830070329.GS153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the prepare_packed_git_one caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index cea3698af5..3a841c0f69 100644
--- a/packfile.c
+++ b/packfile.c
@@ -719,7 +719,8 @@ static void report_pack_garbage(struct string_list *list)
 	report_helper(list, seen_bits, first, list->nr);
 }
 
-static void prepare_packed_git_one(char *objdir, int local)
+#define prepare_packed_git_one(r, o, l) prepare_packed_git_one_##r(o, l)
+static void prepare_packed_git_one_the_repository(char *objdir, int local)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t dirnamelen;
@@ -871,10 +872,10 @@ void prepare_packed_git(void)
 
 	if (the_repository->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_packed_git_one(the_repository, get_object_directory(), 1);
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
+		prepare_packed_git_one(the_repository, alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
 	the_repository->objects.packed_git_initialized = 1;
-- 
2.14.1.581.gf28d330327

