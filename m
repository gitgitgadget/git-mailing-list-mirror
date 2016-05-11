From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 72/94] builtin/apply: make create_file() return -1 on error
Date: Wed, 11 May 2016 15:17:23 +0200
Message-ID: <20160511131745.2914-73-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5f-0005en-P8
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbcEKNU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35658 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbcEKNU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9412474wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0CYfwsOdVq440QImtXqmkILGmEG+ap9+fSQH+HrRV3s=;
        b=ES766OWt65YoRPnNtHqeKFnFkyY6Oy279ssNp3Ldv6IP7315z9PdI3CgI/GA1qPNt1
         FUgpRI+tZ8gHmGJ10b/24BbzJ82jefWlJnl5zPYbfnAcYG9S/9jAFmClvjzO9m3xHeHR
         URqTZrxYUiMyoQMb8YJ5OlYCzYq3KGOi3Q4cEboX8oq6AYONAAHYVpvdDiqk2it/RPJR
         tQnBzApOUH0nNtzXw05FU6Fsm1fTlIb0kKN3rNWmsvLSq551kM2MdwobIBLgKlPFT/w6
         ulFFeBhDy88/QC0SYEOY+TaspRCneYvqPMgZuoCMPVu3rjjO/q3t/nYisiAxDNXR+fFB
         KluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0CYfwsOdVq440QImtXqmkILGmEG+ap9+fSQH+HrRV3s=;
        b=m7h9unccIAvpDH3RWzWu7UxArtReFn55jWdNFkWcOYKJd6KLyJqrG4hZiDDzwX/w9P
         3cZXMHHxjvySvkcwXeUxp1fS8/7pWESnfGrw5KaXOP3iiIrbcwhGv8TFs2iV/oKFGhnX
         qKn+bfgJGnonJeb1QQyS0EQsZCFs9+jpafQpkZSDHij+nTCkFHR/BhKwYzSpCxmmBIiJ
         s1m8Mp6uWw194lom08B+AvHFoSKBaC6Xn0xZYOZfQOQnTaBOwqTVYLKx5C+KvLTVhlUG
         DhQBABGAZafzFX6gXN8IfSJdY8opMSEP7jjcIHfZSVNuPfFm2skJqXRIwkMnNuFpi0SX
         8KEQ==
X-Gm-Message-State: AOPr4FVwyVp9CqN5vI3zVlP7fYvBbd7iUSiQFpiBIa4Pouu/YdyuEO9yj1lLr8Nrv7EXxw==
X-Received: by 10.28.144.138 with SMTP id s132mr4574305wmd.102.1462972854807;
        Wed, 11 May 2016 06:20:54 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294311>

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
index 0e20467..2b562db 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4259,7 +4259,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4270,13 +4270,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
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
@@ -4292,8 +4289,10 @@ static void write_out_one_result(struct apply_state *state,
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
@@ -4304,8 +4303,10 @@ static void write_out_one_result(struct apply_state *state,
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
2.8.2.490.g3dabe57
