From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/13] remote-hg: update tags globally
Date: Thu,  4 Apr 2013 09:30:21 -0600
Message-ID: <1365089422-8250-13-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:33:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9j-0004ZS-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762752Ab3DDPcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:32:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35540 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762740Ab3DDPb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:58 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so2669383obb.37
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CQv7Sljot66NZ7drd+NDxcFQ4JmaWki+qbZHzPyc7tw=;
        b=egXOUrlYrmtwgpmwQGzR+Xi5M3KhKDY6vqcaA4YbAFoD9eysGq7Ypj7XafwK3ApUnG
         gXCkv/KEwMhtN2+BMTbKOVajI2xhjB3hAKkG3k9xY6g367MFhuyCG/ktG0Z1xkAMxeMN
         tSauI8DRfP/QZu8qlndTp/mB9I0/Jhjk4bX56IffoQqKhUJizp6YjMJCvdKnCI0DpWT2
         u4uK7PW7YqC5Sr+RklVpaZyrCYWWaFsHn6PU9Qd4EgUBXw90MFsnJ65q4+NgAz8yjLEo
         BNbYh02xZqXCa91S0Hm1/bDWTwsku613n+iMkmZf0wuOq561KLa99IMBZCvYdwGNtO8b
         IjKA==
X-Received: by 10.182.33.102 with SMTP id q6mr4579882obi.39.1365089517755;
        Thu, 04 Apr 2013 08:31:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm7115872oeb.6.2013.04.04.08.31.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220016>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b784c54..56b3641 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -715,7 +715,11 @@ def do_export(parser):
             continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-            parser.repo.tag([tag], node, None, True, None, {})
+            if mode == 'git':
+                msg = 'Added tag %s for changeset %s' % (tag, hghex(node[:6]));
+                parser.repo.tag([tag], node, msg, False, None, {})
+            else:
+                parser.repo.tag([tag], node, None, True, None, {})
             print "ok %s" % ref
         else:
             # transport-helper/fast-export bugs
-- 
1.8.2
