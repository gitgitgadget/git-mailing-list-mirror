From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 23/49] builtin/apply: move 'no_add' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:00 +0200
Message-ID: <20160524081126.16973-24-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:15:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57V1-0001xG-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbcEXIP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35503 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbcEXIMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so3655243wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F23sX7ZcIJ/Iwqo7HQX8nX/HXSzK6irm0143zZ6YOc4=;
        b=NFHKqLUVCc6MTY6BInE78u1YdnCVRCNqgHDsNegu+pjuMNMtq1qsNzkcX2S1/R4AGO
         j6Zjs5n+IT7MoQTB2J5Tj96TIynntUbdKC5sdVzY77j+nGTstBy8CdWOGAc34zGmQ1UP
         noS/BqSzFjfl8tSNa919AlMUMFpvY4PtshPTr8zMOWGB4GZHMUZ+IpfPEB4dUe1lQJJJ
         V1psvebvq6UWcuM92GodhZCrRGFLufYbdbL8o4K3tyJwUh2GEougtaQ4OflWjLIE2RnM
         rGFYN3akPY2T+aYYSkaZ2cNv4dmsDOWQTA71EoDKcSZvTAuQSMLQX9Cts+UxR+TGUkoE
         uPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F23sX7ZcIJ/Iwqo7HQX8nX/HXSzK6irm0143zZ6YOc4=;
        b=QAwAa75qIJTwXBr5NBU1YHKc5O9Wb2SnB8WZSpk39WKLIBwKvEwQdCe7dMIu/bzNvY
         dBsElVp679Lsj5an3/hNNNar9DMenv1m3GibIJi17vUi8b/ygug4CwfbX/1j7zgtIPS3
         FmbT3hrQH7Oqe1jMwQbQt14R0R8lZr0vk1OnsP2XHZ/VqfokGqOmZuMmEaLfDnixZrcI
         35DHlZ8KedRgir2xgpQo872rcMFk8dToZp3kb2Lb4sli+kY/i6cAuYrbb0UdtUD+JVqF
         Q/c50/Qfzn+jIsVf6LgLaBIJ33GaazazIFJQAW1NLKPGLogdLFTtr6O1qNUzldA4anLZ
         3OGA==
X-Gm-Message-State: AOPr4FViMtVlWQIBJmlB7dVarOebsobUDFdbKFJ7oPSyqEuw7UncRU7a57VmMbevXzNi/A==
X-Received: by 10.28.15.79 with SMTP id 76mr22282185wmp.53.1464077537640;
        Tue, 24 May 2016 01:12:17 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295465>

To libify the apply functionality the 'no_add' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d00017b..604e7bf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -41,6 +41,7 @@ struct apply_state {
 	int apply_in_reverse;
 	int apply_with_reject;
 	int apply_verbosely;
+	int no_add;
 	int threeway;
 	int unidiff_zero;
 };
@@ -53,7 +54,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int no_add;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2782,7 +2782,7 @@ static int apply_one_fragment(struct apply_state *state,
 		/* Fall-through for ' ' */
 		case '+':
 			/* --no-add does not add new lines */
-			if (first == '+' && no_add)
+			if (first == '+' && state->no_add)
 				break;
 
 			start = newlines.len;
@@ -4600,7 +4600,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
-		OPT_BOOL(0, "no-add", &no_add,
+		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
-- 
2.8.3.443.gaeee61e
