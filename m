From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 21/83] builtin/apply: move 'no-add' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:21 +0200
Message-ID: <1461504863-15946-22-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKC4-0007sT-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcDXNfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:18 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36453 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:16 -0400
Received: by mail-wm0-f43.google.com with SMTP id v188so69560032wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Twbng2aUfh+/bJYYwrB+fYeAoTI49sV/oGSUqH08Yw=;
        b=x7pmYexHHxTuKEP5UWEWbAJBV0HxZIF2BbNcl1kg6EsE3IyBJs4MIyOwDp8ZSqSC4X
         yzCR1ZKTD6PLjUV6xsgQrne8m/HR+FdrmMZEf0iNTPu5ajd7auV9KZraqV0ts6dxKfJK
         WHavHlfGnho55CVKllkpU5bvkknR+D5UeSVemk4cv4YLjcCHXGwGYiRDUxEO238N3PAB
         HPChDQouZkGs9JBK62TVidbCrxMMkDBQVcV2RhMqdBBRo80EmqjV613kO/quTk4aOR0C
         22TAO2J2Q6b5Zg42EdpO3+l7aRJcRzbQwSHLgcPT+hCetGex3uuj+fERy1RYpOVjJD7b
         coZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Twbng2aUfh+/bJYYwrB+fYeAoTI49sV/oGSUqH08Yw=;
        b=mYizcb5x54j+FeFt5f+8o9VlyfGR/NYr7dn1ls+kvFF2REJfQWENpoh1CIXDa6E1Lq
         0fKgdtOvdP1Nca+IM6kkComTYY15nY8F7yn9Sd1LYNoQRuoOFBQVG0X0P7BfjFnhfsrx
         q3Q+b5gjwm06rw0eJIHW50+eLAU+8llIiKIyoveLlv4jKFISelJtwASbgXLQPuiWSBQd
         cmo/8jd3So9jQYAVwB9PVCktblIwXmLDy635u1nBiOfclJAQANsGjJXg0LDf0hGYlIVj
         0pxSCCWiuvlDxGsjFGwH21HTduWlUjkLv3PZLkfVpyOekm21xIncOoZZq9QUvy+7pPJw
         dYmg==
X-Gm-Message-State: AOPr4FVoEZYrCbZLH9+d9JZeZWJ/E7w1T5xtR6dvu73u7a2dpdyHS/Jzkx3D3CUUp/MYVQ==
X-Received: by 10.28.133.129 with SMTP id h123mr6922767wmd.33.1461504914840;
        Sun, 24 Apr 2016 06:35:14 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292331>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 33a1f8f..506357c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -43,6 +43,8 @@ struct apply_state {
 
 	int threeway;
 
+	int no_add;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -65,7 +67,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int no_add;
 static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
@@ -2796,7 +2797,7 @@ static int apply_one_fragment(struct apply_state *state,
 		/* Fall-through for ' ' */
 		case '+':
 			/* --no-add does not add new lines */
-			if (first == '+' && no_add)
+			if (first == '+' && state->no_add)
 				break;
 
 			start = newlines.len;
@@ -4595,7 +4596,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
-		OPT_BOOL(0, "no-add", &no_add,
+		OPT_BOOL(0, "no-add", &state.no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
-- 
2.8.1.300.g5fed0c0
