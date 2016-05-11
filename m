From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 92/94] am: use be_silent in 'struct apply_state' to shut up applying patches
Date: Wed, 11 May 2016 15:17:43 +0200
Message-ID: <20160511131745.2914-93-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5D-00056i-MO
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbcEKNVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36263 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357AbcEKNVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9358985wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+NFWDzvWe/6gKGiUvXRwqyNs/BPuvLJxAVPfmzsHgA=;
        b=Y29oT6iAoB3zJKtwPst1vZi66fw0LUB4tiLtFU3Wrvr2gJHuVLx1j3qdX9F5NaRB84
         SfUw9xHQ7IykPiaW0GJGMs/5x0ww+/99hBsE66bKtDf98LUxFJxTQlsCLjRqX+6meFtf
         TsYJGh3h0QqfjozfsBjcAV05QPtvz2/dSqJoQeWp9dB3ku4pFJqpniJSYrOi7vyvxMeM
         x+QwtzphxSfYwEb6MVEQ9UOtWXcZaKZJ/AeqC9lFqNaiU8MlfVxraoSqZBefoU3ZIgNo
         dyjVDG7ZDMQk5bJOlFZsG4YTGrUdoijZzAxXT/wpbPpoYu4ZzzTKF8Pzjs54wgNDHAVc
         Simw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+NFWDzvWe/6gKGiUvXRwqyNs/BPuvLJxAVPfmzsHgA=;
        b=VMbhHQtrXXuKlekRvJchrR+YhiUUc5FV+h+uROFLrvgWEH+Lda6IJEle7Cu8dbT5Q/
         ov3iO3dLk+PGsCNEVZk3hz0+VCZ5kHhM1T6HVe/LFd5440P9Ewpzh3KkJ9lgVE2G3BzX
         LmyZcQPRjKuobC0PR7iMCt1RfK36EDZ6FW3CLBZlgOkaByYT5A4XizTPWlQVOCr1N69s
         Bk0P+9WC4RUDhZjfG/WpnWTBx9CqDj/DGTh/Z7chrONNmtvz0oa6qTv7ncLkVzk4S1FB
         qeRgFA+7qrqQOhQFVgsnylg8EKDCZUNJurTFlu5h9SOinEZKGPPVaMNW2YlPVlIJaJZD
         3N3Q==
X-Gm-Message-State: AOPr4FVjS5uWJAnezdwOCllq1rzKm6aFS3ZsmY5/lOa9wTQO2MykDWoSUMEUgDHQphwdXA==
X-Received: by 10.194.162.130 with SMTP id ya2mr3743724wjb.141.1462972898273;
        Wed, 11 May 2016 06:21:38 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:36 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294305>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index cc66a48..c158c4d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1526,7 +1526,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	struct argv_array apply_paths = ARGV_ARRAY_INIT;
 	struct argv_array apply_opts = ARGV_ARRAY_INIT;
 	struct apply_state apply_state;
-	int save_stdout_fd, save_stderr_fd;
 	int res, opts_left;
 	char *save_index_file;
 	static struct lock_file lock_file;
@@ -1560,18 +1559,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
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
@@ -1594,6 +1581,14 @@ static int run_apply(const struct am_state *state, const char *index_file)
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
 
@@ -1601,14 +1596,6 @@ static int run_apply(const struct am_state *state, const char *index_file)
 
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
2.8.2.490.g3dabe57
