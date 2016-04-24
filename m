From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 03/83] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Sun, 24 Apr 2016 15:33:03 +0200
Message-ID: <1461504863-15946-4-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKBe-0007do-5k
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbcDXNex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:53 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34823 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcDXNet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:49 -0400
Received: by mail-wm0-f49.google.com with SMTP id e201so60523069wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EzLcf4qOXhBoahA7J/jCQ03ylAjZksAvwIq33PxFFlQ=;
        b=GMsRcDkKh2erIaoRIwPyKmewpNPgbCMIuyS4UzBNIzlBUUGXAF5UunYPCFHrtHgF/J
         lzNe/1sQYolX7Qf+btI90dWeqFXKgcu74q4Ess1DiYpkMAEWOjVog94AhsXjetu7ZjNo
         1F7717nP7FW0rUCAK9zDAjJCN3s4776IMd04pnMWnq+O8B4dQSgJnSYmDZVidcpev5qz
         T3r8bSU821nuEnYQ48J6Eobjfy36idU5XULXd3bSthEkJJDMv3pQP01B+Js5Nc3iJSYp
         te1RbRevk2JUFWwuWMw1Q+ci7rcyh/f5XvvF8FxMMethSYC7U/Old97eIP6+apv3JNZD
         Pogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EzLcf4qOXhBoahA7J/jCQ03ylAjZksAvwIq33PxFFlQ=;
        b=mdR6Ut66I+HPLr3g1pG7Bn0rBU1pGxM1ZDLqtJja3pTQAij+8nxDE1+pm13YKzgRbn
         TL/pHzti2mLgYQfb4ZJsW/G84XJ8iuJKsVejZ0Rfbg97pH3XmNpIKNQOgz5QNrn0djO6
         uuQg2SnR3Vg7ubBPa86GNDPpqZ4vBJGAvCzP1WpZhWt9f6gYcYWkQwL572dMtXsP5cja
         AobyKLOW+m0EducBX+3GrjxBTjJO677yXAfB8SdW20uDDEKUJiGtQ2RMGC06zj+OKXNN
         C6ZVGbD5gLEX8I96eUWeJfQBa+vW0q/7zxlZLgz5L928wIwgSLCGBfz4bf2UitAHC6nb
         Tg0A==
X-Gm-Message-State: AOPr4FVAufyQEto/QOSut7ZUw8IeUm7CPXdS9Dt7tqHRIWXMMn9vM7weiUTH2DHa8krhQQ==
X-Received: by 10.194.187.236 with SMTP id fv12mr29814255wjc.96.1461504887990;
        Sun, 24 Apr 2016 06:34:47 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:47 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292326>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e133b38..7115dc2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1516,7 +1516,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 	return -1;
 }
 
-static void record_ws_error(unsigned result, const char *line, int len, int linenr)
+static void record_ws_error(unsigned result, const char *line, int len, int l_nr)
 {
 	char *err;
 
@@ -1530,7 +1530,7 @@ static void record_ws_error(unsigned result, const char *line, int len, int line
 
 	err = whitespace_error_string(result);
 	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		patch_input_file, linenr, err, len, line);
+		patch_input_file, l_nr, err, len, line);
 	free(err);
 }
 
-- 
2.8.1.300.g5fed0c0
