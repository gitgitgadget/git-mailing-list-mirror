From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/8] Make a common superclass for all StGit exceptions
Date: Mon, 08 Oct 2007 01:17:41 +0200
Message-ID: <20071007231741.12626.97806.stgit@yoghurt>
References: <20071007231446.12626.14259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefOV-0003Sh-9T
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbXJGXRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbXJGXRr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:17:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1372 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbXJGXRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:17:46 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefNW-0000LV-00; Mon, 08 Oct 2007 00:17:42 +0100
In-Reply-To: <20071007231446.12626.14259.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60244>

This makes it easier to catch them all. (Indeed, the very long list of
exceptions to catch in main.py was missing some of the exceptions.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/common.py |    5 +++--
 stgit/config.py          |    3 ++-
 stgit/exception.py       |    3 +++
 stgit/git.py             |    3 ++-
 stgit/gitmergeonefile.py |    3 ++-
 stgit/main.py            |   11 +++--------
 stgit/run.py             |    5 +++--
 stgit/stack.py           |    3 ++-
 stgit/utils.py           |    3 ++-
 9 files changed, 22 insertions(+), 17 deletions(-)
 create mode 100644 stgit/exception.py


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 0fc157a..27a616f 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -21,6 +21,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os, os.path, re
 from optparse import OptionParser, make_option
=20
+from stgit.exception import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git, basedir
@@ -30,11 +31,11 @@ crt_series =3D None
=20
=20
 # Command exception class
-class CmdException(Exception):
+class CmdException(StgException):
     pass
=20
 # Utility functions
-class RevParseException(Exception):
+class RevParseException(StgException):
     """Revision spec parse error."""
     pass
=20
diff --git a/stgit/config.py b/stgit/config.py
index 51818bd..3eabc8c 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -20,9 +20,10 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston=
, MA 02111-1307 USA
=20
 import os, re
 from stgit import basedir
+from stgit.exception import *
 from stgit.run import *
=20
-class GitConfigException(Exception):
+class GitConfigException(StgException):
     pass
=20
 class GitConfig:
diff --git a/stgit/exception.py b/stgit/exception.py
new file mode 100644
index 0000000..9933e64
--- /dev/null
+++ b/stgit/exception.py
@@ -0,0 +1,3 @@
+class StgException(Exception):
+    """Base class for all StGit exceptions."""
+    pass
diff --git a/stgit/git.py b/stgit/git.py
index a0493bc..0026fd8 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -21,6 +21,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os, re, gitmergeonefile
 from shutil import copyfile
=20
+from stgit.exception import *
 from stgit import basedir
 from stgit.utils import *
 from stgit.out import *
@@ -28,7 +29,7 @@ from stgit.run import *
 from stgit.config import config
=20
 # git exception class
-class GitException(Exception):
+class GitException(StgException):
     pass
=20
 # When a subprocess has a problem, we want the exception to be a
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 2aa5ef8..058b6ac 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -19,13 +19,14 @@ Foundation, Inc., 59 Temple Place, Suite 330, Bosto=
n, MA 02111-1307 USA
 """
=20
 import sys, os
+from stgit.exception import *
 from stgit import basedir
 from stgit.config import config, file_extensions, ConfigOption
 from stgit.utils import append_string
 from stgit.out import *
 from stgit.run import *
=20
-class GitMergeException(Exception):
+class GitMergeException(StgException):
     pass
=20
=20
diff --git a/stgit/main.py b/stgit/main.py
index 2c8716b..f54330d 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -255,13 +255,10 @@ def main():
=20
     # These modules are only used from this point onwards and do not
     # need to be imported earlier
+    from stgit.exception import StgException
     from stgit.config import config_setup
     from ConfigParser import ParsingError, NoSectionError
-    from stgit.stack import Series, StackException
-    from stgit.git import GitException
-    from stgit.commands.common import CmdException
-    from stgit.gitmergeonefile import GitMergeException
-    from stgit.utils import EditorException
+    from stgit.stack import Series
=20
     try:
         debug_level =3D int(os.environ['STGIT_DEBUG_LEVEL'])
@@ -284,9 +281,7 @@ def main():
             stgit.commands.common.crt_series =3D command.crt_series
=20
         command.func(parser, options, args)
-    except (IOError, ParsingError, NoSectionError, CmdException,
-            StackException, GitException, GitMergeException,
-            EditorException), err:
+    except (StgException, IOError, ParsingError, NoSectionError), err:
         print >> sys.stderr, '%s %s: %s' % (prog, cmd, err)
         if debug_level > 0:
             raise
diff --git a/stgit/run.py b/stgit/run.py
index 7986f3b..989bb27 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -19,9 +19,10 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston=
, MA 02111-1307 USA
=20
 import datetime, os, subprocess
=20
-from  stgit.out import *
+from stgit.exception import *
+from stgit.out import *
=20
-class RunException(Exception):
+class RunException(StgException):
     """Thrown when something bad happened when we tried to run the
     subprocess."""
     pass
diff --git a/stgit/stack.py b/stgit/stack.py
index 4d1a066..bdb4e38 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -21,6 +21,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os, re
 from email.Utils import formatdate
=20
+from stgit.exception import *
 from stgit.utils import *
 from stgit.out import *
 from stgit.run import *
@@ -30,7 +31,7 @@ from shutil import copyfile
=20
=20
 # stack exception class
-class StackException(Exception):
+class StackException(StgException):
     pass
=20
 class FilterUntil:
diff --git a/stgit/utils.py b/stgit/utils.py
index 857c0f0..3a480c0 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -2,6 +2,7 @@
 """
=20
 import errno, optparse, os, os.path, re, sys
+from stgit.exception import *
 from stgit.config import config
 from stgit.out import *
=20
@@ -166,7 +167,7 @@ def rename(basedir, file1, file2):
         # file1's parent dir may not be empty after move
         pass
=20
-class EditorException(Exception):
+class EditorException(StgException):
     pass
=20
 def call_editor(filename):
