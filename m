Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiBPKzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:55:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiBPKyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6529E97C
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i14so2748305wrc.10
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WixbW0OSoA7IdMQhhP0xT088HPSMGgfKzB5SsBiwsjs=;
        b=GmQCvH1XzwCLX7opt+hCfrtUSZs5o35ThYNfPgDtYH8ZsnDR6QwqpRUoqjjOmtCb0w
         QgTEXqyEvKJaIt/pbnOY1cx302OUisIiDxu9MSA00toq8c1xmxkDwqWWTyhCdvtEeY5S
         xa5llVL0fWqrLtnhZ2Z7lM1oRuReWMQS7M+ysHzJT89CTBWkNBO/14knuJ9VhD4L/LEg
         UewUawt1KCZ/Vf28IpolIqlj4zvTDVaQQelwFqcjYjdhtuuvWcrIOqa97zMhSSfPkosu
         6gjFhEl4mSAjKaEsYMMMvWba3AmkSinIe+1FkTzJtKFmw7akLXAQi3n9GtTP9v6VTFjv
         Hp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WixbW0OSoA7IdMQhhP0xT088HPSMGgfKzB5SsBiwsjs=;
        b=ijxUS6O2iXxmMIaBMZfqKiRp6kBoJQoUDF0ZI0Ks6vUCpI3WD0z4u2tiZOjiJNnOop
         jJiSaCGA+5/AfXM0BcjE8jCQ6M9u5/FR/zH7/Gh6LuAsUOav1rJZ4Nj/M37PlYQoQtA6
         Er8vJPvvFJUi8qCxNjz0zVnVyQhJ7N/O5Qf6Cq9CcrZb/BKgkXaUthrh7DOA5JWgBD/5
         jG9OHWsXPhozuqhHL7vSG2rrM6tUj3zstbmyew9CBzkSoM3SFFcVuxlvbFze3IrxkIBX
         SFwxKocRwj5PFhqF3LLFXa4pC+mE7NfLDYGAsB0GPwXiAhoCTqbvGzrAleWLcpD8GHix
         evmA==
X-Gm-Message-State: AOAM533OWnu+Bub19tnWGbvrPsT0u8ynWuvJsRtWCHmAjb2GnqogWaEc
        e4OVF6qyWjhaPVypq2ZURgCk0o8/D/c=
X-Google-Smtp-Source: ABdhPJyl/Cal6phRy38xj9Bsp7286hCdFBHlyaSTGPZO/UTIq2DpMscXYdbjCUAkKXnOkFW04oQHHw==
X-Received: by 2002:adf:f706:0:b0:1e4:aa99:3387 with SMTP id r6-20020adff706000000b001e4aa993387mr1858274wrp.680.1645008876339;
        Wed, 16 Feb 2022 02:54:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm14790261wri.109.2022.02.16.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:54:35 -0800 (PST)
Message-Id: <6d8423b6e1e969ffed02b148546b88d118affd09.1645008873.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:54:32 +0000
Subject: [PATCH 3/3] add -p: disable stdin buffering when
 interactive.singlekey is set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The builtin "add -p" reads the key "F2" as three separate keys "^[",
"O" and "Q". The "Q" causes it to quit which is probably not what the
user was expecting. This is because it uses poll() to check for
pending input when reading escape sequences but reads the input with
getchar() which is buffered by default and so hoovers up all the
pending input leading poll() think there isn't anything pending. Fix
this by calling setbuf() to disable input buffering if
interactive.singlekey is set.

Looking at the comment above mingw_getchar() in terminal.c I wonder if
that function is papering over this bug and could be removed.
Unfortunately I don't have access to windows to test that.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-interactive.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f1..ad78774ca26 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -70,6 +70,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 			      &s->interactive_diff_algorithm);
 
 	git_config_get_bool("interactive.singlekey", &s->use_single_key);
+	if (s->use_single_key)
+		setbuf(stdin, NULL);
 }
 
 void clear_add_i_state(struct add_i_state *s)
-- 
gitgitgadget
