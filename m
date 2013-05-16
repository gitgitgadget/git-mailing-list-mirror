From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: fix cloning of non-listable repos
Date: Thu, 16 May 2013 05:04:05 -0500
Message-ID: <1368698645-28429-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 12:05:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucv4I-00025v-Om
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab3EPKFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:05:36 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:62032 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3EPKFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:05:35 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so3505096oag.3
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=CPEDER2eIq6f6/Uy1O9eRxFfld8Pm/bvD/5qdzljLSg=;
        b=zFzh0Pb2tSeRFuT0ZFrDuxUCsygW1+1EPzSixFV3topijdZOmCfEtrfLVwDS2ahPNt
         EhtTmgoFeuD3g9oh6hRvn2RtgNFvLB9h+VSeYjtgrBaDLxyNpSHmYY8TOwI1ahySBJJy
         9xfwiHkL2STodvnt1NhqeipZwoo7MyXmJgI4++hX7oAyeZ93dU30DXBPUylk4CyABPSe
         NnR4Hk8AaZoOql/lO+uNMCc5Vh8T7wGaUw52PihZvz6J1PF80G09FQrMv1gM7H/LORnh
         nMfPNU8vp4nCScwEXTX9L4R5JZwaBznG1viId/NNwk0aDp8BADHi6XvQPK84D4xIGabh
         iCww==
X-Received: by 10.60.141.2 with SMTP id rk2mr10883020oeb.69.1368698734994;
        Thu, 16 May 2013 03:05:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm4567033oby.12.2013.05.16.03.05.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 03:05:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224545>

Commit 95b0c60 (remote-bzr: add support for bzr repos) introduced a
regression by assuming all bzr remote repos are listable, but they are
not.

If they are not listable they are basically useless, so let's assume
there is no bzr repo.

Reported-by: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

We want this on master for v1.8.3.

 contrib/remote-helpers/git-remote-bzr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b295dd4..ad42317 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -840,6 +840,9 @@ def get_repo(url, alias):
 
     try:
         repo = origin.open_repository()
+        if not repo.user_transport.listable():
+            # this repository is not usable for us
+            raise bzrlib.errors.NoRepositoryPresent(repo.bzrdir)
     except bzrlib.errors.NoRepositoryPresent:
         # branch
 
-- 
1.8.3.rc2.542.g24820ba
