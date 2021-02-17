Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBCC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE7B64E02
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 14:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhBQO42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 09:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhBQO4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 09:56:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826CC061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:55:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n1so6480399edv.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jq/qpPwjlSepz6Po34xcn2QXiL6QutnqCYaichxQLaM=;
        b=HQz2wm+49OyAjNjh+f5SbiadQyaWEF+B6w7tcbAEghA4FEGwZUrJygiDNxFxnSgeyA
         +jBfNVyiksvEH2TtbPjT+OCPzb8NH16vSp6jpGyw1SX2CdRWWJnyefm1nCLu0dgPEdGv
         cb3KxuHLhroiOPCVW5HPz7D0+WV3k3hs5H+s7bRuWJf06bcJ0bRAQ8VdW/j4J7w/X0eW
         BuNB8caT+FcDjf6kGoCSwVqz3rQfMJWutH8MV7vomUP3Xy/P/1OT0ZLTfP27hnPqZaEC
         6uoMbBtE/vdMsQI4l82uHYtLxg9p9GNh+CInO7up8/qGe1hCinixb5pqJ4XQTVi2t1im
         Xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jq/qpPwjlSepz6Po34xcn2QXiL6QutnqCYaichxQLaM=;
        b=eZrXlvEDJfc4Jr0xz24QEfAqThNa3OEP7KqzjJUkpfiqn68gOoeeWf6v21hv809X2v
         4Np39XVuGHN90rtr0+E1xTYlOYRSsVVdAQf0wgTz1R0F/kPhcf8qZK0bLIXc8gI1K2vl
         ydhqz47iPebEVYUnE7Je1O23Po+h7cd+RvD8vlPzbUs0QyWK3aiKVRsfqznRoUoIRUMP
         zzzlqBVFlHA/ZzcCUcfJqoanEka4sSyp6PFPYKAGyI+V818nJuPt9SosoKIDRf1FiTAn
         pd896OuzA2Vp3pmLS6Rb7bGoTVveJjd+mYx4+Qd39SfTmWncms+o/N+6DRZWlo4qH53L
         kzuA==
X-Gm-Message-State: AOAM532f/lX8YADDUlaxSLFItgTcgUva3968rBUURnEW+dnaZBP2MwkE
        G1KF1ssVxP/avFbFA6Jgz63Qv60nwv+/1+Gi
X-Google-Smtp-Source: ABdhPJwbaMTUIpFxCAW2XtZZZDAeWmkcblJrZKvIjhL9mbMS2w/E8gcsaMWorDxTuxMNFF7x5gxeyA==
X-Received: by 2002:a05:6402:12d6:: with SMTP id k22mr26539462edx.368.1613573739400;
        Wed, 17 Feb 2021 06:55:39 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id t19sm1133092ejc.62.2021.02.17.06.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:55:38 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 1/1] blame: remove unnecessary use of get_commit_info()
Date:   Wed, 17 Feb 2021 15:54:43 +0100
Message-Id: <20210217145443.36764-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.1.850.g2d41e9e789
In-Reply-To: <20210217145443.36764-1-rafaeloliveira.cs@gmail.com>
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
 <20210217145443.36764-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git blame --color-by-age`, the determine_line_heat() is called to
select how to color the output based on the commit's author date.  It
uses the get_commit_info() to parse the information into a `commit_info`
structure, however, this is actually unnecessary because the
determine_line_heat() caller also does the same.

Instead, let's change the determine_line_heat() to take a `commit_info`
structure and remove the internal call to get_commit_info() thus
cleaning up and optimizing the code path.

Enabling Git's trace2 API in order to record the execution time for
every call to determine_line_heat() function:

   + trace2_region_enter("blame", "determine_line_heat", the_repository);
     determine_line_heat(ent, &default_color);
   + trace2_region_enter("blame", "determine_line_heat", the_repository);

Then, running `git blame` for "kernel/fork.c" in linux.git and summing
all the execution time for every call (around 1.3k calls) resulted in
2.6x faster execution (best out 3):

   git built from 328c109303 (The eighth batch, 2021-02-12) = 42ms
   git built from 328c109303 + this change                  = 16ms

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/blame.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index b66e938022..641523ff9a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -425,13 +425,11 @@ static void setup_default_color_by_age(void)
 	parse_color_fields("blue,12 month ago,white,1 month ago,red");
 }
 
-static void determine_line_heat(struct blame_entry *ent, const char **dest_color)
+static void determine_line_heat(struct commit_info *ci, const char **dest_color)
 {
 	int i = 0;
-	struct commit_info ci;
-	get_commit_info(ent->suspect->commit, &ci, 1);
 
-	while (i < colorfield_nr && ci.author_time > colorfield[i].hop)
+	while (i < colorfield_nr && ci->author_time > colorfield[i].hop)
 		i++;
 
 	*dest_color = colorfield[i].col;
@@ -453,7 +451,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	cp = blame_nth_line(sb, ent->lno);
 
 	if (opt & OUTPUT_SHOW_AGE_WITH_COLOR) {
-		determine_line_heat(ent, &default_color);
+		determine_line_heat(&ci, &default_color);
 		color = default_color;
 		reset = GIT_COLOR_RESET;
 	}
-- 
2.30.1.850.g2d41e9e789

