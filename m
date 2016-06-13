From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 35/40] apply: don't print on stdout when be_silent is set
Date: Mon, 13 Jun 2016 18:09:37 +0200
Message-ID: <20160613160942.1806-36-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSE-0004Co-ML
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424978AbcFMQLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32777 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424968AbcFMQK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so16046859wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nNTtRvBuRA9x9MR3SBmZKsVAUcmVtCsGQJCuW0qYr2U=;
        b=GRBeNDiiicQ2uvGe6SU3jTsM9sY9c/L0ZZKKc3eP+tp4pW450E0Mv/Yj0F5OaCO3Y3
         O6CImcCRKjN/oBFbQisli2na0PdxkzZlv+Yc56ktG+Ug5joVon0AxBe6MQ4Uy/FFaTnT
         yfDPDjUOvEz88hs6YP1epmiIxJbk2+Rl9Rz3gP3LBD8yRlzaDxoG1ZCm0AoMWqQAeOSc
         AWGkP262AevTtq74pDTRTCPgHcO5nQaHLj/3p7ZTtK3EDrgAad05Firzm0jNbxoYrXTL
         DPYfu3knBrVYPIoIZWYu6ZqOPHU8usNK+KPo/WHGJ8HNC0nXAq61k4kzbbkXfgMvPh5/
         G/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nNTtRvBuRA9x9MR3SBmZKsVAUcmVtCsGQJCuW0qYr2U=;
        b=CNKqDvewE+OO41SnW1j0mfaxNweerguZbX/AOUHFLZDES7wLt7qBJ2EWcESzELX84A
         tplVVeJ8hAU4I5OGKoLNykyqPAW4QYBy487+nf8IMmeALATZDWswFQPCxIS8OQRGg1gA
         im2ZYvZtG5KCCmKAd0+r05bbjFzhh2k9m8Kix4a/g+JaohxKFqF/K0VXIc+Ef+gvsgYK
         08soCmUWAaaRvzW4zn+bqxp2m8Vw01ISD5P7yej9RhGCNx0cY0u0J02dWNlAFrn+669e
         it32IDnKqX/cwLW6uMAQ2zIqyCRchU7AezkA1WTjUeP5z5hVqba4ozQk3lMJ1JWUYtBe
         8gVQ==
X-Gm-Message-State: ALyK8tI85uRIU6/0QdVxL/v0dTSpdbL1/xdRuEk2+RqksBDinMkKekkgcYoEJMS/uaESrw==
X-Received: by 10.28.197.132 with SMTP id v126mr1932737wmf.8.1465834255832;
        Mon, 13 Jun 2016 09:10:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297214>

This variable should prevent anything to be printed on both stderr
and stdout.

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
2.9.0.rc2.411.g3e2ca28
