From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 09/83] builtin/apply: move 'check' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:09 +0200
Message-ID: <1461504863-15946-10-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFl-0001Ni-5q
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbcDXNjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:39:08 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38188 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbcDXNe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:58 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so89921711wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1A6pCY3qJgTnEf9toMsvXnv6mM3FFuvMwof1MG9eTmQ=;
        b=sn/hhARiiornNH+w1/8JHy34WhNERvMoTWajx9AZ4J07RdGNaQ2UUsySsma+/p4azJ
         rb9wJOMQ7ZBKT2mIjLhU/JEsObCOkjHiTslMNShc/UoSkjWbPnHGxDkcC34q7wpXsr/W
         fFUvFY+LyDS9ZgmFv6bUGT/CAvuNBsneVAMsv4MqycG99FNdGy8jkcwbcLIhGqb3cGhl
         HdWdUrNnIJCxqXxxCnEniCKkGArX4H8gTy1rtKoMulH5Q93IRjhMYcoPu7yUC6uYKcBd
         kma8MtF4nAiopJ050BpdIfXfBOMKzFrr0xn98w2pYbOpndhm7Ot0DyFapWZ+GHtMT+mW
         prVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1A6pCY3qJgTnEf9toMsvXnv6mM3FFuvMwof1MG9eTmQ=;
        b=RgTZsq0vegvbVYm92FPvcOO2JOlHoUCvUEEWL1pPaxFVIEh7MxaU4h7r9hCfXIj2vX
         CN+8X5WtVdZ7l1WImm9PQISDhaveKQ/z8k30b8kDtVkCgmObmlIdxVxwMuN3sLTg5iIc
         Yqx/rmQK4jGlN6b7j8tRPsDhBCYRZswxsxhJ/mW3qm9X+zTLAHIsEcK4pajNZsB1cVLy
         deznp/f7zHEU+pru81/TygptR43Vf2i55zL/gECJF2H43JSDRWxI94RYArRd2x6E1cxR
         maw79pI1LHgxvyixgwVntfEj6nU1Sd4ZxXSorCQxtwBIp5DmckscteE+8l6HqOSVJj1J
         GrIA==
X-Gm-Message-State: AOPr4FUth+1YTvUclbZ6D8M9vAWo3Gyww2iIVpgOH3lLhIGFw+emvaZjp/ntYzd1haZRlQ==
X-Received: by 10.194.48.7 with SMTP id h7mr32847673wjn.81.1461504897103;
        Sun, 24 Apr 2016 06:34:57 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:56 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292399>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ad81210..6c628f6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -25,12 +25,15 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 *  --check turns on checking that the working tree matches the
+	 *    files that are being modified, but doesn't apply the patch
+	 */
+	int check;
 	int unidiff_zero;
 };
 
 /*
- *  --check turns on checking that the working tree matches the
- *    files that are being modified, but doesn't apply the patch
  *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
@@ -47,7 +50,6 @@ static int cached;
 static int diffstat;
 static int numstat;
 static int summary;
-static int check;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -2053,7 +2055,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 * without metadata change.  A binary patch appears
 		 * empty to us here.
 		 */
-		if ((apply || check) &&
+		if ((apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
 			die(_("patch with only garbage at line %d"), linenr);
 	}
@@ -4441,7 +4443,7 @@ static int apply_patch(struct apply_state *state,
 			die(_("unable to read index file"));
 	}
 
-	if ((check || apply) &&
+	if ((state->check || apply) &&
 	    check_patch_list(state, list) < 0 &&
 	    !apply_with_reject)
 		exit(1);
@@ -4561,7 +4563,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOL(0, "check", &check,
+		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
@@ -4634,7 +4636,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
+	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.1.300.g5fed0c0
