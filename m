From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 13/19] http: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:32 -0700
Message-ID: <72828866118c7e86e07a5cbaf4b69f17d8a71d1c.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wN-00011f-Fy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbaFIWVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:14 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:33670 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:13 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so5514875pbb.3
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ADRvhbxn8bBCRW0DxUp9K/6YX0cUgst9LabBRTjTemg=;
        b=i0kJO+Lo9sC9sAWVY7Vja7Nk1AO3e01yFTmGYno4mKsur8LotXQuxEzLBBz8kZyruE
         6OmhKlLT4FkFWZHJLUqj74cIOJrORuB1DvDdHU/3o/J7Fsi1nYBDni94oHUEb4ADyW0f
         XRtPHJwd+n7ULPMOhFTB5SCpgCTfa6vXHABKIHnJoI6Rc6dj7kKAGbHoV6Z2QGrl/hS7
         kTGKidS2/twVsCBNJW/StTx321wZK+yXWLqgidWmBIpRMTRwUTfV8VfB8Bs+1yHL/Vod
         pIb0yum+UHThp8HdCnsc7ShxZ7Lu4GnwAwYsIEUuCwenBrmqFXiUtYn9kqBxz+AsbPdB
         hN2A==
X-Received: by 10.66.161.69 with SMTP id xq5mr1246536pab.62.1402352472449;
        Mon, 09 Jun 2014 15:21:12 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id vx10sm2731064pac.17.2014.06.09.15.21.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:11 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:08 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251121>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 http.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 2b4f6a3..626fed7 100644
--- a/http.c
+++ b/http.c
@@ -1098,8 +1098,7 @@ static int update_url_from_redirect(struct strbuf *base,
 	    strcmp(tail, got->buf + got->len - tail_len))
 		return 0; /* insane redirect scheme */
 
-	strbuf_reset(base);
-	strbuf_add(base, got->buf, got->len - tail_len);
+	strbuf_set(base, got->buf, got->len - tail_len);
 	return 1;
 }
 
-- 
2.0.0.592.gf55b190
