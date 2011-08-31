From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] xdiff/xprepare: initialise xdlclassifier_t cf in xdl_prepare_env()
Date: Wed, 31 Aug 2011 12:48:46 +0800
Message-ID: <1314766126-5060-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 06:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qycjd-0004Ph-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 06:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab1HaEtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 00:49:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49503 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1HaEtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 00:49:01 -0400
Received: by gwaa12 with SMTP id a12so267573gwa.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2hRagKu8TR+Zb4jWXgn5+hRNNNNcikBjbixAuXXTt8Y=;
        b=wNkzKF87dPd0AbP//rrYmancYM1NqjD2ElcV24vV/Py1Jn85sWngs9Gh5LtYx2QjFh
         x++n/imTQBG/2BwWM4Qiia909pQ1vP/TJVBz+m83CZZ29Iyzicjqm+Zt1IcPJptf8cdW
         MnTS5AtIOKXFWmywJW29wqddaS17rwGXAhGrw=
Received: by 10.91.47.30 with SMTP id z30mr6022645agj.58.1314766141150;
        Tue, 30 Aug 2011 21:49:01 -0700 (PDT)
Received: from localhost (nusnet-75-164.dynip.nus.edu.sg [137.132.75.164])
        by mx.google.com with ESMTPS id h25sm6835540anm.30.2011.08.30.21.48.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 21:49:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180456>

Ensure that the xdl_free_classifier() call on xdlclassifier_t cf is safe
even if xdl_init_classifier() isn't called. This may occur in the case
where diff is run with --histogram and a call to, say, xdl_prepare_ctx()
fails.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

This should go into 'rc/histogram-diff' in 'next'.

 xdiff/xprepare.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 620fc9a..4323596 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -239,6 +239,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	long enl1, enl2, sample;
 	xdlclassifier_t cf;
 
+	cf.rchash = NULL;
+	cf.ncha.head = NULL;
+
 	/*
 	 * For histogram diff, we can afford a smaller sample size and
 	 * thus a poorer estimate of the number of lines, as the hash
-- 
1.7.6.1.706.gaa5cf
