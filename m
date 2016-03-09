From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 36/48] builtin/apply: move 'whitespace_option' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:04 +0100
Message-ID: <1457545756-20616-37-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJ6-0000CS-BT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763AbcCIRxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:51 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37430 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbcCIRxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:39 -0500
Received: by mail-wm0-f42.google.com with SMTP id p65so81834490wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KzfTTMUHS0Bhk8LmDtpdgDd0Qp7KibYLFWF53McW6tc=;
        b=lZPwWltD+jHdyjVSsakpNkQIGpgn00EqPX8ySeHy/90lMDlMTVt6n3YNbQ/krzWmRZ
         MXpHx8l0kbbTD0nMJJX7fJpo2/OX5ccQjBkVkXvTpJYdTkMLBG9FRet/XIj7QsL1h7A+
         XwUqywkbtjzCj4IbDWpj3ApYafRIZa12IqOfpUsBVvE36RJvPXMPcfFUG+K5V2Ry02+r
         D0HhUQgt9x2NkkMUBVL4c9SxgLF2p++71eCnTD51M2T97NLf7UR3M9JqSds2XcZnidHO
         L1B/eMD0o1qWJdTZ2TTGKD5f5cJpeGkxm6LNi1AggdVivume4i8t4vtk8v+6g+NEKM+s
         FuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KzfTTMUHS0Bhk8LmDtpdgDd0Qp7KibYLFWF53McW6tc=;
        b=Wt5tdQ5Wm11ZQf74evpKawDj0rFg/PaS7mTx8g8tfrR0fR0EmMPiJp0gsWfZStjowj
         Q0yv9deGW91AbWNWH6qvfnhEdYZ2dwXuF4dBc4pTOMtJO4PTy2o6Sizy8wB4fvXH+KxE
         aL7oEDF06qK+al5c2Z0g9FeBQqR4TwiWiW0G5RdRci6JmIoYJqhBjBa2BC9w5a2jPsEj
         aKZRtixzO6DdhYnsyb6TAqanlVY59e69JsLf2tFoO5gfx8D+HSWj1Od0tVc6D93tp8aA
         BAYEYDk5uxKXUexow+y2guR5N9JX3Tte1PibNox72C43JMJXHkkdZHkkd/1P/RJV4oXi
         9bAA==
X-Gm-Message-State: AD7BkJIQvUieMcA/mEIe88R1yrjBHf2ZWVdzuuIZ5fS+T/EsXSqREADeR2Zqh4BLwc71CQ==
X-Received: by 10.28.14.8 with SMTP id 8mr421029wmo.66.1457546017756;
        Wed, 09 Mar 2016 09:53:37 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:36 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288527>

This will enable further refactoring.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1d665c2..63eb031 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,6 +79,7 @@ struct apply_state {
 
 	struct strbuf root;
 
+	const char *whitespace_option;
 	int whitespace_error;
 };
 
@@ -4632,9 +4633,9 @@ static int option_parse_space_change(const struct option *opt,
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
@@ -4659,8 +4660,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int read_stdin = 1;
 	struct apply_state state;
 
-	const char *whitespace_option = NULL;
-
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
@@ -4700,7 +4699,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
+		{ OPTION_CALLBACK, 0, "whitespace", &state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
@@ -4789,11 +4788,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
