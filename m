Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCAC1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfISVri (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43908 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404909AbfISVre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so4656327wrx.10
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ao+NzFwXmcpY6jPLn7a0cyEdMrOBU/3Xt6HN24ZPmDg=;
        b=ovqp2pI1+oZBbpXiGh6mrsHK9/hulLw+XrSjZLKDmBDF6LtCsqjjK561rJ2BjzcxoN
         WqQ7FnnKGrZNu8ovaJdIS7JoHOgvs4xD87rXEuKaWxapu1x4MAkKGaMxl4habfj3zCMd
         gXOPcA8vlFy6gpP6XC1T58G1weUNhd+3+OXlj0p/tj0Qw+hhVSrnhiE20HzjXmWcAhoz
         0+SyERDpSOXpctg6OepDjtMPTUWkeUN0T9jePPC0xr2+1K1oxhNDwIRx+MJEtyWqV+hJ
         CImQnlkgCOPHcsIG8GJcKb6dI5kOEHko9MKVVD/2J2bzVzDQct4OoYryphBmUBlqwOZQ
         MVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ao+NzFwXmcpY6jPLn7a0cyEdMrOBU/3Xt6HN24ZPmDg=;
        b=e9elsl0uWrHxS1B2a7tjXlQZgmTF1DdSYKApqBnJZ8bNuaK9veQb0hpX/Cxt4kJxrI
         zCBPZokBY9I1GY91lnHywrgL8b1uQhwk9y2OwDvD2iWMAQ0AsH34HT+yBv+c65PE+USw
         1fbYSEPdO0feLVAWj2zjsFljMfT+ddfDYKNaLzKWkzJ1i6qRIFiXmHCmCnsAtU8/yxsf
         w5kRu6tVJP2lIm+hvvGHT6iJ87pIjyg9wbQfki90PMJQNGK8gXt/2gSmY5uY/OxHg4pT
         bbVIhJsd7u2Y7woRkhiyd0f+wwHzXSxpZfWewFKJ8O18dngB+9W9i/rxoEQz5ecpWtIL
         h7Fg==
X-Gm-Message-State: APjAAAVGgSIpTuspzVtcXkC3nRapAOIh4wuTy1GUFaFtDROM5kJ1FcC/
        XWJbOYstt63ksRjA2O4nnbqtBfNa
X-Google-Smtp-Source: APXvYqy5zu6yOlADAH9thmHChbsV2NRNwDlhEZoLBW1fwpKsmihVK8nVnP1ro5wrIR532+i3zWfD0A==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr8830095wrw.237.1568929653232;
        Thu, 19 Sep 2019 14:47:33 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 13/15] name-rev: cleanup name_ref()
Date:   Thu, 19 Sep 2019 23:47:08 +0200
Message-Id: <20190919214712.7348-14-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier patches in this series moved a couple of conditions from the
recursive name_rev() function into its caller name_ref(), for no other
reason than to make eliminating the recursion a bit easier to follow.

Since the previous patch name_rev() is not recursive anymore, so let's
move all those conditions back into name_rev().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b6fa495340..e202835129 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -102,9 +102,23 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *start_commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int from_tag)
+		int from_tag, int deref)
 {
 	struct commit_list *list = NULL;
+	char *to_free = NULL;
+
+	parse_commit(start_commit);
+	if (start_commit->date < cutoff)
+		return;
+
+	if (deref)
+		tip_name = to_free = xstrfmt("%s^0", tip_name);
+
+	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
+				   from_tag)) {
+		free(to_free);
+		return;
+	}
 
 	commit_list_insert(start_commit, &list);
 
@@ -291,20 +305,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (commit->date >= cutoff) {
-			const char *tip_name;
-			char *to_free = NULL;
-			if (deref)
-				tip_name = to_free = xstrfmt("%s^0", path);
-			else
-				tip_name = xstrdup(path);
-			if (create_or_update_name(commit, tip_name, taggerdate,
-						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate,
-					 from_tag);
-			else
-				free(to_free);
-		}
+		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
 	}
 	return 0;
 }
-- 
2.23.0.331.g4e51dcdf11

