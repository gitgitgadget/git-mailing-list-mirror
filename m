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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0852C433F4
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902586196E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC1NQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhC1NQL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E5C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so10142810wrs.9
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8/ZaRVDenYkZyomOTvSsvbNt712bd4wtm183qMayjo=;
        b=KhnniZRRxNqQSXuM5KZ3CXX0RSHyN912Y4il+VdJuaeF2bBmamA8xKJ4BWdh6EO0I1
         vHnf0JmhAyZzloJ7QIJtUO90Ujf+Kvwy0YoRBIr0hXbROqSjmKpfYhVmhIHJ9EYD97Jw
         U55DtOiLwZHuPbGj37OwNuaaTlMMzv+9t9xG673J+q1wGDl4LTCJsxE8O5Pwi95N89Zz
         CF4A8YCMs/WyouSHswXK8ZxrTAxr/RKS8Mq4bvmQru484jg5cmQFXPKl2LmTePq682vf
         J2ihdIXq3p9LGYJ4r9uV/IJwPaf0CvfN90vVw3t8neQ4iMVnCLgMNoQL3o+i4exH2PuK
         5+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8/ZaRVDenYkZyomOTvSsvbNt712bd4wtm183qMayjo=;
        b=NhlYwJSsfmNpsK5vwUXWJry5ZfmEwjGiGHe/NcSlVQRrcq8tc6A+7RPhe7eKRN1oV7
         MRSiBuG6FWTgqnRjfo8mQsyS3+MxkASltjx0JU40oOzYWhGN0L+fNcvAERB14b4kUJ2j
         +1fq2EKIX7ED3SAQ/4yvGYb79O5lu59kl7q4B5upYnAnlX2x+rBDtX56XcSWAZth0DzS
         waS1bvgXPnhOSv1TXZu7L1KYSLAn0Pp+lFU7LetU+gA2JuZslHq9Dzk/SoPHf4jzZ3Th
         AvR9QmclSeExZgowmKD4jTQdX2fuyw1p2ttaQ+YrQXoxOJyuvGu/eEYmwPCMawAuvNat
         /h4A==
X-Gm-Message-State: AOAM5306N9R9+mXrxOgw0EiL7RzAzt3RR1Vs13VnmiaxN8TpinXfJ7Rx
        oK+oq3WAXARF7GkAHC5Sn6wJ7Gi7+vtDEA==
X-Google-Smtp-Source: ABdhPJzyL8rnm3mqdnbU+ovpXcgzU+gfm1cQGmYr117NIjPFsiq8R4xzy/sOf8KoRV3QpZIcrel1mw==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr23852143wrr.297.1616937369550;
        Sun, 28 Mar 2021 06:16:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 18/19] fetch-pack: use file-scope static struct for fsck_options
Date:   Sun, 28 Mar 2021 15:15:50 +0200
Message-Id: <patch-18.20-581c87c63c6-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
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
index 0f898a5ae14..4ec10a15852 100644
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
2.31.1.445.g087790d4945

