Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E88C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiBWRzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbiBWRzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694A63A0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j22so14838370wrb.13
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=aLvLcyOrw3dVD4fgmLkC5kEweHhK05RJtFOkkcwLPxLdKxVRV1HPgSH2/8lcFEPRYi
         rYCov8YsG+zrvIjnBVQviCwPzCnkHKZ0/RczVuRI4UqxQMv2t5yil0VhrHSwoKm/75cL
         XpSvQc2PZlFS9HnSkU5kJELhE53cVnX4eZXZbQOmewecds1rDI3rEBR8Y9jGsh7Leyn1
         FbYQS1yApQpue+Nwyf40eBfg8MoWaVEs2lrPdBLPHalkuY5wwHImiF5HFxiY37BD/uMH
         Vyb3eaejh2HZo9I9TNE6YAW+//gklYaxko0gY0R1RCVsJ0NilefZoJGkP0nu0ksiB/m5
         9dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=ryRbHFbLJH7NGO+Vf2A7d/jyLjzFNDoJPGGRlJpnWrpZ++QbtwFOh6xJPOb6Vpqp1E
         YiudSxpqHNpUaoOUKWISppTBRqSIjOgitZ/pacVquEiQAOG+xM/ZfTl8jIo5HCTxgpGN
         c+Fv3zwRuL3WA1QR8ESd6OUexLVe4zRaoJVDKegPiYj7VZejfFsltT6OGX0EQiYAA5t3
         gS7yJRK+nt3hiltcFzkrVBEh73093dw4Aa0+4jqqekVv2BH9HixiCfoQ2PeOvd6YBFgw
         RfXiN1hDvuJfEjvg1hb0TfGVOJZa7EOVohpcu2u6RzRVhD6dWjA8Twau0IqeuwPVqsRA
         K/0Q==
X-Gm-Message-State: AOAM5338s3HK3PeI6TtrRUZ1DlZwfcOcRWWZZPmRHnRgg6mdxc6kwHzQ
        MJLcm3Y6D+THkJdZhhusuZ0jTJvHL+w=
X-Google-Smtp-Source: ABdhPJyK2tJpKQ92t2somcQfAp+jGq/H4eu0OhPk8gtwX1OOhd6T3KTz1CBXcgh4dmYlgAaTOSEjug==
X-Received: by 2002:a05:6000:1547:b0:1ea:7d56:83e8 with SMTP id 7-20020a056000154700b001ea7d5683e8mr605433wry.404.1645638916437;
        Wed, 23 Feb 2022 09:55:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm240765wrs.1.2022.02.23.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:15 -0800 (PST)
Message-Id: <d5edb193229731edbac9f861ad569885ec2b4405.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:03 +0000
Subject: [PATCH 03/11] pack-objects: use rev.filter when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In builtin/pack-objects.c, we use a 'filter_options' global to populate
the --filter=<X> argument. The previous change created a pointer to a
filter option in 'struct rev_info', so we can use that pointer here as a
start to simplifying some usage of object filters.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..256d9b1798f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
@@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, &s_r_opt);
+	revs.filter = &filter_options;
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(&filter_options, &revs,
+	traverse_commit_list_filtered(revs.filter, &revs,
 				      show_commit, fn_show_object, NULL,
 				      NULL);
 
-- 
gitgitgadget

