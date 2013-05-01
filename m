From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/18] remote-bzr: always try to update the worktree
Date: Tue, 30 Apr 2013 20:09:56 -0500
Message-ID: <1367370610-14250-5-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLaT-00073I-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934067Ab3EABLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:11:55 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:43369 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934056Ab3EABLw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:11:52 -0400
Received: by mail-yh0-f47.google.com with SMTP id f64so208706yha.34
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ppeC1yXqcme5a0YKT/580brmHWSP4/Ad63kIU9uL9uc=;
        b=0g20JxEm1PkNSVsav+cn7/ypcM8hULL2v9M+Yt9lbv/GY/tg7VjuVnx72EMTmLv+CN
         dWQ83PxITeUMx6y3R9Xig9nEDjqIwPH7p7sqVZf2w2pB0iw5ndhi7ob8UeW3eS/Gy8E/
         XmZP6/asrqZ69K3DQThVZ+AfpKZP1d9rfuOaWFjDPvRVW382znDlfmunpqvEv/3fj54q
         tq95qgko1NBUR0qp7OYepLbATqdI+qIKSehQSQCXSANsubPPSSIQyAkxsY8Ga6K6rmnq
         6jEQSySvA2XJKTB8D/YJpsza2MTUsiCAku2SROGZdz058hY92MqH12vkkr2z6lr9oEot
         fNhQ==
X-Received: by 10.236.85.230 with SMTP id u66mr727774yhe.7.1367370709964;
        Tue, 30 Apr 2013 18:11:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i44sm1564177yhk.17.2013.04.30.18.11.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223047>

And fail properly when we can't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b428244..eb91d28 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -641,9 +641,13 @@ def do_export(parser):
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
-            else:
+
+            try:
                 wt = repo.bzrdir.open_workingtree()
                 wt.update()
+            except bzrlib.errors.NoWorkingTree:
+                pass
+
         print "ok %s" % ref
 
     print
-- 
1.8.3.rc0.399.gc96a135
