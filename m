From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/21] remote-hg: redirect buggy mercurial output
Date: Thu, 11 Apr 2013 07:23:03 -0500
Message-ID: <1365682997-11329-8-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGdo-00074s-EE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019Ab3DKMaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:30:03 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:65517 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161619Ab3DKMaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:30:00 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so50592qcq.5
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HpebKHk9u3Q6G0n6E6KEyFF7vLfND1ePacJnFIpOdTk=;
        b=jMQjgnki0MbaNjsiATw/xYDLV3mZ4r3Uy1VkoHO8YpuZnasO/dpuDvVLtyFburQSE+
         +VbhRCgmN/5UZ0w12GdbCdphA7iN0GyuegqXT39gkTCurBrT6YsF+86rYMqgMXHTqF3I
         XL+7u+oIgDDz+sYjndjkCvqpSDjhAeJEfUQ7kUiEKdyBdzbziTOqFB0/c8wTAYtG+jmE
         DdfsAeB1XQ7rEArsPEZbxf1KePQv/8I70f5qAOqcJRb9c0MuOADMOiVgLlA9tRmpG6gF
         DKzJ6kqJP0iSgbTdkE+0UM4bDD+d5/TMSsZe7MXgvu+CNt2V4q8KrQMl/RqLieTZm5/U
         84bw==
X-Received: by 10.49.58.97 with SMTP id p1mr7524221qeq.28.1365683084913;
        Thu, 11 Apr 2013 05:24:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ku2sm6293626qeb.4.2013.04.11.05.24.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220874>

Mercurial emits messages like "searching for changes", "no changes
found", etc. meant for the use of its own UI layer, which break the pipe
between transport helper and remote helper.

Since there's no way to silence Mercurial, let's redirect to standard
error.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b200e60..874ccd4 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -271,6 +271,7 @@ def get_repo(url, alias):
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
+    myui.fout = sys.stderr
 
     if hg.islocal(url):
         repo = hg.repository(myui, url)
-- 
1.8.2.1
