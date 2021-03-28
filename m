Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1CC433E8
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BF26196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhC1NQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC1NQE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C6C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so10184013wrd.1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmN0ZTlKU1ndq9HW4UBz7I9dl7Tk5HKEh5FpMs+bW8c=;
        b=SVLU4FHgLHlgwkFWRXj+vhFD39CR3B3fIpfY4CaftMZKeliCpVCLu+rEeZNb9SzpQ2
         iGeQoeMmcCYly7yAg7h+jDa1TXsmqAxkofz7jluV8u+YNeCgdUet3BaDxajuoQXKuW2z
         iyBrjSUpJL1eGFWQsAdU90yohnD+qv/Ekl+u6lFYjZfvlTmJBgEM0T+4HATd3H3SJMBW
         FCvQmw58nACgc+mCmz39mQ/3/XLp3fbfuypm9lwKRAM2JHUK8F5DqBOOa1lJgjo42d4a
         ZpinbfHaqD5mXbhUOUrBvWzx9h13TW3DmWSHHe0ccYbWBISWk6U92wOGfWlJlfXPVhWf
         vo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmN0ZTlKU1ndq9HW4UBz7I9dl7Tk5HKEh5FpMs+bW8c=;
        b=MMEsyXYyYSndwo4j1LyEb0kuYJdNJJ6cR5m69eYJtbD8PnENnubLEhgyuBeDiHd/XB
         w/kqAl4CFzSoG1GUqXzBRQgjd1Ei6d80AkPknHjd/MmbQevRQ08vIKDa7z7L0+pOA3Zh
         9YDy6uRIXngk4J1T3sdpIwZ/H56cjClH4v88krtQ7hJxRFeKptDvgiQHgYs3lbHSHKDD
         ZU1tJotj1JVz9UCwOugZ/JYUpGcIh6b6pq12/WWz8WAv0TjPe/phzqIur7vPheyI34f8
         8Esc8dCM0VSzZ5HuupAuniUitukdLrimsdvCjl1NL9Op44F/sfojQaz1h9wMpS1gZ7U7
         Y2qw==
X-Gm-Message-State: AOAM533oWPQR+shi2HSFjhM+MRRSZrD7ioobIa5TScTshIX2QQ1LPkZT
        tlCGt6zryTHeGBi5aGy3lpN2Sfd6RmVx/Q==
X-Google-Smtp-Source: ABdhPJwQVrNEjBxwhKOl0fGqnDnhHIdWgGBWg2S7lnkFFdf60Hselo1r13iOJc/B+jGyBwFGPYt0vA==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr24136133wrc.309.1616937362646;
        Sun, 28 Mar 2021 06:16:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/19] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Sun, 28 Mar 2021 15:15:42 +0200
Message-Id: <patch-10.20-d7f1c5d37de-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason to defer the calling of parse_msg_type() until after
we've checked if the "id < 0". This is not a hot codepath, and
parse_msg_type() itself may die on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index c5a81e4ff05..80365e62842 100644
--- a/fsck.c
+++ b/fsck.c
@@ -201,11 +201,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type;
+	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
-	msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
-- 
2.31.1.445.g087790d4945

