Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9EC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0AB64E90
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhBXTMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbhBXTLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:11:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3974C06178C
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id b24so2232159qtp.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T/TrMmLxVFvCMM3Gy+nsVSLynHsbxrEsNMhxDSmKx94=;
        b=epwRI4st3OTMUlrYR/6TvT0KXDbBCMEvOH/W7c0Qo6YvZughoEBZ5AJeAe3Fgd5fGO
         1Rmbc8ak4l/lqlWkqC9BBeR30dVK8/83dpnJj5LRVSjYb4Nx14rgsdu1Mslo5QZfrcXW
         0PsQzyWSymUp/qVpgXhP0smmO6abKMurgXi/lLrGfNtotBeAgBJkDdgaPZPuicSWZxKH
         wmDWNBVUuZScueDabt/wF9wjeq21Lqiqw4tMuZhfrdE+P1/KRxxrdgQZRpsA0G34r9ry
         fmb72bmIoq4epl33dLutynpf8tRJ3WxTsmlrNiu9w+l+/l/AqvrFmQKF2Kc4NLPqJDRO
         pGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T/TrMmLxVFvCMM3Gy+nsVSLynHsbxrEsNMhxDSmKx94=;
        b=KqHjIr9i+dVod5ObdBA+ynZHi1MSLEFyuiWIN+dNgjL6xMBr6yj8QYGyae4pAn3J6r
         VqrBZzhppSkkOT97ibBiexwZR/tlXwThjuvfRiaZLHJN9Rq+IDhNoxyqiYNNRtEOERGJ
         X0n8UWljI6OB1vprNusQS2uidMBFjL/LqmzPetYT1BwnRJ0hz9vN2yFl3QzvXnFFmyna
         4s1DH+qt6zxBmrjAz1E8nmRv3Iqj2irh3pLwfAYm6+r9sfLa5y7C0UgUWOMw5KgQyK68
         HqaAuedZaI6lXnxUgNtKSLey17QsyYDRLX4HMUgio3G6NVE9+0zGD8OKn7kgosaFv3eE
         a1fg==
X-Gm-Message-State: AOAM531vXg59XmKmPXBpzH3eOgHUgbMEByXKqeltqdg7H8EWs1WSDjOy
        OSefBtBxQfzksWDrTbXRyDmKqS7GPaVKgFUv
X-Google-Smtp-Source: ABdhPJxmc6gUR+fI9y50lMiJ9yl9dE2K9PCdismmOvoH5XypIZ3k3uRl6msvi0Z9gfWNPSASrk1xCA==
X-Received: by 2002:ac8:545:: with SMTP id c5mr30367863qth.296.1614193788674;
        Wed, 24 Feb 2021 11:09:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id k8sm2202406qkk.81.2021.02.24.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:48 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 06/15] builtin/multi-pack-index.c: display usage on
 unrecognized command
Message-ID: <98d9ea0770ea38caaa71c6b9bf234c8bdde2639b.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1614193703.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1614193703.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given a sub-command that it doesn't understand, 'git
multi-pack-index' dies with the following message:

    $ git multi-pack-index bogus
    fatal: unrecognized subcommand: bogus

Instead of 'die()'-ing, we can display the usage text, which is much
more helpful:

    $ git.compile multi-pack-index bogus
    usage: git multi-pack-index [<options>] write
       or: git multi-pack-index [<options>] verify
       or: git multi-pack-index [<options>] expire
       or: git multi-pack-index [<options>] repack [--batch-size=<size>]

	--object-dir <file>   object directory containing set of packfile and pack-index pairs
	--progress            force progress reporting

While we're at it, clean up some duplication between the "no sub-command"
and "unrecognized sub-command" conditionals.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9fdfe168c2..5b05e5ce39 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -153,8 +153,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		opts.object_dir = get_object_directory();
 
 	if (argc == 0)
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
+		goto usage;
 
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
@@ -165,5 +164,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
 	else
-		die(_("unrecognized subcommand: %s"), argv[0]);
+usage:
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
 }
-- 
2.30.0.667.g81c0cbc6fd

