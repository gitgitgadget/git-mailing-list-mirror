From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] Let --decorate show HEAD position
Date: Mon, 12 Oct 2009 22:34:12 +0200
Message-ID: <36861d16d0e21c662430882140893ad9a0b2fb25.1255379242.git.trast@student.ethz.ch>
References: <200910122206.23044.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxRmu-0006mu-FY
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 22:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbZJLUfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbZJLUfh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 16:35:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40363 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756774AbZJLUfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 16:35:36 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 22:34:49 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 22:34:50 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <200910122206.23044.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130062>

'git log --graph --oneline --decorate --all' is a useful way to get a
general overview of the repository state, similar to 'gitk --all'.
Let it indicate the position of HEAD by loading that ref too, so that
the --decorate code can see it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wrote:
> Damn, this fails tests and I only just noticed while testing another
> series.  Sorry for the noise, reroll upcoming...


 log-tree.c                             |    1 +
 t/t4013/diff.log_--decorate=full_--all |    2 +-
 t/t4013/diff.log_--decorate_--all      |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 1618f3c..f7d54f2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -43,6 +43,7 @@ void load_ref_decorations(int flags)
 	if (!loaded) {
 		loaded = 1;
 		for_each_ref(add_ref_decoration, &flags);
+		head_ref(add_ref_decoration, &flags);
 	}
 }
 
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 903d9d9..d155e0b 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -1,5 +1,5 @@
 $ git log --decorate=full --all
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, refs/heads/master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 954210e..fd7c3e6 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -1,5 +1,5 @@
 $ git log --decorate --all
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
-- 
1.6.5.62.g4370d.dirty
