Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E03C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469892084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ZM5cNPdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgAPCkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:45 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45759 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCkp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:45 -0500
Received: by mail-qv1-f66.google.com with SMTP id l14so8403592qvu.12
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jF5qhXuIQ8F3Plu3rFjobAzR/ZV2A97vsIsWZCzQ7kM=;
        b=ZM5cNPdu9rO0suGL8GK1T0qROv/LtFk1c4Q3S7pyjtkU1hjyHg19ndzrUQK9ElXnX0
         ApGkhFOiVFc12hxOzyQW2FSBPWJNQgRrEdVYK0S+LZ1zvYXg8WuQFddfwrBoNsRnSf1h
         1E2PjZP1AMeCXyzSlLs/lHZiyfYwZLJ3+rtoJwLHuhK1J9Qp6Ech8GeOfp7y71/HZOti
         Wx5F2OMiu9I5wLvkB8R+6DWUvtckQr3oo21c1bese0hMY2BNqmXfeik13viJeTyYM8m4
         uf2vlWslduXaNG4lu7zBwQEPR6yGAR7BYoGwmycq8pGDHePzIK+VzVgCc3Xrj0QG1y5G
         7NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jF5qhXuIQ8F3Plu3rFjobAzR/ZV2A97vsIsWZCzQ7kM=;
        b=DpkN/zI2DIx0H0IlYDyh/CZjaKAyj3IGPzZaL+yOx7ZZsaouIFJJxTZV421CRYiRsJ
         wlUtCvujWeLJJL+uGV5UKSJoTMcB5NbbIEEZ4Mdfttk2oFf799Zhim0qxswXT/yTGSNQ
         PXINlYuf2AVE/rutu/WRueoXQSRoWp5lD+29nS9HdYA5fUhgbezX8OomRbBZVddDA43V
         HfNPBij0n95wR8qv0WEvBab6sCWO5ITRIbhT4gFtBw6N4niwYU3K07XRsWrU3x3cDWnZ
         LHQlES5F4m63bJmJpj21VVcxVx4LumdwWodF1keod/446HcvdVJ5HTS2jeWNIDQJFZwd
         uYYg==
X-Gm-Message-State: APjAAAVBBi5cghwP87WIgFTocYERxDEcYiNLDkaDyknglUibOfed8S0P
        iDYunaCX0PvxvcGCpj4XD9Sgog8G6FM=
X-Google-Smtp-Source: APXvYqz3bOF1gOVYBcURVhADgFQfTgoKehDTtFjqvyPD128BD1BMryVL8wjOu4aARBr9cyuyJ8AjQg==
X-Received: by 2002:a05:6214:154b:: with SMTP id t11mr447936qvw.175.1579142443999;
        Wed, 15 Jan 2020 18:40:43 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:43 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Matthieu Moy <git@matthieu-moy.fr>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 03/12] grep: fix racy calls in grep_objects()
Date:   Wed, 15 Jan 2020 23:39:51 -0300
Message-Id: <5295c892ee12eb4f8a2fab2cd7e419dc04b18203.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

deref_tag() calls is_promisor_object() and parse_object(), both of which
perform lazy initializations and other thread-unsafe operations. If it
was only called by grep_objects() this wouldn't be a problem as the
latter is only executed by the main thread. However, deref_tag() is also
present in read_object_file()'s call stack. So calling deref_tag() in
grep_objects() without acquiring the grep_read_mutex may incur in a race
condition with object reading operations (such as the ones internally
performed by fill_textconv(), called at fill_textconv_grep()). The same
problem happens with the call to gitmodules_config_oid() which also has
parse_object() in its call stack. Fix that protecting both calls with
the said grep_read_mutex.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 896e7effce..91fc032a32 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -658,13 +658,18 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
+
+		grep_read_lock();
 		real_obj = deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
+		grep_read_unlock();
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
+			grep_read_lock();
 			gitmodules_config_oid(&real_obj->oid);
+			grep_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
 				list->objects[i].path)) {
-- 
2.24.1

