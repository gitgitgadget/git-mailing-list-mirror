From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/34] mailinfo: remove a no-op call convert_to_utf8(it, "")
Date: Mon, 19 Oct 2015 00:28:18 -0700
Message-ID: <1445239731-10677-2-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sP-0002R0-25
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbbJSH25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:28:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34692 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbJSH2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:28:55 -0400
Received: by padhk11 with SMTP id hk11so21764649pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=8ifoM0QML/cwRoNLw4QjvnhMhJEISfmQk+JqqsEde9I=;
        b=CiEdsKhebO7VM2EBT+GRQ1/gSSax2dV0nlzfCjjs/XUYSkq0OI3UcEd2XXl8mRydkA
         W83DLZtraUD9KnKQJjATC2UwWdK1vePnVAqGG4G89ExJwKvSZcMyIGZEGIhWrhqPlkLr
         7FOUiBkUpc1CRk2J1zO4WzEsKcmJtNQBfKqkLTwHIh0fBm/46FFDTDNWeJxsASMgQvYB
         1rhpR9X9lwem1vFo2a7OPAJep9Cqkqn2U/wGscFbqXN0a0Of5ipMxH6WfHrlym1V6+ZE
         Y3Uv4B6etYp3x8Lho+gUpWB7Zv9VC/o/7IJftcUsTTtrZUgBuJ7K63AaUgmdX4xeEULq
         Rcgg==
X-Received: by 10.68.96.1 with SMTP id do1mr32341610pbb.37.1445239735233;
        Mon, 19 Oct 2015 00:28:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id fe8sm34882714pab.40.2015.10.19.00.28.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:54 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279833>

The called function checks if the second parameter is either a NULL
or an empty string at the very beginning and returns without doing
anything.  Remove the useless call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 999a525..5a4ed75 100644
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
2.6.2-383-g144b2e6
