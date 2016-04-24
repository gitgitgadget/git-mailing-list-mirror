From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 68/83] builtin/apply: make remove_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:08 +0200
Message-ID: <1461504863-15946-69-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDI-00006x-1K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbcDXNgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:35 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35190 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbcDXNg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:27 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so60546159wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dXbcjwagskSSPox3CWXjBBPP8wGh1/kwufItIN/c+Kk=;
        b=Ky8REhUsP8KGVmKDnj1/QVRH7rJzLS3JjLBqqPcGJlGCNx/XbfE0fTZ/WyBeWtjWBu
         UJvZimpSqkFU9ywNMMAKiSR7qPuklsnrUynXVI7W0lAVlKlsnzKAvVCO6v2zxdWZep/4
         3vb9Xa41oJH/a9Olt0dGCDgIUPshg5FnPU44bnUYQaEcgsGYxskgdTohKWy2s+cHpmJw
         N1AykLaVH85aY32u9VyOfmTcvzD4P+3qQTJBSHdbv9CSrwtQHr7Ongt3WMP5I7sE8wX9
         GHksVIteDUm5jZdS8ad6gHCgEcO6JLqTr1XoLmbm6Lt+lb/a50SX7AN/aEQT3Cx1wLkj
         Mn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dXbcjwagskSSPox3CWXjBBPP8wGh1/kwufItIN/c+Kk=;
        b=Kx3eERVyIPweUqhjoaygHuAYQI/P/k8gxJhd7lMq+7bV90twdXbUESjBY9z+zMiLIX
         ec8XH69Mxq20yQzHGf6ICE8Th+EdoV4V9233oEg2opFR0Pe7+vle7n5ivU5z49pdtcc/
         ln35S28Nt28iDAbzcY2TZsDOfXhL/j6W2Sy+VEuC2sdgS7Kf7b3TRdUOf93jqZ9e8oTT
         aduhwiUNqUKDSQBPKp8auvKDHCkWn3tA65jaraPsod6d9jwJ1sqB7aj6gulpnUqY+u1K
         xOm8koz8XVSMgint6Wv3M+vSH21r/VW1A4vZzDTGGG1l0+rTmk/2gHj+ARpD9Slvqz02
         1yDA==
X-Gm-Message-State: AOPr4FUWef/LeOTrsRvFlkjlfUY7ZEv50ZDuzg/SALBRtxzWRZp6LXeVNTA/0zu4HHlvJA==
X-Received: by 10.28.168.76 with SMTP id r73mr4302364wme.44.1461504981241;
        Sun, 24 Apr 2016 06:36:21 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292358>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 69bb94c..89118c1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4071,17 +4071,18 @@ static void patch_stats(struct apply_state *state, struct patch *patch)
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
@@ -4260,8 +4261,10 @@ static void write_out_one_result(struct apply_state *state,
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
@@ -4273,8 +4276,10 @@ static void write_out_one_result(struct apply_state *state,
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
2.8.1.300.g5fed0c0
