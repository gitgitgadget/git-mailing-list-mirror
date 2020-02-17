Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02EC34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC288207FD
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="V07/mCOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgBQOwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:52:46 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:56536 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgBQOwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 09:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1581950679; bh=LCsoJMxvg5kY0wDDYrHHOd/feJFEMbhLj3YkB0VIvJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V07/mCOqoKPJU7VKtc+9FgNdKdkiK3MUe1oOZeNdQe/y/rtE9TUvolrMMedf1Q3yZ
         4OU23Jq4iOQD9hwSZj0fnJz9Yp2aWLj21dgm86wQscQsTLCEy1fTzlyeBtTyEFsjAa
         wW5oSwmvYWu7rm7oVBX+5FoWCKqmKJicQZSa09Qc=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 2/2] send-pack: downgrade push options error to warning
Date:   Mon, 17 Feb 2020 09:44:32 -0500
Message-Id: <20200217144432.43920-2-sir@cmpwn.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217144432.43920-1-sir@cmpwn.com>
References: <20200217144432.43920-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because the receiving end has to explicitly enable
receive.advertisePushOptions, and many servers don't, it doesn't make
sense to set push options globally when half of your pushes are just
going to die.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..8c81825e7d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -439,7 +439,7 @@ int send_pack(struct send_pack_args *args,
 	use_atomic = atomic_supported && args->atomic;
 
 	if (args->push_options && !push_options_supported)
-		die(_("the receiving end does not support push options"));
+		warning(_("the receiving end does not support push options"));
 
 	use_push_options = push_options_supported && args->push_options;
 
-- 
2.25.0

