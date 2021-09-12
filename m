Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27EC433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E273610A3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhILARV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhILARV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BF8C061757
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s24so3872872wmh.4
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4o/0QoQUwLvhQ+aXkgZv1L46xFg4uGAN2KvEf5r0WLA=;
        b=jh5l1BBsWaoIF6moLQcrjJwqatBs7tGxSGgPmlBun9WDHXfzB+ymFeIYlDFf5FockI
         lY6MUvjusa+SX+mkmz9JvRBM/PV1K64FNT9qGxo2b0cxYRn9lI+nF5XEdxCcHEOE2hq7
         PN6fSHC9mnmeVj4pwxuywjmz0djpi/DdZkTx1Nvk2jF/RG9rAjRDEQUMZ2uhMh1H85oA
         EasmSGexB+ONsr32FMo9jsS0wVe4vUTLneymqze3ZXhPxw7PYw7PAECQtNPaZXqI9tZ/
         b7xvAtJpJog3l3Rt/bERjAxPgEZFFRWnuMh3vapcARQfJVFOVttKfcrWVQk4oXLO2Cz5
         pwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4o/0QoQUwLvhQ+aXkgZv1L46xFg4uGAN2KvEf5r0WLA=;
        b=WVU4ibTCrCdTrvHASt2FKjxyQPp6yFc2ogWKSTteqtP0b46mrGD9ipA2VzjW7nX2tj
         3ZCMGIUEOz9BOrCliWPtk6IbGrWdtIbPSDJUCQf7hVnrZOfo4EQj/s292X9TqX+EpH/S
         XVFRhqIZfSiy180SsibyzwDpXU5VahCKh0byKPgUIvrdWED6YB3DdxhRhTW5YCfVfAbc
         yPIkE34ZMclemSi98yOgnQaL7AVLVeprwE6iVqR7GlJs3i24CHXqD2jC58iRGjTpiUpr
         blLRJL2dWtrB7K7Wddhs7tkRY023a6NzQUmTV63tno8NGg5W5OkphPaOajXUh2kFbipK
         z4Ow==
X-Gm-Message-State: AOAM533C3Ws+ebWAFQP+l9xpH7fk4m+brroAgxbvV4cGeOa6bmR6Xnax
        M8hGWVZsDZT0dhCAm/mhDUImziW3Xz8Uyw==
X-Google-Smtp-Source: ABdhPJwsWoTelaoilB5hrhl73sViQwflj4O7+90/UxHvWFz2YR+1oXB+brfojNhpMLdCy53MgwLQDA==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr4448771wmq.110.1631405765999;
        Sat, 11 Sep 2021 17:16:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] remote-curl: pass "struct strvec *" instead of int/char ** pair
Date:   Sun, 12 Sep 2021 02:15:49 +0200
Message-Id: <patch-v2-1.7-2ef48d734e8-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll be changing the "int nr" in the "struct strvec" to "int size_t"
soon, i.e. from signed to unsigned. It will then make sense to use the
"size_t" type for things that mirror that "nr" member.

This sets up that change in remote-curl.c, we'll change the "int i"
here to a "size_t i" in a later commit (let's also split and "err" up
to make that change smaller).

In this case the push() function can just pass the "struct strvec" it
has down to push_dav() and push_git(), in addition make use of
strvec_pushv() in push_dav() instead of looping over the the specs
ourselves. So we can get rid of much of the need for tracking the
"nr", which in the case of push_dav() was already a "size_t".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote-curl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 598cff7cde6..1f177e86f11 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1266,10 +1266,9 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
-static int push_dav(int nr_spec, const char **specs)
+static int push_dav(struct strvec *specs)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	size_t i;
 
 	child.git_cmd = 1;
 	strvec_push(&child.args, "http-push");
@@ -1279,18 +1278,18 @@ static int push_dav(int nr_spec, const char **specs)
 	if (options.verbosity > 1)
 		strvec_push(&child.args, "--verbose");
 	strvec_push(&child.args, url.buf);
-	for (i = 0; i < nr_spec; i++)
-		strvec_push(&child.args, specs[i]);
+	strvec_pushv(&child.args, specs->v);
 
 	if (run_command(&child))
 		die(_("git-http-push failed"));
 	return 0;
 }
 
-static int push_git(struct discovery *heads, int nr_spec, const char **specs)
+static int push_git(struct discovery *heads, struct strvec *specs)
 {
 	struct rpc_state rpc;
-	int i, err;
+	int i;
+	int err;
 	struct strvec args;
 	struct string_list_item *cas_option;
 	struct strbuf preamble = STRBUF_INIT;
@@ -1326,8 +1325,8 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 		strvec_push(&args, "--force-if-includes");
 
 	strvec_push(&args, "--stdin");
-	for (i = 0; i < nr_spec; i++)
-		packet_buf_write(&preamble, "%s\n", specs[i]);
+	for (i = 0; i < specs->nr; i++)
+		packet_buf_write(&preamble, "%s\n", specs->v[i]);
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
@@ -1342,15 +1341,15 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	return err;
 }
 
-static int push(int nr_spec, const char **specs)
+static int push(struct strvec *specs)
 {
 	struct discovery *heads = discover_refs("git-receive-pack", 1);
 	int ret;
 
 	if (heads->proto_git)
-		ret = push_git(heads, nr_spec, specs);
+		ret = push_git(heads, specs);
 	else
-		ret = push_dav(nr_spec, specs);
+		ret = push_dav(specs);
 	free_discovery(heads);
 	return ret;
 }
@@ -1374,7 +1373,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
 
-	ret = push(specs.nr, specs.v);
+	ret = push(&specs);
 	printf("\n");
 	fflush(stdout);
 
-- 
2.33.0.998.ga4d44345d43

