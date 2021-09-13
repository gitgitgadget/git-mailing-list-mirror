Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86A0C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFAE610A8
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbhIMPrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244807AbhIMPqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED750C0A889B
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y132so6944102wmc.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NzPFbNI5mqavLRsRCxjdW4h17gl29AKfsozAHlpo1Wc=;
        b=VPErcNxtJkWNbaUWEOgODTnt/OnXyfThi+RL7lh8SqsDhGgt/dTkyr9Yd4c08Qx4nu
         0XuQi2UTmabg296+UYOXe7adwpqWRqTl5wCM4wusmGJ482by26pPIPEYD7oZCi/Vnh//
         +5BDrYbc0RY7QozJ5BMWUaZl7KFmZdVZKpQgV9qPEW4CUpeiSOL4RTX3Var8YfWLkDh4
         9tU9fAtTUPBQQmkc1LmN5x/u/cWDAVHPYm6AwvrWsLCwBHJMD5CtM0Y+gmDWbBpWpeJP
         aqPXRhLi2wBNoDdn4dJOvPnYPCT7hpSKYy9eg75ySu6kwLV7kUwZybX8IsMitqHXmZEO
         Ip9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NzPFbNI5mqavLRsRCxjdW4h17gl29AKfsozAHlpo1Wc=;
        b=cMS1XOjYhczDnFrH3fOURLM9picjT/pFkx2Du3ifOEvkS9/ORGQDw1xV+TZgzAR81u
         ZPWsoJAw/O2He3qx0Tr+r7U/Oo/OJwtVTrb6lXACf2SVRJy/oNeTuPZGMBXaTQRIR82m
         zkJQ60xBwAQQPGUyB4iEw6UEvQG04g9GhexO59Lp+ELTWudURzmGKDTb0Bm+lWr8+r4b
         +Y5eOhRNFPlXYa2R2ElwE7bb/oqf+bJ+n1KuM/+YrUes+7A7jUZ1k2LFPE8gvHUUb+DA
         PELiZ30RxCvzAEAMqxfbC1O8+cJN4MvG6+RiZWPzaX7zudmhqQoohESUSSC9Lh8VWeBg
         rp3A==
X-Gm-Message-State: AOAM5337If1ysgewmWhVFnyln6QFDLa20vC9B9MNPpZnTFP6cURdakWq
        pM0zaOFaOPuF72ZiOtnHIC676pTqWDM=
X-Google-Smtp-Source: ABdhPJxHrVy8uSjWgllGiOsR3nxvtBvrpRuxOuEtcstUIdEi+ryOqXGDC1eST2y8/Ub3bsPC86S61Q==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr6216056wmf.177.1631546373668;
        Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23sm7129556wmo.14.2021.09.13.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Message-Id: <bc103e703e80072733859315c0ada3b154e30b71.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:21 +0000
Subject: [PATCH v2 10/11] rebase: use lookup_commit_reference_by_name()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index 7905672d8de..74663208468 100644
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

