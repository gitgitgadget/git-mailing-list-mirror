Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE0D1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069AbcG1QDP (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34572 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759041AbcG1QDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so11845958wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4Ks++OPcezjn9rGEfb4eVvAV3EhukwfnccteyGQ8YI=;
        b=DN5K/ylyRr0m6duqtpS+RMMM7Y3R2uPVCBbIPM9FMGRe1HjDCBUlgxWQ2F+KLQQBFa
         1SAOjn5BAGqj/aplTzP4+ClgY53nFotiHpk35axkFa/7/OohsaqI0t3HxKqHXU2FLnpy
         +Bcv18+kWntmY4mbIyDHjty4mgVx+i+D+85EjpsGZZD0TTMlspWk6bfb0mUT+0LDYcJd
         Dolesr3p6FL93TQ4zg/3Ra9Tv0cwNZwWGRo5fAHn7TdI+zYuWK9gpg4nUapgAiUMbeWD
         V0ZWKgqpjKJmU8wCUHbqilSUhSUZV3CfQ73Trv9J8TrIUzpEoi+1ggWcYMusv37UQQBW
         hAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4Ks++OPcezjn9rGEfb4eVvAV3EhukwfnccteyGQ8YI=;
        b=OcMBCv4zdc8CBurgWT3n6sRoHY4pvLmC0neMwelb5T5QSXytpQmt1hIHK89hUeqh9m
         sjGn5whxFLBwBM4WdVNq+sebgbNEjc0zm64nlCze+nYq5BrQHMrwDl5MV8MH0I30cBDX
         PeFB6SgGyAK/ZwQxkUYkpFVXAhkojZl8rJz8AlfjFsjFdXBncWeIt4okA8mtF4Vr02t2
         075IDfHkAx8dCE9UmcCj1Vmw+gopa2zCTIlR3ZVcjdwXoA5iBKkByYfIwtGBNBgGNNEj
         5LKCTrZYwcB/T30n2S8g6U5gaHFTwjILhk9mYlg/y9rAfnWJwDYLqzNqzGP1CMz1EkMP
         az2A==
X-Gm-Message-State: AEkooutXgYlEBtrq/pjfFuCICd5BmgOJW16KazAh7YtdzcsslOrledviEoG+0ENeilT5FA==
X-Received: by 10.194.77.174 with SMTP id t14mr36801369wjw.146.1469721787696;
        Thu, 28 Jul 2016 09:03:07 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:06 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 3/7] Skip checking integrity of files ignored by sparse
Date:	Thu, 28 Jul 2016 18:02:22 +0200
Message-Id: <20160728160226.24018-4-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

(this might be wrong, not sure if this is the right place)

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 cache-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index f28b1f4..ab01ae5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -354,7 +354,8 @@ static int update_one(struct cache_tree *it,
 			entlen = pathlen - baselen;
 			i++;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+		if (!ce_skip_worktree(ce) && mode != S_IFGITLINK
+				&& !missing_ok && !has_sha1_file(sha1)) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
-- 
2.9.1.283.g3ca5b4c.dirty

