From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 33/48] builtin/apply: move 'p_value_known' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:01 +0100
Message-ID: <1457545756-20616-34-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIx-00006C-H6
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbcCIRxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:43 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34611 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933741AbcCIRxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:30 -0500
Received: by mail-wm0-f44.google.com with SMTP id p65so203140904wmp.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHi4axfJ2BMe2LplBVXzitcGZVqaW7YTAiTHL9O63so=;
        b=jk+QuW6u8kaV1mOZ9ZF4vgxlJkBk+0JTRrsGFUJ1XT6nEqZ2d/C/vNH26edpXBebmW
         duLwFNahXYJxuh6E8W1ffN6w7WGYlCWNTqldX/hxCISjnm+/6L3BExma1nlkQxgc1skN
         J7pd5lZ6OIE2jZNw7xxOBV8BF1MQ/UnaqLnkr008pa4M9vv2ozCR3X6v8JSDxdgGp4qg
         7bo9tQDJm6DR+ti2KRFAAOgEXgcd20bNgcprhDpWtrDpYx+tmwPvXFKlNhYiZ5+2Na9x
         chxW3J7pp+UDafDKH28Q5R5/v0Dvt1DUrhFjeOfBXtfhP44R0HoK7ADZ7QTIVvwlFzhr
         k5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vHi4axfJ2BMe2LplBVXzitcGZVqaW7YTAiTHL9O63so=;
        b=Tti8mw71G0SWc8qBHVWtbwt/4h4hAqOrW6DXPJPRAn3hsRdjcRj5aboW6uisH6LQEz
         lM1Ixiu8uIdiak2rUT2iG3hh/KjzX9mfxgwtMStHtSbcqJbEV2rZ56PBOaDqJGcfUaD5
         qRiSRiwueMT5jpFej6uK5/I/4JcxYCkYHEjYLXnbMZEOwnj5a33j6aTc4ojd39QLtiT8
         s1VUpGDbCsN8Fx4O0wccqZm5sSw/CdH6pdAZkOl8b2wHVkJ0uGWFEn4tSL//mWKTUGEE
         nqjANABhOTXg7wolNKsovNtEsiFudabyuiWMP2w4e3DbRwTxmxr8Rte5vggLmIqaGzgt
         WX/w==
X-Gm-Message-State: AD7BkJJl7IwxW96uBhU6F4BP1Ovl+1HXE4hHCYlz3pzEAjOy6MLV9XHiEqqi1BE3bAvZ1w==
X-Received: by 10.194.174.197 with SMTP id bu5mr39780677wjc.23.1457546009518;
        Wed, 09 Mar 2016 09:53:29 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:28 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288522>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8d4a900..cb995c8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -67,6 +67,7 @@ struct apply_state {
 	int line_termination;
 
 	int p_value;
+	int p_value_known;
 	unsigned int p_context;
 
 	struct lock_file lock_file;
@@ -77,8 +78,6 @@ struct apply_state {
 	int has_include;
 };
 
-static int p_value_known;
-
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
 	NULL
@@ -891,14 +890,14 @@ static void parse_traditional_patch(struct apply_state *state,
 
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
@@ -4601,7 +4600,7 @@ static int option_parse_p(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
-	p_value_known = 1;
+	state->p_value_known = 1;
 	return 0;
 }
 
-- 
2.8.0.rc1.49.gca61272
