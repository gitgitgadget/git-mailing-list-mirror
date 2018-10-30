Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39A01F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeJaHER (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:17 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:39039 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeJaHER (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:17 -0400
Received: by mail-qt1-f201.google.com with SMTP id c7-v6so14583621qtj.6
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YO3O9ao+a380ah4iINvvvfgfIz8RhV8ESC9cQKn4NoQ=;
        b=hYnqCjHgEev0OqKBr69ttx4Fbu5x8lXWnGqbL78Hp1ukzT56JggCznmQLRzceBEC5I
         70DA06uPd85h2p3PlrfPHqpiV2LUPytE3NnNVjqFKCfgroL6F7UOmZTvR1PbHFSk5ULG
         g+pkid8UhzBtPdEv9tiOCw7cumZCOeBO8fxrpZ7F81rvm9fzx2qjrcwafQHueMOjBzYv
         OsmJfKrlfRcnO/iu0G7pGWzl3TEDobtQgYL1NjrehXcJPQ0CNJKPJlMYSqmmUsLrP5bw
         vh3xp3bXFBSm04ctmi3rNze0XBe0DmMEHPGpw9L+eCBMN25zzu+CkcqiEHbM7zeKP8Xk
         MDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YO3O9ao+a380ah4iINvvvfgfIz8RhV8ESC9cQKn4NoQ=;
        b=Q2zb+kKeLDNg/INfQ6Uio1H7yYlV6XDrBlOU5VHtWr81ub8jCGUJas2IrbCm8KDo+E
         5vVis8iRhsVF5ETtbOHtN4qmTJQQm8LJgu2nBdBGZmGy/ei+vnPNaiYlK3VSw0H+X7+E
         SHYKjF9JbipWBMW8tNH0RH2BpweRUvIQa+23O05wbYenuhw4UYx98ZE6nOmQr29wsIXg
         8bQt3GTk5372nk50Vd2ZgYcqKg5ROWObxoTQRVPiumaJ2ACPD8yBDf51WwhaOx0ZHhSL
         nwG5MAAVRifUrsvVEA/qLO0R9J2lBt0W9hoDft7jFSTfPBtKQlLadW2fPHKFSfkv7V57
         RFmg==
X-Gm-Message-State: AGRZ1gLcNvPsabBvnsSZALxeXEtJGnF/FCizif1VLIWY9e4lmVYtM6rF
        uAnG14wAgU6645LUyZCO9TZjTPRp/+4+E/1pf0pmr9cWZpSR27dclAGUfLA0Tq2K8Om0Dab3gQY
        PNjomuwvU2JVMOcvkNBghBtC63Y7sNRUseHf448vrcf03odGrrIevigHpOOf4
X-Google-Smtp-Source: AJdET5eDd3McvFQ6/2CAi3ZU7veFbSrqc3xf3v+In2D61IJ7w3oEBvqT8KmR+XF+3k1Cxl/wdZP4zAmRKXmN
X-Received: by 2002:ac8:6b82:: with SMTP id z2-v6mr443072qts.11.1540937342020;
 Tue, 30 Oct 2018 15:09:02 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:05 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-13-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 12/24] commit-reach.c: allow get_merge_bases_many_0 to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index ab2bb1e5d5..bf7a513991 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -216,7 +216,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -226,7 +227,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -249,7 +250,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -261,19 +262,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.19.1.930.g4563a0d9d0-goog

