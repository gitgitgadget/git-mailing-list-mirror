Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834101F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeB0Vau (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:30:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36028 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeB0Var (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:30:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id 188so1287997wme.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCjLvuDkNdDh1n4Eb8cYOItgvxyIpCOjJx3JQ1EwTSw=;
        b=dcC6Vp7fjeQtK9JrJW2bsymcZHJYw55rVPP7bSd4kC7/vvhYtAAlvQvDOA+u+z0T2X
         VcmMm7jI0F6FrgSxADiWMmUN3swNrSBVUhUrJEzXhsbdqpAs6ZtsDQmmIGIJP6sVvLxv
         F43K7uzB/b5RXOJ4PUNb1F4200uLo51XcCPVH1/wm7t6mJhIshKUERB/DnrBQqyhZtgm
         cRLN0FeU6fud/VP5ydW88fVxNosa6h4SaNrWE/VpjTg4uii8bNGwjCmetD9pP7gX+gcj
         ZkzwPQX0w6HshgpeDEuMwEh3LXWH6Ra2MT9F7hVlNerOvoshsuduaW6lUnKWql4KTJ2P
         ruig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCjLvuDkNdDh1n4Eb8cYOItgvxyIpCOjJx3JQ1EwTSw=;
        b=I7qPy58+Qs1SAXauIunXtE4ps0A2sjAdUny6N/eY2QmHk1hYupuoIPYn0FFenmx8uG
         piS9cqamzMBOjIscMZwCAX1N8Fmn45azqJU1EstdJX9nfIw3qpISNWKSIU1FtoXC+JVh
         I/PhO/9ZniH9YV2t21/miaj39bCmVJXQwcs84hcQDq65MztCa8tkRyeQ2GGq76m9TIC0
         E6WimyXlJ7ytKLVGfeqy1Ha1NLiJmhenc32GIfbosEZsm1Xo+SAswXq2umimVIub5yMV
         YG/zff9/YzCfLffrTXnW1oHGhQUsnkaRBbkIJH7SkzKCi7UUW8JDVyLCKMVR3JAGnEq5
         2JmQ==
X-Gm-Message-State: APf1xPAKWUj1asbUnFMh0CXXdIxTY7MGes/4vX8xCYW26f4749qCSshc
        YEhouALsgl644gcXjCPCXu3aEdvW
X-Google-Smtp-Source: AG47ELswoTiOGO+msh33Z6KFsROKF9cHrgr6Jij43ijcxxNsLXd2vMoYKaW7hAW02swGZHEG/dG/Cg==
X-Received: by 10.28.147.12 with SMTP id v12mr12130599wmd.139.1519767045822;
        Tue, 27 Feb 2018 13:30:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t91sm126888wrc.21.2018.02.27.13.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 13:30:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] sequencer: always roll back lock in `do_recursive_merge()`
Date:   Tue, 27 Feb 2018 22:30:10 +0100
Message-Id: <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519763396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
References: <cover.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we return early, we forget to roll back the lockfile. Do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 90807c4559..e6bac4692a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -465,8 +465,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
 	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
-	if (clean < 0)
+	if (clean < 0) {
+		rollback_lock_file(&index_lock);
 		return clean;
+	}
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-- 
2.16.2.246.ga4ee44448f

