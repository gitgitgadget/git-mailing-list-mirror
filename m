From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 6/7] Prevent graph_width of diff stat from falling below min
Date: Mon, 16 Apr 2012 03:44:54 -0700
Message-ID: <1334573095-32286-7-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjTH-0000o1-1o
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab2DPKrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:47:40 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:36457 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2DPKri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:47:38 -0400
Received: by dake40 with SMTP id e40so6755901dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UeN/DIpXWV/QXGxq8Gue1s2OS4kNwUabm/6x4IHhaoo=;
        b=n2zhur8WxwRzwxG/8FHjJtrZXj6yugsK8Kwfv8wX+N+X2jCG6ar5rCrn9Aq+6B4Zeg
         11o9t8qMcc0GP1Xe8q2qPY4IhKiBPaIokub92nB6GCe8FrlsRRboI2eoccVDiG28kiNn
         MiaJYiNM6yKaTd8rNfK7ezkc2SbASKp0DwDeqW9MkNJfP+jUyiaNXraPCjo9kRaf0tKI
         y4dEoSWDOBHOD75t7jzq2whgK1HgBtiaOSlxLvr0XsBxCkGmcrThWav5H5K0M6K9ginr
         X6GSoqVNc0pvp/IHvfyDY2HwJ8uZcfMdeZW9KQFpETqIk4FyQ4iTKamyv12AvbJZD/Yk
         5OwA==
Received: by 10.68.225.39 with SMTP id rh7mr27085548pbc.104.1334573258048;
        Mon, 16 Apr 2012 03:47:38 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.47.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:47:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195617>


Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 0b61cf7..f08b41a 100644
--- a/diff.c
+++ b/diff.c
@@ -1473,8 +1473,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
 	if (name_width + number_width + 6 + graph_width > width) {
-		if (graph_width > width * 3/8 - number_width - 6)
+		if (graph_width > width * 3/8 - number_width - 6) {
 			graph_width = width * 3/8 - number_width - 6;
+			if (graph_width < 6)
+				graph_width = 6;
+		}
+
 		if (options->stat_graph_width &&
 		    graph_width > options->stat_graph_width)
 			graph_width = options->stat_graph_width;
-- 
1.7.3.4
