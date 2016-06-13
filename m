From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 10/40] apply: make init_apply_state() return -1 instead of exit()ing
Date: Mon, 13 Jun 2016 18:09:12 +0200
Message-ID: <20160613160942.1806-11-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSw-0004no-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424887AbcFMQKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33337 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424850AbcFMQKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so16042202wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gVZuPgeFX8HA/agx6Adq4TlgegNPU27o93/h0HiUhvc=;
        b=gL0zSfVoK/LbSs0ZpSSANV/IoSHaubH4OuVqBVjA19Ib3UqoJSpUwOvLe994UyMcJr
         I5lprRoOSvHYOQqKA3ouhWhufRK2TrxAaHHzu5NQUlwuUYSJx5xlltotGhfbf2vL0/pH
         fgSoay2eDqrH/b72QsqjTsx4SQQ9STHNoKf9yToS0OSDPxbf0ROjiUsF61Fsr+IvrbpX
         IIzVysKtphAKVUqzug6lrpS86lGhgaDDSZL7SR4QV9nwdEhSEoYoy3pw14jxvY8nlc/F
         bhJEpOKm9eXQp1zpJil/ayAgYYSja3fsNFL3O6jIs4cl++FDRVVmj8A9JA8VChx8frlj
         5XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gVZuPgeFX8HA/agx6Adq4TlgegNPU27o93/h0HiUhvc=;
        b=OWhH1bW89LuEaVHN8Kxj4h3TMZ8yBq7eq87TG/c7NIkp+VyGgxUaSK18s5J43MQ6wd
         bEy/hKI+DV8sx+BqDiYbazylu1We3qPxy3EwF+KK6K9W1kcob9lcWUtg3gyC+Q5DEWk+
         4xTdU+PBObKS+GlvzSX8yqZBx6v75V4JQSRBWlcCXRLm5brrS+X0M3c0Ek9NPfIgr+9Q
         fEsz/BSGDkIdePygxsqIe/uByagEXGB/UvLBSGrsPznhpg+KKpG5OiaboJYy9jq4JBUX
         kKUkdhYEGfx8JbsWkoefRClx5DTo/X8ZILACKcv7SbyMNeSDKq4yX+pog0JE+YisHtTZ
         u8gQ==
X-Gm-Message-State: ALyK8tL+yHiPXKV4tv6p46w4wXNPI/hI8jGqklm3CErnASPmbHmuWKpAvxRCgwrUW/xphg==
X-Received: by 10.28.17.132 with SMTP id 126mr357284wmr.90.1465834210817;
        Mon, 13 Jun 2016 09:10:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:10 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297226>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", init_apply_state() should return -1 instead of
calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 11 ++++++-----
 apply.h         |  6 +++---
 builtin/apply.c |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index 1f31bb4..c5a9ee2 100644
--- a/apply.c
+++ b/apply.c
@@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state,
-		      const char *prefix,
-		      struct lock_file *lock_file)
+int init_apply_state(struct apply_state *state,
+		     const char *prefix,
+		     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -76,9 +76,10 @@ void init_apply_state(struct apply_state *state,
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
 void clear_apply_state(struct apply_state *state)
diff --git a/apply.h b/apply.h
index 77502be..7d3a03b 100644
--- a/apply.h
+++ b/apply.h
@@ -102,9 +102,9 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file);
+extern int init_apply_state(struct apply_state *state,
+			    const char *prefix,
+			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index bc15545..2ae1243 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4728,7 +4728,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix, &lock_file);
+	if (init_apply_state(&state, prefix, &lock_file))
+		exit(1);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.9.0.rc2.411.g3e2ca28
