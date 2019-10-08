Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E6B1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 18:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJHShn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 14:37:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42530 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHShn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 14:37:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id d1so11336434plj.9
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WUXh4hBqoIPXL5AfRT19yRmW4eW7b8gJ3wAfTfgxyJ8=;
        b=B9hTkiPZHfKLBkdNRnNfZu5e2zYm4P8ZYAMcNXM0V2lPncFt0h7PjjLZ4bmDqVdIMW
         uA81COaSn2ZxtwT5oNyTs0hPY5R8nkc7dWLzXcz2VuvdkcNjzj48ZdeHkRydefp8GFTG
         2f8rZ9yH13tXE+ONWBVyG+yklBEPE6c4spXwBLd/flN5AuBZ+tMLNfc4oshm81M3w9Be
         9MAYjbuCqRnVlwJa25nEeifrQ4BmFomKXjEFu9BMz594wPaRAjrFYTghxsrE1bur7/+4
         Ki0KmToXmlfQ4t8MtSJTIBUHx2tlnzWttNryPvB/xVja7AI5lhCbH18Xli+4ML2Hz0ER
         OXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WUXh4hBqoIPXL5AfRT19yRmW4eW7b8gJ3wAfTfgxyJ8=;
        b=F/mYkGeYf1QaFe3jlLRYRXvIc8w9nelgE83ioci9lWyVysTXN6+9YwiBlsgQFcttZ/
         3s3WQjDOMiLKJ5DzY2IxYAtz0M240A0FRZ8zt+WYAJ49enWCiQ2ezQkP/Gre/28F1i53
         LdJ4c1L+sFEJr5LrthHqFM1f07Oxi/JXmNmta0B+LXk5We6NCPAwi7BVWvja4gVJjtL9
         sGK42fCKRfYC8gslo7epmvnB+Yiw3kYYJiQrPpjMXMYDJX8oLd08PR2Ae9+b8o5juH0j
         lBneSTjUCpw6Piw4ULhOSdYviDj6YxiLk/11m09h4vlp7EMWoIwUFV/5m63x3IouSfpZ
         OkQg==
X-Gm-Message-State: APjAAAWns+wP87jUbxCBGZ39JiJT7U9XoQSeGM1qjdB0IkrKT8K3nkuu
        JDFoL0vdJr2ZPv4cpEAsm8Ejftg8Wjf7syexGYL99B45mut6QihqjEuYpw4Wbq8V433+bh4aFhN
        9ksRNRW4bAE0UlEvmdKFP+a0D9KH1L82Bt+GqcbCjg0I3R/mrEgefVNgPqaOl9eS8ehJxoNNjkY
        f1
X-Google-Smtp-Source: APXvYqxV46Uk0ged6zgevCrLzbUJDOgecxfA8mA+uI70MO9+QkAA2ByIJcNd/I+smn37iudzpe8D/5QmSWOwhzLbbbpC
X-Received: by 2002:a63:d111:: with SMTP id k17mr38689437pgg.355.1570559862339;
 Tue, 08 Oct 2019 11:37:42 -0700 (PDT)
Date:   Tue,  8 Oct 2019 11:37:39 -0700
In-Reply-To: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191008183739.194714-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2] send-pack: never fetch when checking exclusions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building the packfile to be sent, send_pack() is given a list of
remote refs to be used as exclusions. For each ref, it first checks if
the ref exists locally, and if it does, passes it with a "^" prefix to
pack-objects. However, in a partial clone, the check may trigger a lazy
fetch.

The additional commit ancestry information obtained during such fetches
may show that certain objects that would have been sent are already
known to the server, resulting in a smaller pack being sent. But this is
at the cost of fetching from many possibly unrelated refs, and the lazy
fetches do not help at all in the typical case where the client is
up-to-date with the upstream of the branch being pushed.

Ensure that these lazy fetches do not occur.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
> For example, would this change mean that the resulting pack may
> include stuff that are reachable from the (missing) negative objects
> that would not otherwise have to be sent if these objects were
> available (or made available by the lazy fetching), and we are
> making a trade-off to send possibly more in order for not fetching?
> Have we laid enough on the table to help readers if such a trade-off
> (if we are making one, that is) strikes the right balance?

Thanks for your comments. I've expanded the commit message.
---
 send-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 6dc16c3211..34c77cbb1a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -40,7 +40,8 @@ int option_parse_push_signed(const struct option *opt,
 
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative && !has_object_file(oid))
+	if (negative &&
+	    !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 		return;
 
 	if (negative)
-- 
2.23.0.581.g78d2f28ef7-goog

