From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 71/83] builtin/apply: make create_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:11 +0200
Message-ID: <1461504863-15946-72-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDU-0000Cp-Om
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbcDXNgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:50 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35205 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbcDXNgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:31 -0400
Received: by mail-wm0-f46.google.com with SMTP id e201so60547144wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crbZXNZddiss11Y0QtSfbfrYKdzXu/1XNsNvUQMWpNs=;
        b=NwaoI4ag5EJPAVuJkFszvdnY4iv02nN+ch6nBovzv5Q+DdYzeYTANGMFliwt3VdwHF
         FwXeMGVnStQ+9POL6Zr2KtvUVO7Dvi4OeZJiSbleFCfeyGejcKlmuy2/F7LEL2unpxVG
         3sh+OjCI5/6yFRYwwbVJ45eMgmnBLSUH1Z1hfQ5OyZo1GXfhdRzESZFyeVCg8hpiAlY8
         vXaLPbJm6MWHITcZxJiuvxzlC3k2berrT9552rj1mn6jDZdcTVYmETgHy6o41dOqte+c
         qsI6TsuFfXb6d37BdrLadzY3nTLhqWM80y5MdQBcNOaQ6l4AmQL07+QvRJ2W6nhgHK9Q
         BTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crbZXNZddiss11Y0QtSfbfrYKdzXu/1XNsNvUQMWpNs=;
        b=diDmPhAD09Tk72JbnKuIkvHuwG4PEv66VejENxSqTtr+UzDlxvTeY08HQxbEjPuHQj
         g5Qir5RU86+A/xA/GKJmtrtphmRB6slsNQX23vU3K3Hj5/py2VLZpz7ltnH326X6q0vZ
         JzVzHAijw7nq7Jk+L9k5XLOZI8EHpgu1c7x2birX1pZhPLipdjqoiCvxA+yAKqlSg3zW
         MUd6JrNVhCCL6dkbNeyx2kbWbW3zmdjygn1nWMz2LPBITaO0jxtcwU6Xub3woCagb586
         PxbTcs9v73j2zAsTw3BKUV9Dg1fuCJgBx5beq5RE9gea0e7HCgP1BuNDEnjMV9qAVaOL
         CSKA==
X-Gm-Message-State: AOPr4FWw7OVXvYa78Qixf+eU+OM8fSO0C/+mVXi6TTU0gmW30mc5QFXWa6tzlp4N1n/eqQ==
X-Received: by 10.194.87.103 with SMTP id w7mr29624225wjz.13.1461504985279;
        Sun, 24 Apr 2016 06:36:25 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:24 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292363>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e021fad..ebac9ee 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4253,7 +4253,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4264,13 +4264,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway) {
-		if (add_conflicted_stages_file(state, patch))
-			exit(1);
-	} else {
-		if (add_index_file(state, path, mode, buf, size))
-			exit(1);
-	}
+	if (patch->conflicted_threeway)
+		return add_conflicted_stages_file(state, patch);
+	else
+		return add_index_file(state, path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4286,8 +4283,10 @@ static void write_out_one_result(struct apply_state *state,
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1)
-			create_file(state, patch);
+		if (phase == 1) {
+			if (create_file(state, patch))
+				exit(1);
+		}
 		return;
 	}
 	/*
@@ -4298,8 +4297,10 @@ static void write_out_one_result(struct apply_state *state,
 		if (remove_file(state, patch, patch->is_rename))
 			exit(1);
 	}
-	if (phase == 1)
-		create_file(state, patch);
+	if (phase == 1) {
+		if (create_file(state, patch))
+			exit(1);
+	}
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
-- 
2.8.1.300.g5fed0c0
