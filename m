Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFAC1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeFLRx5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:53:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41234 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbeFLRx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:53:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so12488817pff.8
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhKRUWq6W5tmr0WvzxXRZadNWxn+eD3picOXrpYsOWE=;
        b=r9I7YKTAU1KAVy0RfDZdfJ8EJJp8Od/OO09xi7MKyZUG1odNBp1n9Ot0byCP/TzFAb
         PcQYSKMt8bS/huvditR5/XYloadpU4skbYAtLtenPOukpBGW7iLMyRWoXVMea8Vrle/t
         YJ1LXawtrMdDaN/bZSwPGXmVGr6UUMDz0T2KboSHmDYWqTZl1IHIJ3Leky1w/Mzd8M9f
         BfTrNz75QZHc3ztIKnEp63r8pS18/dPzSLaDOanMKhYmM0DIpF2RD9V50sXkRbSUPj+l
         kvzEPRe7HBotyfoCzASgM5I5zMzK0jLeGhviJTa8j799YqH++NXe2X/nGMRvvcbcico0
         Af2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhKRUWq6W5tmr0WvzxXRZadNWxn+eD3picOXrpYsOWE=;
        b=RatEa23LbeeZt0FuE65XZNtedXOfCe37tQ7VTfW37n2d1xvVlzEmtTFWesMtXfPkXk
         fS63mAQCtYQHxR3K/4nSLlRboQy3kDvk+VX7m3BjGejAsS1+9G5UNB579X3cLz65OzoW
         cvrFN4GFGz0KgBRUWY2le5KI2Yjfv0gIPMuKZk5e5kdW6R4jFzidVPP4W+i+upMzm6yc
         w0RK/ctpvoa30uDvUSjIdU+8GAwpGKYYlNE/V7psQu5PpEHWv4d9M4qlfYXCP9R9vN8w
         n4H9ol7AmhVqMolwj2zIfjPXKXDu2kMeW3J4iG9O0qE/fxUofB60vAIfA0igif0OTggu
         NRzQ==
X-Gm-Message-State: APt69E1g5OfQj/d5I220Fv4zcCDn+BL7F/uDcIEW3H7OPvvBr1aJj6Jv
        bPtvGU7EbIg/orsLe12ga+Z22w==
X-Google-Smtp-Source: ADUXVKKp8gBRhsiX4fpdRzPYFjy4B2LgZQjkIzM7WarzaFdrxTx/w1FhpUKtC+NyBYonzY/Zmv4J1A==
X-Received: by 2002:a63:107:: with SMTP id 7-v6mr1155715pgb.289.1528826035437;
        Tue, 12 Jun 2018 10:53:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w19-v6sm660074pgv.59.2018.06.12.10.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 10:53:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, masayasuzuki@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/send-pack: report gpg config errors
Date:   Tue, 12 Jun 2018 10:53:44 -0700
Message-Id: <20180612175344.65466-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any caller except of git_gpg_config() except the one in send_pack_config()
handles the return value of git_gpg_config(). Also handle the return value
there.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Makes sense.  I wonder if this was deliberate

There was no need for other configuration to be loaded and signing
pushes is the first that needs repository configuration.

Looking at 68c757f2199 (push: add a config option push.gpgSign for default
signed pushes, 2015-08-19) further, maybe we want to also have this?

Thanks,
Stefan

 builtin/send-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4923b1058c6..b54a0cae878 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -101,7 +101,8 @@ static void print_helper_status(struct ref *ref)
 
 static int send_pack_config(const char *k, const char *v, void *cb)
 {
-	git_gpg_config(k, v, NULL);
+	if (git_gpg_config(k, v, NULL) < 0)
+		return -1;
 
 	if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
-- 
2.18.0.rc1.244.gcf134e6275-goog

