Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009BC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC22F206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 13:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BigMQlql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgC1NFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:05:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1NFt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 09:05:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id c187so14561438wme.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2fZ8UlEe8exU7fxTSWwk1LZfvTTV5Q8vwVOCNbqyAI=;
        b=BigMQlqlNSDA/htsMlDcnwdxCRX7VO4TxHS7TYPvdYLgBh92x8g2nIsFJMdqNcyVDY
         J+vgGLs2IJ7uRFnklp7vBUQAnCjPByC5VAe93JYW+qlIJDLydt+zZl0XmpzDJh0o63V/
         9Kv0xM3JkLgNNcXykF4TialU6OXFEfzUqo/Dzbv1pfn68jkkHbJ10o/Mvt/tU/7gK6Fq
         WKVDIg8x0ObrRSt9wGcQLxTWQ5TtFmucuwqrkAFfESrcBTodVBiUdYQodMWUvQfiipCy
         TUpiKm2D6x83Un1xaKC8okJuCzjn7Wh47AISpHMBrysJWgAx0eBbIXZ07Io5YYl3Bu3L
         yAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2fZ8UlEe8exU7fxTSWwk1LZfvTTV5Q8vwVOCNbqyAI=;
        b=Hnb0Q1aqDY1FWnEigVfU0Zo85JbNRlNjQkisY0Kje0zYOVv1kWyr7+UMpfpnLfDvUY
         R7pKluZmpOza1ImEPSqux29x9ZaE+TELm16tZ036aXRZ9qc2xUVMijShWqaMXPssfhIp
         S+wy8p0kt8ImYcoHk5x+YPos4hTJbs8MmkgkP3GxIUfoVZCpgNauaCAgc5onG4LKTSQB
         3FmRuQqpNY+e8+FK0Vqrsmt28gXYm9psn2p0Fa7r7y5mmiZQ9O/Qj0PhCAv55o1PyB+d
         QBYSFPbBeSmzIdyljSndUFwpVwGpznyXK5VRoP3GEi3DyvNm+bi5gBkkIM3uC/QTkikP
         Ay9A==
X-Gm-Message-State: ANhLgQ1ffvzK83hxdxdnWPlkLbKLorbercob261udHk3h6rZ5K/9NzIG
        zOjdszYs927z8k50waK9l5Nekc7a
X-Google-Smtp-Source: ADFU+vvC6ftWDcsK/D9kxuJn6/jHxpsiWUyZZfq/rds32RCKwUwBZHwAUQglWIhF/W/i5Ev2k8QUlA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr3747602wma.36.1585400747981;
        Sat, 28 Mar 2020 06:05:47 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.googlemail.com with ESMTPSA id f187sm7273826wme.9.2020.03.28.06.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 06:05:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH] sequencer: mark messages for translation
Date:   Sat, 28 Mar 2020 14:05:15 +0100
Message-Id: <20200328130515.17550-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..ba13a9a63b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3128,7 +3128,7 @@ static int do_exec(struct repository *r, const char *command_line)
 	const char *child_argv[] = { NULL, NULL };
 	int dirty, status;
 
-	fprintf(stderr, "Executing: %s\n", command_line);
+	fprintf(stderr, _("Executing: %s\n"), command_line);
 	child_argv[0] = command_line;
 	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
@@ -3841,7 +3841,7 @@ static int pick_commits(struct repository *r,
 					fclose(f);
 				}
 				if (!opts->quiet)
-					fprintf(stderr, "Rebasing (%d/%d)%s",
+					fprintf(stderr, _("Rebasing (%d/%d)%s"),
 						todo_list->done_nr,
 						todo_list->total_nr,
 						opts->verbose ? "\n" : "\r");
@@ -4093,7 +4093,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			fprintf(stderr,
-				"Successfully rebased and updated %s.\n",
+				_("Successfully rebased and updated %s.\n"),
 				head_ref.buf);
 		}
 
-- 
2.25.0

