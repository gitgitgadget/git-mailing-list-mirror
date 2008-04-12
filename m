From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Log environment and cwd as well as the actual
	command
Date: Sat, 12 Apr 2008 17:47:27 +0200
Message-ID: <20080412154727.19690.60228.stgit@yoghurt>
References: <20080412154427.19690.71877.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:48:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkhxr-0008V1-4T
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbYDLPrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYDLPrc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:47:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1473 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbYDLPrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:47:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jkhws-0004Co-00; Sat, 12 Apr 2008 16:47:26 +0100
In-Reply-To: <20080412154427.19690.71877.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79369>

When debugging subprocess calls (with STGIT_SUBPROCESS_LOG=3Ddebug),
it's important to know the environment and working directory we pass
to the subprocess, not just the command-line parameters.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/run.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/stgit/run.py b/stgit/run.py
index 77f2e65..0b79729 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -48,6 +48,12 @@ class Run:
     def __log_start(self):
         if _log_mode =3D=3D 'debug':
             out.start('Running subprocess %s' % self.__cmd)
+            if self.__cwd !=3D None:
+                out.info('cwd: %s' % self.__cwd)
+            if self.__env !=3D None:
+                for k in sorted(self.__env.iterkeys()):
+                    if k not in os.environ or os.environ[k] !=3D self.=
__env[k]:
+                        out.info('%s: %s' % (k, self.__env[k]))
         elif _log_mode =3D=3D 'profile':
             out.start('Running subprocess %s' % self.__cmd[0])
             self.__starttime =3D datetime.datetime.now()
