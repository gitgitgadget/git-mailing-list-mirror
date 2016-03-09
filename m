From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 25/48] builtin/apply: move 'p_context' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:53 +0100
Message-ID: <1457545756-20616-26-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIT-0008D5-16
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933740AbcCIRxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:19 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35280 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbcCIRxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:06 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so190224760wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PAS4LjZZ7m+3IXwXAdU3/bq3Rb44hbMsfxSgR0HCEu8=;
        b=Y8oM6kLqIlyh6rPO8dw2P6sGAIHh25EZg68+QZIG2OcjmBzJtajOy0aYuDZfwp2exE
         axoAOhP567XtH0w9+pJOYRsqLBBSJLwpGaYMIXSapKDgJnl8q4Z3c2C4EzPahIcg4aGl
         ZxEYTax2Y75EnLGqrmtmW6cFLnJD1J2qCiR3t53F7jurEzwUKHHm7R0herMus6AKu1Be
         ynWCgb0upngwjyzo4hzHmY+OvLC0+WsX/X4BigA3wHf3q5/iMt1h/mM9UvNqjiPoEc1g
         LNbDi4+etqRYNLxHnpaS8QtpvYFiYvNisaOWcVj1fSDGqPvXGJ84UIhYyM9Rxq17P90L
         GCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PAS4LjZZ7m+3IXwXAdU3/bq3Rb44hbMsfxSgR0HCEu8=;
        b=cALpLx/9my2b53zbsXpX+pJ8om9DvfshpTdjdgX/nHInVHFo3Gdj1u/8BxeRMwV0DD
         lDQcsOY6Syah6dEmgCNbV/CewIuKyevHhayWeIDQXwCUZQRfHyE6/aYlIKD72IzbyMp6
         7f947HUawNGH2d7FjDH5NGyyNfX8MxDF8iaP+55W0+yFLuK5f0e3KU10EtUez4CxnX7P
         rt1aAAEMR0PC+mHKoH/YuF30GAif/MzKnw8Q5XxzKVGALXFu7jU12HLtHFG0BfwDzi7E
         fqUh6k7dR8DETfLCFOJOSQmLgogkaiwy8JoYDYrFmRL8uAzCGoC6CdwhlKFQgluoYd/2
         nwFg==
X-Gm-Message-State: AD7BkJKx+xEeLx3aUIBR1GJd+JjOlpwfH6YwZtpGUo6NU0iirmsVnhA8awYXMZNioIgNbw==
X-Received: by 10.194.22.97 with SMTP id c1mr36830229wjf.19.1457545985540;
        Wed, 09 Mar 2016 09:53:05 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:04 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288514>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5a2f0f4..6e347e2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -64,12 +64,13 @@ struct apply_state {
 	int unsafe_paths;
 
 	int line_termination;
+
+	unsigned int p_context;
 };
 
 static int p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -2889,7 +2890,7 @@ static int apply_one_fragment(struct apply_state *state,
 			break;
 
 		/* Am I at my context limits? */
-		if ((leading <= p_context) && (trailing <= p_context))
+		if ((leading <= state->p_context) && (trailing <= state->p_context))
 			break;
 		if (match_beginning || match_end) {
 			match_beginning = match_end = 0;
@@ -4621,7 +4622,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &p_context,
+		OPT_INTEGER('C', NULL, &state.p_context,
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
@@ -4658,6 +4659,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
 	state.newfd = -1;
 	state.line_termination = '\n';
+	state.p_context = UINT_MAX;
 
 	git_apply_config();
 	if (apply_default_whitespace)
-- 
2.8.0.rc1.49.gca61272
