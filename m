From: Hannes Eder <heder@google.com>
Subject: [PATCH] fix "stg float -s FILE" for FILE != "-"
Date: Fri, 17 Jul 2009 11:35:04 +0200
Message-ID: <20090717093504.13718.78957.stgit@jazzy.zrh.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 11:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRjr3-0003r0-2d
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 11:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934314AbZGQJfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934304AbZGQJfl
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 05:35:41 -0400
Received: from smtp-out.google.com ([216.239.33.17]:4040 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934303AbZGQJfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 05:35:40 -0400
Received: from spaceape10.eur.corp.google.com (spaceape10.eur.corp.google.com [172.28.16.144])
	by smtp-out.google.com with ESMTP id n6H9Z7rQ002769;
	Fri, 17 Jul 2009 10:35:07 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1247823307; bh=73/NnroGdQgy18/Bkx9feg+/Fr0=;
	h=DomainKey-Signature:Subject:To:From:Cc:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-System-Of-Record; b=aNdoPUksWhBztwZxxb2CeMihO1hjWXco8ujv4Galgbcg
	N4XvovIkdePw/q64wbuIPJydFHMGmZPN1WLY+01WtQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=subject:to:from:cc:date:message-id:user-agent:
	mime-version:content-type:content-transfer-encoding:x-system-of-record;
	b=KejVAtFgCiBJDx8QvFGUJSkGxD7MFEvr/VHFxd/wHCdpFkPfhcwMBKIEGa4LMLgds
	mdNF1mkqvxFnVMs32ZifA==
Received: from localhost (jazzy.zrh.corp.google.com [172.16.74.150])
	by spaceape10.eur.corp.google.com with ESMTP id n6H9Z4kf005737;
	Fri, 17 Jul 2009 02:35:05 -0700
Received: from jazzy.zrh.corp.google.com (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id DD156EA4DA;
	Fri, 17 Jul 2009 11:35:04 +0200 (CEST)
User-Agent: StGit/0.14.3.366.gf979
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123455>

The commit:

  commit 5a1bab1ad60688471e100e310c58c7e60d18cd80
  Author: Catalin Marinas <catalin.marinas@arm.com>
  Date:   Thu Apr 9 23:40:59 2009 +0300

      Convert "float" to the lib infrastructure

introduces a bug in "stg float -s FILE" when FILE is not equal to "-".
This patches fixes this issue.

Signed-off-by: Hannes Eder <heder@google.com>
---
 stgit/commands/float.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index e561c39..9316398 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -16,6 +16,7 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
+import re
 import sys
 from stgit.argparse import opt
 from stgit.commands import common
@@ -55,7 +56,7 @@ def func(parser, options, args):
         if options.series == '-':
             f = sys.stdin
         else:
-            f = file(args[0])
+            f = file(options.series)
 
         patches = []
         for line in f:
