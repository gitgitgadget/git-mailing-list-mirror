From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 1/2] strbuf: make sure buffer is zero-terminated
Date: Sun, 10 Apr 2011 22:54:17 +0200
Message-ID: <1302468858-7376-1-git-send-email-kusmabite@gmail.com>
Cc: jwa@urbancode.com, drew.northup@maine.edu, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 22:55:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q91ex-0002x0-SF
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 22:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab1DJUy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 16:54:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41472 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab1DJUy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 16:54:56 -0400
Received: by bwz15 with SMTP id 15so4018948bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Lr0m5pmTjL+EzEGQdiAvzgeJ9vUqiWfsLlKZ/yUKCt8=;
        b=WdBOsN6cpyvTfKEcIOhPy4VhLZ9/vuooGP6B1gGVSC1G1dx0gnKDfw7/qbhRdZFo2q
         wMNT8xLQRyXc7eGziMOm/WJTW5RWqBzkB3tq/7wdL2A4AiEtAVTLBSqGT0GRaK8EomgR
         A4dEJe0xtwBQoMkXjjsIcwPco4Tn/+ZPsTazU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WeRc0EiJRs8pnlzbWTZDw8tEEQrePfhV03TmbJWUKhhAP1z7opJDc36OE4VYhENINm
         31kKQq+SV0M1zci5kgl1WVvshkY/S165GMRyC1DkEmH8uNKMZVnRANbM1CgqzIz0b3Xa
         bcmtajN9aSvysNARyP4Yf3ZV3V+YBdEoe2Ju0=
Received: by 10.204.26.132 with SMTP id e4mr1940286bkc.142.1302468894307;
        Sun, 10 Apr 2011 13:54:54 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id c11sm2836082bkc.14.2011.04.10.13.54.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 13:54:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0.916.ga2194
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171286>

strbuf_init does not zero-terminate the initial buffer when hint is
non-zero. Fix this so strbuf_attach does not return garbage.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 strbuf.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 77444a9..09c43ae 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -30,8 +30,10 @@ void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc = sb->len = 0;
 	sb->buf = strbuf_slopbuf;
-	if (hint)
+	if (hint) {
 		strbuf_grow(sb, hint);
+		sb->buf[0] = '\0';
+	}
 }
 
 void strbuf_release(struct strbuf *sb)
-- 
1.7.4.msysgit.0.916.ga2194
