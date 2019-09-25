Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB44F1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393005AbfIYUNz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:13:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55788 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbfIYUNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so94782wma.5
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gijRYT2eyqnmnBy3v47Z+nvLf7G8xiqP+R3ZELLetAw=;
        b=L6UIw4ne086U4CVDk/FdO/gWf1gbERdN7qDs8e7a0pOvhZDWAVpjPUGg5K4Md7Bc+D
         MTNL3zwq6GWklCZkoeGO/N0jnUmIxabqEaQAAwRBPGXTrz92ViLFx0e8xMQZAg8b0bva
         wVJ65423Wq+ymHByX+9QggFRK6gx44Jap3SsuiT/EPr5lr/CY1fe+SmId1/z/ZwpQ7k4
         0lhxwy5/zleVFY4fsiQ+DcNgJzhm8BFhkwGuMda/Ln9hueLYiQvNYtfOk2WhF/dGu6es
         FqtxpXM5YBqjpJdXwM5RUSuvDLaEb7aZzO2q9yKtbSIbXNj6yYOtc2xg2Xam3SZyluj2
         3LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gijRYT2eyqnmnBy3v47Z+nvLf7G8xiqP+R3ZELLetAw=;
        b=sin21GxDZjpEbW3TNNkpH+B81ZyX3LXJEZxXjrqQnmZB3rv2H+3ekJexi4WzTmlwhu
         FRB4Kle9MDSxF3mOLfnwyavaYOzkhJJ1Iaxa7PQWRnxReDmIew0EL6W5cGOWov7riFIq
         FKRgcGFIFjKX8+9/gST0lmsGMVRc5BjscCWD2YJV0kDs8EJj7Ny2oi4+6DdUr9KGrgCy
         MgOiyFc8dJJ4vGVvfbT7t3jjEAk51wSW2DFUoM8M3Yt1/3K1ZBWU4/8deoGO0j5D2sut
         o7/9fGRT3ioeHBGpkfJ7Tr9Sf65uIi8yrffre0d21hnp1YWp7P2T+yGVKYiucok8UmfB
         3/lw==
X-Gm-Message-State: APjAAAUl6aXFRalQnTEq0FMPf4rzdhyg/Gce8791CdaeaFzyaDVkArSt
        sTxDyIJ9pxUN4Pb39Oj0lLJQGK2N
X-Google-Smtp-Source: APXvYqwsjxkLgtjFtI5n4OxEM1etv/vR1dYZkyi5QoYR/dOU3AaJXbUi54+5qg1jwgNUuJ4nanheHQ==
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr8085wmc.127.1569442432673;
        Wed, 25 Sep 2019 13:13:52 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id d193sm138022wmd.0.2019.09.25.13.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 4/5] rebase: fill `squash_onto' in get_replay_opts()
Date:   Wed, 25 Sep 2019 22:13:14 +0200
Message-Id: <20190925201315.19722-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_replay_opts() did not fill `squash_onto' if possible, meaning that
this field should be read from the disk by the sequencer through
read_populate_opts().  Without this, calling `pick_commits()' directly
will result in incorrect results with `rebase --root'.

Let’s change that.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e8319d5946..2097d41edc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
 
+	if (opts->squash_onto) {
+		oidcpy(&replay.squash_onto, opts->squash_onto);
+		replay.have_squash_onto = 1;
+	}
+
 	return replay;
 }
 
-- 
2.23.0

