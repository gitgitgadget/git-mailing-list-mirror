From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Fix infinite recursion on absolute paths
Date: Wed, 24 May 2006 08:06:43 +0200
Message-ID: <20060524060643.GA1490@diana.vm.bytemark.co.uk>
References: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 08:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FimWA-0000RT-2z
	for gcvg-git@gmane.org; Wed, 24 May 2006 08:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWEXGGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 02:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWEXGGp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 02:06:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:12808 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932603AbWEXGGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 02:06:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FimW3-0000OC-00; Wed, 24 May 2006 07:06:43 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20666>

Calling create_dirs with an absolute path caused infinite recursion,
since os.path.dirname('/') == '/'. Fix this by exiting early if the
given path already is a directory.
---

 stgit/utils.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/utils.py b/stgit/utils.py
index 68b8f58..ed6e43c 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -130,7 +130,7 @@ def remove_file_and_dirs(basedir, file):
 
 def create_dirs(directory):
     """Create the given directory, if the path doesn't already exist."""
-    if directory:
+    if directory and not os.path.isdir(directory):
         create_dirs(os.path.dirname(directory))
         try:
             os.mkdir(directory)
