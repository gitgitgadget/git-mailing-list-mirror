From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 20/48] builtin/apply: move 'threeway' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:48 +0100
Message-ID: <1457545756-20616-21-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIE-00080C-8N
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933723AbcCIRxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:00 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35052 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710AbcCIRwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:54 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so190216287wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vvJS+kjh3anTwTO5VoKj3zU2pWgYEETOQPOcIfh9fbY=;
        b=JbR3uuTuHPXIzlntcM8TB1oKgAwcDiinWqubuoTJkXemRw7bzpChMh0iYKxaoO30ZS
         hveIXpbXrVGNgrvnrWkAgb4K+zOcVNWTlPFsI6qL7VPiQZDUnBTKZrszuJk7+JO/RiAW
         d0SjGlchJoTEUkoLKoWmK0Zet0uFUJee6ht0NXcJCTtJu14/ROIvqu1IgFEeBsv9OlfY
         ark5+zZRrR8olBgaX+bSkEq2I4tH4e6bhQ7BgvVb69MtQCbgEhbj/YUuceBC01242GOl
         3fCAVYvSE0+f1WUnkFYVmOoOimuWzOTgr0P85HV4FyrYFXQm0kQ+qzVTZbaK5gKT9u+c
         Pz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vvJS+kjh3anTwTO5VoKj3zU2pWgYEETOQPOcIfh9fbY=;
        b=YnJ2297pSF7eAB5mjOT2zl6FY54Z16fGqPKc2Cla6ZDz/g7e5awcGE6LZ4lIOwz854
         B+SRyQb9tOimalllyyuI8I5RX3GXXeNCNuGcWu8pipLEGMv7Pg5pGVxulqDyz5+qb+ML
         zUSmkfW8z8ryqqhpE9IH7ZZQtUMQV+gzO4WXXr2SywqoxWWFG2IvU/AI+0aYldPd6gqm
         wTVeJbPTStpeWXCLzFtOsyvCUnL8eTEW+4eqqDfWyFvus2o4wc9V8JpPkvA7ZLtCEH5y
         Ceb4LCGlMKLf8mk6hNN1vgo2d+WDsv+uDPOmn9VhLAkrX9C7Rlezot8z0aF3ssgbdU/1
         85zA==
X-Gm-Message-State: AD7BkJLYxSOiz8uDfkVFC9zCtvzUWsI9L5ggVf7SVVlI4x/V1zslKJMes6I0MOXMneLQug==
X-Received: by 10.28.14.8 with SMTP id 8mr417355wmo.66.1457545972813;
        Wed, 09 Mar 2016 09:52:52 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:51 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288510>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1542dcf..fab731f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -42,6 +42,8 @@ struct apply_state {
 
 	int summary;
 
+	int threeway;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -64,7 +66,6 @@ static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static int no_add;
-static int threeway;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -3506,7 +3507,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 	if (patch->direct_to_threeway ||
 	    apply_fragments(state, &image, patch) < 0) {
 		/* Note: with --reject, apply_fragments() returns 0 */
-		if (!threeway || try_threeway(state, &image, patch, st, ce) < 0)
+		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
 			return -1;
 	}
 	patch->result = image.buf;
@@ -3801,7 +3802,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
 		int err = check_to_create(state, new_name, ok_if_exists);
 
-		if (err && threeway) {
+		if (err && state->threeway) {
 			patch->direct_to_threeway = 1;
 		} else switch (err) {
 		case 0:
@@ -4612,7 +4613,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
-		OPT_BOOL('3', "3way", &threeway,
+		OPT_BOOL('3', "3way", &state.threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
@@ -4665,11 +4666,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
