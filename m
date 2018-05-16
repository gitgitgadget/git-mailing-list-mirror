Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A826F1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEPW7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:24 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:38461 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeEPW7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:22 -0400
Received: by mail-qk0-f202.google.com with SMTP id y127-v6so2337735qka.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JE/pnRxBlyo6amKlgjsZztyV6qMLl11JS4gOLVW3T2g=;
        b=BNi2cDRVOIOPBe3boLoOvmRjemSHpY0AA8q2sjqnxjbMRfY7AEOo+jA8Zi56PU59iP
         E5kXJ71AE50VC5jYhI1xNqAO37U6js0S2l3ESwpkq3Wbgf1U1tgmBAmzCzjmGQiAyO9F
         NB0hRJqQyCeBAIyr/+Skw511zpLdagOTqOyzIKfcxtz/rZvTmFWxlue17I7RsuMe1LGj
         QD9qwCPzke/0k5F4+I7UX9ZJK2r9YdG8EZAbCdpe4oSjRRx0I2s6Qoad+SKSL3D0MZ1z
         aUuuw03D5n1hRr20EV8+mDgT6NE2grEjHqE/x1/vRUxlYVn7RNKB5idO7v8XsN/REzFk
         XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JE/pnRxBlyo6amKlgjsZztyV6qMLl11JS4gOLVW3T2g=;
        b=D8w4UvAM0CJW0zfRhgYPC71pvuZXq5IKCsGj3AXpX0MQPKE/OzrTHh5G1e1Hc+ggSd
         6NiogFv/3J+lfhHznakRaNiQyxkmeGs2hAh1QCrHjYHg0M39vHxrnVt0KnfgM5SHtZn9
         AatfOzoM7zC/pbite/ktgFVjShd0lBGkSWPF6Mi4iI7zbKlC+QR+ifPgDuPuCGxKLxoh
         xuDhnotioFORv59r5Uz1R3T0ovHOaIlaZir6hlfYkjrErNePfzGalxAmUPalq0e/6wWr
         1/EoLZ9L13oIxxGBACo49vmID+IUaup8BlTSZHa46BZzPK13pxcCn3EgLmds5uFWSOxq
         ZS5g==
X-Gm-Message-State: ALKqPweg5IkFHx7W8grhbaP887m0vJCJVY1kfJctuHCF4paT+b8nzmfU
        Lyx2ZfUHAn00b66oeSvJhTTAATtdhyY3iN2NevMIg6RpsZfn2V2xNmehoDYGejELR2+a9LuAUg+
        p7PTXPG+cdYpV8EhqBVTsDX5uyA6Mr/YUSXVaR9xMM1JIEjBOhxZ3Oy7DXQ==
X-Google-Smtp-Source: AB8JxZoctY+qkILEIiMWrZy129HFVhhDONt2PxS2eA3OyJvaukdUfV6tUQpiZzm8u+rPlsYhCbvd+/h7MYI=
MIME-Version: 1.0
X-Received: by 2002:a37:8f07:: with SMTP id r7-v6mr1390653qkd.53.1526511561229;
 Wed, 16 May 2018 15:59:21 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:05 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-19-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 18/36] fetch: convert refmap to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the refmap in builtin/fetch.c to be stored in a
'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 18704c6cd..6b909cd5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -60,8 +60,7 @@ static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
-static int refmap_alloc, refmap_nr;
-static const char **refmap_array;
+static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -108,14 +107,12 @@ static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
-	ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
-
 	/*
 	 * "git fetch --refmap='' origin foo"
 	 * can be used to tell the command not to store anywhere
 	 */
-	if (*arg)
-		refmap_array[refmap_nr++] = arg;
+	refspec_append(&refmap, arg);
+
 	return 0;
 }
 
@@ -403,9 +400,9 @@ static struct ref *get_ref_map(struct transport *transport,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap_array) {
-			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
-			fetch_refspec_nr = refmap_nr;
+		if (refmap.nr) {
+			fetch_refspec = refmap.items;
+			fetch_refspec_nr = refmap.nr;
 		} else {
 			fetch_refspec = transport->remote->fetch.items;
 			fetch_refspec_nr = transport->remote->fetch.nr;
@@ -413,7 +410,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 		for (i = 0; i < fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec[i], &oref_tail, 1);
-	} else if (refmap_array) {
+	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
-- 
2.17.0.441.gb46fe60e1d-goog

