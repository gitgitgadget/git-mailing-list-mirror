From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 23/94] builtin/apply: move 'no_add' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:34 +0200
Message-ID: <20160511131745.2914-24-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U30-0002X8-Sq
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbcEKNTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34702 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbcEKNTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9412640wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MoPJUOt4nhXnijwQPcbqTEvUjBuVHkR3gSrFZ79BYqc=;
        b=RN2nhzl9yEIw+UZNwJwckBepom7FFO8SUo533exEUZmWkc0MGc+eo4KAM7O9xFvHAN
         A0goeSSM97J8rL80dageznGghZJMi5IKggjyPAYX1qKuA7O9yb+SLnolJ7P4VsKWJa+c
         //QfmwWWYwTE5m9EnegTY7hpXVbb+SOP3WJuudEop7mls8Y11tTw689a69SrCgsPkr/K
         REC9vcUjq/rRXBw262YChWUpHmk2Um8pcTFOnjrWEkZZG/cyV6fc2FknBdFbxZfTEodM
         SxOgBMwBUd6YTfGATexArlI4th99ZECf94eKV5y6+MQgn33DLZ6oNB4vPwnJwz6hDoIi
         QApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MoPJUOt4nhXnijwQPcbqTEvUjBuVHkR3gSrFZ79BYqc=;
        b=LImF+QgaEvzDuW7Tzr+u6eFLltsGXSJjRHDpjne/IgjSAyLrL7kPpPLvQT5D+PJeIo
         z2OM2wdXUqjEh9QnZT20Ax/N3jF92gGtT/aJp7xINLhS8xS7uqEXGBWaVPcecPD0eHne
         aXTs+4F1JuemJrdPksO4c0HDwHjM3uYEjDtbA4RsiqUL9J+4l6JupLVlZ8oL2ySpw6bp
         tXLYrxhI6R3mEO6k1zw7NqsxKzrqejxSwyBQ8uj1Z8aN7RzTpXrmoHXs9x2SC5BKcmZ8
         ri2433F6GJVJj9f2WZrcv/i57FsWr5NNRLOLvihRS+VyrzrzUzdHsi5BoCoinRqoK5uL
         FkAQ==
X-Gm-Message-State: AOPr4FWfwPN8ngR1v5JWuzI7IvG6kUsiT9QHTMfqOc5euNHGUUeoVxsXaj28X+JicmY4Jw==
X-Received: by 10.194.234.36 with SMTP id ub4mr3757391wjc.4.1462972752649;
        Wed, 11 May 2016 06:19:12 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294261>

To libify the apply functionality the 'no_add' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3650922..d699cd9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -41,6 +41,7 @@ struct apply_state {
 
 	int summary;
 	int threeway;
+	int no_add;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -63,7 +64,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int no_add;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2792,7 +2792,7 @@ static int apply_one_fragment(struct apply_state *state,
 		/* Fall-through for ' ' */
 		case '+':
 			/* --no-add does not add new lines */
-			if (first == '+' && no_add)
+			if (first == '+' && state->no_add)
 				break;
 
 			start = newlines.len;
@@ -4605,7 +4605,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
-		OPT_BOOL(0, "no-add", &no_add,
+		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
-- 
2.8.2.490.g3dabe57
