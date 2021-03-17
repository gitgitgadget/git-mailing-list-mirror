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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D59C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1564E64F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhCQSWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhCQSV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40085C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1893290wmj.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3vXHWJ2/Ynpr02hktr7aopm6VP3FNrN5iPVrzOnnFE=;
        b=QFg2NSEzbwprzdpPeoRZtkxyVE9NLBi5clLlramsWhf3efLIo4lXqEo7huSJk3YdCo
         Fpk7S8LmIqq3Qet+/dcPDO6ICBiiSQ6BoGab2pbQPe5xZ1efYRqeFw6o/akb1xTMtv1X
         jR/C/EpAuF2udQv5OeKAURhe6YzjpBwbFUr31oNocEzz/cWdFaZZmUFnn/RDLugCVkWz
         YfN0xgVDA0z37tvkY50clnztL0zkiXDsPmyxrnMzzIK+n7kVMUl5GBSdqyNRhc91NO9h
         l7qLcjLF56elwuThtFPWSVStAs3NdiAH6CF8OGkkdAS6AsXNrEZrqWUnaUN/n5kPu7yZ
         6xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3vXHWJ2/Ynpr02hktr7aopm6VP3FNrN5iPVrzOnnFE=;
        b=TKhsMWN/BSFInEITVI/xi+cOQGt9jxc1qRLsUlwvYzL/LLqrwbysc1RGtmI94o9kZs
         sV6yJsY+u5NCx23uuQx+IPH+gkvdyK0oSGKPFZOJWgCGFNppOVzbX/cvLxNDv9RjMOOe
         EwnPgZdB2AJ2tkbzUXP72pULyf6lBrQKC3HvGO/MynGduqXx8qbzFQHPWCjgo8MRbbYt
         J+VL0tWXi36RKz7RGuJ1LJBIN1fVzj2uiWOxrGFwUhgYWVs9Qb6aVUOMGLp3L//+g/t6
         zpRuDuQNlC8C/OygUZVe7x5zcpNMf0BfErgg9uMNsShxsbLQ74XJA2fE4RCfmKxST8Qv
         8iaw==
X-Gm-Message-State: AOAM532T22oZ3dzXrKHpyir9RQiWrQS8Yduv+D6j+vO07nxkOgbFnp0D
        rAZ6Gr/KDrIlG5Z5dNZe0mmFmBzBUh653Q==
X-Google-Smtp-Source: ABdhPJzvBVecZWTnU3N6vpRR/opb54puJI6G50aawjfdvDEV+lnM5XTVtbv5o3VHBc6YNLvah16bqw==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr100515wmg.87.1616005284724;
        Wed, 17 Mar 2021 11:21:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/19] fetch-pack: use file-scope static struct for fsck_options
Date:   Wed, 17 Mar 2021 19:20:53 +0100
Message-Id: <20210317182054.5986-19-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 5476e1efde (fetch-pack: print and use dangling
.gitmodules, 2021-02-22) so that we use a file-scoped "static struct
fsck_options" instead of defining one in the "fsck_gitmodules_oids()"
function.

We use this pattern in all of
builtin/{fsck,index-pack,mktag,unpack-objects}.c. It's odd to see
fetch-pack be the odd one out. One might think that we're using other
fsck_options structs in fetch-pack, or doing on fsck twice there, but
we're not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 82c3c2c043..229fd8e2c2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,6 +38,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -991,15 +992,14 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 {
 	struct oidset_iter iter;
 	const struct object_id *oid;
-	struct fsck_options fo = FSCK_OPTIONS_STRICT;
 
 	if (!oidset_size(gitmodules_oids))
 		return;
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(&fo, oid);
-	if (fsck_finish(&fo))
+		register_found_gitmodules(&fsck_options, oid);
+	if (fsck_finish(&fsck_options))
 		die("fsck failed");
 }
 
-- 
2.31.0.260.g719c683c1d

