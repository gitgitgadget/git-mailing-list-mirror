From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] log-tree: simplify digit_in_number
Date: Sun, 25 Jul 2010 20:31:52 +0200
Message-ID: <1280082712-5760-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 20:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od5zj-0000di-Eu
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 20:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0GYScD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 14:32:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51418 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0GYScB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 14:32:01 -0400
Received: by eya25 with SMTP id 25so345888eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NAd+78dFFiZ/rUqgOOzubPV+Wyr35pmW3OahSaesoFw=;
        b=cosyPAMDpXBThYR3BJ5cJv2q2ifIBjaCl0JfRzhFGuDxlN1awEdaS4qEIP1znkvOeS
         kKbYDK7wGBHPgaddKwd0h+S+UXYC6ww/Tkah3isQWF/eC/1eM4QyHWsQeXT4gdjmAA6x
         q0iExxKyEG8e9sK15Q/DL/C/5aiv4pO2wbvFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hEW4z7vqrZjn933vAVk+cnZcXSbbwjBcfGvM1HO21l0P1vaw3L2+vGSYogiI/iksoM
         z2b3o3R2ZwGSawHwNk7CPvRdWByEMCtaLe9HGFXBSrYDihMut2zwlowCbP3v774oqx8s
         acBOJhXSY/TZPdvxKvEQU+75bWHPOO+udn5uY=
Received: by 10.213.31.139 with SMTP id y11mr5511874ebc.27.1280082719762;
        Sun, 25 Jul 2010 11:31:59 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id x54sm4269021eeh.17.2010.07.25.11.31.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 11:31:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151776>

Make the algorithm to get the digits of a number
more easily.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 log-tree.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b46ed3b..c7cfcf4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -254,12 +254,10 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 
 static unsigned int digits_in_number(unsigned int number)
 {
-	unsigned int i = 10, result = 1;
-	while (i <= number) {
-		i *= 10;
-		result++;
-	}
-	return result;
+	int digits = 1;
+	while (number /= 10)
+		digits++;
+	return digits;
 }
 
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-- 
1.7.0.4
