From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Sat, 14 Nov 2009 13:10:57 -0800
Message-ID: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 22:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Px6-0003ic-Px
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 22:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZKNVOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 16:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZKNVOR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 16:14:17 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35447 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZKNVOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 16:14:17 -0500
Received: by pwi3 with SMTP id 3so2609202pwi.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 13:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=DfmPlfKBNGbhJg4psyYXgWL9Y6YHn/2ausKxwJ1o1VU=;
        b=Hot8ELpaYbo0KxWViHtaDlLTdlxrRLXQpGBXz7wBFQNUE2UmLYW/3lT6NxmlQ2C3WR
         BqD7RpB43udbzS0K4H3Gfi2b1e19ftsytz2/AAYgCYOk+0AfK1Ld2VnuSl19n5gsmhlf
         yaf1a+BsadL6huKkMDctvGOGSBjrQeLbt5xGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=mHDUIhqiD7KNaVgB/DR5mvbhFR6MtSz7zjQR9/ySXrEvX2bpX1x/ybtvjHipwaYpay
         F2/z6tu76ixxMZh8g5u92PhtIbe7ULkptnbOiDC8uZptDEiNI3N5eFFJHXeML3AKATYd
         P40KXxoQSec5yUXOhowkDztAN7K9uQX7eZess=
Received: by 10.114.249.24 with SMTP id w24mr2843260wah.146.1258233262878;
        Sat, 14 Nov 2009 13:14:22 -0800 (PST)
Received: from localhost.localdomain (host-98-127-69-228.bln-mt.client.bresnan.net [98.127.69.228])
        by mx.google.com with ESMTPS id 21sm283716pzk.7.2009.11.14.13.14.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 13:14:22 -0800 (PST)
X-Mailer: git-send-email 1.6.5.52.g4544ce0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132888>

Found with valgrind while looking for Content-Length corruption in
smart http.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 http-backend.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f8ea9d7..ab9433d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -634,7 +634,7 @@ int main(int argc, char **argv)
 			cmd = c;
 			cmd_arg = xmalloc(n);
 			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
-			cmd_arg[n] = '\0';
+			cmd_arg[n-1] = '\0';
 			dir[out[0].rm_so] = 0;
 			break;
 		}
-- 
1.6.5.51.g191f5
