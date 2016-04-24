From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 18/83] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:18 +0200
Message-ID: <1461504863-15946-19-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFR-0001Ek-MT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbcDXNis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:48 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38268 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbcDXNfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so89926832wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ZPVxgAZURdAsm0W4LFm4hYR9tZGeFP4PAyhp2ISxAk=;
        b=ESTRfzElmiDP2zuoMBNKaxPX0Ifp8FmQ7iBPYRtwS8XvR/geoXESyNRxcH63Ny4Vnn
         80V4fP0TXCQIJmxLhwA/PfDOpOjGrkonsGBT1lckUoH7uVbq/893mY3PA4L+Jj0TGSYd
         3F+V2R0TfkJLGtW9BQVcY780QClDE6yh0Jo6KhAbncTSLWjo1eZpX1ndnZgNFE4UfCIF
         V7VtxHeEBByPV+4JITl2nxveFq+X6DwtWXfY1U5D2LiNYeMYRcGuS72md4RqBHYGM3NE
         SW0twa6rMLgRiGJ4+NxWDENPn6A1l7QXXBd0Sz2J1wsjDB0RG1SxxutHGde1YFHXSOFg
         5N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ZPVxgAZURdAsm0W4LFm4hYR9tZGeFP4PAyhp2ISxAk=;
        b=brPtEtVKx/+/WJ3YxiXwwCaPObff4F41ez/7JDF3ZO2HAdOQMrEJoBUhXZkVK0cyOm
         WQU7lYxkTDACG2LFhszEc47nV47zFjAGhIEvJUwBoLOVZPmwb37rUzTUASB/sGyxmc1S
         0q/C7c/PQ6thYwOICW2D1y5E7q1mCHeSe7CjtY+LazTk7kYIDhmaDsxT1E5i1GGcYJFS
         7wmeIu+vMKsgYP15ZFpRYqD11RlldaL0Ozxh3FXiHrApQ7A2tOB/zyRpfibJlnKIU0E1
         WuZC+1VNHdIt1FeKusRb6R4NeokOW0zKaeC/U7SOltDzc2meqmMwH9M3QkHXKXjse1Jf
         VcVw==
X-Gm-Message-State: AOPr4FUI8Pcy+8uXLTbuFPYx7OrPJTL7MvZ5sTtx2LkKzz1T6fWzj38VrjrISYQU2CvoJA==
X-Received: by 10.28.17.211 with SMTP id 202mr6685109wmr.11.1461504910690;
        Sun, 24 Apr 2016 06:35:10 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292392>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d90948a..16d78f9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -36,6 +36,9 @@ struct apply_state {
 	/* --stat does just a diffstat, and doesn't actually apply */
 	int diffstat;
 
+	/* --numstat does numeric diffstat, and doesn't actually apply */
+	int numstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -51,14 +54,12 @@ struct apply_state {
 };
 
 /*
- *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int numstat;
 static int summary;
 static int apply = 1;
 static int no_add;
@@ -4500,7 +4501,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->diffstat)
 		stat_patch_list(list);
 
-	if (numstat)
+	if (state->numstat)
 		numstat_patch_list(list);
 
 	if (summary)
@@ -4598,7 +4599,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOL(0, "numstat", &numstat,
+		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
@@ -4675,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.1.300.g5fed0c0
