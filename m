From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 12/48] builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:40 +0100
Message-ID: <1457545756-20616-13-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHs-0007jf-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700AbcCIRwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:38 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36655 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933669AbcCIRwd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so190583201wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMRPo8xLpJDXpwZwBo9AWs/TK/xxdMaQaaocz/NaVzw=;
        b=NOKbKIa35l7ewWnedvgSFzjt53855TjAI7VjrIMp25hx4yuAGpU9h8P08HMQ0fgkTM
         sPv8iliDy1JTPhTSo4uOqNslJ0LteL1pIZw7+I+LTejqvzoRyo84CRKzR9rzoBwwcfgt
         HM32pSgUgVMKIbpnTi5w3zYYDlpG4eLLu23DQfYyRWdz/gV/KCKCsP9AeX5l9OPrvvH/
         Nk+Th5iTPQKm05XQkfAOfggt+k70oFOgxr9JJ1pA9F/rQDYGCYSYD8wfKFyAaf4JFk0r
         uscT9IH/82zVi19PGf+wOnnMhRHYXWOyaFrPnysUZvA41evVCQMPQOQln60NhOR9fD+Y
         zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMRPo8xLpJDXpwZwBo9AWs/TK/xxdMaQaaocz/NaVzw=;
        b=BdONW+hA+2VcuDtN4EL7tgPgSMBc8Kq4e2lkfQ72+vpO1Dt5xO3DOG/HlSuJtRyeDm
         PepwXj1SIgQ4e27W9QJYKSxMZVNHzUU9NS/RI8IQoucUumGzSDEjEmOzZfXiwmXsVwS5
         gOsGaPggVAKLE3S/7Yk3rZRPF6Opf6kA8I4L9bfxEOrKtG2SGkRKarCOdg9al3Hj3Pix
         YkcWiMgljCCEt4nBMiTa2MCNUImOz4JVzDGpGuW5W6i7wnGgAGjcIrmc7TLEYkMrgXY1
         LtTUp1MpMFy+JWjSnnkG87AslTUNUyrz3oFIFoVr7VzWHlcTCW0yKTTLL89DM00PkwFy
         PNKg==
X-Gm-Message-State: AD7BkJL8XGow9tZaBDlTHsn7aj5xRPrk3gam0bVF475DscnSuWqeDEJnmCcbKHPC3e4vSw==
X-Received: by 10.28.142.202 with SMTP id q193mr400202wmd.60.1457545951774;
        Wed, 09 Mar 2016 09:52:31 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:30 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288498>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6bf3024..fcb3c14 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,6 +27,7 @@ struct apply_state {
 	int newfd;
 
 	int apply_in_reverse;
+	int apply_with_reject;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -55,7 +56,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
@@ -3105,7 +3105,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 		nth++;
 		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
-			if (!apply_with_reject)
+			if (!state->apply_with_reject)
 				return -1;
 			frag->rejected = 1;
 		}
@@ -4467,11 +4467,11 @@ static int apply_patch(struct apply_state *state,
 
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
@@ -4617,7 +4617,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-		OPT_BOOL(0, "reject", &apply_with_reject,
+		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
@@ -4648,7 +4648,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (apply_with_reject && threeway)
+	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
 	if (cached && threeway)
 		die("--cached and --3way cannot be used together.");
@@ -4657,7 +4657,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
 	}
-	if (apply_with_reject)
+	if (state.apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
-- 
2.8.0.rc1.49.gca61272
