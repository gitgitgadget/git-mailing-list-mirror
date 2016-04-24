From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 25/83] builtin/apply: move 'p_context' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:25 +0200
Message-ID: <1461504863-15946-26-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCG-0007z6-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcDXNfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:25 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38320 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbcDXNfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:21 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so89930347wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q2U4khisLlQLaXs2oDkPTNn/s2IVYTkWdFSjyRY58ew=;
        b=iTb5E6rtYgrhc4vjqJT7+0if0rksCh0a0XqwqPVw51UWVOe8mVJegbbNcqunO3DfyT
         e5RjgqaJ7hlfn5W/AC3PL/eVcH+aG0WjIv3uCzXRoFXYslq4yWEC322cAFjGrFZq8Yee
         8RRPYe+qS8GSrse9X6/3046LHnMaxCOKscLjSEGtv2PFWOHrocGKmfGvBhCvnjnJrWNI
         7btDxwYcq264RlUlI9ydFtbyYz9Jz6jw52/JWQ01lSk7VdHOPn/o8B0niJan4QwTDfRy
         hBxPKLRVb/kYniBYFmrBwF7JMERzgyeGey89LTNDWdUQEJM8+4bJNatZiHtj73reTd2B
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q2U4khisLlQLaXs2oDkPTNn/s2IVYTkWdFSjyRY58ew=;
        b=geT651ObdnlRHfkRCnMNbagDV4W2WvzYQbhYCC+bsed+IQqV8V1GV57vlrITdW8nkY
         sF/91zJvbRwHcDBFqtYcLb2pzZ5kJb4Mf1kKWIlX8IBOvMDZnwTD6u/Zj/acSg4NPJuu
         zRt/gf63KYeTzZoBWV93DtXCAM8rl9TCVjJfvimtzZpZl0gKueC/zuCwEyFbz/kNrRLQ
         IaONouQtVfdbN5er8UN+SPuv+PCR8kZe6VTFipLyvSFKNS8KB9HIySnDpS+WS/Tkxlkx
         jtYCsTWZHKqi7mCSJFuT2uT97tcN9Ryhm6279n/z/2SN8NkeDacG0n8VvhctZmj2D6l9
         jmmQ==
X-Gm-Message-State: AOPr4FWA6NE1rdXpQrWNR5bAH1XRKdLZbucHrbE6Eje64vzy64PpnikmiuR73eXNJTeYcg==
X-Received: by 10.28.142.5 with SMTP id q5mr6743017wmd.21.1461504920120;
        Sun, 24 Apr 2016 06:35:20 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:19 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292340>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f69f982..b6d2343 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -63,6 +63,8 @@ struct apply_state {
 	int unsafe_paths;
 
 	int line_termination;
+
+	unsigned int p_context;
 };
 
 static int newfd = -1;
@@ -70,7 +72,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -2888,7 +2889,7 @@ static int apply_one_fragment(struct apply_state *state,
 			break;
 
 		/* Am I at my context limits? */
-		if ((leading <= p_context) && (trailing <= p_context))
+		if ((leading <= state->p_context) && (trailing <= state->p_context))
 			break;
 		if (match_beginning || match_end) {
 			match_beginning = match_end = 0;
@@ -4624,7 +4625,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &p_context,
+		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
@@ -4660,6 +4661,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.prefix = prefix_;
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
 	state.line_termination = '\n';
+	state.p_context = UINT_MAX;
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.1.300.g5fed0c0
