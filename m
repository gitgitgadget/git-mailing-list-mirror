From: newren@gmail.com
Subject: [PATCHv3 0/6] D/F conflict fixes
Date: Tue,  6 Jul 2010 23:20:28 -0600
Message-ID: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwV-000285-1h
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab0GGFNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40958 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0GGFNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:00 -0400
Received: by gye5 with SMTP id 5so2206137gye.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=F9x/LkDRaFSS9b30iPFPMPQ5PRITWY11ocUvraRY8w0=;
        b=e1MADHt920pt5GhIxPz9FckUCJG6hm5xXb+lWga6WHT0+ZA43He5SMnJKe86c1B1OH
         QsIJynFyZj4yHvtX0stffpAysN0l3NqZbxcKVDV7L0BUcNGKHIcl+Gc4Aa2FRsUzX+qH
         ZmJ8yGH7nRaELu2LrnYYkCD1s/4dz/Up53zsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ACF0fowY+Hy+Zxn7z8fH5wJlvTEWk/57nZ2/RbqtS8wwzW3rkKbVx5xWNPRGNWK/qz
         ZFKFwRQLGLIbV7G0QV77wAyNWgmMS/vNSajDs0kEOj+tEGNl5XOalpW0VmbT8ho5rGbv
         NFSOq1bWP3aJd15V8YsUDDvvRMMYB9bB/Ef4k=
Received: by 10.101.154.15 with SMTP id g15mr3248796ano.222.1278479579330;
        Tue, 06 Jul 2010 22:12:59 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.12.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:12:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150438>

This patch series fixes a number of spurious directory/file conflicts
and associated bugs appearing in cherry-pick, rebase, merge, and
fast-export.  It also has a minor robustness improvement for
fast-import.  This series includes testsuite fixes for currently known
failures in both t6020-merge-df.sh and t6035-merge-dir-to-symlink.sh.

The right person to review most the changes (all but the trivial
fast-import change that Shawn already commented on, modulo one minor new
change) is probably Dscho.  In his absence, the next most logical
reviewer as far as I can tell is probably Junio or perhaps Shawn.  I
hate to overwork them even more, so if anyone else has some time to take
a look or even do some simple testing, it'd be much appreciated.

Changes since the previous submission:
  * Added a new patch (5/6) fixing fast-export -- Shawn pointed out
    in the previous round that the bug I attributed to fast-import was
    actually a fast-export issue
  * Modified the fast-import patch (6/6) to note that it was just a
    robustness improvement rather than bugfix, and extended the patch to
    also handle regular files in addition to symlinks

Alexander Gladysh (1):
      Add a rename + D/F conflict testcase

Elijah Newren (5):
      Add additional testcases for D/F conflicts
      merge-recursive: Fix D/F conflicts
      merge_recursive: Fix renames across paths below D/F conflicts
      fast-export: Fix output order of D/F changes
      fast-import: Improve robustness when D->F changes provided in wrong order

 builtin/fast-export.c           |    1 +
 diff.h                          |    1 +
 fast-import.c                   |    7 +++
 merge-recursive.c               |  106 ++++++++++++++++++++++++++++++++-------
 t/t3508-cherry-pick-merge-df.sh |   34 ++++++++++++
 t/t6020-merge-df.sh             |    2 +-
 t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++-
 t/t9350-fast-export.sh          |   24 +++++++++
 tree-diff.c                     |    4 +-
 9 files changed, 194 insertions(+), 22 deletions(-)
