From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 0/2] series: submodule: fix handling of relative superproject origin URLs
Date: Thu, 24 May 2012 13:37:35 +1000
Message-ID: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 05:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXOsE-0007SY-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 05:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab2EXDh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 23:37:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42381 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab2EXDh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 23:37:56 -0400
Received: by yhmm54 with SMTP id m54so7355332yhm.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Aeg89WqY+tqIEHiQ43ejAY1GVCvNmdtYLFqvK3zpCGA=;
        b=YJLoMGYORvPY/WXrUjd4KUkeXmSKHUJxTVLJGNT7Kqt10T1rtOvnk2IiAuuKDLUgN7
         i3p6cEkWEbylcvZyLNDwntj95ddkjAbEminQiWBiHaBT45uC1copLKiyMEz/MobrHgvg
         eueWudD/7mftTGn5eHCzZMPmN5+GvKA2dsFET+YVpsJp5BugDY1hoXvcTp3t7bvKS5h9
         OR993IHMgzTc6F6p2OaStQBwkfVq+4TVA7HUwmpB0gi87mpS7HnMHk3BOlb6U5S4eeK+
         4NbQAaf/wkkyZxQwlxMLiH7LVkHy6KRawfq0JpICp2OSD41UzSX3xmp1irFC6xG0Vlkt
         JU8Q==
Received: by 10.50.40.202 with SMTP id z10mr15323207igk.64.1337830675920;
        Wed, 23 May 2012 20:37:55 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([1.142.1.227])
        by mx.google.com with ESMTPS id if4sm14062525igc.10.2012.05.23.20.37.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 20:37:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.649.g5ca7d80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198344>

This series ensures that git submodule handles relative superproject origin URLs correctly.

Current behaviour:

* does not guarantee that the submodule.{name}.url property of the superproject is 
always confgured with a valid path to the submodule's origin repo that is 
relative to the working tree of the superproject.
* does not guarantee that the remote.origin.url property of the submodule is
always configured with a valid path to the submodule's origin repo that is 
relative to the working tree of the submodule
* errors out (origin URL = foo) even though this is not strictly necessary.

These changes:

* guarantee that the configured paths are always valid relative paths
from the working tree of the repo containing to the configuration to the
origin repo of the described submodule.

Jon Seymour (2):
  submodule: document failures handling relative superproject origin
    URLs
  submodule: fix handling of relative superproject origin URLs

 git-submodule.sh           | 57 +++++++++++++++++++++++++++++++++----
 t/t7400-submodule-basic.sh | 60 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 70 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 180 insertions(+), 7 deletions(-)

v4->v5 changes:
       Used test_expect_failure for failing tests.
       Added comments to justify statements.
       Isolated changes to the relative branch.
       Used role-based variable names to help explain transformations.	

-- 
1.7.10.2.649.g5ca7d80
