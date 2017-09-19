Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D3620A28
	for <e@80x24.org>; Tue, 19 Sep 2017 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdISVfC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 17:35:02 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:50744 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdISVfB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 17:35:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id m63so471612pfk.7
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sqvdynWbcJgOvyF7+61Rs2k4BQjrIqRxJyXmDYd6f2g=;
        b=JgijwlQ2T+R1D9BcBzk4zO/PfhA620OsG7l7rltDZuYmpFiBxNPt+YYusiuZDU5Ic9
         T+qNx+15dlbTwQipRsORdeawK8YuGZcfviwOgOHSIqmqxZUQ4S39qXjH/w/K3aFAxAoo
         B+sPR0STpye1lngl167pFxQ6IiZ4G/GX2aO/1JnweaKu6/ZmpwLUDCufYmWMKOHor/jH
         /Nj8ad0t9rWVYt9XWbFyqXWSEjUPfcja66p55pJ5kc1jwx9OLUT+05VGbPfErvATum25
         9Q+JlKzVlw7kuyj2Usy5lheX4LCIrW6ErQX7u8IjKryTa4ALvKAJFVO+puxiIHIrKmYw
         zimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sqvdynWbcJgOvyF7+61Rs2k4BQjrIqRxJyXmDYd6f2g=;
        b=AoLsM5qzyf28nVO4RlyA+PW4Olf73n7rbDgbzqXkLvuTttngHy9CSYq/iLA3U6D0+W
         waM/li3qbABqq1fUNT09uw9lZH1KtE9BMn0jXcY2pgpPsQqMHW79t2/hf0hAjfozmA89
         bq0HKHGD85TGohgDPbF5kocz3cunfeW3QDyRbNpyDYGtXVHOWHBtX1QdgqI1v5cF9CKu
         tTsd2fCwq8qs8BKO1zHb57JnjtWzepOcGmQ38WWL8rwXvkklybuo1ny5ffTtg09SmMjk
         M2+UcnD45fClQb5s/KCnNz8Ck08BX3Hmp9DZGhPwA4fp+aZI9CEL5mLNH9n55w2MJf9E
         73fQ==
X-Gm-Message-State: AHPjjUgawfTiAO1cmkkPt5SypNzywj/zJk0HXlGZZtvykfE0V5obvjhI
        oq3CWavRzFvRAntKR4wQxW2ROJoLnTg=
X-Google-Smtp-Source: AOwi7QCAWbykGXm+EDolK9MpoUAqI9Y3Z3hVgssI5wsgetMHf/dkrmzFTefhjnekpM+8E9Po0u+V1g==
X-Received: by 10.84.235.65 with SMTP id g1mr19074plt.353.1505856900522;
        Tue, 19 Sep 2017 14:35:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id m87sm5626146pfi.122.2017.09.19.14.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 14:34:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH for jk/leak-checkers] git-compat-util: make UNLEAK less error-prone
Date:   Tue, 19 Sep 2017 14:34:56 -0700
Message-Id: <20170919213456.13983-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
References: <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0e5bba5 ("add UNLEAK annotation for reducing leak false
positives", 2017-09-08) introduced an UNLEAK macro to be used as
"UNLEAK(var);", but its existing definitions make it possible to be
invoked as "UNLEAK(var)" (without the trailing semicolon) too.

Therefore, modify its definitions to cause a compile-time error if
invoked without the trailing semicolon.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Sure, here is the patch.
---
 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 003e444c4..9bc15b036 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1184,9 +1184,9 @@ extern int cmd_main(int, const char **);
  */
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 extern void unleak_memory(const void *ptr, size_t len);
-#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
+#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
 #else
-#define UNLEAK(var)
+#define UNLEAK(var) do {} while (0)
 #endif
 
 #endif
-- 
2.14.1.821.g8fa685d3b7-goog

