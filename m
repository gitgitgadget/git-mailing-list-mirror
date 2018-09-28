Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDF71F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeI1XCL (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:02:11 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41216 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeI1XCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:02:10 -0400
Received: by mail-qk1-f174.google.com with SMTP id n3-v6so4221589qkn.8
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9uqmVIyR1m11S6/TsLEd0Y1xadSurWHPN9WY1ZkonrA=;
        b=DqR/rdJGERGMDjUv7tZOjYDzosEt0JyePn3q9uqDSGt8D/moYflMjAnFGRWuzdj7Xw
         wQXJ6Jc2EbTfYROjXNmieJwkrgL+KInLtpjr44GpjD/Wg8qQZqNc4CA2ryTqVK+Xn5Ry
         6lvxIUpxI2nVmAYDzqA1DgeWpt1axEX8MSjlHu4T/JZH40DFcSyaWaxH825e1WLCepKK
         Bop6PFKnT/gvFa2RhpbPAawt1eQLhEp1EP0h2sJCFB/m8UScAKjeSv8jjmAnDtl4jInx
         rhb/FNUWhwjxVEDugsO+Zr+XejEB36C/XlnEvkr0cWECpst5V0tXds/9SB4JquVZ1ODb
         Xh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9uqmVIyR1m11S6/TsLEd0Y1xadSurWHPN9WY1ZkonrA=;
        b=pBjtR6xJKBtIQ7WnrC9Qd3eM06wlm0hH6Nv/j52P4FIrnIbTJbamaTA32ZnaNkhjAH
         Tom8tfVfdCWBkMt1Rc0Qe/65WPwyWFkZnJpvrSn/nK6r1MF4Tsecd5QNoxqxQP7h2qov
         pbCRmHouXlAwEi3gP4yo+diUFRLBi3bz5uLMde2VTevBK6cOh5mm/+1DOtOKLebK/jjZ
         pkIav0oB+bONPQ/zQknYsGCLCTopP2V/hGatyMeNWkO4O1RsVcZPUR94qoZq91TtMlwk
         bkd3IzufQi7Cn8CA1eIuKG0gXi+arN7LGTKzHTV3x2nBcbkqfDYuXoqgVcYCZ1ixpZFF
         W83Q==
X-Gm-Message-State: ABuFfohGHctJt8bqk5Wc1hSbJWonHpl4gCyHybwH8db5/Ahz7NvyQzqJ
        10JuIbg3qSq4RSdXGNeILCpk9ECg
X-Google-Smtp-Source: ACcGV63WOynh0HVvMxbCXVdiDRxp1pfiivEDAMJ8Pjr9tO81yBHc5CHmOpTM7lr2fXsAEMLQ1aRvfg==
X-Received: by 2002:a37:a48d:: with SMTP id n135-v6mr5754505qke.160.1538152655591;
        Fri, 28 Sep 2018 09:37:35 -0700 (PDT)
Received: from lottle.net.com ([2600:3c03::f03c:91ff:fe55:6cc])
        by smtp.gmail.com with ESMTPSA id n25-v6sm3519135qkl.8.2018.09.28.09.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 09:37:34 -0700 (PDT)
From:   Kyle Hubert <khubert@gmail.com>
To:     git@vger.kernel.org
Cc:     Kyle Hubert <khubert@gmail.com>
Subject: [PATCH] Improvement to only call Git Credential Helper once
Date:   Fri, 28 Sep 2018 12:37:16 -0400
Message-Id: <20180928163716.29947-1-khubert@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling the Git Credential Helper that is set in the git config,
the get command can return a credential. Git immediately turns around
and calls the store command, even though that credential was just
retrieved by the Helper. This creates two side effects. First of all,
if the Helper requires a passphrase, the user has to type it in
twice. Secondly, if the user has a number of helpers, this retrieves
the credential from one service and writes it to all services.

This commit introduces a new field in the credential struct that
detects when the credential was retrieved using the Helper, and early
exits when called to store the credential.
---
 credential.c | 8 +++++++-
 credential.h | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index 62be651b0..79bf62d49 100644
--- a/credential.c
+++ b/credential.c
@@ -280,8 +280,10 @@ void credential_fill(struct credential *c)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
-		if (c->username && c->password)
+		if (c->username && c->password) {
+			c->retrieved = 1;
 			return;
+		}
 		if (c->quit)
 			die("credential helper '%s' told us to quit",
 			    c->helpers.items[i].string);
@@ -300,6 +302,10 @@ void credential_approve(struct credential *c)
 		return;
 	if (!c->username || !c->password)
 		return;
+	if (c->retrieved) {
+		c->approved = 1;
+		return;
+	}
 
 	credential_apply_config(c);
 
diff --git a/credential.h b/credential.h
index 6b0cd16be..d99df2f52 100644
--- a/credential.h
+++ b/credential.h
@@ -8,7 +8,8 @@ struct credential {
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
-		 use_http_path:1;
+		 use_http_path:1,
+		 retrieved:1;
 
 	char *username;
 	char *password;
-- 
2.11.0

