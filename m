Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56379C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUW0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJUW0F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:26:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539B1BB554
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y17so2390621ilq.8
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/GiXiCUojIvEAZIVZPMDyEUyrAGsES8iWuEromJJ9g=;
        b=GGjx3VtfTUaM4psQ3puvP7VXPk1iXH8keEcwdJqAi1qRqyx2GysYPk/xOutAjxEv6Y
         fyHV6jvxW1bHb7rl75O9Z2eq1xiyeQ9HO1cyVucCPfY7Bo6IHhefLsv8Hk8w34PGXrd6
         xvrSAn41DRnlvMxwvj/Dq6jFwoTmsu35ZmCxnUdq3U+FCXheMWlTNLfd3fPLRuAMth9/
         pZE4ZwoOb+WL62qxzinWP42wd3Hteqf24SXWRpSM2PmW0OS6rCJ+AYcQax8yD4xlpE23
         QalYelUnLD8QFHTwKOVZyi4pBitQaGV0S3uz49pVEIfs4i8nbd654tMIwo34jFGwkmiJ
         C5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/GiXiCUojIvEAZIVZPMDyEUyrAGsES8iWuEromJJ9g=;
        b=Z34by/RxZuwT0/XqXvlcg23qPLxWu1Px8LouCixpT7SO5sDZc7RFZ+eH1CD/H5Yd3M
         87aQyNjCrlW8398RTyKWDIM85Vp0Iw8WAnlmPQ2ILwjuhhbNzK7Lplz18NkxAbEEl7nB
         p51QDejqN7Kmn2GK/3ChKJYc2HHyr7MWnTJQ3WtHFulfrOW0dTUty8jLF8VwuHZuvxYg
         1kY7phYRqadE2sqV+EAGXZL03D560IDWphscMS+p3ejDVJZH2X1fd5JP6/8kmneSK2uM
         bnNOv/dPZaHsen5q6yv0hlxkrTOZNudDnz1BwQctR9LapqSU+YrLVqWu1SS5VEuHfiQe
         Nocw==
X-Gm-Message-State: ACrzQf16CsWRl+1Q9Hjm8BMnPlkPCyZRbobJnuRwXBHwV5ayUqbKE/T/
        SxL9bsKlH72udhrGtg+BaULSDWerqhionXN4
X-Google-Smtp-Source: AMsMyM4iA5rwyED8qjzee1OpJB167lBRZMPjvnUPxqpzQiDEUThnQcpeusVq9V4eC89+2jpZGF8jhg==
X-Received: by 2002:a05:6e02:1946:b0:2fa:b248:47e9 with SMTP id x6-20020a056e02194600b002fab24847e9mr14610779ilu.153.1666391155907;
        Fri, 21 Oct 2022 15:25:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a92cf01000000b002fc681a6ad8sm4447583ilo.78.2022.10.21.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:55 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 6/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <f4f233fb488cb7080f112e515923672671a1c233.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of handling SHORTLOG_GROUP_AUTHOR separately, reimplement it as
a special case of the new `--group=<format>` mode, where the author mode
is a shorthand for `--group='%aN <%aE>'.

Note that we still need to keep the SHORTLOG_GROUP_AUTHOR enum since it
has a different meaning in `read_from_stdin()`, where it is still used
for a different purpose.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index ebf2bf3d3b..4b95820bca 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -253,15 +253,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
-		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
-				      &ident, &ctx);
-		if (!HAS_MULTI_BITS(log->groups) ||
-		    strset_add(&dups, ident.buf))
-			insert_one_record(log, ident.buf, oneline_str);
-	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
 		strbuf_reset(&ident);
 		format_commit_message(commit,
@@ -383,6 +374,10 @@ void shortlog_init(struct shortlog *log)
 
 void shortlog_finish_setup(struct shortlog *log)
 {
+	if (log->groups & SHORTLOG_GROUP_AUTHOR)
+		string_list_append(&log->format,
+				   log->email ? "%aN <%aE>" : "%aN");
+
 	string_list_sort(&log->trailers);
 }
 
-- 
2.38.0.16.g393fd4c6db

