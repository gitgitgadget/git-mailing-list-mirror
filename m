From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Fix unsigned time_t comparison
Date: Mon, 25 Feb 2013 23:51:16 +0200
Message-ID: <CAHXAxrMZODO07_dPep-yKgrzD1228iSMGUXX06xkKDmoZF4+qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:51:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA5xg-00016H-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 22:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606Ab3BYVvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 16:51:22 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60923 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402Ab3BYVvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 16:51:17 -0500
Received: by mail-qa0-f47.google.com with SMTP id j8so1914387qah.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=9B9UtGfj34eQsGeZ9MROLh24oG18BCeSd4BOXzJ0xGU=;
        b=i8n5rwG13wGVTjn27CxyhKQ1p0Cuy32NHkDAhsWSOX/SMeM2mXb2yyGlf9r6UD4Qpq
         pg4hkao3EQZJChq+ZRKIEo98KoqpZeoZGQXaX0wyr5Ap8XQm4WliBRnfwThNrBaX45fL
         8O4OnYOPrD5J/9wbQx9ATlcS962zbmHAFDw99R5KhQcpAwbrrElZ+tnQvy1zCYL+mnPu
         4nAGJg2TZf1Y+l6qwutLMVXqBehgfcOYnKGAA7USWF18lNl6LUjtaas4FnrXImenhG75
         ZbQxQ6vDEZoPhzL5r5qKXO49V/gnHar3/FJxzIa5zX0OO/5qlg8cUD2XYBdc1wB1tmEx
         y4sA==
X-Received: by 10.49.59.105 with SMTP id y9mr16071687qeq.41.1361829076892;
 Mon, 25 Feb 2013 13:51:16 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 13:51:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217109>

Do not compare time_t (less comparison) with -1. If time_t
is unsigned this leads to always true comparison.

Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 57331ed..1ac28e5 100644
--- a/date.c
+++ b/date.c
@@ -383,7 +383,7 @@ static int is_date(int year, int month, int day,
struct tm *now_tm, time_t now,
 		 * sense to specify timestamp way into the future.  Make
 		 * sure it is not later than ten days from now...
 		 */
-		if (now + 10*24*3600 < specified)
+		if ((specified != -1) && (now + 10*24*3600 < specified))
 			return 0;
 		tm->tm_mon = r->tm_mon;
 		tm->tm_mday = r->tm_mday;
-- 
1.8.2-rc0
