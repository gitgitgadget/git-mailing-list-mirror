From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/8] git_remote_helpers: Use 2to3 if building with Python 3
Date: Sat, 12 Jan 2013 19:23:42 +0000
Message-ID: <4a17f813970d0e6c4c7795bc2c0ac7842465e41d.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6i3-0001gj-33
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3ALTZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:25:17 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:60472 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab3ALTZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:25:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 0B18E2149C;
	Sat, 12 Jan 2013 19:25:15 +0000 (GMT)
X-Quarantine-ID: <i3mhnBbntCas>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3mhnBbntCas; Sat, 12 Jan 2013 19:25:14 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 5837520014;
	Sat, 12 Jan 2013 19:25:14 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4CF69161E1F3;
	Sat, 12 Jan 2013 19:25:14 +0000 (GMT)
X-Quarantine-ID: <5NgN1TD-iJ32>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NgN1TD-iJ32; Sat, 12 Jan 2013 19:25:14 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id F1075161E556;
	Sat, 12 Jan 2013 19:25:00 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213305>

Using the approach detailed on the Python wiki[1], run 2to3 on the code
as part of the build if building with Python 3.

The code itself requires no changes to convert cleanly.

[1] http://wiki.python.org/moin/PortingPythonToPy3k

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/setup.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git_remote_helpers/setup.py b/git_remote_helpers/setup.py
index 4d434b6..6de41de 100644
--- a/git_remote_helpers/setup.py
+++ b/git_remote_helpers/setup.py
@@ -4,6 +4,15 @@
 
 from distutils.core import setup
 
+# If building under Python3 we need to run 2to3 on the code, do this by
+# trying to import distutils' 2to3 builder, which is only available in
+# Python3.
+try:
+    from distutils.command.build_py import build_py_2to3 as build_py
+except ImportError:
+    # 2.x
+    from distutils.command.build_py import build_py
+
 setup(
     name = 'git_remote_helpers',
     version = '0.1.0',
@@ -14,4 +23,5 @@ setup(
     url = 'http://www.git-scm.com/',
     package_dir = {'git_remote_helpers': ''},
     packages = ['git_remote_helpers', 'git_remote_helpers.git'],
+    cmdclass = {'build_py': build_py},
 )
-- 
1.8.1
