From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Name the exit codes to improve legibility
Date: Fri, 14 Dec 2007 07:25:27 +0100
Message-ID: <20071214062527.29148.7928.stgit@yoghurt>
References: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33zy-00024P-HR
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbXLNGZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbXLNGZf
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:35 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3018 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbXLNGZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:34 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33zC-0002j6-00; Fri, 14 Dec 2007 06:25:26 +0000
In-Reply-To: <20071214062251.29148.86191.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68240>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/main.py  |   25 +++++++++++++------------
 stgit/utils.py |    5 +++++
 2 files changed, 18 insertions(+), 12 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index a03447f..95e25f8 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -23,6 +23,7 @@ from optparse import OptionParser
=20
 import stgit.commands
 from stgit.out import *
+from stgit import utils
=20
 #
 # The commands map
@@ -39,11 +40,11 @@ class Commands(dict):
         if not candidates:
             out.error('Unknown command: %s' % key,
                       'Try "%s help" for a list of supported commands'=
 % prog)
-            sys.exit(1)
+            sys.exit(utils.STGIT_GENERAL_ERROR)
         elif len(candidates) > 1:
             out.error('Ambiguous command: %s' % key,
                       'Candidates are: %s' % ', '.join(candidates))
-            sys.exit(1)
+            sys.exit(utils.STGIT_GENERAL_ERROR)
=20
         return candidates[0]
        =20
@@ -206,7 +207,7 @@ def main():
         print >> sys.stderr, 'usage: %s <command>' % prog
         print >> sys.stderr, \
               '  Try "%s --help" for a list of supported commands' % p=
rog
-        sys.exit(1)
+        sys.exit(utils.STGIT_GENERAL_ERROR)
=20
     cmd =3D sys.argv[1]
=20
@@ -216,13 +217,13 @@ def main():
             sys.argv[2] =3D '--help'
         else:
             print_help()
-            sys.exit(0)
+            sys.exit(utils.STGIT_SUCCESS)
     if cmd =3D=3D 'help':
         if len(sys.argv) =3D=3D 3 and not sys.argv[2] in ['-h', '--hel=
p']:
             cmd =3D commands.canonical_cmd(sys.argv[2])
             if not cmd in commands:
                 out.error('%s help: "%s" command unknown' % (prog, cmd=
))
-                sys.exit(1)
+                sys.exit(utils.STGIT_GENERAL_ERROR)
=20
             sys.argv[0] +=3D ' %s' % cmd
             command =3D commands[cmd]
@@ -232,16 +233,16 @@ def main():
             pager(parser.format_help())
         else:
             print_help()
-        sys.exit(0)
+        sys.exit(utils.STGIT_SUCCESS)
     if cmd in ['-v', '--version', 'version']:
         from stgit.version import version
         print 'Stacked GIT %s' % version
         os.system('git --version')
         print 'Python version %s' % sys.version
-        sys.exit(0)
+        sys.exit(utils.STGIT_SUCCESS)
     if cmd in ['copyright']:
         print __copyright__
-        sys.exit(0)
+        sys.exit(utils.STGIT_SUCCESS)
=20
     # re-build the command line arguments
     cmd =3D commands.canonical_cmd(cmd)
@@ -265,7 +266,7 @@ def main():
         debug_level =3D int(os.environ.get('STGIT_DEBUG_LEVEL', 0))
     except ValueError:
         out.error('Invalid STGIT_DEBUG_LEVEL environment variable')
-        sys.exit(1)
+        sys.exit(utils.STGIT_GENERAL_ERROR)
=20
     try:
         directory.setup()
@@ -284,8 +285,8 @@ def main():
         if debug_level > 0:
             raise
         else:
-            sys.exit(2)
+            sys.exit(utils.STGIT_COMMAND_ERROR)
     except KeyboardInterrupt:
-        sys.exit(1)
+        sys.exit(utils.STGIT_GENERAL_ERROR)
=20
-    sys.exit(0)
+    sys.exit(utils.STGIT_SUCCESS)
diff --git a/stgit/utils.py b/stgit/utils.py
index 837c6c2..29a5f63 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -301,3 +301,8 @@ def make_message_options():
             m('--save-template', action =3D 'callback', callback =3D t=
empl_callback,
               metavar =3D 'FILE', dest =3D 'save_template', type =3D '=
string',
               help =3D 'save the message template to FILE and exit')]
+
+# Exit codes.
+STGIT_SUCCESS =3D 0        # everything's OK
+STGIT_GENERAL_ERROR =3D 1  # seems to be non-command-specific error
+STGIT_COMMAND_ERROR =3D 2  # seems to be a command that failed
