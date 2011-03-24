From: Carl Michael Skog <cmskog@gmail.com>
Subject: [PATCH] Test failure when spaces in git root
Date: Thu, 24 Mar 2011 01:11:46 +0100
Message-ID: <1300925506-20378-1-git-send-email-cmskog@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Carl Michael Skog <cmskog@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 01:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2YAe-0000fW-PI
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 01:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933405Ab1CXAM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 20:12:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64927 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933100Ab1CXAMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 20:12:55 -0400
Received: by bwz15 with SMTP id 15so7115306bwz.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=8Eci0DVL+Xf2ycbhlb7fsuMCfVcZmCSqmBEXfR7GKYs=;
        b=pPKu1evcUbP4maeqIAl6xO6bvPNXnBP8LtepEV1hR/yDIarlfXYPQpJIkTP3JiWmTP
         jMKPs/Vhoq0irP7KWoJiBZjV41C95bzT7q3sMiV33e1s/UPky4dy+p0WeLbSbX7r8i8Q
         2/DYmbImVsjPLVauoYggeMiOhlNYA3T7tVMZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YyGQuHauFSqWtbTX3QHTYeRW+cADAue7WF9Nm6lKjLkfoaxl2mZHhzzUTyEf41fxVk
         YGDbfDsrMLq/d4AHy521NY5Njvz8e0YxR3FpDouGhLBlYIoEZS7rq0mqXM+50ciBN5rS
         hPDKnoccIuLj8FR/cPoK+YVohpmfRlG3N83fU=
Received: by 10.204.57.135 with SMTP id c7mr6852297bkh.88.1300925574205;
        Wed, 23 Mar 2011 17:12:54 -0700 (PDT)
Received: from localhost.localdomain (109.58.81.226.bredband.tre.se [109.58.81.226])
        by mx.google.com with ESMTPS id v21sm6327617bkt.11.2011.03.23.17.12.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2011 17:12:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.99.g3d9132
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169883>

Some of the svn related tests would break when the git root path had
spaces in it.

The test checks in t/t9119-git-svn-info.sh where falsely assuming that
the only space where in the path of the generated subversion repository.
This will break when the actual git build repository has spaces in it.
Add a global modifier to the sed command that generates the expected
value for the tests.

Signed-off-by: Carl Michael Skog <cmskog@gmail.com>
---
 t/t9119-git-svn-info.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index ff19695..752bf26 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -28,7 +28,7 @@ test_cmp_info () {
 	rm -f tmp.expect tmp.actual
 }
 
-quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
+quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/g')"
 
 test_expect_success 'setup repository and import' '
 	mkdir info &&
-- 
1.7.4.1.99.g3d9132
