From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 3/7] Adjust stat width calculations to take --graph output into account
Date: Mon, 16 Apr 2012 03:44:51 -0700
Message-ID: <1334573095-32286-4-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjSx-0000YV-94
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab2DPKrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:47:05 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:58989 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2DPKrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:47:01 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so6754418dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S2qH//BU5plNH9R/11NPhBsBzAk/Ks3WDmGaCJflfSg=;
        b=xXa3/hcAy9C0p4iYxbkzT3naiRSV7HB/kIdtNVeWdW1TPXPLFVH2GQjAD1y25zjhwo
         5V/tjozrppfZDTouwWfBJCy0hoXTwtv00Hk7QAY/FBnByKq+fpBJwTGph+fwqyzLRnwU
         ms/CuPYkVnbEATaYM59boO2GDxMGmWSRJOipuRUcIsvsnyOtnmzIrpqHZI0Xh8o7LOSN
         8iDO7y5zC0WxaANnAZ7Lz68qQyB4amhqHYrntHAXkvKr961rTFRxlDihg0rWbUoVSMIK
         Y45QGnJp1XXBm0JYO7VbYsddskECLnWLSb5RJJF2buZUl9RCGo+4pCNBXer2HEfabfH9
         7L8Q==
Received: by 10.68.220.65 with SMTP id pu1mr27715523pbc.32.1334573221080;
        Mon, 16 Apr 2012 03:47:01 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.47.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:47:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195614>

The recent change to compute the width of diff --stat did not take into
consideration the output from --graph. The consequence is that when both
options are used, e.g. in 'log --stat --graph', the lines are too long.

Adjust stat width calculations to take --graph output into account.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..0b61cf7 100644
--- a/diff.c
+++ b/diff.c
@@ -1445,7 +1445,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 
 	if (options->stat_width == -1)
-		width = term_columns();
+		width = term_columns() - options->output_prefix_length;
 	else
 		width = options->stat_width ? options->stat_width : 80;
 
-- 
1.7.3.4
