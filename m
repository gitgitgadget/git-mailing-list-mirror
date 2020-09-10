Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409B8C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D354D20795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXMyOmcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIJTHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgIJTEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC13C06179A
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s205so9599938lja.7
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a1LPn6RpS2ZYMcSASWXRo5meExpp02Y5LHw0fw9Qe4=;
        b=gXMyOmcNwc9lNRVAeBNh089jadeawpMEcE57tHE9ld3LUULdKi0js53R7lUh7e9nb5
         xOazRBW5gGoNTvE6oWlbEQ/+M59xUCuuZqGEo+IyWvkv35NHIxZpzWMgKd+uoUtJ5H4N
         exQdRpK0zHcguNsEmhFpn+pV7gOJWwYgDWdVHtD+zD02qBNtDZnXh9+69rxz2Q5Meyt1
         QjQgqSfz4KRr2FEW3kNJfidHdLbIWWdlW4WoeExyMeDLTwRQuC1jQn5ISuBLjTBFtPMX
         iXsc+l6AbzYvJij2ePx8lBYY996odJxDjBEOa9w55i1BF4fOP82b5RtaksRP/8vQe4iD
         1K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a1LPn6RpS2ZYMcSASWXRo5meExpp02Y5LHw0fw9Qe4=;
        b=CYAijRoJ7Tos6Sr9STONV0y79dI+4fzJZve0c5jlZmtWSRDVqpeNP9IPrN6RR9blIT
         miazOS83fhK/lIsZFKMhxnkHYWHB2sCUfQd+gJ0i0yqVk1O62z8UayRDpElCCH3yC8kJ
         YNDn8c+3rpDlBSH9vVeqYrKOpm3m2WYMoAc6z4ufUw5p8PCyuc/5I+yLjDDsJTuO80Ff
         kicX56RpLP/nlQk+FhUdnOYSPVxtIO57AcdWYVGEiNSOJhhICZMpOJeR5p07M9dDNWJ2
         Y+oi/JT7Y+nxnwLWTyWx0CON2UzTpCflIBYPosPBlF1KXh819nwzMosMa0pwMuGgIoKP
         eBJQ==
X-Gm-Message-State: AOAM53340jEveKpfTA/M8W4Vpu7uXtDg2tFP4B0E6jHWWohD5pqs26h2
        7JGSiMwCZqylo/YVPb35zhpHmTfNgDo=
X-Google-Smtp-Source: ABdhPJxOCn1AEI+177rbfbgD1PLK+uYix4EtSFYn5dKI07jmADck+FCfZUCKs8SUZr9nTI/zp3zO0g==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr5518177ljn.226.1599764653867;
        Thu, 10 Sep 2020 12:04:13 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] worktree: simplify search for unique worktree
Date:   Thu, 10 Sep 2020 21:03:42 +0200
Message-Id: <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We track the number of worktrees we've found and break out of the loop
early once we hit 2. This is because we're not really interested in the
number of matches -- we just want to make sure that we don't find more
than one worktree that matches the suffix. This can be done just as well
by checking the NULL-ness of the pointer where we collect our
answer-to-be. Drop the redundant `nr_found` variable.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index faac87422c..ac754b88ff 100644
--- a/worktree.c
+++ b/worktree.c
@@ -172,13 +172,13 @@ static struct worktree *find_worktree_by_suffix(struct worktree **list,
 						const char *suffix)
 {
 	struct worktree *found = NULL;
-	int nr_found = 0, suffixlen;
+	int suffixlen;
 
 	suffixlen = strlen(suffix);
 	if (!suffixlen)
 		return NULL;
 
-	for (; *list && nr_found < 2; list++) {
+	for (; *list; list++) {
 		const char	*path	 = (*list)->path;
 		int		 pathlen = strlen(path);
 		int		 start	 = pathlen - suffixlen;
@@ -186,11 +186,12 @@ static struct worktree *find_worktree_by_suffix(struct worktree **list,
 		/* suffix must start at directory boundary */
 		if ((!start || (start > 0 && is_dir_sep(path[start - 1]))) &&
 		    !fspathcmp(suffix, path + start)) {
+			if (found)
+				return NULL;
 			found = *list;
-			nr_found++;
 		}
 	}
-	return nr_found == 1 ? found : NULL;
+	return found;
 }
 
 struct worktree *find_worktree(struct worktree **list,
-- 
2.28.0.277.g9b3c35fffd

