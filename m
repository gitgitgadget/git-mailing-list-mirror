From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 15/83] builtin/apply: move 'allow_overlap' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:15 +0200
Message-ID: <1461504863-15946-16-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFe-0001LC-V2
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbcDXNjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:39:01 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36413 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbcDXNfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:08 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so69557563wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hteGwzz39cak6WomJSRYpCXpZ7yBcKgV8PhQ2tXoBmw=;
        b=xSKQ4N0BDpUfH19b6LSjxN0xcmQhmFvmQHVXfe4C8chyB8ExW8DhKz7jhfcc6SPNmp
         n1uAfgZLMVhokjmMMOYHn5V+wuTfzf4m0VVw6W1c9h0FT+v2NOoER3WktjYOVi/HEsj8
         Q6IFyg0Uo3v/DqRpM42n7cJ83yz9WW9pzw+DBMYgFvKOcarFGNU0JBUbCmL39QQJWCWy
         5IBYGRsqOjmFeXZEQ+kDaSzhNCoX/OEzHERLNVjfkqwW5OhG7GkA4wIweZ8rlE2THHx4
         PI1Ot16L5qg7RLirjAzZ12OslzUKEFA9X7mFkp48mtb5PwHH7W43H9QrIpBD8ghLXRaj
         No2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hteGwzz39cak6WomJSRYpCXpZ7yBcKgV8PhQ2tXoBmw=;
        b=kCNV6DCz9RtkOvEKOkKp8VZJUiaxHyFByHwTEHO8dAJt/5aQeeXoSeiYtpKpJZQYg0
         Fiy2Xvz68+nPZ2RDvvZGLBjGBJEvMW3+e5UoKhW/zqNoBwgdty/L3lAHpy2itNfziFrJ
         RRXwfCQD2N1N6VjNXAoIcuGXmkT1bUVIsLWF+JTSmMr8F9S3hpnUHzQ4N9bmGr6yKpoW
         Mk/LWSebravAVBD1h+3SNbaSKlkZcC3tyW4rQnYdMwyt3QBZHvB3ge4yIJJUWE/eN7Zv
         A0iuzImgulY12BJuSKlPc+soy5b2ZVO0TqogUmcv3Hc4jx9jiteGKoem3fh2cCxntNNK
         TNQw==
X-Gm-Message-State: AOPr4FWgn/3IX6kNgCrFacOZeWh00toGXbeMXSu3XyZdJmuo3YwpXLrZxysce0NKLEbi9w==
X-Received: by 10.28.140.12 with SMTP id o12mr6848104wmd.19.1461504906438;
        Sun, 24 Apr 2016 06:35:06 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292396>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b57be2c..a5dff99 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,6 +25,7 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	int allow_overlap;
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
@@ -58,7 +59,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int allow_overlap;
 static int no_add;
 static int threeway;
 static int unsafe_paths;
@@ -2635,7 +2635,8 @@ static void remove_last_line(struct image *img)
  * apply at applied_pos (counts in line numbers) in "img".
  * Update "img" to remove "preimage" and replace it with "postimage".
  */
-static void update_image(struct image *img,
+static void update_image(struct apply_state *state,
+			 struct image *img,
 			 int applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
@@ -2700,7 +2701,7 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
-	if (!allow_overlap)
+	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->nr = nr;
@@ -2948,7 +2949,7 @@ static int apply_one_fragment(struct apply_state *state,
 			fprintf_ln(stderr, _("Context reduced to (%ld/%ld)"
 					     " to apply fragment at %d"),
 				   leading, trailing, applied_pos+1);
-		update_image(img, applied_pos, &preimage, &postimage);
+		update_image(state, img, applied_pos, &preimage, &postimage);
 	} else {
 		if (state->apply_verbosely)
 			error(_("while searching for:\n%.*s"),
@@ -4629,7 +4630,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOL(0, "allow-overlap", &allow_overlap,
+		OPT_BOOL(0, "allow-overlap", &state.allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-- 
2.8.1.300.g5fed0c0
