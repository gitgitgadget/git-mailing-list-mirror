From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/18] remote-bzr: delay peer branch usage
Date: Tue, 30 Apr 2013 20:10:09 -0500
Message-ID: <1367370610-14250-18-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:13:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLbT-00087G-RT
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934199Ab3EABMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:55 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:46610 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934177Ab3EABMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:52 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so213751yha.14
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=K7Dhf0XexS8lA0zivHAvWw2jsNzRJ2RiWSdxuDsjrvk=;
        b=ef1uRS205G95iiKFJQOnQP2Qdx1MPQuCPFcWUu5zL1DUTr4scGvykaTcXGXaalEpn/
         5DWmcLqQywLctfZuGJRiXVQADYh3KojQ/v0DcHZPwK1SInorXMEHwImlg6wiepMftLeu
         lI2ASKIvBTZEphwFyi/WSmvoZ0CQYOdlNPmwwMUvNG+xGXP7WBScQtuXdXyPV6Vcd8LC
         DIMc7jCFFOTG1I8lSqPNNqviaHiminW20CHva1N3QFKjdKYoSkGz4Cj5vMdkgSnU+1QF
         DCBNncIHeA/Ik6n3+qa6KKice8mgAW+nltPBeUCO1+eVRKSgm3kKhrOloFPrV65/8oRM
         iKrw==
X-Received: by 10.236.197.103 with SMTP id s67mr537152yhn.201.1367370772004;
        Tue, 30 Apr 2013 18:12:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i67sm1517878yhq.25.2013.04.30.18.12.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223062>

So it doesn't time out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 66e3861..b2d67f7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -687,7 +687,7 @@ def do_export(parser):
         branch.generate_revision_history(revid, marks.get_tip(name))
 
         if name in peers:
-            peer = peers[name]
+            peer = bzrlib.branch.Branch.open(peers[name])
             try:
                 peer.bzrdir.push_branch(branch, revision_id=revid)
             except bzrlib.errors.DivergedBranches:
@@ -825,7 +825,7 @@ def get_repo(url, alias):
         branch = origin.open_branch()
 
         if not is_local:
-            peers[name] = branch
+            peers[name] = branch.base
             branches[name] = get_remote_branch(origin, branch, name)
         else:
             branches[name] = branch
@@ -841,7 +841,7 @@ def get_repo(url, alias):
         for name, branch in find_branches(repo, wanted):
 
             if not is_local:
-                peers[name] = branch
+                peers[name] = branch.base
                 branches[name] = get_remote_branch(origin, branch, name)
             else:
                 branches[name] = branch
-- 
1.8.3.rc0.399.gc96a135
