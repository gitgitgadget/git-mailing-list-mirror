From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 12/83] builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:12 +0200
Message-ID: <1461504863-15946-13-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBr-0007l6-Ab
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbcDXNfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:07 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37513 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbcDXNfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:03 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so90198059wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SppjMLTi/gPzCrC1gSEak/tMgjRHwsiNzgSdWewedgM=;
        b=gnbRbYFOTX8/o5sx+3739hmTA6+MneSveNWZpqIuPZdweti9JY69GYnODiREvfu59N
         KHpptt1qOaRpmoBLkE51vkpV58lq7voUlIlKwTYfcGBlPd/rDi4Z7iMw17fTym2ijwlU
         KSaOtPw1K+cNKKCslqhgdEjvLKdqs6Qf3Jyh5naEm3faqOeQfOh+s/N3cMCya3tkAcAn
         XYU30zcQlQ3McNKcJv4yD/XZHjo1OwOLqp68Dop+dAfDaPasZpLLGEE0Q0Pa74LAvbjc
         qi2oNHsiuC5uL+ucK5lf097aVZvIK6TN/jHiXqn8LbNXbkpKnJsj0CysrpTCHf1JcZNM
         F13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SppjMLTi/gPzCrC1gSEak/tMgjRHwsiNzgSdWewedgM=;
        b=Bnf0uDSFea80TRn/RM2D3sqiw36WEIAtuC9s71mpkMYLZvMtiFqi8aeiJR+KC2aTRU
         RCURefSptidEg0daQX0z7ntLDwGC1+KIQpHfm4ykTIC88A74i9INEU82OK0F8i85CVTx
         JMgG/bLS72eQ63Nhbg/9iX04vFKcROVi0rXPWr2oWZgfDljoZcwaksc5nvRC5XROIvYb
         TBRa30lBT1hSqiH9JCp1eYdBuL/vWEvwBcd3QzsHE194r9B7sCgh6e8OBtxGo/mQB212
         DIkldJZ8soFuUp3ALP/ggzO2qEH/8L4rG8Eilh+0nO0LtyP/sbVEBbe8UHtihYe9SBq2
         3MDQ==
X-Gm-Message-State: AOPr4FUhS34XwM5QWX+Lv05SYIPQh73JLLJahzgU5cw28C31G37O/mOV6F7PxZr+kIKfQg==
X-Received: by 10.194.187.236 with SMTP id fv12mr29814994wjc.96.1461504901820;
        Sun, 24 Apr 2016 06:35:01 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292333>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 755e0e3..67560e4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -26,6 +26,7 @@ struct apply_state {
 	int prefix_length;
 
 	int apply_in_reverse;
+	int apply_with_reject;
 
 	/*
 	 *  --check turns on checking that the working tree matches the
@@ -55,7 +56,6 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
-static int apply_with_reject;
 static int apply_verbosely;
 static int allow_overlap;
 static int no_add;
@@ -3103,7 +3103,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 		nth++;
 		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
-			if (!apply_with_reject)
+			if (!state->apply_with_reject)
 				return -1;
 			frag->rejected = 1;
 		}
@@ -4469,11 +4469,11 @@ static int apply_patch(struct apply_state *state,
 
 	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
-	    !apply_with_reject)
+	    !state->apply_with_reject)
 		exit(1);
 
 	if (apply && write_out_results(list)) {
-		if (apply_with_reject)
+		if (state->apply_with_reject)
 			exit(1);
 		/* with --3way, we still need to write the index out */
 		return 1;
@@ -4619,7 +4619,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-		OPT_BOOL(0, "reject", &apply_with_reject,
+		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
@@ -4649,7 +4649,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (apply_with_reject && threeway)
+	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
 	if (cached && threeway)
 		die("--cached and --3way cannot be used together.");
@@ -4658,7 +4658,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
 	}
-	if (apply_with_reject)
+	if (state.apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
-- 
2.8.1.300.g5fed0c0
