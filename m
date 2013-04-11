From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/21] remote-hg: fix for files with spaces
Date: Thu, 11 Apr 2013 07:23:00 -0500
Message-ID: <1365682997-11329-5-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Peter van Zetten <peter.van.zetten@cgi.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYV-00071t-8R
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236Ab3DKMYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:36 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:49866 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161139Ab3DKMYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:35 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so659765qco.35
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wv5bKOErhi0/8x3X3UXvbQlrttW0T7tGyet2C2p2+VY=;
        b=ZoAu3VWH5If4fdN2ggnojGNrVTusfnJg55G3cvgyoR2p99j6xui8BAvTRwpqJyrIil
         oo189wbBEteS7cunfMK4Z6e0JjsFvVTc4w1W2pTx2JYZUpz05RMT2BfZ3GpgaVXsUPxO
         GgY/01SVHQkH/AuWlL2m6y5AmpeGmIq+PtBS4T2lgasP9GzyauComPD5UI6Mz559mzJW
         rdI1Thk/vFpcUx1LQ8j9IS97excVgeem82611sjqR+8lfuoGLfyk5AK9Tcf23RXP/cki
         DhBH5JcTK9YBdDQkr4e126YSQK+9BIWEPJN9tGOeH3fuRAPfjlKnkWtc/mFfh2gJ7XYX
         SZNA==
X-Received: by 10.229.133.136 with SMTP id f8mr2380298qct.32.1365683074919;
        Thu, 11 Apr 2013 05:24:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ku2sm6293250qeb.4.2013.04.11.05.24.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220858>

From: Peter van Zetten <peter.van.zetten@cgi.com>

Set the maximum number of splits to make when dividing the diff stat
lines based on space characters.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 19eb4db..c6a1a47 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -578,7 +578,7 @@ def parse_commit(parser):
             mark = int(mark_ref[1:])
             f = { 'mode' : hgmode(m), 'data' : blob_marks[mark] }
         elif parser.check('D'):
-            t, path = line.split(' ')
+            t, path = line.split(' ', 1)
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
@@ -625,7 +625,7 @@ def parse_commit(parser):
         i = data.find('\n--HG--\n')
         if i >= 0:
             tmp = data[i + len('\n--HG--\n'):].strip()
-            for k, v in [e.split(' : ') for e in tmp.split('\n')]:
+            for k, v in [e.split(' : ', 1) for e in tmp.split('\n')]:
                 if k == 'rename':
                     old, new = v.split(' => ', 1)
                     files[new]['rename'] = old
-- 
1.8.2.1
