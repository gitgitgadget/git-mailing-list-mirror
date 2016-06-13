From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 22/40] builtin/apply: make create_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:24 +0200
Message-ID: <20160613160942.1806-23-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURw-0003vv-I4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424935AbcFMQKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33494 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so16044014wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6L/Xnyw5IfoIh9bRlK27nugvknCmfJZfEgK6sr23tA=;
        b=XXzKYDsZmV2uxoPv/FW9NTsDGYOt/8s062RltlnBWp0lvK5y6EzXqlk+s3SO4C1QQg
         Dl5Kd34AzC/4i4tci31LaMcUAT/pyyfgWY8jawn1XDragJhG/jrLerkszZYoV1Tjs8oj
         VeO/DGJpWHgdXA8SrqfStNZNiIRi6pvv3b5SyBQmiuCzyeQzOHkxxyTcrDR8SL3N+rZ6
         V5NItj8TwsEBHGbWVObWqJAyWnhAK4raW9HjSvoP1lZ68olfP5Gv/LnZb4vqjkaPuWY5
         QnZOKq0PFhBX+8/96keg+TyTPdayu8JR4Phts2UTG3XWck91smiRyJr8bw0XrzXkgJZy
         qjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6L/Xnyw5IfoIh9bRlK27nugvknCmfJZfEgK6sr23tA=;
        b=b5x0YIPRuvw48MrVGYOmbniS3YmdCSWU3UfsAxNU1YIDAeWtmFkMdFNWLtzU8WJir2
         Ze4iELgVx6+Hkq+cjdnMZ9FWPU6QVsVZoXeTvkx3F0Vc7anB6OP1ZaWA4QR7U4tfNvbI
         85eXzaM7iPDbTGg00z9A70/T17dz3lMY7a1UOekTpafK+ooHjXpJ+w69SmyOG9k0Sn23
         p5T0ZvW/ogsa3yxlcC2HjVwxDRzmf4GNf5XJvnD92GHBa/GceczbAOQQdn1m2GA/+EvW
         bNKxNfnhA2WyeazJmeMTI6ix91vSW4oRep2X51J5s9DWj8jcdXNa5kPGmMNTEqPhS7AA
         GlbQ==
X-Gm-Message-State: ALyK8tKnK+YsfAQdMBmoydxj9p3Ab9su1XMKgxVuXCm8uRgxh/KSewT4nBxIsWk8ci99Ag==
X-Received: by 10.28.36.8 with SMTP id k8mr2016311wmk.66.1465834226790;
        Mon, 13 Jun 2016 09:10:26 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:26 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297208>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_file() should just return what
add_conflicted_stages_file() and add_index_file() are returning
instead of calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 005ba78..76d473c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4258,7 +4258,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4269,13 +4269,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
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
@@ -4291,8 +4288,10 @@ static void write_out_one_result(struct apply_state *state,
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
@@ -4303,8 +4302,10 @@ static void write_out_one_result(struct apply_state *state,
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
2.9.0.rc2.411.g3e2ca28
