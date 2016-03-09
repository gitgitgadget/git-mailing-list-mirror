From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 02/48] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Wed,  9 Mar 2016 18:48:30 +0100
Message-ID: <1457545756-20616-3-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHJ-0007RT-L2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbcCIRwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:06 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35194 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbcCIRwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:03 -0500
Received: by mail-wm0-f52.google.com with SMTP id l68so190184257wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UT9036X0dJ8SfhNqtbSs2G7KYLe1zDC5bPkzVARnaps=;
        b=XvDXhgCo1NYSsxImLeQct75eNl++2J+3eDPQlaug/fDvQU3XHsgdqXK72aXHUB3bbR
         v9Kq1ZiFIyUZKHmCu9g8TgzPsb4TYYJGl7gkLUjyeh2AvKIMzNRf8SNlIotzawlfJwXC
         f3mSnupHZD/BlBxJWakq0BFRa1sN1WE8vYaE1t4tqysdKhFEdAWBu6QxS3IOQXsSGL+c
         CcRRU+8i1Uow6g8xmlkPSVA9ffHLcbofm+W2BqaezFdRFnfBD4izXfCOeQEimK9V/BZ+
         ZcENYw4CkLIyF1vOkP33xKXZS+s9CQl+upBqY0fVtqNMuXuHWh5p2l4JknpywhqCNAfV
         h/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UT9036X0dJ8SfhNqtbSs2G7KYLe1zDC5bPkzVARnaps=;
        b=h9/ldNVTIf51cgE1hW8oK95cTYjQAbwuv0TqhXXsGBEJ2Y3SqDuJR038ghugH9e9tK
         CN3d9deDMDlzM+WlRc1kr7yF9sGf16M6SpGKaDzbKQalw+JPTFtaoyCQCVCQxmgYfUrI
         5o+yBmwVnQj1nizej+d6zxPOKTBxK9+908vXTpFz+9kXLzNm5cK3nBElwVZMy3+8Z+CT
         di/0L7BNwZrptZrb0EXDLwcV4In86zMQJI21GZB5creT344/hNZaL7fwFZPSwCW1bMBh
         v4LCCaZlamLrbYNmyD9sP0ulHdCVcCueSwTH6dHtJ0/yH/FT/I6bEV3+l5uuzp++Mg96
         qLPw==
X-Gm-Message-State: AD7BkJLFKT1bEuv/no++VtlEr8XyKXsR04BHviC0mmxJ5RvBAhi510nbNUfGSoyY6jnZ4g==
X-Received: by 10.28.174.8 with SMTP id x8mr357956wme.49.1457545922133;
        Wed, 09 Mar 2016 09:52:02 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:01 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288492>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7d9be63..3f740c7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1525,7 +1525,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 	return -1;
 }
 
-static void record_ws_error(unsigned result, const char *line, int len, int linenr)
+static void record_ws_error(unsigned result, const char *line, int len, int l_nr)
 {
 	char *err;
 
@@ -1539,7 +1539,7 @@ static void record_ws_error(unsigned result, const char *line, int len, int line
 
 	err = whitespace_error_string(result);
 	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		patch_input_file, linenr, err, len, line);
+		patch_input_file, l_nr, err, len, line);
 	free(err);
 }
 
-- 
2.8.0.rc1.49.gca61272
