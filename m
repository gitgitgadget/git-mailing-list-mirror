From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 35/94] builtin/apply: move 'whitespace_error' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:46 +0200
Message-ID: <20160511131745.2914-36-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3L-0002jQ-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbcEKNTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34825 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcEKNTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9405379wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rz/nOFtbOL2RAlWWFBIbiQUebq0qmGh8tmvugra6+BM=;
        b=HDAmnTpNM9nQfEq9Is3oVFyymQ8HUtj2wuBLB/RWC+4P/D6cN6xFeglTMygzcexGaB
         HsJCanlvM3SPS9Ya7tJhboibzPGG4+I5ADk1B+Zh+IBAYa2V5Jlm5oawaPd29gsxAc7h
         4TeCsF1BDfNCzXxi9kHPBF/I5QbvedQiwRnsATepr4VkzjTmp50RdPxWpRRQ0Os22S7L
         rhKNmHaGZQXkgS6u+i2ZScEzUO8H30i5jtHm15ZlOmw3KizPQI758Jk5Mg+5m34gStyw
         tQJPQwkS2lKI1SBEwWJ3BDcdok4F7unrLGgn/6DldqbGHD9lNWldfCmFfUDZKbKtayVP
         yspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz/nOFtbOL2RAlWWFBIbiQUebq0qmGh8tmvugra6+BM=;
        b=mlRd/+ly/cfYp1pT9haDHVTuIpn60wRwwrHsf3rQiYrEPL6NApibtz31qU+Y3BlV6+
         tQH0tr9GHAAsJSdFXZkE5P/u/uecpJjyYKjbU6DaU2OpmvzysbmcRQPiav7hn18TBi5h
         0oSJHDGleexpsCPkytNKwL733L+M1BF94FjGm8HgfBNPZp9P3d1RjwCAI6n0shdg8VJs
         1AauYE4tCVzhEGlaahM41ZJC8XMadKDNbWF4mDCkAiMA89ydtVQfTSWmM6zY0g8Q4nbL
         7kzvV2m6vQpeJKgq2ZlzibGYN0YtHpwDfL4KgFSww9zGSqWdM0hfQInLNxaAb8yCQgt5
         XjGw==
X-Gm-Message-State: AOPr4FX3NPxM9F8rP+MjojBIKIcDYhrwdobdNUPgcSD/CkaTp15Cn80gyzOqVziICbMxXQ==
X-Received: by 10.28.57.137 with SMTP id g131mr4552895wma.5.1462972777782;
        Wed, 11 May 2016 06:19:37 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:36 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294266>

To libify the apply functionality the 'whitespace_error' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6b3540f..1684f25 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -66,6 +66,8 @@ struct apply_state {
 	int p_value;
 	int p_value_known;
 	unsigned int p_context;
+
+	int whitespace_error;
 };
 
 static int newfd = -1;
@@ -81,7 +83,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int whitespace_error;
 static int squelch_whitespace_errors = 5;
 static int applied_after_fixing_ws;
 
@@ -1603,9 +1604,9 @@ static void record_ws_error(struct apply_state *state,
 	if (!result)
 		return;
 
-	whitespace_error++;
+	state->whitespace_error++;
 	if (squelch_whitespace_errors &&
-	    squelch_whitespace_errors < whitespace_error)
+	    squelch_whitespace_errors < state->whitespace_error)
 		return;
 
 	err = whitespace_error_string(result);
@@ -2862,7 +2863,7 @@ static int apply_one_fragment(struct apply_state *state,
 
 			start = newlines.len;
 			if (first != '+' ||
-			    !whitespace_error ||
+			    !state->whitespace_error ||
 			    ws_error_action != correct_ws_error) {
 				strbuf_add(&newlines, patch + 1, plen);
 			}
@@ -4535,7 +4536,7 @@ static int apply_patch(struct apply_state *state,
 	if (!list && !skipped_patch)
 		die(_("unrecognized input"));
 
-	if (whitespace_error && (ws_error_action == die_on_ws_error))
+	if (state->whitespace_error && (ws_error_action == die_on_ws_error))
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
@@ -4792,11 +4793,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	set_default_whitespace_mode(&state, whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
-	if (whitespace_error) {
+	if (state.whitespace_error) {
 		if (squelch_whitespace_errors &&
-		    squelch_whitespace_errors < whitespace_error) {
+		    squelch_whitespace_errors < state.whitespace_error) {
 			int squelched =
-				whitespace_error - squelch_whitespace_errors;
+				state.whitespace_error - squelch_whitespace_errors;
 			warning(Q_("squelched %d whitespace error",
 				   "squelched %d whitespace errors",
 				   squelched),
@@ -4805,18 +4806,18 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (ws_error_action == die_on_ws_error)
 			die(Q_("%d line adds whitespace errors.",
 			       "%d lines add whitespace errors.",
-			       whitespace_error),
-			    whitespace_error);
+			       state.whitespace_error),
+			    state.whitespace_error);
 		if (applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
 				applied_after_fixing_ws,
 				applied_after_fixing_ws == 1 ? "" : "s");
-		else if (whitespace_error)
+		else if (state.whitespace_error)
 			warning(Q_("%d line adds whitespace errors.",
 				   "%d lines add whitespace errors.",
-				   whitespace_error),
-				whitespace_error);
+				   state.whitespace_error),
+				state.whitespace_error);
 	}
 
 	if (state.update_index) {
-- 
2.8.2.490.g3dabe57
