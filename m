From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 41/44] am: use be_silent in 'struct apply_state' to shut up applying patches
Date: Fri, 10 Jun 2016 22:11:15 +0200
Message-ID: <20160610201118.13813-42-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnk-00042I-0M
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbcFJUNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36274 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbcFJUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so1037849wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqU0wfHiof8QIq2VAM3KvpUIpt4j8swzxei0prcfwak=;
        b=BUTd4Z+Ve6O+6APN/b6+VT1q+g0ES92sjXUwb4itArM8hvhpTgx5MesL/eo93vETJE
         XxHFNRFBGRUrdwtKVOIvo5EeDaPXsPtywVljlgwOUW9aVnv0JrH/lznMBH9+1/xRNZKR
         kFZB/MQKmaWmKg9yTzaZQVkrKYk1MLc+pwfdZEeDS73gWAEGgyVmFvjs+6Z3XaAw+Xk3
         ws2luSN0F0u//uo/AGgTqS9yNkeTv1QqHPxVqZsXzxPxXio35551w/sLQJpuXKUosJu1
         imh94fkq+i7goUETGYxArsODe4IuvwVyxYDOmh+9cmlcnuPypjAgyYG7jXEOorEMMVEV
         LFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqU0wfHiof8QIq2VAM3KvpUIpt4j8swzxei0prcfwak=;
        b=DFVz4AcKPv3WAyrTM/AsMLfMKsPJuTQqGCwC0uYILq02Vp8aSFl6+iHXsgTMOuX52q
         KFdy2isY7U1Azl7D0IQtgN//Ad+xsKEk8+SvC0DdcZ8sexr14VgQxBI9nVROjUdJHin/
         77S1t96mMBAMkE48+Y6KwcVUd+uBOAu3B9jsj+8yeXdRMQJAcuhPG/OKLdy/FgWHqqiW
         6kuDiDTbWyJ9kTh/rVRZw/u/4CUCXDdoO8UU0OEImGa8AqaDBzs+9+WDuZuRRuGjyay8
         cyVPKf0jGJykFHegz07W2GkmCti69hUp3UQOlQsW/ECYCKTOqLx/z3X17s7m16ki1k+K
         cx5g==
X-Gm-Message-State: ALyK8tKW6PKMAwtXtFMcumjXt9E8NefphcHd21diDVpvRdDopH8E9P6hxzRKppj6Fya4ww==
X-Received: by 10.194.206.39 with SMTP id ll7mr3637348wjc.179.1465589566667;
        Fri, 10 Jun 2016 13:12:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297050>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a16b06c..43f7316 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1525,7 +1525,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	struct argv_array apply_paths = ARGV_ARRAY_INIT;
 	struct argv_array apply_opts = ARGV_ARRAY_INIT;
 	struct apply_state apply_state;
-	int save_stdout_fd, save_stderr_fd;
 	int res, opts_left;
 	char *save_index_file;
 	static struct lock_file lock_file;
@@ -1559,18 +1558,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
 		OPT_END()
 	};
 
-	/*
-	 * If we are allowed to fall back on 3-way merge, don't give false
-	 * errors during the initial attempt.
-	 */
-
-	if (state->threeway && !index_file) {
-		save_stdout_fd = dup(1);
-		dup_devnull(1);
-		save_stderr_fd = dup(2);
-		dup_devnull(2);
-	}
-
 	if (index_file) {
 		save_index_file = get_index_file();
 		set_index_file((char *)index_file);
@@ -1593,6 +1580,14 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	else
 		apply_state.check_index = 1;
 
+	/*
+	 * If we are allowed to fall back on 3-way merge, don't give false
+	 * errors during the initial attempt.
+	 */
+
+	if (state->threeway && !index_file)
+		apply_state.be_silent = 1;
+
 	if (check_apply_state(&apply_state, 0))
 		die("check_apply_state() failed");
 
@@ -1600,14 +1595,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
 	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, 0);
 
-	/* Restore stdout and stderr */
-	if (state->threeway && !index_file) {
-		dup2(save_stdout_fd, 1);
-		close(save_stdout_fd);
-		dup2(save_stderr_fd, 2);
-		close(save_stderr_fd);
-	}
-
 	if (index_file)
 		set_index_file(save_index_file);
 
-- 
2.9.0.rc2.362.g3cd93d0
