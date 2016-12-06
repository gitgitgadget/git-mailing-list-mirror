Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505831FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcLFVxm (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:42 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34007 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so153559665pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KObSeXazQBnXuzO4nEXtor9m2WZuR+rOGwCyd2w4UYk=;
        b=e0cwK1IFoMjqAne8pq5J2+h4VdtJbLdQOeqxr00JkS5mDqdAuik6NUWSzWuCKVMcnS
         9FLRCFPYlnj//tK2yhD9xCbHDIfQ15DPbDe6aK6WvuA81mpmwVfOVIv4AG50C10uF72o
         F0TeYD1lC1GWCZonUIzyEdCArHzzw7KQ+NtXUt5m9/NBB4uT/eYEhJwsY6nmDmyuwr26
         +06qu0ThZ4TnFq8TpoCPl2zAQVTnlSK7Q+ydwh2PzS891gj+QBxeq6JXC4u6VMuegd9D
         bhCQY5ytk/D+ZFYKBIdoflba3BRhvgKt7WBnGlRo61aC9/n3Ur93+Ffpdju/icZ35q4a
         EjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KObSeXazQBnXuzO4nEXtor9m2WZuR+rOGwCyd2w4UYk=;
        b=afix0CkIIcVYlU+oTf6ZFrq3DxQC9SsoO+gaN8+Mm04pz7vCdj24QohnGYddR45gxK
         XlbtWefoX4dPHQyHscybse4hEfs7JkHr+/L4iPq14CmlqzU+4hFTC2kI7ROhVl68xA3s
         M9V4kvm+NhmEYq4NfoaZZglrTK6B2HtrMefF/cNnKhRpctzC7q99yVKli7Mrz1JqNCQt
         fuOPwEX3fUhpMfdV0sPOm/DCFlOfPA910LWX6KemOfZyTsslcth8/jMQSqMEh3yDkAlG
         pQY7Af9wqZztwQn4EsDGsB1jopMxUaMOPcyc4+9yBqurFfboTbuLmgGdHidZJGP+k6W5
         a5xg==
X-Gm-Message-State: AKaTC02uPvuDVxCMRapeNVm+WfsBc4S7AmKaBj9/ZqYljQvuK0YjKYRCh3443jpxaz6GLjpS
X-Received: by 10.99.113.68 with SMTP id b4mr117064077pgn.33.1481061146417;
        Tue, 06 Dec 2016 13:52:26 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:25 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/17] mv: small code cleanup
Date:   Tue,  6 Dec 2016 13:51:36 -0800
Message-Id: <1481061106-117775-8-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the call to 'parse_pathspec()' doesn't modify the passed in
const char **array there isn't a need to duplicate the pathspec element
prior to freeing the intermediate strings.  This small cleanup just
makes the code a bit easier to read.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/mv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 4df4a12..b7cceb6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -56,9 +56,8 @@ static const char **internal_copy_pathspec(const char *prefix,
 
 	/* Copy the pathspec and free the old intermediate strings */
 	for (i = 0; i < count; i++) {
-		const char *match = xstrdup(ps.items[i].match);
 		free((char *) result[i]);
-		result[i] = match;
+		result[i] = xstrdup(ps.items[i].match);
 	}
 
 	clear_pathspec(&ps);
-- 
2.8.0.rc3.226.g39d4020

