From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/34] mailinfo: move global "line" into mailinfo() function
Date: Mon, 19 Oct 2015 00:28:27 -0700
Message-ID: <1445239731-10677-11-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4uF-0003fZ-Is
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbbJSHau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33672 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbJSH3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:06 -0400
Received: by pabrc13 with SMTP id rc13so182994358pab.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=wtSRba7kdAKxTeFvxFeRuM1cH5ayPwBVG473IxLz52A=;
        b=liLVtzvqPl6TCWmRgGL6J3GBwgna1Uvuo926gXRW//C7e2Pl4Il5zleDcnYurGmrDp
         ms0Wqtv8FsHGhwYoMRZ2PsBeNqGULxaa4hCWGaLXzz86TwvTClLroQUfd2wdEGpu3RGD
         pXxs5bebfNpYq6/jaecWinmsmmzbsL5EG9l6rTGS/KqkIeyAHbUmEg8c720vwrjEv2oZ
         rG6YR8gN1sxYVPkM4uPa+WVDAqF72MUP48l7eCdJtYgb7PZo/57xT11eqC7vMvt4Aft/
         uZyIFigsr/MADbVOCuDnzeq96o8JFvYRxF4iRlTr/tHHmklt/VsNMcPdJcA2JwtGKL5u
         HZwQ==
X-Received: by 10.68.68.143 with SMTP id w15mr33359091pbt.56.1445239745953;
        Mon, 19 Oct 2015 00:29:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id tj2sm34796327pab.4.2015.10.19.00.29.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:05 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279864>

With the previous steps, it becomes clear that the mailinfo()
function is the only one that wants the "line" to be directly
touchable.  Move it to the function scope of this function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 12d1eda..c8dc73f 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -12,7 +12,6 @@ static FILE *cmitmsg, *patchfile, *fin, *fout;
 static int keep_subject;
 static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
-static struct strbuf line = STRBUF_INIT;
 static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
 static char *message_id;
@@ -966,6 +965,8 @@ static void handle_info(void)
 static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 {
 	int peek;
+	struct strbuf line = STRBUF_INIT;
+
 	fin = in;
 	fout = out;
 
-- 
2.6.2-383-g144b2e6
