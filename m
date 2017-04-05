Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F079720966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbdDERrc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:47:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34536 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753845AbdDERr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id 197so10709105pfv.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HTlPvFNXLDpEdmlilzlB5LBq19O8msW56AAKlTWKxNk=;
        b=Xj9jWxQNYfs3FumRMNX5xfccp/o7n2pqUND73iPPLLA2pWoOGeyUv6EvDNlZbd1wjI
         6EYj9QtWMWj8UHdYVBTDZaYHS2THCq42RqYwwSq0WmG1HgrQgTq32u8T5gV1GXR4q09r
         WKzWZa6rl4vEP48sZGuoraeFbrPddAkRGvC7seLUn6F0ATsne5HbuPHZKSlhVWCwKBdd
         XvXHO9kyElV/YIuZPDjlWDbHTHqNMpDzqTb8i10SoOcRe3XhBEWUqKzyFQ+KkgHR1JOo
         8DXjt++ZLBGJIDVR0rS6x4OrmnvEO6lAL6Z3UYLJSARnRVlUvTshqWP3cGCL7/i+hzmA
         zOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HTlPvFNXLDpEdmlilzlB5LBq19O8msW56AAKlTWKxNk=;
        b=S/+GdXNppoC11EsIdSCGFelJDto6tLO7Vp2jauGicGp/y7at81CyP4nr9ni2U2O2B1
         SVqFqt/GxJb+E6+r1w2wA5uH3eyab/Dk3ZIDWzLnR2/QMc7L9eKTm+bU/MuvFotZuXtY
         B8HwQhOxoyPISehy6QcUvNdjPCThU3/SzBaqIGdiQR2HITX+tmCEHz1H/SCzQmG9uVuY
         lJ+dGF1vJS/knAcoHiNtoFIhdRVv/WW/5ccaEK0WygOtO3iuYbb2/witV8DIyLiBcBUj
         GiSrNAUMa6Ljl7dFRI+FPG/NdhctkDokjsjDpJ19l+xMhzapbvtVhK5XV0LO2CIgPuFw
         yZMQ==
X-Gm-Message-State: AFeK/H2hdXFu3DaKYzN4S2OsJpqmzugBRTP5AJ/TFRkoeTPLijYcWiZeh2j9z1uW23tFqVT+
X-Received: by 10.84.225.145 with SMTP id u17mr37234762plj.91.1491414447575;
        Wed, 05 Apr 2017 10:47:27 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 1/5] push: unmark a local variable as static
Date:   Wed,  5 Apr 2017 10:47:15 -0700
Message-Id: <20170405174719.1297-2-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170405174719.1297-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There isn't any obvious reason for the 'struct string_list push_options'
and 'struct string_list_item *item' to be marked as static, so unmark
them as being static.  Also, clear the push_options string_list to
prevent memory leaking.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e..a597759d8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -510,8 +510,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
-	static struct string_list push_options = STRING_LIST_INIT_DUP;
-	static struct string_list_item *item;
+	struct string_list push_options = STRING_LIST_INIT_DUP;
+	const struct string_list_item *item;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -584,6 +584,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			die(_("push options must not have new line characters"));
 
 	rc = do_push(repo, flags, &push_options);
+	string_list_clear(&push_options, 0);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
-- 
2.12.2.715.g7642488e1d-goog

