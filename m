From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 36/94] builtin/apply: move 'whitespace_option' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:47 +0200
Message-ID: <20160511131745.2914-37-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3M-0002jQ-4s
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbcEKNTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34840 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbcEKNTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9405479wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5+0jMSVRAukbmskC4jjkr/fp8ZmAcqqRpLtoBQ4x9uY=;
        b=ambBgcwUDtts9FGpgDYQWpi08jSHOkm/UQo4OFfnxfa+8CvZLmv6nGkwcJtUl9OpKM
         851hpCabvlLvNBJb7o+AqSJGhc2L4Sk1QYWSBv6CKQQ1nbvMvkbCIk959xwxrYM0UK3s
         11ZX0BzUiqlvCyDKW3luMOdWSEzZ4Km93CdhJlLXV7JevZSfBj5j60aDCVcD2bgS5vZq
         jpzIRnK/8iQ5lI4rcABhHnKGF/5t83JXMqt/JZsRHdbDskQWyLIWeIK9+UsqHjMPdeCG
         oY+INM3Mrit863dpScP82GCkl6quVw9qQE/fPOWBdvodnt1bBAdsFGuGx6pqVklI0+d/
         TNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5+0jMSVRAukbmskC4jjkr/fp8ZmAcqqRpLtoBQ4x9uY=;
        b=W1akl+udnNVi+Iw7g2ZwhRmXPhvmgFgRc/XhOsKDxazSv/uanB9FVjW8pw1Mezw7mW
         jyn/xQSkzM6FkA0pz3y/abmbyAAv3S9yOUdhl+jD59dDOGAWoHo7cDi1oxyu+80L/q3t
         zaxkD1fOqAzri0E0TdoVv6gaONJp3nd6PmKxsJIj2A9JdjMRMK0AlcQsvFlA59Osy8v7
         IfdJ56LLynopODSB6bQPRS/kC476BlrsJiyH1X9TkhlVokzHV+7AX+jbfs1vw4yTzdfo
         rSc/6R4N3+1wOY6pquwwbg21AEqtGem9hl+jXbcQoF4MCBzq4NlPQLQ7sJ0j3iUDA83/
         t6aw==
X-Gm-Message-State: AOPr4FXldWUYEMhwYTsXTXhZ2tMUn9bE3Fn6ffGi3io3l1BbsQa9nFcXsFB7kZHRUK6oDw==
X-Received: by 10.28.127.81 with SMTP id a78mr84041wmd.34.1462972779733;
        Wed, 11 May 2016 06:19:39 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:38 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294269>

This will enable further refactoring, and it is more coherent and
simpler if all the option_parse_*() functions are passed a
'struct apply_state' instance in opt->value.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1684f25..4b9a5ff 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -67,6 +67,7 @@ struct apply_state {
 	int p_value_known;
 	unsigned int p_context;
 
+	const char *whitespace_option;
 	int whitespace_error;
 };
 
@@ -4625,9 +4626,9 @@ static int option_parse_space_change(const struct option *opt,
 static int option_parse_whitespace(const struct option *opt,
 				   const char *arg, int unset)
 {
-	const char **whitespace_option = opt->value;
+	struct apply_state *state = opt->value;
 
-	*whitespace_option = arg;
+	state->whitespace_option = arg;
 	parse_whitespace_option(arg);
 	return 0;
 }
@@ -4670,8 +4671,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int read_stdin = 1;
 	struct apply_state state;
 
-	const char *whitespace_option = NULL;
-
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
@@ -4711,7 +4710,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
+		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
@@ -4786,11 +4785,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (fd < 0)
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
-		set_default_whitespace_mode(&state, whitespace_option);
+		set_default_whitespace_mode(&state, state.whitespace_option);
 		errs |= apply_patch(&state, fd, arg, options);
 		close(fd);
 	}
-	set_default_whitespace_mode(&state, whitespace_option);
+	set_default_whitespace_mode(&state, state.whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-- 
2.8.2.490.g3dabe57
