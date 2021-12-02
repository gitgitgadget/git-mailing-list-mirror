Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC4DC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 03:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbhLBD6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 22:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhLBD6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 22:58:31 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F8C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 19:55:09 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id g9so21895015qvd.2
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 19:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNEEq7W7acSxycuGcbjAK/bIbFVCQgh7WR5sYWIZb1U=;
        b=Bnd8R0HMWgU7LkIwu09QvcQM3wH0QxXRDhwarleLCHSoEZLl0WnJXp1KvBy96fmGU2
         cQd8l49gvoOVynbKcg8zmwB2WjxVX2Qqrod8ZJCCOAQtefx1/WWjmO2So+6k7zCBPMkR
         NR/PQGxm6GfIhNE02Q7wzF+v+qZrbWsIlcswg3h9o5FUMiYGJsgkJtC/ebYGiT/Edulg
         mwqK/FRZxBYHaJZP3aKW4V1s509HxsAN6A3rYoAMjcirZ8zBv9pqGKCTT0Og00S66PBr
         mHn9X80t8gy8AfHTkAcGxxEkanUucgCjDroT9m/m+iJkp9zNWdO+G/ASEE4G5vcxdwS3
         XPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNEEq7W7acSxycuGcbjAK/bIbFVCQgh7WR5sYWIZb1U=;
        b=RuCn0iUa1GdldisTxoeXu1d6kzGXP4f6JZr2h+Ov3350GKquCTxAaMB/iDozuh6fJo
         mDaQVsv7txeH4aS9WjYdxgOFTGSVh/AzgPFv/GqeiJd7VQpFr07RCzPZRmml2hx5sz7+
         P1eWDBCXQQjPljjlOyXvZ01vC6rb5x54bgksGVfHhN7ZWqoJ/O5kgOJWtNfzZyzUyZjp
         tSNhoIt+wP0rSbZKj++Em6DvQKliL5pgQALid3h7spoAc3MEDMG1T6f9cXv+sJW/a7hN
         l4VSiZhb/yH5mVfKZj2C82jsLIkGwMWECvZ+gF/8yncoViiiBuLVXKVjbrDsr4L7YGfa
         7DHw==
X-Gm-Message-State: AOAM532rYcauZcjBn18ba+uiVS9z8scTMWEMloTqDI9z4ttMkoHllvpr
        o5VjiaSS36iAZoGzqD4lEs4h8R+Iybg=
X-Google-Smtp-Source: ABdhPJzutgzOdM9kVYfspFBMPGfFgXXqL7CtDvWTWMr/ReIlN6SGsMpu+WszuLtarZAAqchzmSsAPQ==
X-Received: by 2002:a0c:edb0:: with SMTP id h16mr10745614qvr.17.1638417309021;
        Wed, 01 Dec 2021 19:55:09 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q20sm881949qkl.53.2021.12.01.19.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 19:55:08 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chris.torek@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [RFC PATCH 1/3] terminal: teach save_term to fail when not foreground
Date:   Wed,  1 Dec 2021 19:54:44 -0800
Message-Id: <20211202035446.1154-2-carenas@gmail.com>
X-Mailer: git-send-email 2.34.1.460.g364565cfab
In-Reply-To: <20211202035446.1154-1-carenas@gmail.com>
References: <20211202035446.1154-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e22b245ea5 (terminal: teach git how to save/restore its terminal
settings, 2021-10-05) allows external calls to the termios code,
but kept the assumption that all operations were done with
foreground processes, which was proven incorrect.

Add a check to validate that the current process is indeed in the
foreground and in control of the terminal and fail early if not the
case.

To avoid changing behaviour from the other users of save_term() the
full_duplex parameter has been overloaded to restrict the new check
to only future callers, as it is set to 0 for all current users.

The detection is done in a helper function so it can be reused by
all other functions that might benefit from it later, and once that
is done that overloading might be unnecessary and cleaned up, but
doing so has been punted from this series as it is not needed and
might require backward incompatible changes.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/terminal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 5b903e7c7e..509f2518d1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -29,16 +29,31 @@ void restore_term(void)
 		return;
 
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
+
 	close(term_fd);
 	term_fd = -1;
 }
 
+static int is_controlling_terminal(int fd)
+{
+	return (getpgid(0) == tcgetpgrp(fd));
+}
+
 int save_term(int full_duplex)
 {
 	if (term_fd < 0)
 		term_fd = open("/dev/tty", O_RDWR);
 
-	return (term_fd < 0) ? -1 : tcgetattr(term_fd, &old_term);
+	if (term_fd < 0)
+		return -1;
+
+	if (full_duplex && !is_controlling_terminal(term_fd)) {
+		close(term_fd);
+		term_fd = -1;
+		return -1;
+	}
+
+	return tcgetattr(term_fd, &old_term);
 }
 
 static int disable_bits(tcflag_t bits)
-- 
2.34.1.460.g364565cfab

