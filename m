Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491411F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeBFA0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38922 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeBFA0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id w17so174086pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AgzDPD6YxIDte8FlQaL3bh2lWepPJYMYdQx8d2Vn8yk=;
        b=Ea2nkHyBzWJp1FgcBKoHjMQWzM1XDs+bEow4Aap359Fo60TMI9V2t0qCpV17LTApST
         wzR12hMrVXft21aLP0LtSXsF7YVJncIQAeTIQj7VDDOy8PBWlyNwiMixIJcPL4qNOWcN
         Dpplgker0q9VKXwNmKUP6Te7mhYCYMWzS5Qh+oTDKzjbhDQr+EV0aQEdJ27JqE8OsjJB
         xpGeVJB23QV9Y1tp4uuYuxMpok79z8rO7P+pZILOQnAhE0R0zVT2cKO1gnkk5m9uZgoh
         63VTbhg2f+4Btfrg2po4Imcq5Wu4d9B/Ec1pe0QNt/I39gYMVdQiPV3bkdNrflQ91L+A
         PDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AgzDPD6YxIDte8FlQaL3bh2lWepPJYMYdQx8d2Vn8yk=;
        b=afX/QIoFzEvUZKTj8uSsgMuUnGKjDef/xtett4igbqfMDJjtMmQ6pEeFA6j5IdmxHi
         ZBG0mXNiQV4YamVI7CaCPCeVwBdcZsBTTuSuoFUa1PMu7LDl2+eF0/g1yofoPLOZhLcb
         rOUV6FFsNHeKRhWhGmBm93dD04RO6NZvAFeYAkdnCPnXXKyfykJY2psiyKFDdT6E8icI
         l9ARmF3MAgpFELHK5eCWPA+eUdY1YWRxSHwDUbYOlYCOF9xpRJOpZLF0jz4Eh61lKmjR
         s6Sp9giO61t4zXNnoPAnlxd4bsulfZwOTSYEtU5brRLFCD/OwAe9zHnnvXkK6CfdQcCj
         ImFg==
X-Gm-Message-State: APf1xPD11DEUSAdDr/8AcMoN4hLBGz17t1bn69B/UTb4zKK8Pw+XWulT
        +S5gZNS6RGLD2ZA6eqnzIr7RutO7hj0=
X-Google-Smtp-Source: AH8x225CMChd78ioGDTKOAKIbwvj6xWkZrlYxQJJz8soYhcNJ1s+6w1Ts/zOOAFX81EPg12fztlXkw==
X-Received: by 10.98.194.201 with SMTP id w70mr168681pfk.188.1517876799905;
        Mon, 05 Feb 2018 16:26:39 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m83sm19458389pfk.107.2018.02.05.16.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 154/194] shallow: add repository argument to check_shallow_file_for_update
Date:   Mon,  5 Feb 2018 16:17:09 -0800
Message-Id: <20180206001749.218943-56-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 shallow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 67feeb3a4f..2a7685fa7c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -219,7 +219,8 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-static void check_shallow_file_for_update(void)
+#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
+static void check_shallow_file_for_update_the_repository(void)
 {
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
@@ -321,7 +322,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 
 	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
@@ -368,7 +369,7 @@ void prune_shallow(int show_only)
 	}
 	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
-	check_shallow_file_for_update();
+	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-- 
2.15.1.433.g936d1b9894.dirty

