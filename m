Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C62C10F25
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3212146E
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 06:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/+GJqxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgCKGzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:55:52 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40482 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgCKGzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 02:55:51 -0400
Received: by mail-pj1-f65.google.com with SMTP id gv19so514780pjb.5
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggy0Uishz/mF512hzooex2V5adQSzH5f3x+NwXGg4h4=;
        b=s/+GJqxKwfWCJd5yTvFPnDx70UkJDyZddegVWlFX9AtSR+yBhtTwlhTg/vFwDX3JBT
         4LLGzP3JOK72RkaC8l6OIOEM8VzF+2DA1dechB8Tp6TRw/Kt+XZMWAGALhIp8ops5QgY
         op2TRIJ/Cv+EjKhJtI6AVkM693PGi91AxuI1oTFDg+D7HdTZGxbtot+RVaVTIYW+K3DB
         laBRbMubmH/zjCQYxoywHmuhbS5OD5wqpWM7pQ6MpckVVww0jgdFkXUv4a6kD18UAR+n
         eHJjXF3jK9onjneXYFvjbunpJqOvWUCBiqadFBjJYKBAT3ybCptUwtXeZAOBjBZ+amYh
         5QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggy0Uishz/mF512hzooex2V5adQSzH5f3x+NwXGg4h4=;
        b=Pj+E6aBOfkSpTeEQsGmPLdLCgp99zEqK5ipfETBxsc2+W4Qj1uS0sWEVw7083EjNR8
         QIKZWovNQVRTbL5D1PtkxkQetTiYavTndMqhFVtT4t7I8Cqs+pc5Gl9aZaoZDlODDYZ7
         ioX5BOPgieJYvCSLrEUtWgGj3gHytmAPphd1WS3qv6meMHWWS23nW6+yUKCpu8b9pfAc
         fwtFDm0DvyqiBmNsg/Ixdk6YryLU+TYqUtpXOb/SAfgWHMoexk3ld8zGTXlQwTjI9/P0
         oAwpNKfDUYC+/Q1vSl1QKwslUsjj2qlXtEvr5g3Lz8BXbUlNu8FuruNkiNrRTcUJMiot
         AssA==
X-Gm-Message-State: ANhLgQ3PT83z28r4IsJYMSx0+PKFPgDtMzbvdV7AagI7UIWZ9uMHNsPH
        4Mf2HuPNGJDDG9GbXGF5WXw=
X-Google-Smtp-Source: ADFU+vuQwdxBz0/wT0IAQl267gsvSJVbJIu/OsvcpkaeRdMCKINi7aRBHvOmUnQDcByrjt0/kZMVyQ==
X-Received: by 2002:a17:90a:9906:: with SMTP id b6mr1912642pjp.122.1583909750071;
        Tue, 10 Mar 2020 23:55:50 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id 13sm49704068pfi.78.2020.03.10.23.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 23:55:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: unmark a message in rebase.c
Date:   Wed, 11 Mar 2020 14:55:27 +0800
Message-Id: <20200311065527.7669-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0.1.g67b07ef6f6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit v2.25.0-4-ge98c4269c8 (rebase (interactive-backend): fix handling
of commits that become empty, 2020-02-15) marked "{drop,keep,ask}" for
translation, but this message should not be changed.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cb7aeae597..bff53d5d16 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1543,7 +1543,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "ignoring them"),
 			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
+		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
-- 
2.26.0.rc0.1.g67b07ef6f6

