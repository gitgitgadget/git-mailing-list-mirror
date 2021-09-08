Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3543AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8DF61102
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbhIHJvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349291AbhIHJuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F1C0617AE
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so1042435wms.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5yx1dMb0hK9A0DBcrgI3wIjtDeekFCHuqBloKxfazTQ=;
        b=puqeDv7OPw4NHFlWabUbK7qZ74OwS8qX/3grRTKDOevWG8O2OQFPhlLoBaaSgSSpFW
         w5WkmDWNRD5G52fcDfPYod1Axd38PDHAQwQ62L0K5/LC7AbzWm2c8SK12xJDvEMHkiwm
         DDyLZqTwGMojVIoZiAGyeBahlpvVt8ng93RoF2FRfEb0RWYqyVizqAsN2QaRnK7ZhVKa
         8i88vDbIrPQuaoYb7GP2AXMlfd+1F/fXYq8oL7mjOfatKAyOpA9mQsS0uMNHgGRbJecA
         YWQsk8KSZQ8lS+Nwro7DS20daUFmHoRqQvBjYpC0e7yGp3zNktCcKPZ5Tj6eUkJSUNDz
         d4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5yx1dMb0hK9A0DBcrgI3wIjtDeekFCHuqBloKxfazTQ=;
        b=COA6mRpz6hnaUO6G+ZWyY7QetNbG6QOVoCP8aojPfLTzaVdhMOlMX0D/DdR4VOJcH9
         y+ZcFo2dGuG0aGiqUa3kK5DKox0DvhTGeParFyWe//BvZNnRjFnsRHXEjleekKcUoJGo
         E/q9K57pHzPHpxp8eaWwcH/ltNYNz/ZZ8V8JiVlLYZmBm5Rp2EH5Bnv0SvgnUxfKG8YR
         BUtsivET4sbsWU2dhu1LFLHuBKNIuxTX7/Hdt9UpMpONRaezSdQ8j+MrEQn0m5/nqFk2
         ITplq4xc68TSz0IxJElpOBJ4GmCRw0abxWj7YSbuS0imZgCI8Yl/GrSTqNrhts7qWcWU
         0gxA==
X-Gm-Message-State: AOAM5334UN07nRBeGxT3aE3eBUeKwpVOdAi+chcVSQvGcy3o/0LRvNDv
        WtKA9+p/2H1eD/tLXGm7WrR8xFuDErg=
X-Google-Smtp-Source: ABdhPJwpKXcwN+lAjFNtaXyeNjR3DRbJSdHQAlh57ClUMgKMwbXfHxRyLjPxU8XHyernS8/2vypNBQ==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr2717162wmj.26.1631094569624;
        Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm1516797wmc.22.2021.09.08.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
Message-Id: <c537897006c7f9ab61b965f4d0b2dae30c0c7efe.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:21 +0000
Subject: [PATCH 10/11] rebase: use lookup_commit_reference_by_name()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

peel_committish() appears to have been copied from the scripted rebase
but it duplicates the functionality of
lookup_commit_reference_by_name() so lets use that instead.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e8c3c77bab0..93fcc0df2ad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -762,17 +762,6 @@ static int finish_rebase(struct rebase_options *opts)
 	return ret;
 }
 
-static struct commit *peel_committish(const char *name)
-{
-	struct object *obj;
-	struct object_id oid;
-
-	if (get_oid(name, &oid))
-		return NULL;
-	obj = parse_object(the_repository, &oid);
-	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
-}
-
 static void add_var(struct strbuf *buf, const char *name, const char *value)
 {
 	if (!value)
@@ -1844,7 +1833,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (!strcmp(options.upstream_name, "-"))
 				options.upstream_name = "@{-1}";
 		}
-		options.upstream = peel_committish(options.upstream_name);
+		options.upstream =
+			lookup_commit_reference_by_name(options.upstream_name);
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
 		options.upstream_arg = options.upstream_name;
@@ -1887,7 +1877,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.onto = lookup_commit_or_die(&merge_base,
 						    options.onto_name);
 	} else {
-		options.onto = peel_committish(options.onto_name);
+		options.onto =
+			lookup_commit_reference_by_name(options.onto_name);
 		if (!options.onto)
 			die(_("Does not point to a valid commit '%s'"),
 				options.onto_name);
-- 
gitgitgadget

