From: kgeorgiou <kyriakos.a.georgiou@gmail.com>
Subject: [PATCH][GSoC] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sun,  2 Mar 2014 00:42:11 +0200
Message-ID: <1393713731-55358-1-git-send-email-kyriakos.a.georgiou@gmail.com>
Cc: kgeorgiou <kyriakos.a.georgiou@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 23:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJsct-0007mf-M1
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 23:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbaCAWm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 17:42:56 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:63295 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbaCAWmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 17:42:55 -0500
Received: by mail-ee0-f50.google.com with SMTP id c13so1150600eek.23
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wZBiELUyprCueF5x62qkbaeacky5da9mqaUJ6Ly31fE=;
        b=gi1g5VWywiYbUNoRH016uP5KzFM4lyukN+6+TI2fnnJDBPG4ruGbGV4bANQJUJJWaR
         2LniKWPLZyyFieHf1fuUuQ719/lf/2hSmLGZHmfM2EUfIPd60CVq8hgrm9J1QnsmENmm
         CeFhr0a/Bq/czMXP1zToMSlcn2etc+aSZLgastXnluynDyW1NmLlrI12UkTdq6Trnt5I
         +ssHbZ7/3CQ97vxzHCSo0hrk/c6kX8+oSnMypjM9wYYhW5TvfIEFuRtxE9BNGbu4MPQj
         owwcndIQLE4eYl6PZ8713yF3pRIospU0CwOG19yeKjLUStDpwmTmGEoM4eSoxg6J9Igb
         g8RQ==
X-Received: by 10.15.83.67 with SMTP id b43mr16920518eez.40.1393713773966;
        Sat, 01 Mar 2014 14:42:53 -0800 (PST)
Received: from localhost.localdomain ([212.50.113.31])
        by mx.google.com with ESMTPSA id a2sm28924044eem.18.2014.03.01.14.42.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 14:42:53 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243113>

Rewritten git-compat-util.h:skip_prefix() as a loop, so that it doesn't have to
scan through the prefix string twice as a miniproject for GSoC 2014.

(I've just noticed that this miniproject has already been tackled by another 
contributor, if that's a problem I can pick something else.)

Looking forward to any kind of feedback.

- Kyriakos Georgiou

Signed-off-by: kgeorgiou <kyriakos.a.georgiou@gmail.com>
---
 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 614a5e9..713f37a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	while(*prefix && *str == *prefix) {
+		str++;
+		prefix++;
+	}
+	return *prefix ? NULL : str;
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
1.8.3.2
