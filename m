Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2221F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBFA2l (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:28:41 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34332 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBFA2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:28:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so192401pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/JOTmRCZ6fVHXVJJD452iUxKjHoiJ/ihiCfHk6aBBk4=;
        b=FgR0YseXeOZ1Te70UEtFh0buFMcR5zwAwX6uFtSn1QEI524RadXZ2x6i+L85DrGjus
         xzwmloqrSZUj1c2trqcdw54/23GcReZcJhNNdoWYJmlT53PiLwzVYZnIuNmLNbjK6clm
         0Wkn5oLV9xDr7A0abIsSR2mc64LBFtuIazayjkrrPOgkfR2X6Nui/H85fCpEZ4py6gjS
         hj5Osgp9cdIE7rwqoiIosos9E8ZRxhVr/J00E/gxJLXJzPkYClZ4tkUy4u4vzNQaO+dy
         hheRzAyAvoH35ZGxObwcPFHCSsT6qlu4zeJI0D0eGiDQQ5/ZLK2EvKJu3Z2o9Em4C2bw
         XviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/JOTmRCZ6fVHXVJJD452iUxKjHoiJ/ihiCfHk6aBBk4=;
        b=BeUEILUU+sU/rs0iSWqQcURwrz06KC1pTmleMt3/PlTkZRXjGwUN9t8tSt0HZMa8C9
         Igpk0e3iaQAZmUy36ivOimNY6xjHaVhp5tjmE41NBnloR3zavKmretjLxSTByWmbiYoV
         GJxuJQQS1zZw7NdqvFS7zvg/wpln+oZvo+SX2XH5CyG995nrkzRSt+/SLbXMS2LypME3
         G7JmN/skjgPVExBMpjhtIWhNludE624BM//TLsUIVEYH8cy/9UOgzznUOyxyaht2aJ0f
         7JspnDKnOR9xb/4Yn/pqJp5yfqAfDQZ4ccBF4ZEFAUYrtRiIKjomh3WRYcoYiV8fdI/e
         0pLg==
X-Gm-Message-State: APf1xPAZcH0QD7KxOVzUFvXD45+4vPqtiM1/DpHVCjlTiSDKyqxhKMGP
        kQOyCP98KqKhRtdmOM2Bx41vzckZtFY=
X-Google-Smtp-Source: AH8x227LdZZjZDDJSNamXL3zKL/ISwFuBkbEHtYdciATusx5UAkOtKDb5LLaCLNKu0Q0yAP4C+VL/A==
X-Received: by 10.99.126.73 with SMTP id o9mr449168pgn.429.1517876916037;
        Mon, 05 Feb 2018 16:28:36 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b6sm18556371pfe.85.2018.02.05.16.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:28:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 167/194] commit: allow merge_bases_many to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:22 -0800
Message-Id: <20180206001749.218943-69-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 5454bb5e11..b01352f54a 100644
--- a/commit.c
+++ b/commit.c
@@ -854,8 +854,7 @@ static struct commit_list *paint_down_to_common(struct repository *r, struct com
 	return result;
 }
 
-#define merge_bases_many(r, o, n, t) merge_bases_many_##r(o, n, t)
-static struct commit_list *merge_bases_many_the_repository(struct commit *one, int n, struct commit **twos)
+static struct commit_list *merge_bases_many(struct repository *r, struct commit *one, int n, struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -870,14 +869,14 @@ static struct commit_list *merge_bases_many_the_repository(struct commit *one, i
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(the_repository, one))
+	if (parse_commit(r, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(the_repository, twos[i]))
+		if (parse_commit(r, twos[i]))
 			return NULL;
 	}
 
-	list = paint_down_to_common(the_repository, one, n, twos);
+	list = paint_down_to_common(r, one, n, twos);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
-- 
2.15.1.433.g936d1b9894.dirty

