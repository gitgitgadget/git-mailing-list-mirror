From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 69/94] builtin/apply: make remove_file() return -1 on error
Date: Wed, 11 May 2016 15:17:20 +0200
Message-ID: <20160511131745.2914-70-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:21:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4X-0004Lj-7w
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcEKNU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35597 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcEKNUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so9411867wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bS+STaEjavMWz5T9ZeSrtZhIJJkRN5XPl/xyohmJoBA=;
        b=M8VmER7AH+pRfsZPcOr3shQaY+OZOm7OUzyLrpj/mJGEtQ59E3Wt+J8AR6/kvj/KwG
         jkzmJ4BzyFl7Q91pdLj9BvsBDFuU2zSC8J+HLT3vXz/4z8mNo2mlbL3xzyZbGXb+1A3E
         EbuW0jVOy2v9xwzGXfFDml7MmHLZvM31+U2CmfTUlQJXeuLV2pxOgEnzD2Bj96i7Ssd5
         Pe/MI4dtnYySR2SVAmKkbi8AZpYkFQnUaMWQ/tLUDQtB4ok/ggayGttnqKHZkGCM9bK1
         MSL2JoRiZpOcngVlWZKtA4vTrgzM4qSMWJuUZzS+SWKHBBR7bqmNZdJrBno1Z3UtTnSB
         Bu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bS+STaEjavMWz5T9ZeSrtZhIJJkRN5XPl/xyohmJoBA=;
        b=aECXufmL85G0dzdN+IZ8JQ76yNdIVBQPGGq1JeB9ds1HTgwKDCRFFqbs/CupGBGB/V
         Sao/fmCMaLuyeJhpC7dYJOWKhkTzYeHMUQu7Re59bIOHMLLkGoDUe8cqPyk/z6H9t12/
         8I6PY0l+3eIcE8sWuDENr+noB4itAMNSOfZKHQbDCB7G/xGSwjtj/p97AUafoWZK7Ci5
         z82ueeE7KEZM9DMENVqG15cIsD+nWLBCvMgdLx7VK9vHX4JlTLMj35G7klXom8EF/T3r
         j/HXxRinrg/XXd/geX3reuHCMb9YGS2ICfpvvXv6ExSAtcw15xGFHz5Hm/4tbcqjFbHb
         rkRg==
X-Gm-Message-State: AOPr4FWwjKm8NGN8dFoFEf1NuQq89qUM+WOvv7D2yxlIgbIFgdJvhk+Dp0RTemt5GN8Eew==
X-Received: by 10.28.151.133 with SMTP id z127mr4154363wmd.79.1462972848749;
        Wed, 11 May 2016 06:20:48 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294292>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", remove_file() should return -1 using error()
instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a2cc099..52f36c2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4075,17 +4075,18 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
 	}
 }
 
-static void remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
 {
 	if (state->update_index) {
 		if (remove_file_from_cache(patch->old_name) < 0)
-			die(_("unable to remove %s from index"), patch->old_name);
+			return error(_("unable to remove %s from index"), patch->old_name);
 	}
 	if (!state->cached) {
 		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
 			remove_path(patch->old_name);
 		}
 	}
+	return 0;
 }
 
 static void add_index_file(struct apply_state *state,
@@ -4264,8 +4265,10 @@ static void write_out_one_result(struct apply_state *state,
 				 int phase)
 {
 	if (patch->is_delete > 0) {
-		if (phase == 0)
-			remove_file(state, patch, 1);
+		if (phase == 0) {
+			if (remove_file(state, patch, 1))
+				exit(1);
+		}
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
@@ -4277,8 +4280,10 @@ static void write_out_one_result(struct apply_state *state,
 	 * Rename or modification boils down to the same
 	 * thing: remove the old, write the new
 	 */
-	if (phase == 0)
-		remove_file(state, patch, patch->is_rename);
+	if (phase == 0) {
+		if (remove_file(state, patch, patch->is_rename))
+			exit(1);
+	}
 	if (phase == 1)
 		create_file(state, patch);
 }
-- 
2.8.2.490.g3dabe57
