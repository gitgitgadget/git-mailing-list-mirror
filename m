From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/13] remote-hg: fix for files with spaces
Date: Thu,  4 Apr 2013 09:30:13 -0600
Message-ID: <1365089422-8250-5-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Peter van Zetten <peter.van.zetten@cgi.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9I-00048e-2g
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762539Ab3DDPbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:34 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:45668 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762518Ab3DDPbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:32 -0400
Received: by mail-ob0-f180.google.com with SMTP id wo10so2624926obc.39
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BPaso7DkO5mme5CA/1kdfQcPbBICc+MR1St9v94bsa4=;
        b=YipnkM+c7xX9KuRt+T5F6KBL9HkOakj+qswYpIvNTlVtkF2nfSrINAnbwVxz59bPxM
         CiTx3GVDDaNTJfB3eS8ZMB4+htuKe0daYRiEbc5EHHqxYArkPvsQSc3U58iRcxw3f7Oa
         dTXL6GWeh+3iO3MI7nmZxdvlJnd56jFr04K5UvRS3k6apD20ZNapyifAgC0n6tvXK66p
         qY6ENlCs93iBKwrTIXQLvw+LCCZdUh5s8Iry6OwZsT/HzEkyKEsDAJpOkVhLtoA1ebzp
         MMfKp48zzcRNN+7UIYPNsWPKYGxa83kL/8lc4VZNOR6TBRxRdBx6fX2TwXEI31ZCnro9
         aLZg==
X-Received: by 10.60.10.3 with SMTP id e3mr4623665oeb.51.1365089492202;
        Thu, 04 Apr 2013 08:31:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c4sm6637614obo.9.2013.04.04.08.31.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220008>

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
