From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 22/94] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:33 +0200
Message-ID: <20160511131745.2914-23-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8a-0000ii-3e
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbcEKNZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:25:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33754 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9407582wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gTLEIVOrec/4SiYU0Ym18KOSR2HmeyZF3xSy4khrDL0=;
        b=GOCkHpsmusZk/Ea2sQSPc7nd3HY7+6tGgiMWLcy+Sk0S4y1v4WDqTf21CLWsdTzNDV
         tpc5LtVquzR9OK9VQCp+9KNJDJnKNjEEZjWxoG6HXPk5exGrZ4ib5sZLA3ZuHr5KF+W7
         goJVQq8Ts5mkGZJvnt1eTdELmhVlV32bC4XXczGJNCqdjIxYF9gMl2ZyRjoo9x/YOrGK
         jOY9+R+rhYQUqpjRrglc1AArd4AXco7EEE7eCJGJ+K50PaOM46jm1hQvODBnNgAJ6gbZ
         Nt35F7cLjzEMGaYtn7pFo7AjJUOx/gFdJ8UbPkJddPQ+wcU0QjFaY24svsAKojxCAwOV
         0v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gTLEIVOrec/4SiYU0Ym18KOSR2HmeyZF3xSy4khrDL0=;
        b=TeZ0d7wt/E7g5SkFE85OavCBQbIdn19Pdfu/ZOiddSklxaGDNqyXScW9/TSeDHNWJG
         KN8Bf8btQyK2LAbVO0e79EM7e0rxh9Ahbm/MmLuB2r0kzTYmL5eSz0JIWm0U0MkD4b5v
         aVEUZ4Z0v7uF/tBv0/Uv0E0v8mhOL2FSoi9nBSE57IW7TWoq2XCMBYL005Fj9PEfWLEy
         ANTvwwvXRFO75dNpgV1equyATSyASHhVtX6QpbLNqyyB6Jlx1FgTLFBofdANm1AkjASl
         jS7kLmo8NRjUiYw0+LhyoE6y/09x6QCpcHZGOLhhbnolIErFia+q2Wk5VgLjormUmID9
         XPTQ==
X-Gm-Message-State: AOPr4FWDAXC7cOnJv30zD1R2JWNZOWctt7w/q/PjRNPncdmN+Ma2tFo2Vb3i+vvjB/ok1Q==
X-Received: by 10.194.85.161 with SMTP id i1mr4050389wjz.95.1462972750618;
        Wed, 11 May 2016 06:19:10 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294332>

To libify the apply functionality the 'threeway' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6216723..3650922 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -40,6 +40,7 @@ struct apply_state {
 	int numstat;
 
 	int summary;
+	int threeway;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -63,7 +64,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static int no_add;
-static int threeway;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -3501,7 +3501,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (patch->direct_to_threeway ||
 	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
+		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -3796,7 +3796,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
 		int err = check_to_create(state, new_name, ok_if_exists);
 
-		if (err && threeway) {
+		if (err && state->threeway) {
 			patch->direct_to_threeway = 1;
 		} else switch (err) {
 		case 0:
@@ -4625,7 +4625,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
-		OPT_BOOL('3', "3way", &threeway,
+		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
@@ -4669,11 +4669,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (state.apply_with_reject && threeway)
+	if (state.apply_with_reject && state.threeway)
 		die("--reject and --3way cannot be used together.");
-	if (state.cached && threeway)
+	if (state.cached && state.threeway)
 		die("--cached and --3way cannot be used together.");
-	if (threeway) {
+	if (state.threeway) {
 		if (is_not_gitdir)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
-- 
2.8.2.490.g3dabe57
