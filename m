From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/20] remote-hg: fix for files with spaces
Date: Mon,  8 Apr 2013 12:13:18 -0500
Message-ID: <1365441214-21096-5-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Peter van Zetten <peter.van.zetten@cgi.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf5-0004EZ-To
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934796Ab3DHRO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:14:56 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48862 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934710Ab3DHROy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:54 -0400
Received: by mail-ob0-f172.google.com with SMTP id eh20so2624134obb.17
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BPaso7DkO5mme5CA/1kdfQcPbBICc+MR1St9v94bsa4=;
        b=hYVWj7MqjVhgl2bURBt+W5kX8tUXMk1J8hDWBvldCJmnI7mDlx0FJeu0yaNpj6h7Lg
         /rUsNHgJIYy7ejVFP4PV4V7NiqKwVPxxRbGPMrev5aNX3wQb5UKChrrakLazVz93dZ49
         Bn/PGc05fEuVZlhzLEaxVkNU/+DHHMEgS1M7mdkBZCCmm3+NgYFnhC6DzZXIlNrYl1XX
         q3ieJqFM/E1wpWCxLQwwW3+gis6T37cwEhSrPBT0QV/4fwTnQpKz0OXbyuqKeL6o3tRt
         4CLTls3jzKigjqe011+b++ervbHh4jydipHGHujLHzzJv1QPzifKAzwgnMhlxXV7YIW8
         3mTg==
X-Received: by 10.60.145.147 with SMTP id su19mr16590631oeb.9.1365441293976;
        Mon, 08 Apr 2013 10:14:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ka6sm24998705obb.3.2013.04.08.10.14.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220448>

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
