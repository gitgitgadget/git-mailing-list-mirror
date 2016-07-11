Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC112018F
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbcGKRXd (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33819 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcGKRXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id w75so16416484wmd.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Nk99pcWgH4YcsneWjsBfa0kzeyelvpoz8dMj8x+/4M=;
        b=izV2PBudbVvCUdWgISwutvErKC9JHhaeg+EMbZkIzKZOj1LjD1R1qDbXxJ483oWRbo
         xODgyxhujvw6JOjIGXPRKQEHsQked+CCgXcKN4sLPuzjsxlWgSCnBrlrJtdpmQDUcebB
         hfFGTjmEVeUdCT/5X7/RTXt64UtmcnixlgmYW/BNrbDIT5UhCXE+QEV/zu0ErBWH7rYU
         csNEE6R35M9/JoArxBlWmWF5QfeiJjeVCNbjmK3xwO4O/jyyImcjzJTm/WHC0FzOQPU2
         NFoT0xBWzfqY34WoT9oLV7V52Yzr/XwXYtsr7Q125+tENVub5MFJ6PzZLpSEOqqVm7sq
         hSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Nk99pcWgH4YcsneWjsBfa0kzeyelvpoz8dMj8x+/4M=;
        b=fiPdPmb50VNlGpPyO4ty7Q985y6GWb+N1mKgKMKUK+DX5OcvMF3Um6erPjCFy77M/+
         1KFG6LSqNvzI8IybohrCB/jV/ef5/9A6+owN7XPlhVwXUslPmNfPiJlwcpqKcdeAW/40
         itaSnORzFQiicX0LRGMMIXw8L7lmeXkiOX9t7SvlYJ/HFwPlW0M25U8LPX4xJkRaeaAF
         Yy0XE+7qhfjAxaXXrqKZbbnWaRIBex7plgQOGV7UFtAZqBL8CjBHsufLzQxiNCICHYjU
         ic4hDpN8ERfr1bdGOqnDtQODicw57o0yIZFQMlbDzWiBkg0uvKOqdeR8gZENIqAoNa+N
         KDYg==
X-Gm-Message-State: ALyK8tIP/ALYyDe4rK/Xoi7zP3LfWnzt7+WwyY2188sm44wSmhfAmXXSvgwzk1nIJ0CGmw==
X-Received: by 10.194.173.39 with SMTP id bh7mr933525wjc.178.1468257803052;
        Mon, 11 Jul 2016 10:23:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:22 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/8] update-index: warn in case of split-index incoherency
Date:	Mon, 11 Jul 2016 19:22:50 +0200
Message-Id: <20160711172254.13439-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f06fe80..2b8aaa6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1108,10 +1108,19 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (split_index > 0)
+	if (split_index > 0) {
+		if (git_config_get_split_index() == 0)
+			warning("core.splitIndex is set to false; "
+				"remove or change it, if you really want to "
+				"enable split index");
 		add_split_index(&the_index);
-	else if (!split_index && the_index.split_index)
+	} else if (!split_index && the_index.split_index) {
+		if (git_config_get_split_index() == 1)
+			warning("core.splitIndex is set to true; "
+				"remove or change it, if you really want to "
+				"disable split index");
 		remove_split_index(&the_index);
+	}
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
-- 
2.9.0.250.g7087ccc.dirty

