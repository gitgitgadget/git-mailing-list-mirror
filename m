From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 1/2] strbuf: Use _rtrim and _ltrim in strbuf_trim
Date: Wed, 30 Apr 2014 17:58:06 +0900
Message-ID: <1398848287-77109-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfQM5-0008NX-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 10:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559AbaD3I67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 04:58:59 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62422 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbaD3I66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 04:58:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so1622471pab.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MmVGA9T2G6mqwLbvIbuUEI5AxEZ5WyT5gStikG5jrG0=;
        b=PbfHJmcBUeb35R+1rr2zaxAS6tJmBFT0eWIoC7WbtVbcvOu3s3kCWmdlIj8LvkTM+w
         abHv1DrIsj6VHJn76lySKeik/yszUBjNeh5fgM5r4FLCInWDTfSesPO74hef/Ap4FGdf
         FoC+kn5InEn3dzU6wYh0vPCvIvYig/eTaojEeiL4+6w6pSgWjqbVVUtscc2isAfc59N2
         fbVDr38OK5e3T58MeluSNt8PyVCbqQhClTy+X+S+8CKa36zCrobA5fdbhCQSDWK5h7a6
         vrE2gENLKhaY+0GXLnaP3zXZRofwuKCFZsrqeSig7cJBwX1HRb9N8QkUyE8uE2VZirC4
         NR8w==
X-Received: by 10.66.184.239 with SMTP id ex15mr6361922pac.122.1398848334194;
        Wed, 30 Apr 2014 01:58:54 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id g6sm130770710pat.2.2014.04.30.01.58.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 01:58:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.507.g779792a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247685>

strbuf_trim strips whitespace from the end, then the beginning of a
strbuf. Those operations are duplicated in strbuf_rtrim and
strbuf_ltrim.

Replace strbuf_trim implementation with calls to strbuf_rtrim,
then strbuf_ltrim.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---

This is tangential to my GSoC project; I noticed the duplication
and thought it could be remedied.

 strbuf.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 83caf4a..382cf68 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -96,15 +96,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 
 void strbuf_trim(struct strbuf *sb)
 {
-	char *b = sb->buf;
-	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
-		sb->len--;
-	while (sb->len > 0 && isspace(*b)) {
-		b++;
-		sb->len--;
-	}
-	memmove(sb->buf, b, sb->len);
-	sb->buf[sb->len] = '\0';
+	strbuf_rtrim(sb);
+	strbuf_ltrim(sb);
 }
 void strbuf_rtrim(struct strbuf *sb)
 {
-- 
1.9.2.507.g779792a
