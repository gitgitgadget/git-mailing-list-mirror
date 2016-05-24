From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 14/49] builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:51 +0200
Message-ID: <20160524081126.16973-15-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:15:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Up-0001rL-05
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbcEXIMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36061 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcEXIMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id q62so3636604wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2RQRRJoB+Maz7WrMDmDf4pLA6MPP0JCobzNE6xIXGow=;
        b=wdemJ0Ob+d7Itin97m4gGcjkBOBXB7dx7Ju4BZ8BYZIk6bcbkOQIUWZX3yyTQrf3Tt
         vHfpsrYRKirEi7SFQPepVAVgc4QzPOoMeDCF5e+U7DBv+EQixGm6YBuk/oHIn1V+zetS
         69Pt3wnkDP/7F9ZBc+f5zRMrKOfBV1U75Vlx1QbHsm3YngaEP98VXd0gjPSi2sXj86CQ
         E/i4eEWvkPA1j6MrEADcF2g42OeX1MhfdwG5DwQ9ihyhSSZn4mQBAYUbIqIQYpFLeib3
         gKtUZif36mXWgEvKISZr1AG6QaV1k7hpYKPXjgfpBplxiwUOZam6cZ7sT6i62v5XhxxY
         v9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2RQRRJoB+Maz7WrMDmDf4pLA6MPP0JCobzNE6xIXGow=;
        b=i7wD7x0y82a72DTYIePBHZ4AO/OUrpCRUDIVN2igLK7dynnixilBA5+psSLQK/XYkW
         MhTaDkKn/ytSOarlXB/M9sDo+MrWpMlDNS3KLcl1OoAgWvuBhWr4kvHFxrx7LdwEjwvw
         zfiknw7qEN6sbfCBSc9NmSiwjG3SGbvC8X6+Vahbv9D/X4rmnianwJUGg0weDEyC7UiW
         YhpSu8P+d4mpq2MEDKz4SdY2Q+SLWcZ7ya2rK+MOv3dihC+zfP0jISRfQ0cGfe6UUA17
         N7XJ48D/eN3wD8phsr5pkj33Fg5bEnOSxIj+/yTXhcDE/AWMdbwLRmD6Uk7Pf8OPGGqS
         GNgQ==
X-Gm-Message-State: AOPr4FV49va1Vs5CsUanQatszTrPYMTioa1deVSflVJAJ/Py7sznkdStQlQutflf4q035g==
X-Received: by 10.28.93.6 with SMTP id r6mr23022858wmb.93.1464077525667;
        Tue, 24 May 2016 01:12:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:04 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295463>

To libify the apply functionality the 'apply_with_reject' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 796d990..8692e2f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -31,6 +31,7 @@ struct apply_state {
 
 	/* These boolean parameters control how the apply is done */
 	int apply_in_reverse;
+	int apply_with_reject;
 	int unidiff_zero;
 };
 
@@ -50,7 +51,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
@@ -3096,7 +3096,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 		nth++;
 		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
-			if (!apply_with_reject)
+			if (!state->apply_with_reject)
 				return -1;
 			frag->rejected = 1;
 		}
@@ -4462,11 +4462,11 @@ static int apply_patch(struct apply_state *state,
 
 	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
-	    !apply_with_reject)
+	    !state->apply_with_reject)
 		exit(1);
 
 	if (apply && write_out_results(list)) {
-		if (apply_with_reject)
+		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
 		return 1;
@@ -4631,7 +4631,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-		OPT_BOOL(0, "reject", &apply_with_reject,
+		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
@@ -4653,7 +4653,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (apply_with_reject && threeway)
+	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
 	if (cached && threeway)
 		die("--cached and --3way cannot be used together.");
@@ -4662,7 +4662,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
 	}
-	if (apply_with_reject)
+	if (state.apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
-- 
2.8.3.443.gaeee61e
