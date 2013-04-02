From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/13] remote-hg: fix for files with spaces
Date: Tue,  2 Apr 2013 13:02:53 -0600
Message-ID: <1364929382-1399-5-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Peter van Zetten <peter.van.zetten@cgi.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vk-0006yp-GN
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761826Ab3DBTEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:13 -0400
Received: from mail-gh0-f176.google.com ([209.85.160.176]:44493 "EHLO
	mail-gh0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760821Ab3DBTEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:11 -0400
X-Greylist: delayed 76593 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2013 15:04:11 EDT
Received: by mail-gh0-f176.google.com with SMTP id f16so112357ghb.35
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BPaso7DkO5mme5CA/1kdfQcPbBICc+MR1St9v94bsa4=;
        b=k9qiVAd4Ws+OvxWuR3xjZyug5l7icgcJ3Jy+ijY/8BSuFPOvJf/+g5cwSFwq5WSpLD
         PWkm9223uAr6pylnLJT8BULFHRy1S/A+TxG4zXtJfKWtM8DbwhitwAb9RtNbPoQGONT5
         pVi5TbXUEX7PO2KEVpyC/9XJrQulPdtnco7CH92WZkqerTwx3/Xr1EVRzHK2MH4Ce/re
         B3U1WOeRV4GvlRRJb/iWxOse4DBVO2gd46KZdfLisbrjWUqcfeoVzsKF7A21Pae0hNTf
         NjA7BzDE6CVfFcASCneQCjbgfpKPn7LNN9l4YR6+K9srutkZay7ySljBjzanhldtbMAI
         rDkw==
X-Received: by 10.236.223.137 with SMTP id v9mr15778447yhp.166.1364929450517;
        Tue, 02 Apr 2013 12:04:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u33sm4893466yhn.7.2013.04.02.12.04.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219837>

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
1.8.2
