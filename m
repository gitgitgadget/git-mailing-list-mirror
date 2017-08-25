Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E43208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbdHYQsm (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 12:48:42 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36893 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbdHYQsl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 12:48:41 -0400
Received: by mail-pg0-f50.google.com with SMTP id 83so1762175pgb.4
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kz7srqVGWzIwKlXNnqRNLSVr8DJKZn0lHINsjpoReq0=;
        b=KzzN2GHrBvWv6nnjYUaqUOqrnJiAtNXS8EKoUP+HqL5F5OfwXZkoIRt4EKsymVDTCN
         SZ3C9lXFcILeF3RqNLNMyF+KPsGtq17wKzNDqQQxR5IOqDAYUCnVdLMAC3padkRMg0C6
         KtIo3xKcapvyWDtiKhFeLs7wOHV1nm2Zjxx9LOyg2nDF2JNQiE/yV4GBfMif2fPTFC5U
         rpJtB0qdaxb4DxqXGDHQ/J7YBPuU+jQ+vJOMWN/HApMzb1fkgj/wlaKiABE2qTx1ZHQh
         hd2lYH5U0GnSFGwynhZ9SdxH0aUs6b+DOfCg8nIKLRjYhBFrgY2CWYRy9n7bFBQuUMcH
         EaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kz7srqVGWzIwKlXNnqRNLSVr8DJKZn0lHINsjpoReq0=;
        b=CotQ1Zsps/PSf3ujQohNth1HI1MjG8HACQDfeWWpzhcm6htY/LdbGCDhK6XKkoGAnk
         GAfZZaPiI9LLnf9RC7McW1zdjAQhvO5+4pXRwMKjlLH+nVWDAxuICej9tkhpTscaoGmh
         1irrxjMllImi+PWVBF9iz/vWuYY1qEc1tPzUPviUAp1C/E1bcGm2wYf0dW8o7iaaqKUl
         EvklemK/QTP4AaUIaj8vd4SHcYGEz1eQNReZWH+iXKKz/cHMtKMTLgrLBiC7PQKBihz0
         YtPQj5xmq1BqoeM9CwRabJXY73m/5g87oHFkXZ7D6iQOFrfaRuoLhYd8rTS7/xuvQP7+
         TyUw==
X-Gm-Message-State: AHYfb5iXtCuELbVXN4jvgfpZEq/GPIZH/UMWbey/u8sv5/unY7mzomrM
        BZjoLfJ9jt0v6P82Qy3x1g==
X-Google-Smtp-Source: ADKCNb4mCFdZvyEbGtfLrOX1UCSgvebxSO72Z/ce+nuXaKI2ENPQl8rwAG4CQqPsnvfIjrEpRx0h1A==
X-Received: by 10.98.223.76 with SMTP id u73mr10483617pfg.104.1503679720375;
        Fri, 25 Aug 2017 09:48:40 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:45d:1079:91e6:dbda])
        by smtp.gmail.com with ESMTPSA id h62sm12128459pfc.97.2017.08.25.09.48.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 09:48:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] usage_with_options: omit double new line on empty option list
Date:   Fri, 25 Aug 2017 09:48:37 -0700
Message-Id: <20170825164837.30118-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the worktree command gives its usage, when no subcommand is
given. However there are no general options, all options are related to
the subcommands itself, such that:

    $ git worktree
    usage: git worktree add [<options>] <path> [<branch>]
       or: git worktree list [<options>]
       or: git worktree lock [<options>] <path>
       or: git worktree prune [<options>]
       or: git worktree unlock <path>


    $

Note the two empty lines at the end of the usage string. This is because
the toplevel usage is printed with an empty options list.

Only print one new line after the usage string if the option list is empty.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 0dd9fc6a0d..1307c82861 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -603,7 +603,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		usagestr++;
 	}
 
-	if (opts->type != OPTION_GROUP)
+	if (opts->type != OPTION_GROUP && opts->type != OPTION_END)
 		fputc('\n', outfile);
 
 	for (; opts->type != OPTION_END; opts++) {
-- 
2.14.0.rc0.3.g6c2e499285

