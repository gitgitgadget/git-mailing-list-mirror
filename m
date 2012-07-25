From: Stefan Zager <szager@google.com>
Subject: [PATCH] Make 'git submodule update --force' always check out submodules.
Date: Wed, 25 Jul 2012 11:03:32 -0700
Message-ID: <1343239412-26780-1-git-send-email-szager@google.com>
Cc: Stefan Zager <szager@google.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 20:04:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5wS-0006yx-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 20:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab2GYSEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 14:04:07 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:52265 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab2GYSEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 14:04:05 -0400
Received: by fat25 with SMTP id 25so51399fat.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LXXRN081ko6aq94qbaU3XlJ+rQUN1f12Ykpz71dT58A=;
        b=M/oQBfByJk3JelFNZURfOAtV/CDu/ceWPNjknYkjX/bcbzv5cTI3vL+1ka73r8MhB6
         YCoh6cTZ/g/1KQHlOb6JCA79p4I6EQ4lxfilI4iStm708FLehoJc/pL0IYW3cO4WEXgy
         2/4groOXiDjvSqdHflUl1LsLQMMeIZafhDiWSYTK72/LCZvE0SZkyesjtIBIgtZegF0W
         J5PdzYe8tObC8tkiFubHrTZ6QUSVgTKbgxju/bJlwJ27UH73SNVtgF8gmOysAseLDT3K
         n0Ohnm827TbGbGl5yQ6Lv624L5QD6IkYwwdxUlquVZK3tdWau6Rdp0zFmI+x7yrjQYWa
         3CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=LXXRN081ko6aq94qbaU3XlJ+rQUN1f12Ykpz71dT58A=;
        b=gY5t1SeK7rHos+CVaAzxEAj0ZHyffkYyWveNi1WyKkobfK4dSOkySv/kFaHn15lbQo
         ooJR0BFfvJSEDdn9QYhTb/g5eNo6quey7+IFpK1ClrdguXBJJaE3dyLsyeJdECcGIh8e
         4Q/GMz98M9sBrD6VyGzqMriqRKtyOam84lpJ9N6YCLV0qbUIVkA/U0iSd8xNUVbUz7Nu
         J4/cAsiQOR5sCo+IjrsFNj45Gs2FwlVvwuEAoIdd3mZTggkJN1C/RR2yL8+HJK6rfuXH
         90SAn0oKAeLL9iDU5BPyW7mtIeQZzCyKNZHd0QVSnDIJCOgOSr9DhbVrj8VGix59adyJ
         E2LA==
Received: by 10.180.24.202 with SMTP id w10mr745343wif.0.1343239443201;
        Wed, 25 Jul 2012 11:04:03 -0700 (PDT)
Received: by 10.180.24.202 with SMTP id w10mr745334wif.0.1343239443168;
        Wed, 25 Jul 2012 11:04:03 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id i17si566420wiw.0.2012.07.25.11.04.03
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Jul 2012 11:04:03 -0700 (PDT)
Received: from stefro.sfo.corp.google.com (stefro.sfo.corp.google.com [172.31.52.143])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E332A200057;
	Wed, 25 Jul 2012 11:04:02 -0700 (PDT)
Received: by stefro.sfo.corp.google.com (Postfix, from userid 138314)
	id 058891C0FDC; Wed, 25 Jul 2012 11:04:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.gd284367.dirty
X-Gm-Message-State: ALoCoQl26Lq8LKO1ZBm/ILTrSMgH0803R22jpXc/rSGQRkpe3LEh/1lf9Av9RGNGKHQmNvg2HVzOvk7mZ7fhqF3i6hRrtPrnuRIr7P/TfihuvvOU7Pf1yOf8i6K7UwIC6moz39XE7KY+Av/ydLUlK0XTn7zxaNQj8ToZ+kYePlKam/vQFEFhtrb5TfYUAMdcrxdXSlnn6MHT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202182>

Currently, it will only do a checkout if the sha1 registered in the containing
repository doesn't match the HEAD of the submodule, regardless of whether the
submodule is dirty.  As discussed on the mailing list, the '--force' flag is a
strong indicator that the state of the submodule is suspect, and should be reset
to HEAD.

Signed-off-by: Stefan Zager <szager@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dba4d39..621eff7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -575,7 +575,7 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule path '\$sm_path'")"
 		fi
 
-		if test "$subsha1" != "$sha1"
+		if test "$subsha1" != "$sha1" -o -n "$force"
 		then
 			subforce=$force
 			# If we don't already have a -f flag and the submodule has never been checked out
-- 
1.7.11.rc2
