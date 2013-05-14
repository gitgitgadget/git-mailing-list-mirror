From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: update old organization
Date: Mon, 13 May 2013 23:20:27 -0500
Message-ID: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc6kT-0004AH-QP
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab3ENEV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:21:57 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59207 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3ENEV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:21:57 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so85132obb.30
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=PFkjVu63FPz9RTDi1LInBzcCrV7T/R7q41+QYGGtsSo=;
        b=d6r5pdnuTp8OqNYvkxXkE8TfaWIjTDvDBqSnOJAzcOwoJrxYTt511jybpMORzlAtcv
         6nj9KK7QT/xnPJ014P+kdvbzUdrv11Iyh+dtbrViWKx/baiaHFWc4cye4lUau8g1gXqf
         V0cBg5y7L7x+yI9Un8H8zCT08BEVX3WjwaAI2SA3HgGOx3SPV0iOuvUCr/yBFeFku5jA
         Du2I7WLQLulOr1utQG7HstpEmWB+1npO51lUMuIq197Xn+SFyP2DJx73dWwwyeVvFdXq
         6t8ny8/z9VvbsHFum+G79MK/fVDzKECgpr9HJCmqkxYfufqsD65C5hidIeRADsSicSFJ
         3FBQ==
X-Received: by 10.60.134.241 with SMTP id pn17mr15291408oeb.140.1368505316729;
        Mon, 13 May 2013 21:21:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm19967675obb.5.2013.05.13.21.21.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:21:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224234>

If a clone exists with the old organization (v1.8.2) it will prevent the
new shared repository organization from working, so let's remove this
repository, which is not used any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3e452af..b295dd4 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -830,6 +830,13 @@ def get_repo(url, alias):
         clone_path = os.path.join(dirname, 'clone')
         if not os.path.exists(clone_path):
             os.mkdir(clone_path)
+        else:
+            # check and remove old organization
+            try:
+                bdir = bzrlib.bzrdir.BzrDir.open(clone_path)
+                bdir.destroy_repository()
+            except bzrlib.errors.NotBranchError:
+                pass
 
     try:
         repo = origin.open_repository()
-- 
1.8.3.rc1.579.g184e698
