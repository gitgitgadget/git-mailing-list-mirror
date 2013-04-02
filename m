From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/13] remote-hg: update tags globally
Date: Tue,  2 Apr 2013 13:03:02 -0600
Message-ID: <1364929382-1399-14-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WC-0007LU-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011Ab3DBTEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:49 -0400
Received: from mail-gh0-f175.google.com ([209.85.160.175]:57796 "EHLO
	mail-gh0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab3DBTEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:47 -0400
Received: by mail-gh0-f175.google.com with SMTP id f1so115873ghb.20
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Bs3wuqaj/YDSAcbVUDeuNj9n4VejU7hbSEZbwdOCmzU=;
        b=p6JFYa2o31Nd1HSm8Kg+nxsZOKtfs9MZNV856I8fUlEH7u/4nHvkNz/nI7AEkigIF4
         EdYHqlfZ18bxsvG7EjZDXAjp1SjpcvMOkUV8R7CUjPqspbRl7CadZT7lKZp5P9Clb/QH
         /XfFT5FmaFeRk9O6rdzT2+8ntu5+be6TDKjCQT1O3sSPfhhZaWTyy7YLkSG/7vO4E2qT
         wDzgI+7ohegnmHp3mnl3msJg7JyAWHZ5sKyx/QOearrDGrctT3XsJw7D16yzEG8Z+qX0
         vQzXAPH7ORf/bP08DMuoUNvLRZmxmnPlOuBTjOjk3QXTg2mThWUB4ZvzS/V4w0UZ84Hw
         EmDQ==
X-Received: by 10.236.128.34 with SMTP id e22mr16376566yhi.11.1364929487181;
        Tue, 02 Apr 2013 12:04:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u19sm4839478yhh.15.2013.04.02.12.04.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219842>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3130b23..c9d7636 100755
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
