From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/3] remote: check for superfluous arguments in 'git remote add'
Date: Wed, 24 Apr 2013 15:54:36 +0200
Message-ID: <f1da9b0de420a56313760847b580ee40e2c75b0b.1366811347.git.trast@inf.ethz.ch>
References: <cover.1366811347.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 15:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV09o-0002N4-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 15:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743Ab3DXNyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 09:54:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34610 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485Ab3DXNym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 09:54:42 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:38 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 15:54:39 +0200
X-Mailer: git-send-email 1.8.2.1.935.g71f5136
In-Reply-To: <cover.1366811347.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222250>

The 'git remote add' subcommand did not check for superfluous command
line arguments.  Make it so.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 builtin/remote.c  | 2 +-
 t/t5505-remote.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 937484d..5e54d36 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -178,7 +178,7 @@ static int add(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_add_usage,
 			     0);
 
-	if (argc < 2)
+	if (argc != 2)
 		usage_with_options(builtin_remote_add_usage, options);
 
 	if (mirror && master)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 764ee97..eea87fc 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1020,7 +1020,7 @@ test_extra_arg () {
 	"
 }
 
-test_extra_arg -f add nick url
+test_extra_arg add nick url
 test_extra_arg rename origin newname
 test_extra_arg remove origin
 test_extra_arg set-head origin master
-- 
1.8.2.1.931.g0116868
