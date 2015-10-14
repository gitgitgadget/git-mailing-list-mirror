From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/31] mailinfo: remove a no-op call convert_to_utf8(it, "")
Date: Wed, 14 Oct 2015 13:45:27 -0700
Message-ID: <1444855557-2127-2-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyf-0003pY-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbbJNUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35148 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbbJNUqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:00 -0400
Received: by padcn9 with SMTP id cn9so32988953pad.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=CRKu5vovrnhgX06s5OUcHlFtgTYkfiqBj3tb4OODOaM=;
        b=OIB3UHRl9XpaRggco7kjjkGgSsPvXc5pOoTYMZuOi/NJ2WSMOeN4mGxl/tFctQoAVI
         KYmn9BJWtHrCu/lqBw9eGByx0T/qRHqthYg2dxl1UxmJ2/urdSEQ7OjkTCQuGfzuRXp2
         +qUtX8aBaPVMzAagJ96kwHEAAvpXz8qYkufl5kn5ocOW7G9bC0fc/U8pZ0fvbFljOQi1
         eSNC6gvwbZ9xOz3elJePLoCCEEPMuHu8uWGLfZGlW0GJyZ5PN/fxFcj3zCvkgCVisnSv
         6JkhqYZtwLjacPyMjmXijXGmSLvCk1yikVHI/1bX0b7fw1AWfwKHmm0qX+cSP2Co2s9B
         qZRg==
X-Received: by 10.66.150.161 with SMTP id uj1mr5627445pab.148.1444855560163;
        Wed, 14 Oct 2015 13:46:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id fe8sm11335696pab.40.2015.10.14.13.45.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:45:59 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279623>

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
2.6.1-320-g86a1181
