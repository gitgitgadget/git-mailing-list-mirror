From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 10/19] date: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:29 -0700
Message-ID: <a4423dad33c44ba6badc9b44018a5de0ef4f5995.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wB-0000t7-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbaFIWVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:03 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60806 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:01 -0400
Received: by mail-pb0-f51.google.com with SMTP id rp16so64077pbb.38
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WuAgrXfjWcfpR09EfAedoSPDq8bhbkdn0zjaB9+9AMs=;
        b=zn4pf26dHd6Slxt2pXBwEKBtESTPB6RfPDIuAF9wazyzMfaubmzpM2HxgRxLYNjzhJ
         lZTDiTVVYNwcUcGTz1HtQIJNJ8plw5CxTKWMcpDMGE3KfihNwO6iXde8pfYTWCGzR9pH
         0TgURS7DL1OJUdaUHohqYiMP6SBd9DTp0hCdi4F/eEEexf9xsGrO2B4Ywi47Dcy+qjGy
         /JGTlINgVXn+15wCtHAWZza5HlJk+Qn7SX1fiKq4oeLXS2DdNs+b842NEOJm72QeyWpu
         bJEV+T22t1mbIbsBD2/sE8cBbvdV7Ezm987sdGex4It1R4rd6l3f5IKIuOQsBJTe57Hm
         tpHg==
X-Received: by 10.68.193.193 with SMTP id hq1mr7405540pbc.107.1402352460560;
        Mon, 09 Jun 2014 15:21:00 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id tf10sm65778557pbc.70.2014.06.09.15.20.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:59 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:56 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251118>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 date.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 782de95..0b723a4 100644
--- a/date.c
+++ b/date.c
@@ -166,8 +166,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	static struct strbuf timebuf = STRBUF_INIT;
 
 	if (mode == DATE_RAW) {
-		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		strbuf_setf(&timebuf, "%lu %+05d", time, tz);
 		return timebuf.buf;
 	}
 
-- 
2.0.0.592.gf55b190
