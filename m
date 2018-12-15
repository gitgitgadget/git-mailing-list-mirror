Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EC420A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeLOAKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:08 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38673 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeLOAKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:08 -0500
Received: by mail-pg1-f201.google.com with SMTP id x26so4978696pgc.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aVF32Ohub+dX3Ja3aLdphwGDaYF3GYle5PUNGGrttT8=;
        b=SBjwEVUww1F25FRwuLusU06ZAcXckCJsHdlsIDxdabHVWFaLEaIKomS8iU91Fv3p4H
         nsabsaduLVEkvnqtErhkfBeLR3WJ5DboWaMhDdK8v4bWXbtW3DBjoxE7QQZa4yCIT1oV
         JFvx2NiuQPPa5zeBImuM74NhLOPx4cZsa2ER714KmbSt4o5qP4f3Cstl0NJqBBP3xjAk
         M9BLX5EUwl7v8RvVEyDpXlrFXRMd/eZr8l1aazpwCe4d89mqUze0+c/sR/TPoc7C/BdF
         4MU9ChrRi88WOjW5+L3bifKXmlzatwhCygDBlxyI2hfoUgadRov7eXSQ9KVFrigVTou8
         kIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aVF32Ohub+dX3Ja3aLdphwGDaYF3GYle5PUNGGrttT8=;
        b=jV9ImIRDp05+DWTdqUHwd3AXE7RAxSe7YsOmMOP2kW+ZXIyWp647SGQF7SkjkqErc/
         2jQ6WgnYjPC+dNcU3f5cCGAoYN7LLX421m9rNzCqBq0sUElOKnUT2XeIQQ03po0Tzlhu
         4D/Y6kc7BVZnzSvjCzs4ZeETtuaywYUJtvFtINAL1wuM+mJWOXErD58ZgY0ffNeAEb/+
         FVxptacp/fPePAWA9wgp4mQvL/gGIAvRJkLnlQzKaaG4dmUejNqTamiSRJuzgH3iS3Mm
         PUj3hlf1E48l1D0LWs7RFN3GaVBBQCN4Gk1jbLBsnM5Le/wRdoNv409nH9lW+pfF43BR
         7FGA==
X-Gm-Message-State: AA+aEWaaia0WEZhTVfH9EDs6HPH5Jd/ijG9PxF801Jr63fLXvPrznFaM
        OfORxZLfZhE2hAhF3kV3uXdO1b6BdI8wIMYFdPjXszA0CM90q38pEZkL8I6HQoxWmztBz9pOnxV
        pe3LUzhvIfMspL5oMobtIM4TPmImP6EUMpaEtWxIz5QuHwaetDhZwGcqAEbkT
X-Google-Smtp-Source: AFSGD/UHCUcg2OanqzCZsp/JVEEOwKx9Fxha0n4niFGRD3bJFabh/PndaFRJ5wSRxTUFY1VSD7jhmIuFtFh4
X-Received: by 2002:a62:ae16:: with SMTP id q22mr2720398pff.1.1544832607019;
 Fri, 14 Dec 2018 16:10:07 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:28 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 09/23] commit-reach.c: allow merge_bases_many to handle any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-reach.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 67c2e43d5e..a53b31e6a2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -95,7 +95,9 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	return result;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+static struct commit_list *merge_bases_many(struct repository *r,
+					    struct commit *one, int n,
+					    struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
@@ -110,14 +112,14 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (repo_parse_commit(r, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (repo_parse_commit(r, twos[i]))
 			return NULL;
 	}
 
-	list = paint_down_to_common(the_repository, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -224,7 +226,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(one, n, twos);
+	result = merge_bases_many(the_repository, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
2.20.0.405.gbc1bbc6f85-goog

