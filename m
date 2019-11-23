Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E031C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF20320706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 14:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqWmP3CW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKWOqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:46:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42630 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWOqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 09:46:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so8507244edv.9
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 06:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXbqoHk5sy1+srZ9EBF2TtASRKkO02tX5K+iDaduaZ4=;
        b=dqWmP3CWnzybcwtSnuzTsjayJLk5SnnrONIu0gFTuIDZ7A14MZc0zXmA8x5dwYEHmY
         qMfj3PQkg6AdFTvgzuEJSQDeP4sCybXa1ieTJWvKvzVHTyNSU4cYVNB98fJaEN7uHpmJ
         EASjuHWnvlu+bLTa9C1Nd//dGxfZylJXbmi3TGnLsG/mATX66RWa4T1Yj3EHUjkShKLH
         /XgoMaGO+R3y2d50gFitEvs6kq50ZEjAfBmhB5wXer9hotUdg0b1jJgHHh3OTEeNWke9
         3cToJ+Q5nmTtNavB0y8tJ3npJzO4lE22jxmhhQUb4UoMIKys8L3gFy/aggj3GqZRJ05k
         VUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXbqoHk5sy1+srZ9EBF2TtASRKkO02tX5K+iDaduaZ4=;
        b=Q/t+z5cQZWIkAUJQ/NO3MNBeCGqZqLQIjoVrzNrGnr3GeBuXlTy5WJptt9LHv4CIUj
         tYga3G28zZl8gl3OInEH6Qc2kmspiGb0ZYZGSxiBX74skQAMrNjoxUUypqPKx+YqK0Hv
         WLwpQJYdQpPknexZhQr1102FwQNh1svGXcTy7TZj+mNladtHNl+hgrupzk542YDmxHTW
         PD/mVE0jRbhZcRLbqGadgSbHRzxToO8UGATkGinbW2ihOroXlBRjl5j1bj0x8R3BXJhl
         RmunT8QlSLXrXB0hBw5+LpFrvBUHq6XYpTGsGycKDMHO8i8DUS6qQNeDO7ETX1OtZ6Dd
         tfDw==
X-Gm-Message-State: APjAAAXWMso6MrlWNfsXXsH1AXRtDtvz4c4ff0TplOV+XNRjVIgEcD6c
        YgDCD9Wa04P34nVzptBuwYFO3Zbz
X-Google-Smtp-Source: APXvYqzIgot51aZBLtYlj4M1jsu32LpmDCHTy77kVDtYP6CD6k+DZngiitlvIT6DKz2YLEulFj/caQ==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr23019942wrp.5.1574520042984;
        Sat, 23 Nov 2019 06:40:42 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.googlemail.com with ESMTPSA id b10sm2399298wrw.53.2019.11.23.06.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 06:40:42 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 4/5] rebase: fill `squash_onto' in get_replay_opts()
Date:   Sat, 23 Nov 2019 15:37:04 +0100
Message-Id: <20191123143705.17280-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123143705.17280-1-alban.gruin@gmail.com>
References: <20191007092641.12661-1-alban.gruin@gmail.com>
 <20191123143705.17280-1-alban.gruin@gmail.com>
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

