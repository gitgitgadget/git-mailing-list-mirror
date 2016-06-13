From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 32/40] write_or_die: use warning() instead of fprintf(stderr, ...)
Date: Mon, 13 Jun 2016 18:09:34 +0200
Message-ID: <20160613160942.1806-33-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUS5-00042v-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424966AbcFMQKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33763 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424963AbcFMQKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so16046448wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ZUFunF820TqRUc7FLKioTmrkc2SuGMtunn4tjH4W5E=;
        b=iUBH2ttNeW328Bj0hARTMn0V4AFVAKKtpQBTp9Xxxv+5N4o65/MQfPVm0YQY2jIUvk
         DC8bPD6K1wCVwYfCCxidCmFSwCEp47S6s/zbKBMH4UUgPdBP1O8PnvQrUAqbC6BxdqW/
         enfz93vHZ6uNGyZR+srx5+xT5/OlBeuqEezNDn2M/sCCODSNkATZbfEqCIREe274M9P2
         4qJoiCLuXXmT7a2VYfigR+eLqN10r3jsIo9IYJs6CMAorfj3ZHwapAQPzc59Ew3Q2SFY
         fMHwculwytuyADiaCvVnaYMH+7a7Jpqtwx7B4FR4brn07QF9TAzOp3RUNjTOUh0fiFBY
         vbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ZUFunF820TqRUc7FLKioTmrkc2SuGMtunn4tjH4W5E=;
        b=ef7l8FBPInyHn3J0xPZjkgugkKbxiJ1akwwk70oxCpV59uNEWCwFh2UNUrRBE4chr2
         HAb04HO9hB4rwwu0T8V2Y9eKI2W0saxjwyQgHhWmX8IabYw2G7gJrdNGqZ5S9jMdTrYC
         TLmGSC/IteBl4nuHPGCkWTxFOkF1auAQr9rBYfbYNyIRvs5EgCcBhrZY6Ng1gRsl/3ia
         sfB6Z45MMFzXzsEOJEE7QVJHTVQkLrstJcONO24ZgEU7djttkIpYhou7BIqPlPgdDm3N
         2DasXY9JI4viavmO4ds86jWgI7H6/ldkVGLLBLrAC6eooG00n/lEktdi7s4Dko6jgbh3
         y03g==
X-Gm-Message-State: ALyK8tLxaXQRjYLO36wnwlaTkqvYpJTKbkF+9MvG4CVbl9wWCtmppT6nyxfyV6Y/ATwY0g==
X-Received: by 10.194.123.170 with SMTP id mb10mr1903767wjb.39.1465834251926;
        Mon, 13 Jun 2016 09:10:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297207>

In write_or_whine_pipe() and write_or_whine() when write_in_full()
returns an error, let's print the errno related error message using
warning() instead of fprintf(stderr, ...).

This makes it possible to change the way it is handled by changing
the current warn routine in usage.c.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 write_or_die.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 49e80aa..c29f677 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -87,8 +87,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
 		check_pipe(errno);
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
@@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
+		warning("%s: write error (%s)\n", msg, strerror(errno));
 		return 0;
 	}
 
-- 
2.9.0.rc2.411.g3e2ca28
