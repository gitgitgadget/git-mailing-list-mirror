From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 4/8] git_remote_helpers: Use 2to3 if building with Python 3
Date: Sun, 20 Jan 2013 13:15:34 +0000
Message-ID: <821f662a13db72ef96a9026133e8cb763c0a9be2.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwulV-00036d-PG
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3ATNQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:29 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:40163 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 636C72149C;
	Sun, 20 Jan 2013 13:16:28 +0000 (GMT)
X-Quarantine-ID: <x5RMl0fU8isH>
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
	with ESMTP id x5RMl0fU8isH; Sun, 20 Jan 2013 13:16:27 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 7E7BF22F53;
	Sun, 20 Jan 2013 13:16:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 72E19161E480;
	Sun, 20 Jan 2013 13:16:27 +0000 (GMT)
X-Quarantine-ID: <LLXfSajRXXaY>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLXfSajRXXaY; Sun, 20 Jan 2013 13:16:27 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 271D5161E509;
	Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214014>

Using the approach detailed in the Python documentation[1], run 2to3 on
the code as part of the build if building with Python 3.

The code itself requires no changes to convert cleanly.

[1] http://docs.python.org/3.3/howto/pyporting.html#during-installation

Signed-off-by: John Keeping <john@keeping.me.uk>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---

On Fri, 18 Jan 2013 23:52:16 -0800, Sverre Rabbelier wrote:
> Assuming you tried this out on both 2.x and 3.x:
>
> Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

I ran the test suite with Python 2.7.3 and 3.2.3.

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
1.8.1.353.gc992d5a.dirty
