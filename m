From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 30/83] builtin/apply: move 'has_include' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:30 +0200
Message-ID: <1461504863-15946-31-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFC-00017X-Rl
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbcDXNiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:23 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34982 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcDXNf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id e201so60532879wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/vWcAXkj9xMu79ShUuyIcB/37A2SkbtWgaIDGKfC3F4=;
        b=aPvj7liW4BIt6+jv+OUgcMbzEFZcAf7OqKQ/X4ta/Inmg8zN2C/AkBPMx2jXPk/iAl
         +KY5Q3rbKsywgwZ/WEEIoYZMgKCsBNtn9qZtD9Zlj2BtCMQPG/8ASyNYgF91MrHNQIJb
         WSFnMAWKqhHJZHrSD5vgsz1T7iXihtqwvSV0Uv2VBCK4ZYfL47I0s/4Rmm0zUx7HFD4t
         sdIzvW1eLc0d5NBkSnTZdGZee5UZPVBM9upfBPpiA8JWGcIGbdJQowSdyvOAgCLFzama
         q3VPcXKqM4kpBe3gSmMuttCLm57v6dCPZcJu0+tjnLxcWikS9LlsGAQQFPGT5+akovvZ
         YRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/vWcAXkj9xMu79ShUuyIcB/37A2SkbtWgaIDGKfC3F4=;
        b=OxOWVfsfHf8JzR/pcnr7tSTKElEcb8G95JQrFEWKQgoBcF8KcHFvzqsJ9qGUeejxDu
         s0K9DxkfRZYtTc8k43ld9PSC4qarGcgRclC6oWH2kwvGqjdebDist8mzLQQRYiXHek1n
         vQddSijp+T0gsy00EP2iJx2rdndC0yAU11FIZT4lfABzETNbsgLGvFG+ZlGu1VMBzJ7S
         IRTdjghSZesxRlMVs5Vy26xe/5liLyL3JcrzJ1D2oA21YyHuLPQg1KtATnhmOa0XAnrJ
         Xw09Pz1dvwFCkszNb+RQpUvdfGAF2Gjl3RXKsnG5ioKXDib0N49Mw/Ya1EKv+JWbG1Qw
         Ez9g==
X-Gm-Message-State: AOPr4FXWHR8ZI/dUfoLV4k/tLWwzt/Fqj6Ctz1M2zWIm8XNVf8gnwMYAq+kZJjv2Ztod/g==
X-Received: by 10.28.154.2 with SMTP id c2mr3388860wme.9.1461504927292;
        Sun, 24 Apr 2016 06:35:27 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292389>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c8b9bf0..0717cd2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -70,6 +70,7 @@ struct apply_state {
 	const char *patch_input_file;
 
 	struct string_list limit_by_name;
+	int has_include;
 };
 
 static int newfd = -1;
@@ -1976,7 +1977,6 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static int has_include;
 static void add_name_limit(struct apply_state *state,
 			   const char *name,
 			   int exclude)
@@ -2012,7 +2012,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
 	 * and such a path is used.
 	 */
-	return !has_include;
+	return !state->has_include;
 }
 
 
@@ -4550,7 +4550,7 @@ static int option_parse_include(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
-	has_include = 1;
+	state->has_include = 1;
 	return 0;
 }
 
-- 
2.8.1.300.g5fed0c0
