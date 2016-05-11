From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 17/94] builtin/apply: move 'allow_overlap' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:28 +0200
Message-ID: <20160511131745.2914-18-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8V-0000em-7v
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcEKNTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34565 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcEKNTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so9411452wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f3587o3bVbX0SGGj6FDHYJzda2hEuIx95iFyi0KxDSM=;
        b=b2F6JXEHMSeD9IX+oXrrtIqod4icq4S8G71wPt91XGGtVzil6QQR27kaALwg9a2q9v
         BdslQhGbjw4wtXabxykhtmLc/ifGSF85fQHV21UrZlzd240MjorOdKpOL5FQy3oTQugu
         p5s9qIm8TazFM5Cry+kYVQZ8PKNqgEpuCtIVl0jZI/EyosHraabosJpEJLTkq+kg1NQz
         oPWlHfxLSlDKi4dAL1Xjec/NumqzdrFrLz4lGmacg8EniRN9I3OhvEBHPrdf9xfqJi4+
         jMDMaxtCgqAOx7Co5YehCHNT2Ijo8kmgs6oyGbHswuQsl/zRpLyj0Hl3XaocODYc7Ph+
         g/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f3587o3bVbX0SGGj6FDHYJzda2hEuIx95iFyi0KxDSM=;
        b=PeOBFBiz8gKm5uC+yxbwNcZoEOSiKcBDqfo3vpYkrWApWRdUwuGmW9Ac3Jw/cIviB5
         EWfnSe6lVx/mf8S1IJ21TlxDLrtw5AYoFki7ocIQFhH1dvUJWb/yIvRjWviZeDyjT0Ew
         7/AR5Pl/+Me0GxsWoAP5R9AXxXbDr8O1CxwWZH+IIW7JvaB2QeKlVgvj1gd0+buvtXlL
         pHl6MoKWWbTeZcukn6kbOkbbwh06e/VPoZkCQBf2tem3r521o0QPHc9sxmXnYvsnJp64
         I0Nqh1YBsUwwkGJSAo7PSdZnyi8vX06Ywjt/Wo5sXoiIg5g84sZprijIUROrtdU460B6
         dQvA==
X-Gm-Message-State: AOPr4FUnpB+Q5DYUjWgfj46o+RdWLM18YJPZWuV+D1gbnXwjjFCtIsHJ23wr+8CXlS/MUA==
X-Received: by 10.28.31.73 with SMTP id f70mr4545632wmf.77.1462972740786;
        Wed, 11 May 2016 06:19:00 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:59 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294333>

To libify the apply functionality the 'allow_overlap' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 635a9ff..8791b28 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,7 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
@@ -57,7 +58,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int allow_overlap;
 static int no_add;
 static int threeway;
 static int unsafe_paths;
@@ -2632,7 +2632,8 @@ static void remove_last_line(struct image *img)
  * apply at applied_pos (counts in line numbers) in "img".
  * Update "img" to remove "preimage" and replace it with "postimage".
  */
-static void update_image(struct image *img,
+static void update_image(struct apply_state *state,
+			 struct image *img,
 			 int applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
@@ -2697,7 +2698,7 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	if (!allow_overlap)
+	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
@@ -2945,7 +2946,7 @@ static int apply_one_fragment(struct apply_state *state,
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
-		update_image(img, applied_pos, &preimage, &postimage);
+		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
 		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
@@ -4640,7 +4641,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOL(0, "allow-overlap", &allow_overlap,
+		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-- 
2.8.2.490.g3dabe57
