From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 17/49] builtin/apply: move 'allow_overlap' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:54 +0200
Message-ID: <20160524081126.16973-18-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57VX-0002Bi-0f
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbcEXIPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35358 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbcEXIML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id f75so3654323wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3nkr5WEceT3iA5OYcZMn8tat/qzwOgGJC0J7EgoJ+g=;
        b=D0n90KWujqNOyZ1u0rK4MJTfjyWJRBxUgf05+vLTaqsWr0yYC2cDca3gcNUcUxGBcN
         /eEc6NBejz2TVQd9EKtLr8fYDwSoCQqjhBvutNTwB5pBPwcX02Xqs5bRJeIsEac7SjsW
         KDBHuJJobg+HlayfXCAHc3mOZ8o6PdYo/eM0jHOXDCyCOjSS948fslJyWuJachw5WPY2
         IQp8zARbYIbJuJwTW9O6phfg3CsTkINT2zYrTqEqrXuq/VbEzVeZE08K0Spo1+WVy+W7
         vZw6wS7GExH1i9vPPohCVxpxfF3Qw28Q5PqJmSsru6++STFcuPRmZf6H0eq+q3AeyCHn
         SndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z3nkr5WEceT3iA5OYcZMn8tat/qzwOgGJC0J7EgoJ+g=;
        b=f8iYocBP48OB9TpOoBZXcs8WKarpgzMNM6OLqPLWXl/rYI5EWbx+ItZRNP3Gci3jXl
         whgnHffkU6Sqay1FooluxD1tNr621aFd9vhbw0jj40YdH44F9+SyOA+a1yyRcGLpCESx
         qm+dIfPDs2Y1K27JwIlbocUWxeh2Jehx3I6Be0YkkSI+IZLoYxZNtyPA96FONgciD+jk
         elCpRZvIaMvO3PWblVGaiLeRxa43rJCCxlMA1wfylDDzI3M/6WYfdxGzqJqN8hiWOBjL
         fP6cq5RcFOfSg29g2k1qZXCqqyi3Y5GEH5O8trdYTL+YVBJ51DCPmgMb9cLRmh4MJfpN
         WPLg==
X-Gm-Message-State: ALyK8tJxzEMV86cMH0w+xc2zixfXSzyRtseMcV2/0bSPnvzwc7/aT6EMIyRJmUXC+Xo2zg==
X-Received: by 10.28.31.68 with SMTP id f65mr10749398wmf.45.1464077529698;
        Tue, 24 May 2016 01:12:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:08 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295472>

To libify the apply functionality the 'allow_overlap' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7b5abb9..ad3bec4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -31,6 +31,7 @@ struct apply_state {
 	int update_index; /* check_index && apply */
 
 	/* These boolean parameters control how the apply is done */
+	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
@@ -52,7 +53,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int allow_overlap;
 static int no_add;
 static int threeway;
 static int unsafe_paths;
@@ -2627,7 +2627,8 @@ static void remove_last_line(struct image *img)
  * apply at applied_pos (counts in line numbers) in "img".
  * Update "img" to remove "preimage" and replace it with "postimage".
  */
-static void update_image(struct image *img,
+static void update_image(struct apply_state *state,
+			 struct image *img,
 			 int applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
@@ -2692,7 +2693,7 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	if (!allow_overlap)
+	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
@@ -2940,7 +2941,7 @@ static int apply_one_fragment(struct apply_state *state,
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
-		update_image(img, applied_pos, &preimage, &postimage);
+		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
 		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
@@ -4640,7 +4641,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOL(0, "allow-overlap", &allow_overlap,
+		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-- 
2.8.3.443.gaeee61e
