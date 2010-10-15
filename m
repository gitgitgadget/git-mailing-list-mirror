From: "Vasyl'" <vvavrychuk@gmail.com>
Subject: [PATCH] Trim ending whitespaces in exclude file if needed.
Date: Sat, 16 Oct 2010 01:41:45 +0300
Message-ID: <AANLkTinUHQzuLJhZnVMKngEO75W=+5sES0WZFAFw5bDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: vvavrychuk@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 00:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6t4Q-0003NF-2g
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 00:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab0JOWsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 18:48:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0JOWsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 18:48:07 -0400
Received: by bwz15 with SMTP id 15so1222621bwz.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=Yjv//4xjrUdd4ThQ7uVhMLOy/Ge5ePtMvL1gEBWYXzc=;
        b=h48bgAMI7+nQYHvO79FqnMLeFNIn7yU4643KlPhxZqyp5C0+H6mjmTIrSruBBNPnyc
         5ng5K1gNwdIvVoy+E4rj0Fd9IlkGrRfZQ8yhQix8nqlal8Zl0OUUBVsFL9zcCR9FV0ST
         mu8RRAROG7NDa5QW2sSNae5Djg8Wk09nsrEYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=q+FXG6U8IBfnxy8UhCogJ10oGthhRxkjUuIFS+4Ahn5ckiEdvqlTJy8+n2qA2+FCuM
         iK5opT+XFX+/VjIRccTiCw/B1t+8XGiHDIQD8Wkhmp0BbX0xcG6We53Le7dDgsaJeJMC
         XuoECSB7RPKy/pSghSq7aUs01+/wksx5RkISs=
Received: by 10.204.69.74 with SMTP id y10mr1322867bki.60.1287182505478; Fri,
 15 Oct 2010 15:41:45 -0700 (PDT)
Received: by 10.204.69.212 with HTTP; Fri, 15 Oct 2010 15:41:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159141>

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---

Hope this can save someone's time debugging git.

 dir.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index d1e5e5e..704914b 100644
--- a/dir.c
+++ b/dir.c
@@ -171,7 +171,15 @@ void add_exclude(const char *string, const char *base,
 		to_exclude = 0;
 		string++;
 	}
+
 	len = strlen(string);
+	if (len && isspace((unsigned char)string[len - 1])) {
+		struct strbuf trim_buf = STRBUF_INIT;
+		strbuf_add(&trim_buf, string, len);
+		strbuf_rtrim(&trim_buf);
+		string = strbuf_detach(&trim_buf, &len);
+	}
+
 	if (len && string[len - 1] == '/') {
 		char *s;
 		x = xmalloc(sizeof(*x) + len);
-- 
1.7.3.1.msysgit.0
