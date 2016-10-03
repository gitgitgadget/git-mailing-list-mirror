Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAEC207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbcJCRUG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:20:06 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:35548 "EHLO
        homiemail-a23.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753196AbcJCRUF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Oct 2016 13:20:05 -0400
Received: from homiemail-a23.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTP id 73FC44B006F;
        Mon,  3 Oct 2016 10:19:59 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTPSA id F2B3E4B0062;
        Mon,  3 Oct 2016 10:19:58 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, sandals@crustytoothpaste.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] http: http.emptyauth should allow empty (not just NULL) usernames
Date:   Mon,  3 Oct 2016 13:19:28 -0400
Message-Id: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using kerberos authentication, one URL pattern which is
allowed is http://@gitserver.example.com.  This leads to a username
of zero-length, rather than a NULL username.  But the two cases
should be treated the same by http.emptyauth.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 82ed542..bd0dba2 100644
--- a/http.c
+++ b/http.c
@@ -351,7 +351,7 @@ static int http_options(const char *var, const char *value, void *cb)
 
 static void init_curl_http_auth(CURL *result)
 {
-	if (!http_auth.username) {
+	if (!http_auth.username || !*http_auth.username) {
 		if (curl_empty_auth)
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 		return;
-- 
2.8.0.rc4.22.g8ae061a

