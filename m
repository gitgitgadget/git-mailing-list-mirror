From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/26] mailinfo: remove a no-op call convert_to_utf8(it, "")
Date: Tue, 13 Oct 2015 16:16:22 -0700
Message-ID: <1444778207-859-2-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8oi-00064u-To
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbJMXQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:16:54 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35621 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbbJMXQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:16:51 -0400
Received: by padcn9 with SMTP id cn9so3392387pad.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=c7EwDFP0huDqxJAT1aRruBwlxhHcOaIf+heb12GUUQc=;
        b=QUkAqczMp7Zd4Micq2bYS22hgKT5ylwyT3dJJLbnkXjm2jx4k680DreQLOjhepUBM+
         02TXFqPg0rnPZe7Leb8iU5L175pd/aU+4iZa15aRRTFcqQ40N5wM03giy0Lo8oX9gniM
         LjlVG02WAQ4J5R3hPJTaPH9C7lD/xHbHtcFdepiSHv3yRG7oilHr8BPG8axccIHNDykr
         U73zyORFu7/Q9baB2i0Y2zOpAOTUPktaxxuoirYmn8BLVh42Jc7ERHmPSv87ELWZKB7C
         d8CUF7ufqiELvkp7O7BygSU8IBNulh/jT67MAK3mURSaxD1KrUjUG514nPZhixJRU8S2
         M+fw==
X-Received: by 10.68.57.175 with SMTP id j15mr64600pbq.34.1444778210872;
        Tue, 13 Oct 2015 16:16:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id y5sm5814383pbt.77.2015.10.13.16.16.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:16:50 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279531>

The called function checks if the second parameter is either a NULL
or an empty string at the very beginning and returns without doing
anything.  Remove the useless call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 169ee54..330bef4 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -612,11 +612,6 @@ static void decode_header(struct strbuf *it)
 {
 	if (decode_header_bq(it))
 		return;
-	/* otherwise "it" is a straight copy of the input.
-	 * This can be binary guck but there is no charset specified.
-	 */
-	if (metainfo_charset)
-		convert_to_utf8(it, "");
 }
 
 static void decode_transfer_encoding(struct strbuf *line)
-- 
2.6.1-320-g86a1181
