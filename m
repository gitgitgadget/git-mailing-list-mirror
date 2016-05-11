From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 14/94] builtin/apply: move 'apply_with_reject' global into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:25 +0200
Message-ID: <20160511131745.2914-15-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:25:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U8k-0000t2-HC
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbcEKNTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36427 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbcEKNS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so9343636wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JbhRXyHw80aJtOmlZVME098HUvHf3UhKVxzv7FDWHPQ=;
        b=UPyDMnZsqa2oZjUxhP6Wq9QW0VmfzkaeM1ryDKgWeruhCyyDz4Divr3AN1A5d2FNSO
         9ZNwMFHFJ7Yc+7vGMZY8yc82hBjlNjNxdI3kqSGyEb7LEVRrhNT8f1cg1cw88jMpnhJs
         0pGKKfikJldXOHjEoI5gQWUrh8imjKwG+MhTD3sIorSj2Yhd55fRNjaH6pqZqISILWgG
         w3Qqvv314lzpxZpWFos98hcbqDxn3u6//pHYHUrFBGYHFpsmLRMWChim+8dWF6XMvTVZ
         PBKnPiivhldyCvzs0GamGwSSx1CgYcEkcPFOeMuz87/AgxBvdqcSSUZeBBIXk7/bU1Y+
         TxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JbhRXyHw80aJtOmlZVME098HUvHf3UhKVxzv7FDWHPQ=;
        b=ZtB8ouzn562lhCOaDM1vWG1qYQ8NvGYV7yJrTVxcEB4XNVeJh8NE/SpXP2i6A5E1jg
         2jWeyEZNzn1peaXlWX6XUDZY7+fB6KrSFTu6UuGYKzY5XPvUsJJmaBKj9Ef/XKukFqFG
         OjAE2yWO/ifdCR3FYThZHeaXZ3AIsuOJX1kfCTCci5r3DTEdwGxx6/CCBYPG0Y+iR1LW
         yfm4wBg/YCir/icpqlhvF4n1WhdDtWypPgrsKj8/Y8SK4JERRa/0k2S4fOObeUBOrTeH
         Z2NyyOUf1Mtr9PfnuOiaEq6NS7sMcQoM6GpUlvVGDc9+aqdgUmjCaqj8t/SgyGmkhiDX
         VPjg==
X-Gm-Message-State: AOPr4FVBfPrFR1CogMLTfi7bEzKxtRRAKEqeI/tMnc7NgYxjBQI2q8NuPBxAVbg2yhZi7Q==
X-Received: by 10.28.1.143 with SMTP id 137mr4146451wmb.17.1462972734373;
        Wed, 11 May 2016 06:18:54 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294334>

To libify the apply functionality the 'apply_with_reject' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 73cef9b..53cc280 100644
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
@@ -3101,7 +3101,7 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 		nth++;
 		if (apply_one_fragment(state, img, frag, inaccurate_eof, ws_rule, nth)) {
 			error(_("patch failed: %s:%ld"), name, frag->oldpos);
-			if (!apply_with_reject)
+			if (!state->apply_with_reject)
 				return -1;
 			frag->rejected = 1;
 		}
@@ -4467,11 +4467,11 @@ static int apply_patch(struct apply_state *state,
 
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
@@ -4631,7 +4631,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state.unidiff_zero,
 			N_("don't expect at least one line of context")),
-		OPT_BOOL(0, "reject", &apply_with_reject,
+		OPT_BOOL(0, "reject", &state.apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
@@ -4653,7 +4653,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	if (apply_with_reject && threeway)
+	if (state.apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
 	if (cached && threeway)
 		die("--cached and --3way cannot be used together.");
@@ -4662,7 +4662,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			die(_("--3way outside a repository"));
 		state.check_index = 1;
 	}
-	if (apply_with_reject)
+	if (state.apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
-- 
2.8.2.490.g3dabe57
