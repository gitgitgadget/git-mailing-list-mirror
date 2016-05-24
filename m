From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 33/49] builtin/apply: move 'p_value_known' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:10 +0200
Message-ID: <20160524081126.16973-34-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SC-0000un-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbcEXIMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36452 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbcEXIMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id q62so3639747wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzb1pXU1JE+ra1pzSw5FA6DoraDxtrgJMQx/1vdyLec=;
        b=Kcu81yArnbWPRvmJ6N//1VqEg/xJPcZwCmnYW7pxAvAXWEA1HveB+uB+znhqlrJKMH
         KUyhnH8iOLv9G54dZhXAelqP6+EZD+tM0kT6iwm6YfXQVxH5R8PdeoZjyDSHvHSvxmmY
         H5DCad+a7nZHhunNfx9QdbWVbgYRrx0aHpVvyl3YNf/N6qLkeCYFahaNl1NkouKs+umH
         XzgCFC/1fwdIYqX/ufjKLnl0dWs00/5K5wU+EPmkPsgZ4GhY4UCIOIGOlUNsX4wC1VM/
         Q3Xh9QTXWaNmcz0l7QwpwxdAyPlbQuPul6w6N6lL0yvTIULNoFCACjNK15jYezgQkZEI
         HY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzb1pXU1JE+ra1pzSw5FA6DoraDxtrgJMQx/1vdyLec=;
        b=NyNUCEtt0087TgKqarqbXW6ijZ8pJ94rncHAfRBNUndYuXqDr9gljGpQP/QKie4F96
         u1nBSfbDop0+UTGrbIwSRkWnIoGvalDjqGS8qHYcoE2X0ruVJgWprFyqKd4l4NSX+4sw
         u83L6nT/0wtF1ToNVvxgzCB1HvQb7SCBSLJgpuKssVnPLt3hOYwi6pYSgpJ1tQ4cPqP6
         F3zFQQ0P7QZ0ZtxZrxnNmIQJzNjIIuiKSOZ8QRuPEEZiIfF0BLwqF5YnPM8VTYJ0J+g1
         JFzf3InAP0mtrbqpx25RSs1MWEyRZPG+zcfuHTFxASyUBpF+Yuit0N37xu+PIbqFlhxt
         plMA==
X-Gm-Message-State: AOPr4FVgu4mZvemcA+C6CJXx3pI8Ea1OxO2BCWmpIjoDrW31EqZr5JXCqr51dcA+gIeAxw==
X-Received: by 10.28.157.202 with SMTP id g193mr22710390wme.46.1464077550568;
        Tue, 24 May 2016 01:12:30 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:29 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295435>

To libify the apply functionality the 'p_value_known' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 843fafd..e1b68d4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,7 @@ struct apply_state {
 	const char *patch_input_file;
 	int line_termination;
 	int p_value;
+	int p_value_known;
 	unsigned int p_context;
 
 	/* Exclude and include path parameters */
@@ -61,8 +62,6 @@ struct apply_state {
 
 static int newfd = -1;
 
-static int p_value_known;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -875,14 +874,14 @@ static void parse_traditional_patch(struct apply_state *state,
 
 	first += 4;	/* skip "--- " */
 	second += 4;	/* skip "+++ " */
-	if (!p_value_known) {
+	if (!state->p_value_known) {
 		int p, q;
 		p = guess_p_value(state, first);
 		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
 			state->p_value = p;
-			p_value_known = 1;
+			state->p_value_known = 1;
 		}
 	}
 	if (is_dev_null(first)) {
@@ -4588,7 +4587,7 @@ static int option_parse_p(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
-	p_value_known = 1;
+	state->p_value_known = 1;
 	return 0;
 }
 
-- 
2.8.3.443.gaeee61e
