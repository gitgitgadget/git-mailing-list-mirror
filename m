From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 09/48] builtin/apply: move 'check' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:37 +0100
Message-ID: <1457545756-20616-10-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHm-0007er-DN
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933691AbcCIRw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:29 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38660 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933685AbcCIRwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:24 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so81969411wml.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v+upVIwuonaYVjWLNnb0Jz5uyVb8uSiBUhRCTnaD2k0=;
        b=opLD1oNWjdyUg0aer/t3fPRlm6N4QmnfWAkKMts8e2WnfwSzGBXU3eISmbZJEKLI4i
         ih4kUpRIP5LwpTEqGhKL17I/iVdlVK4Y1TC7H2/wtiWJByFwFn8ZZlwv2aKoQgfhLIhk
         s4cdSZ/FtsRGRR1JSlPWS91AfJYsJeRyyGqvQ8GPmLwmUsAbPBJLFCGVP/p+U8ZAMjt3
         BHtjHjLTojSid6rG74Wixpc/NhThxrJo3A+exyxsC099AXt3YmsKjVzgOMK6Jab+sC9K
         HiqTabyY61aW0mjPC+gYIdy1nd8RoVvAv383a62ahmkBLvpGFrcSqt2hZsQtZH95BJKQ
         wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v+upVIwuonaYVjWLNnb0Jz5uyVb8uSiBUhRCTnaD2k0=;
        b=LBtcBPZN4udufxpm3Bd6dy7ZNq/k+v+o1+toD89oz4UfMye1NXixxxDuJIoVvDeP+2
         dtKHomG7osrJaFaaa1m3dz2YKaZeN9gmjAsVQCMo8xdJK01HHkyz86Qw3qpDjRPpHSZ9
         9Vf4tqFw7IZYq87ZCLMrv7wjMz0sqOVMpUoVlQqMJ364J7hm6pHTe1xt1xCu8vAPpTYX
         u4pvLdP/7nVuzOG2wawE9oJSNbu/eTGT+yArr/Lz5ApcsyIcbKhXbKx78ZYxd3IIufoy
         7cooY9sDjHnsSGcaNmjYT8vxupe1ukmZ7tJpUx1Is4lIONIgzKMq9a4Temae+w/dnYTy
         /XNg==
X-Gm-Message-State: AD7BkJKAZi5nJD6Tb8jxY/FS2uctu1KGVyL1j911E+FVHtGk9jIC4RKCtEufvflNdGfQvg==
X-Received: by 10.194.60.20 with SMTP id d20mr40303075wjr.109.1457545942722;
        Wed, 09 Mar 2016 09:52:22 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:21 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288499>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d5bc30f..37879de 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,12 +26,15 @@ struct apply_state {
 	int prefix_length;
 	int newfd;
 
+	/*
+	 *  --check turns on checking that the working tree matches the
+	 *    files that are being modified, but doesn't apply the patch
+	 */
+	int check;
 	int unidiff_zero;
 };
 
 /*
- *  --check turns on checking that the working tree matches the
- *    files that are being modified, but doesn't apply the patch
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
@@ -47,7 +50,6 @@ static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
-static int check;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -2055,7 +2057,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || check) &&
+		if ((apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), linenr);
 	}
@@ -4439,7 +4441,7 @@ static int apply_patch(struct apply_state *state,
 			die(_("unable to read index file"));
 	}
 
-	if ((check || apply) &&
+	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
@@ -4559,7 +4561,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOL(0, "check", &check,
+		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
@@ -4633,7 +4635,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
+	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.0.rc1.49.gca61272
