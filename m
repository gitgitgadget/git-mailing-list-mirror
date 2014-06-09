From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 03/19] fast-import: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:22 -0700
Message-ID: <3c2074297916c6f5f8deb923432af22edd1dccd2.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vh-0000WP-9v
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbaFIWUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:33 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47537 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:32 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5378309pdi.13
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BstEYalxiOKLar+PHP+zmTu15IdKWeUUqMZ6YSoW4uU=;
        b=A2nc9ZfhCwM+MJSXCaCJjq37hgbzSDKDLoRDgcIPQ4gUp3NhkFWgLlfnbZuyMbwwjl
         CzC4QYrHoFPO6g2rPuGHNlzerr4AtKuCKZ2CPHoNh20oDeqFaE9az9WuBzA+Z006LlDJ
         nZVa3UBBlO4YBB61TGAU3yApSv4s07fTFBngCor1GiZzW+9fxb1DAmbZFJuchXG+evA/
         c5jXX0TCPDZbrCEfwt2s88vdbNkLmQiwYkgqtNowdvSTFIOmkJYnCjOsLlK+LzuoK3Uh
         OokFdiI1MetkTR9/4MFsHM3JhxgAz6omznfaqFHxzQS1jBW8oWUsn0NqQ9z2ZSezLVa7
         +Npw==
X-Received: by 10.68.253.73 with SMTP id zy9mr7474129pbc.114.1402352432058;
        Mon, 09 Jun 2014 15:20:32 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id is5sm65864285pbb.8.2014.06.09.15.20.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:30 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:27 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251111>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 fast-import.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index e8ec34d..cfe9404 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2898,8 +2898,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	 * Output based on batch_one_object() from cat-file.c.
 	 */
 	if (type <= 0) {
-		strbuf_reset(&line);
-		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		strbuf_setf(&line, "%s missing\n", sha1_to_hex(sha1));
 		cat_blob_write(line.buf, line.len);
 		strbuf_release(&line);
 		free(buf);
@@ -2910,8 +2909,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 	if (type != OBJ_BLOB)
 		die("Object %s is a %s but a blob was expected.",
 		    sha1_to_hex(sha1), typename(type));
-	strbuf_reset(&line);
-	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+	strbuf_setf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
 						typename(type), size);
 	cat_blob_write(line.buf, line.len);
 	strbuf_release(&line);
-- 
2.0.0.592.gf55b190
