Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18F01F462
	for <e@80x24.org>; Tue, 21 May 2019 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUN76 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 09:59:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37171 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEUN76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 09:59:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so20591686qtp.4
        for <git@vger.kernel.org>; Tue, 21 May 2019 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHb7X4cWwIHpQUPeiijK/av/imXGErm757kJh/gLRdo=;
        b=ud5rqpFcyBIUikGqfu7wclSd6vl4k3f3lq5h/nWXOrVtpi0T74xbUhF5g4W49QwDQ3
         PxKhgOc8zsUPhhf+Tque8QJC3a9VLZqpIqsnAN3DYzdo6meR2wAq5tr3sblMGYTWuyc7
         ki0yxEpwlG9FOaPHYGog6rx3ZqDjewSgxajWP7Oygs3sjJ4vgrSRP4pLqKR7MhdoQ/H4
         /N+S6vetdP8jdzRPbu4kTbSTSh377cLYRBK3Nw/SNlnu2fsrIH2t7+dTR8FSKhjyWUBE
         CKco9rwtqMzSKyz7LyUJ//SsRJl4O4Zg0WEtse22+oSv1mhIttnJ+97+Vydw4gliioUx
         wzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHb7X4cWwIHpQUPeiijK/av/imXGErm757kJh/gLRdo=;
        b=rZjZh4J9YbTekUfjfnvig/Aqj7nONQ77S0U/gvQ8sotNuV5oj8YYta1aGV9P4rpLG4
         WLBLVL7NOjtFMvscZ7RIZAQpnImB9j20sjzLlse3HRujClW0nxz046HWjMWsTBekfQAK
         xgCuOTfWNegTzDJ5ntyo4phA8zOHA8EgYZ5OkaEmNJITdbez8UcPpUHek12s3llbmQBm
         vVCNgsNwWBIg6Jx7xaQbMrfPzLsJIIPJDa2juTbed2TBbj66cKQ7jj7wbrTVjD/U1ET2
         AYldHg2G2rOIoZ6GL87g161oJdOdbsGYndkPsQiTSmsg6EQu7+JN4d6eS1ORrdWdhdpE
         9TdA==
X-Gm-Message-State: APjAAAWEPG/256OmZcnFU2OCJkUVQI4KzUZurYOWMT67XEuU/hk2LB3H
        uZvSVTUTFiLN8hLRqfUODdLzQNim6e4=
X-Google-Smtp-Source: APXvYqzvOa0rZGAZYPNlL5VA7LYL2Ikk0HkBsWbTZ2wme8vahiEfhqcIpNEeYls1hGVWd0ZUUxknAw==
X-Received: by 2002:aed:224e:: with SMTP id o14mr68681883qtc.271.1558447197269;
        Tue, 21 May 2019 06:59:57 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:a800:1010:223e:4c6c:142a:3ad0])
        by smtp.gmail.com with ESMTPSA id c32sm6837891qtd.61.2019.05.21.06.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:59:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, jrnieder@google.com, szeder.dev@gmail.com,
        mh@glandium.org, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/2] revision: keep topo-walk free of unintersting commits
Date:   Tue, 21 May 2019 09:59:53 -0400
Message-Id: <20190521135953.214701-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc1
In-Reply-To: <20190521131438.58394-1-dstolee@microsoft.com>
References: <20190521131438.58394-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When updating the topo-order walk in b454241 (revision.c: generation-based
topo-order algorithm, 2018-11-01), the logic was a huge rewrite of the
walk logic. In that massive change, we accidentally included the
UNINTERESTING commits in expand_topo_walk(). This means that a simple
query like

    git rev-list --topo-order HEAD~1..HEAD

will expand the topo walk for all commits reachable from HEAD, and not
just one commit.

This change should speed up these cases, but there is still a need
for corrected commit-date for some A..B queries.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Sorry for the patch-spam, but I took a moment to check this command
on the Git repo, and was able to reproduce the slowness. That didn't
make sense to me, so I added some log messages to expand_topo_walk()
and notices we were walking the UNINITERESTING commits. This is part
of the reason the new logic is slower for A..B commands, but not the
whole reason.

You'll want this patch as well for a test.

Thanks,
-Stolee

 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index be6ccf5786..621feb9df7 100644
--- a/revision.c
+++ b/revision.c
@@ -3265,6 +3265,9 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 		struct commit *parent = p->item;
 		int *pi;
 
+		if (parent->object.flags & UNINTERESTING)
+			continue;
+
 		if (parse_commit_gently(parent, 1) < 0)
 			continue;
 
-- 
2.22.0.rc1

