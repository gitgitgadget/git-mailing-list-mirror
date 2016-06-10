From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 20/44] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date: Fri, 10 Jun 2016 22:10:54 +0200
Message-ID: <20160610201118.13813-21-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoB-0004N6-NK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcFJUNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34295 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbcFJUMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so1055736wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StthcsJwIyhq+KLmECtY5QWFUl56ud5WmZH6yOWqwVQ=;
        b=hbI2NYhFilINrY8ZhtLj2YQIo/iDaPZ20/QjUERuFEnZbXJOzv/ozKYVHVaQhPuCz6
         NIX9hPMOZYvVJ7DyOaoeZtJD6GjgQUQ9Wfh3Y/fASxj1JjPSYxKbWkpwOQeEjG40YQwf
         alCfOCgJ+tg0XDGzTMkvU7Eo9BpKQPqNFA2GLGW4h+SC0LLML2ACyXhMqA/USlCK7zgG
         6CfD0U3dPbKcl58I9bdfCDB+TYgh8bqLXFtY4PZ3mHt4CXZVhj6820K0oCWn35MNzjlq
         a9OYYg/mHwcg85oW1VXDVoV6kUhqyiKS5OZdWuAyF9+Z7KzPkUpR516TXV5cQtA8EHie
         KsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StthcsJwIyhq+KLmECtY5QWFUl56ud5WmZH6yOWqwVQ=;
        b=Iu212EFgAZ9MUYraXGiJeIsH2cuKIvoFd+aABqpvbTvRJpEWPNqOwidthcmKyoQS+q
         XcxfqPrUR9MiIxLALNuDUIuOfc67iI1DCmHgkRYTIHSgJQAqEWPy82Fvu3nGHUE5CAOm
         g+lou+Z4DGJHtcExJC3iL93HJv+75BBIn9b0nQIuZxyEYjdF8j2DXsHTkoUGaxJ8N8jO
         QrvekR8cpqPbdyBpdkLOPciMHkEm6SHWVZVqHG4glvR4MEePa7Rgc2UKVf1+ebI34xup
         ubujArTUJ+LZTWhQFK/AXjFNHdqVlW0iBzFJnj9edSYttEzRAaVVDxjS468esdeHwYg/
         +YRA==
X-Gm-Message-State: ALyK8tL/RfSQGJnlYGAVDt1PejPWd8CPi6St+gywEr7TBriqxHSl6CMHPbvSeKd4Jo/Jog==
X-Received: by 10.194.72.103 with SMTP id c7mr3703566wjv.141.1465589527424;
        Fri, 10 Jun 2016 13:12:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297058>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 694c65b..0997384 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4213,7 +4213,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4221,7 +4221,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4236,9 +4236,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4252,9 +4257,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(1);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.9.0.rc2.362.g3cd93d0
