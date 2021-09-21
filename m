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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCDC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3466C6109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhIUKZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhIUKZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A267C061768
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so37589751wrq.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o8Zaf1nThnc5LF1zdesE20+QA3iC6u4UKAc14B35Afw=;
        b=AhsfTpQF0vhVqybjwOQBek95QULPEVJ3RC6MET87YnhE6M0IUNCassmpMZyohLDhrt
         +prqz0lMfp/3zpPKMLjzNMSAfOjkL9jTYB14Om5Tz1Z1axnhvDm3pkWoUyHPIBeTgR2T
         KURNicJQDnV3ql0MX0FSWiQHHvBZSDc1SNjoXhm7BTyTElY38nqt5kyPltPtM2CHHlV+
         Tfhm6tDE5w5xswGH4NiG0jRUV+jLvnqddRelx2n4wDo5SOQdn306mBEtRueKYhO+trOT
         7mS0/7FRMCHG8BCS4KZ3S51g8zuqQH/OBKKHd1mU3agc3LfpHFXWL47zrSUvny2FUrjy
         Sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o8Zaf1nThnc5LF1zdesE20+QA3iC6u4UKAc14B35Afw=;
        b=5aXffgdphioXRVkH2hrbyga2Z8zXuXETOp+ksKmcYRIiMyNy/83SO20gYi/usYZeo8
         Nn+CoeaeQFXeZZBwRXx/lbvVwOg094gHr6c2mbRgLGAnofblOsYT5gkS7S3myq6STzuU
         7PYpN9moXTr8op0/vwiq+oM6KEKE6PsVY4U2JZnqiDr/HpDky8K7KUIYWX4qP49+8aEk
         JF4UAapCfp05GYNRShA7VoKsZVIwCwq++ry6t7bduJMQpzNUvnFYuRangwKvRo5XVPnm
         KqaQ6Bx74xv9BaD/z3Emz2kg7T6em75JK+AIYx+B9+xgzXhZ3zMPh3Qyek3LmnlRnDSL
         wmEg==
X-Gm-Message-State: AOAM531V7QA/yw6LbWdX5qQ5Op+fz+Of2tQgLD1GiLL+R3JcAhhd08H8
        QQZW5cHD7BW5iqhb4Q8ks6OaE07tXqQ=
X-Google-Smtp-Source: ABdhPJyjZ5EOisoBojqLK5Arvo8MfCr0PPxS8psLVXtvLnIMrrRViys3krswmgphEHIj10ThiDSUbw==
X-Received: by 2002:a05:600c:350f:: with SMTP id h15mr3648354wmq.123.1632219855353;
        Tue, 21 Sep 2021 03:24:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm19986819wrd.59.2021.09.21.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:15 -0700 (PDT)
Message-Id: <4eedd3ae76614df5ac450a0cd901b05ea2e85c6d.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:06 +0000
Subject: [PATCH v3 09/10] rebase: use lookup_commit_reference_by_name()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
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
index 444e169ef74..0ace9e0a8ec 100644
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
@@ -1845,7 +1834,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (!strcmp(options.upstream_name, "-"))
 				options.upstream_name = "@{-1}";
 		}
-		options.upstream = peel_committish(options.upstream_name);
+		options.upstream =
+			lookup_commit_reference_by_name(options.upstream_name);
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
 		options.upstream_arg = options.upstream_name;
@@ -1888,7 +1878,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

