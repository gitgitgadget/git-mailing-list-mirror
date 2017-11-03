Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8D520450
	for <e@80x24.org>; Fri,  3 Nov 2017 20:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdKCUuw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 16:50:52 -0400
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:56288 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdKCUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 16:50:51 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Nov 2017 16:50:51 EDT
Received: from localhost.localdomain (unknown [145.129.9.233])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 3AC9380568;
        Fri,  3 Nov 2017 21:44:37 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     grawity@gmail.com, Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] credential-libsecret: unlock locked secrets
Date:   Fri,  3 Nov 2017 21:44:49 +0100
Message-Id: <20171103204449.5268-1-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.15.0-rc2-464-gb5de734
In-Reply-To: <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
References: <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Credentials exposed by the secret service DBUS interface may be locked.
Setting the SECRET_SEARCH_UNLOCK flag will make the secret service
unlock these secrets, possibly prompting the user for credentials to do
so. Without this flag, the secret is simply not loaded.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 contrib/credential/libsecret/git-credential-libsecret.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 4c56979d8a..b4750c9ee8 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -104,7 +104,7 @@ static int keyring_get(struct credential *c)
 	items = secret_service_search_sync(service,
 					   SECRET_SCHEMA_COMPAT_NETWORK,
 					   attributes,
-					   SECRET_SEARCH_LOAD_SECRETS,
+					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
 					   NULL,
 					   &error);
 	g_hash_table_unref(attributes);
-- 
2.15.0-rc2-464-gb5de734

