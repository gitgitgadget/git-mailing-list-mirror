From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 30/94] builtin/apply: move 'limit_by_name' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:41 +0200
Message-ID: <20160511131745.2914-31-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3E-0002jQ-GX
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbcEKNTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36814 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEKNT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so9346598wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=db0Btw6ByN6G1VVL8eAdZCcb4rPHl5rzhrqyOJyARnI=;
        b=oSq83taTx3tUOCTxzjMtEdBowM5Wut+d0hnMdnMIr2UaOLZ67UilOma+Yf3rdy8zSh
         /0SEANiorPV5fjGa05lYN+Ei4BnbCNxFx5ed1Y3LXNNT91kj/LKYlb8pqsCnlrI/HoVA
         APLLFUsOQbGb13sLVZf2RQ8Hb9/RNYtGZChlff6r4YGbiP9BddLOE5ZIY9YWHytaGmF5
         ZDzQPeUOA+23wya0bEKZB/Ptf/o14xtZp4Nt0qSfPErttQrpaz5w5jBOo/nB5EAW85+3
         GXciHCIrzjHumB6cHuUPJbnawM6xVCmkAlOtNkekuGaV7Tz2BlLTNjUZ4T8OY78TYjzn
         IzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=db0Btw6ByN6G1VVL8eAdZCcb4rPHl5rzhrqyOJyARnI=;
        b=Tcbw5zhvN3dfFsBQKsleHg5y4bkUzHeJio+4jtY/5+3+cNV4gXoPTb0u3XubCteytr
         IVEcN/+6MpyEbL0Qt8I0vKCTERTAuprB5pH2GKfKbPmQyGVL75yKivQMpMhX+DUtPdT+
         yFxQDENO1MJNk+1OZtMr8j2HIq3IF/GcYYI5yzcUVoXn5hkotTqaAp6ygMgEHkLMNUDV
         Pab2664tOs2+jThrB21XejxTZ1BYh+j+KKzVlnd/AF01Gmu8zQyhj+cb7npRg98wPpVF
         sibTsF/PFl0aDNmBo1om/kdfk41r0jwS6bNGud/2jXK9UWpQ+Yh7jY3MhGO7ncgUwT+0
         0ECQ==
X-Gm-Message-State: AOPr4FVmfgsOJLwdrRKqwVTROxW5UeMf8GnKGhtzoXn8e80oaVuRIFU1MqhSTn7llcLMag==
X-Received: by 10.194.79.70 with SMTP id h6mr4206907wjx.157.1462972767071;
        Wed, 11 May 2016 06:19:27 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294263>

To libify the apply functionality the 'limit_by_name' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e43da9c..14bbcc2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -45,6 +45,7 @@ struct apply_state {
 	int no_add;
 	const char *fake_ancestor;
 	const char *patch_input_file;
+	struct string_list limit_by_name;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -1967,13 +1968,14 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static struct string_list limit_by_name;
 static int has_include;
-static void add_name_limit(const char *name, int exclude)
+static void add_name_limit(struct apply_state *state,
+			   const char *name,
+			   int exclude)
 {
 	struct string_list_item *it;
 
-	it = string_list_append(&limit_by_name, name);
+	it = string_list_append(&state->limit_by_name, name);
 	it->util = exclude ? NULL : (void *) 1;
 }
 
@@ -1991,8 +1993,8 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < limit_by_name.nr; i++) {
-		struct string_list_item *it = &limit_by_name.items[i];
+	for (i = 0; i < state->limit_by_name.nr; i++) {
+		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0, NULL))
 			return (it->util != NULL);
 	}
@@ -4529,14 +4531,16 @@ static void git_apply_config(void)
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
-	add_name_limit(arg, 1);
+	struct apply_state *state = opt->value;
+	add_name_limit(state, arg, 1);
 	return 0;
 }
 
 static int option_parse_include(const struct option *opt,
 				const char *arg, int unset)
 {
-	add_name_limit(arg, 0);
+	struct apply_state *state = opt->value;
+	add_name_limit(state, arg, 0);
 	has_include = 1;
 	return 0;
 }
@@ -4607,10 +4611,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	const char *whitespace_option = NULL;
 
 	struct option builtin_apply_options[] = {
-		{ OPTION_CALLBACK, 0, "exclude", NULL, N_("path"),
+		{ OPTION_CALLBACK, 0, "exclude", &state, N_("path"),
 			N_("don't apply changes matching the given path"),
 			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", NULL, N_("path"),
+		{ OPTION_CALLBACK, 0, "include", &state, N_("path"),
 			N_("apply changes matching the given path"),
 			0, option_parse_include },
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
-- 
2.8.2.490.g3dabe57
