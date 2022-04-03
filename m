Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30BC433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359556AbiDCQzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359506AbiDCQzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 12:55:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F093917A
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 09:53:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g22so8456833edz.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kIM0hkVZpUmwNhFMPAda8nfmexLAW0akh/cpJ/cag8=;
        b=n+4U4I5c9V4srhrU0MJ+zrQGJ7f+EI0T9R2JOL3wYRK7PaYgP6Gs8uAJqx4APT95dP
         aoKDusoIylxNRJacV0wzVAOK9aHK7XjiY8HnNfDMWI+sl4Kq6LLxs8t2q7vkXX30eMHn
         deNmcLCmh4EBJLR0gY5Lne1ASIvXUMg5YiqHrIWMKoodkB6JoTMA5Lj7kNiPubbhAVA9
         60TBoXB+0aHhkoMHQj8STXMbnWIWAok1LoDkugioKGZfvh4K+jno8gh3RYc99CkVrGpd
         5fdNT88MOyJFP2xHX73PZGEX3dVyNkiktuOCbnO17yliu/rvJBoHCNcv1JzgiEwmowHz
         huiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8kIM0hkVZpUmwNhFMPAda8nfmexLAW0akh/cpJ/cag8=;
        b=EUer/zS1X1tTigjqS5f5yN4zSSkSGxb/DVhqDkH3LGLXqaGNWGempqHDUQsY677z5Y
         B58CpFFL2NHGo8L3JZVssEwt+oO0LtOPghc4PMqYCgn6SUlcdMHUm7K6PrDJWKJDkrg2
         ZqblVcVAG7/E3XoqM/wDzZxAaipoaoK4VDxeJ9U5ET36bTaygUUOBtWBFgWzF+VRJJjn
         fGR8GDMlUfJiebfb+VDhNmWa8ow6uFLvBHTsuP0xxPL9wFlJvNmb2NAplheLBLzOCbgt
         52D9hk8fAsEBO1bEohA/JOQkyQoiFxdtzFsoDh3lLIXADlEXnuB/WpHmEGYiAJeWSfOs
         xepA==
X-Gm-Message-State: AOAM530RUbpTEQY4aKilGP8L6CG20n7NDw6D+eBlS9NGCdJXQRHMFBe9
        I6TK4FybswQkr9E4adOd2BGdHoOvCe+rpQ==
X-Google-Smtp-Source: ABdhPJySdlhU9kynwL7Sg6zORbTcRWdQQHoxUamOcmex+cjG8FPInd2+85YBw0YGB8HLm4shixFk1w==
X-Received: by 2002:aa7:d619:0:b0:41c:ac48:4ebb with SMTP id c25-20020aa7d619000000b0041cac484ebbmr5613747edr.316.1649004799519;
        Sun, 03 Apr 2022 09:53:19 -0700 (PDT)
Received: from linuxerio.localdomain (j109098.upc-j.chello.nl. [24.132.109.98])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm3389720ejp.20.2022.04.03.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:19 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     gitster@pobox.com, whydoubt@gmail.com, git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] blame: report correct number of lines in progress when using ranges
Date:   Sun,  3 Apr 2022 18:50:38 +0200
Message-Id: <20220403165038.52803-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using ranges, use their sizes as the limit for progress
instead of the size of the full file.

Before:
$ git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines:  10% (122/1210), done.
$

After:
$ ./git blame --progress builtin/blame.c > /dev/null
Blaming lines: 100% (1210/1210), done.
$ ./git blame --progress -L 100,120 -L 200,300 builtin/blame.c > /dev/null
Blaming lines: 100% (122/122), done.
$

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc..e33372c56b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -898,6 +898,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	unsigned int range_i;
 	long anchor;
 	const int hexsz = the_hash_algo->hexsz;
+	long num_lines = 0;
 
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
@@ -1129,7 +1130,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	for (range_i = ranges.nr; range_i > 0; --range_i) {
 		const struct range *r = &ranges.ranges[range_i - 1];
 		ent = blame_entry_prepend(ent, r->start, r->end, o);
+		num_lines += (r->end - r->start);
 	}
+	if (!num_lines)
+		num_lines = sb.num_lines;
 
 	o->suspects = ent;
 	prio_queue_put(&sb.commits, o->commit);
@@ -1158,7 +1162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
 	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
+		pi.progress = start_delayed_progress(_("Blaming lines"), num_lines);
 
 	assign_blame(&sb, opt);
 
-- 
2.35.1

