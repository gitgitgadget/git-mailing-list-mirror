Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F945C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2B207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2ksHXCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKXRpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:45:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfKXRpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 12:45:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so14716895wro.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXbqoHk5sy1+srZ9EBF2TtASRKkO02tX5K+iDaduaZ4=;
        b=Z2ksHXCgaT+ZrX0sHHI0PF0v+PH5AXQkdju6fl7UJATVl2633xZRuKPUGLwTtGpgVp
         /p6CuKNyXnzVVryfYiQO3G8BP7OGJr66P611G2OX8GqK7pzrega6l8RGmWvnjl7P5SV8
         A1v+MMeHWCup/G/sna+6HkK2ovArz9RscLloAhnw5g3foV5XpmR4C5Yh8LxOzOc0mThP
         iOOjF85CFcE5Sro6Hvz1K+tNzibv3U8Ifv8JHMiXFsfAob+gFsvej3J6I/GmAZb90JdE
         Fy8o7/ZPJuyqU6t4ijbfEsev/VWU/ZpmN6+fJ/yo9vMksUcTtg1YkYXZsZIbUG3DwX/Y
         yB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXbqoHk5sy1+srZ9EBF2TtASRKkO02tX5K+iDaduaZ4=;
        b=rG67YttcHsG3QV89cfBK/gHAyuakens32Xx2YiYFzsQTLZVhnf3EQLHRiHRkqOsA4u
         8DBB7JwC66EZBPSEPrEljoRHJCvuuWwhKKR+E3J6bZohqdqt1JC/MqaI4p3gVWMR7X1F
         j6vqO8YxHWTTVrTuR8NnDAppPswxGgp6TJgJ4JqX+OsIJigzduG2qc6lp262Tuu2VOxn
         8r9IG4m+sVzewsuOytqbC8ePv0oniEU8avwK7Ef2LadHH7QV5HIES+iOlSu47Ug/KOpS
         hQyumU7KRqWnexwBrROFmZ393Dk1qhujSRo0oM0qiv6XiFIfSXkn6Rl0GBiCut1BOj+d
         l/dQ==
X-Gm-Message-State: APjAAAUrGqQ7UY/5q6e6bRFoDkzn52Fnc8G2ncFu+nf1T4BU6vMeOUQ6
        cyIkVs01xq4Kl1kWF9j+AiaSYzON
X-Google-Smtp-Source: APXvYqybczh8IwW0dBGy0cveKS4LdUDia26+1FKCB2N4T/I7jHE/49U9xyiBb0TcbhqN59gIHWZiOw==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr24197953wrs.388.1574617541500;
        Sun, 24 Nov 2019 09:45:41 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id a2sm7171315wrt.79.2019.11.24.09.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 09:45:41 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 4/5] rebase: fill `squash_onto' in get_replay_opts()
Date:   Sun, 24 Nov 2019 18:43:31 +0100
Message-Id: <20191124174332.30887-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124174332.30887-1-alban.gruin@gmail.com>
References: <20191123143705.17280-1-alban.gruin@gmail.com>
 <20191124174332.30887-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sequencer_continue() is called by complete_action(), `opts' has
been filled by get_replay_opts().  Currently, it does not initialise the
`squash_onto' field (used by the `--root' mode), only
read_populate_opts() does.  It’s not a problem yet since
sequencer_continue() calls it before pick_commits(), but it would lead
to incorrect results once complete_action() is modified to call
pick_commits() directly.

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
2.24.0

