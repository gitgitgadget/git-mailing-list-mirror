From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 37/44] apply: don't print on stdout when be_silent is set
Date: Fri, 10 Jun 2016 22:11:11 +0200
Message-ID: <20160610201118.13813-38-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnb-0003vF-JU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbcFJUMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35325 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597AbcFJUMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so1051321wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BbPvsU2cTql52xg2gbkJ73+lmuqoYAs1kfVyPJvSVUQ=;
        b=ZNJQPx4MVLJo8dru7Q9fIIZxqAlrujiwJudDkUIOakapx/rkzUkhS1GTY4iV2Qxqlg
         76Sck40feTMGEcRszQPZFfgsJcLKaaI3lev99qbz/dCor0MB4Tp16HIkxAqiDSvXwsRI
         Pd9/4Qn2r91KQRoKEouhNO2gI93nQFq7qyjkfuGKDgxFxrFCrB4FUoOrlVU3NO4pj7KO
         bXBp07pKuUk7rAl1kVlor7VGIUAB3FDLelT5nRyHUyadVX+TMZzRqEe7/h8sIDeCZRBK
         Wmalz5GZ08QtW6B3vW+hZd/vT1OVBrNCbSfVu6YeDrife/pG5rnLRzdqVaKfzauIzZ/a
         FW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BbPvsU2cTql52xg2gbkJ73+lmuqoYAs1kfVyPJvSVUQ=;
        b=ik0iS+tmYb5THzs+tg1MThSjRWKk7YQmDqu24M/dy5gu7d0SoKeMMTlkdUiE5hY5sA
         QhZ3MOSoV0pvu5dd1QA4X0pQ0bfpiqmd2cG/fKPwZ75Mie4ayjpEDPwJCwbgFbDPBUZX
         YjtE5uBy4NAOgJSL5QTEQRk+wl+pLV6rGSXEIeWA3Lxxesfu+WvZ0X/X+FFk1bKhrRY9
         DKNdwQtOdVjp7+a2oNJxa/oH3chcYbNU7w2M3LLv5VaxBDWu/M52hRUy/455+jEC+rBq
         JHdpgKpJecBVskIpKfAu2uDFeaU4D9bxMmlsVFlonwDlQ+Pv6a5ymMYLDfKzFX8IRonG
         uLWw==
X-Gm-Message-State: ALyK8tIWUD8WZBUsqW/DCtBSAibx9hfiaFvL51MkJ33dD1wGuYObMB8pmRe+gTnfKLsJYg==
X-Received: by 10.28.225.132 with SMTP id y126mr630769wmg.64.1465589561578;
        Fri, 10 Jun 2016 13:12:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297045>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index dd9b301..2529534 100644
--- a/apply.c
+++ b/apply.c
@@ -4679,13 +4679,13 @@ static int apply_patch(struct apply_state *state,
 		goto end;
 	}
 
-	if (state->diffstat)
+	if (state->diffstat && !state->be_silent)
 		stat_patch_list(state, list);
 
-	if (state->numstat)
+	if (state->numstat && !state->be_silent)
 		numstat_patch_list(state, list);
 
-	if (state->summary)
+	if (state->summary && !state->be_silent)
 		summary_patch_list(list);
 
 end:
-- 
2.9.0.rc2.362.g3cd93d0
