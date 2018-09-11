Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AAF11F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeILBer (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:34:47 -0400
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:41088
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbeILBeq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Sep 2018 21:34:46 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id zpLyfzGK9Zl72zpM1fIiCM; Tue, 11 Sep 2018 13:33:47 -0700
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        =?UTF-8?q?Jelmer=20Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2] http-backend test: make empty CONTENT_LENGTH test more realistic
Date:   Tue, 11 Sep 2018 23:33:36 +0300
Message-Id: <20180911203336.4601-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
In-reply-to: <20180911040621.GD20518@aiede.svl.corp.google.com>
X-CMAE-Envelope: MS4wfDU7JHEmaQ2whWxRynDZY5MHYxwbWBs6D9/OEveh7Vg1d9/QlUlBjP4V9UHikh2jGvhfq1tB80U0k5t53Jv4bR8IHiLtnuTchGNc7zdI+adsknKnDKLk
 CuQ5Ml5OdYnN+b/NCB253DtsThEhjNgcCvo7k3gode5RPBrklaPYJ0SpSGWcqOLtMSQ408de4VjKHy/M9m3VBnpcEd2GkFMtCFjdc7WfwDoTwRGImdpKvXnm
 uw3fPvVMsqiYoxvGHbLDxVWlaVQDVH6vmi/BXUdeV9Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a test of smart HTTP, so it should use the smart HTTP endpoints
(e.g. /info/refs?service=git-receive-pack), not dumb HTTP (HEAD).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
---
>  do you know why the test passes without 574c513e8d (http-backend: allow empty CONTENT_LENGTH, 2018-09-10)?

Because I did not know what is QUERY_STRING (it is the part after "?"). Fixed now
(Somehow I did see the failure during development. Maybe there was another parameter before?)

I suspect it is not OK in other places of the test, but I hope it should not affect the result
 t/t5562-http-backend-content-length.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index f94d01f69e..b24d8b05a4 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -155,8 +155,8 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 
 test_expect_success 'empty CONTENT_LENGTH' '
 	env \
-		QUERY_STRING=/repo.git/HEAD \
-		PATH_TRANSLATED="$PWD"/.git/HEAD \
+		QUERY_STRING="service=git-receive-pack" \
+		PATH_TRANSLATED="$PWD"/.git/info/refs \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=GET \
 		CONTENT_LENGTH="" \
-- 
2.17.0.1185.g782057d875

