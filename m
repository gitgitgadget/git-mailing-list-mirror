From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 39/49] builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:16 +0200
Message-ID: <20160524081126.16973-40-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SM-0000wb-0A
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbcEXIMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34877 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699AbcEXIMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id f75so3657950wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dNGnbdJ5X68nkzcls0yCzzybO2NIXHadIP077y5qxO0=;
        b=nOCi8PCjZikRsezX6dTtw2KExrH3qbT2oNkeV2FKzXVrONdobfFN0CSHf6I9zRry0p
         GG5pRyOmcMINyNTddzYAL2tF/EmFheimnyp923T3wmtdnS/17CspBZCGDoa19PfOeJsL
         A958OzjMOg7lcC0A7wfK37Ji52aOxh8qEZ2GcTsL9PFoaFRy3HMowHt4UPdwkMEZtIOz
         AROL+6iyhvJI2H5LM5E0a6u0s2gmhXgDaV7aMjfwwAR4lBkjc3l06OgJ81d55UWGmxQZ
         aWQnhfcBJzN7jI3bu9+S+CFfM6REmmEw5XlbQqYw/+dt0jOiB6BnwTYp3NneEqn6FFHE
         EvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dNGnbdJ5X68nkzcls0yCzzybO2NIXHadIP077y5qxO0=;
        b=FVj/vj/gOmCn+Y9mQECmG5wwW4tWFhq9xMky3iwIFU7piNHVrHQk7CJ22SZAWalxlp
         bv3xPojtvhIrYJYeQGxN+DINoUXZE/VTb0ijUlomNxh40L5ndifKd2FlA0c9dMlY5BPY
         jNOPHtiDYul1RgSn9MOUudRB2YYL+5LWAFf0yk4fUxDgPcjB7yfrMJWnFe87dY4VSRgs
         hK7vah7ZW3iPHKDCbM+YOflAlpw9M/y0tuT6sIyhlWHZNvZdNKQO8PMXLI0tsGX3Ot5u
         zW4PtAO8Zg/dMp7cqog8Qngni1GAWuVTtSosA8GzPLg1kcg4i8ZuSkqC/iZ91Hl5xe3L
         3Oug==
X-Gm-Message-State: AOPr4FWXeBFXlyJwb4ll0KapktbJwnUblQ9FAcGHcV3z2R2qh1S1xdU3yuS0QnNtzHOJQw==
X-Received: by 10.28.88.208 with SMTP id m199mr20594934wmb.39.1464077560148;
        Tue, 24 May 2016 01:12:40 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295439>

To libify the apply functionality the 'applied_after_fixing_ws' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 619b8fb..91b6283 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -64,6 +64,7 @@ struct apply_state {
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
 };
 
 static int newfd = -1;
@@ -79,7 +80,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int applied_after_fixing_ws;
 
 static enum ws_ignore {
 	ignore_ws_none,
@@ -2862,7 +2862,7 @@ static int apply_one_fragment(struct apply_state *state,
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
-				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
+				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &state->applied_after_fixing_ws);
 			}
 			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
@@ -4806,11 +4806,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
 			    state.whitespace_error);
-		if (applied_after_fixing_ws && state.apply)
+		if (state.applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
-				applied_after_fixing_ws,
-				applied_after_fixing_ws == 1 ? "" : "s");
+				state.applied_after_fixing_ws,
+				state.applied_after_fixing_ws == 1 ? "" : "s");
 		else if (state.whitespace_error)
 			warning(Q_("%d line adds whitespace errors.",
 				   "%d lines add whitespace errors.",
-- 
2.8.3.443.gaeee61e
