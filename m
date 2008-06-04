From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 5/5] Add stack creation and deletion support to the new
	infrastructure
Date: Wed, 04 Jun 2008 22:13:52 +0100
Message-ID: <20080604211352.32531.10821.stgit@localhost.localdomain>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:29:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40Xr-0007A0-Lx
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYFDV2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYFDV2O
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:28:14 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:33740 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074AbYFDV2M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:28:12 -0400
X-Greylist: delayed 893 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2008 17:28:07 EDT
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080604211757.GVLL28496.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:17:57 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080604212250.GISD8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:22:50 +0100
In-Reply-To: <20080604210655.32531.82580.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83833>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/init.py |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 475a4ce..b68acd7 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -16,13 +16,8 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
-
+from stgit.commands import common
+from stgit.lib import stack
 
 help = 'initialise the current branch for use with StGIT'
 usage = """%prog [options]
@@ -31,14 +26,13 @@ Initialise the current GIT branch to be used as an StGIT stack. Note
 that you must already be in a GIT repository and .git/HEAD must point
 to a valid file in refs/heads/."""
 
-directory = DirectoryHasRepository()
+directory = common.DirectoryHasRepositoryLib()
 options = []
 
-
 def func(parser, options, args):
     """Performs the repository initialisation
     """
     if len(args) != 0:
         parser.error('incorrect number of arguments')
 
-    crt_series.init()
+    stack.Stack.initialise(directory.repository)
