Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF883C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 09:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEFJWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFJWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 05:22:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE930EE
        for <git@vger.kernel.org>; Sat,  6 May 2023 02:22:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab267e3528so18905445ad.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683364933; x=1685956933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0sqZ+GfVajMplO5MYEo/Vpu4tJ7mKja1gy5a0afcdg=;
        b=eDiiWU2gh4B3OL+M+z2Dgs8MXncc5jydzhmrfRwsYqdC8J4Sk3vh+Xkg3DiDxgwcxb
         FmGebFlDyJd/5rfZ7hj9DylfHNKVeS74iDvzWQfGYxHxbAbRdW2y0Yi1+dTXPCDaUxF5
         FPUNGfqQFWe5rzfeggWRsJx/tNC5o1X5MeL6FMLq7lpScECB5/l4h+omfMRG54NMgWi7
         7Sf7oFGv1CTCb85vNrxakV5uopz+iqYJbi3DsEOYZyk17XqBaT4YrnmzoTYdbAMyEOsm
         7dIXR7CskAqJ/ELTHuYksO9t1/asSN/XZyJ6MguyWy9mYhC7kIscx4yD1n0kj4yg8T7Y
         UOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683364933; x=1685956933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0sqZ+GfVajMplO5MYEo/Vpu4tJ7mKja1gy5a0afcdg=;
        b=HINS/5gDL9Pjxf1JnbDTX7WlRjSn9spP9aleBoiHCf6PhaBSOekfkHMB6i7F0CR0l9
         n8XVKBogO6e2PK9XcJbYGyjTWzZMHEMe5AGo8lBOcodaJJ+8rKcWTv3FPdaC7QrEx8pK
         iq4U5yJ7l+VXv2N/QHBKROAVHLcnxyoH9+KUnI2dVUcDQf5sPjhLHi03GyAcZbufXGcD
         xB3d9z65nNgEC16CPXPxoD0ZDVkc8NzBXgkPZEp33BaNnY6cgYtaC76l6vBi2m9ElaRp
         /Ft9/4CtgAtkToz+PPinw54GRjQOr5zDBIQ7aJBmPzQ3+0ec1b3je+LgvMVLV234G93G
         E7fQ==
X-Gm-Message-State: AC+VfDzpDm+TzkAYhrhE1jBpOwO5kjoeHxegt4U5MQNN/6gSuokeexk9
        clf2jPA3/rOyjNZx8NiiegU=
X-Google-Smtp-Source: ACHHUZ6FpNhkrn4ZqaBsFfTmeVO1aaLqvqZjYsB4aUrwXe2W7cIRNi3tECL41ahf5fLHnxsamee/7w==
X-Received: by 2002:a17:902:ea0a:b0:1a9:3447:71ef with SMTP id s10-20020a170902ea0a00b001a9344771efmr4973817plg.54.1683364932956;
        Sat, 06 May 2023 02:22:12 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902854500b001ab2b415cadsm3129568plo.84.2023.05.06.02.22.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 02:22:12 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Sat,  6 May 2023 17:22:04 +0800
Message-ID: <20230506092204.57914-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <20230506091205.57746-1-tenglong.tl@alibaba-inc.com>
References: <20230506091205.57746-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>diff --git a/builtin/notes.c b/builtin/notes.c
>index 8905298b..6eede305 100644
>--- a/builtin/notes.c
>+++ b/builtin/notes.c
>@@ -28,7 +28,7 @@
> #include "worktree.h"
> #include "write-or-die.h"
> 
>-static const char *separator = "\n";
>+static char *separator = "\n";
> static const char * const git_notes_usage[] = {
>        N_("git notes [--ref <notes-ref>] [list [<object>]]"),
>        N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
>@@ -248,8 +248,8 @@ static void append_separator(struct strbuf *message)
> static void concat_messages(struct note_data *d)
> {
>        struct strbuf msg = STRBUF_INIT;
>-       size_t i;
> 
>+       size_t i;
>        for (i = 0; i < d->msg_nr ; i++) {
>                if (d->buf.len)
>                        append_separator(&d->buf);

Sorry, the direction is reversed wrongly.

diff --git a/builtin/notes.c b/builtin/notes.c
index 6eede305..8905298b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -28,7 +28,7 @@
 #include "worktree.h"
 #include "write-or-die.h"
 
-static char *separator = "\n";
+static const char *separator = "\n";
 static const char * const git_notes_usage[] = {
        N_("git notes [--ref <notes-ref>] [list [<object>]]"),
        N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
@@ -248,8 +248,8 @@ static void append_separator(struct strbuf *message)
 static void concat_messages(struct note_data *d)
 {
        struct strbuf msg = STRBUF_INIT;
-
        size_t i;
+
        for (i = 0; i < d->msg_nr ; i++) {
                if (d->buf.len)
                        append_separator(&d->buf);
