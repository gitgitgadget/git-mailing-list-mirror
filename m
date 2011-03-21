From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 00/10] Work-in-progress merge-recursive work
Date: Mon, 21 Mar 2011 12:30:54 -0600
Message-ID: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmi-0000RW-L0
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab1CUSYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:38 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1CUSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:36 -0400
Received: by vxi39 with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=U06I5ZsdNIODVUJ8/1IJhrt4YWpAEp4ortLNoCbw6UA=;
        b=J2QL6gKe1ijR6qzIXgIKvCHWGhGdCw8BHF5mfuwgnD8iwyenLkT56tBMjJsUTMXgMa
         W/uzcUdZAlOacocAyDIbbqah5AKR2XgVApRKrKyhzVoXtoEi0duTXx5CzmbSwfJhx/qj
         JegBzXrKTH2NB8GIVfp2BkKbyrpgEphoAnpuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LaZyek6kJG6Gk9q8sWkuXNeDIQ6FsF7s3Q9pzcnHxAhMJc4OcwlM6ijTDHJIXfoh83
         8Y2Imm4QzJR0neXv5LnLLGQZP+bqTh5VWXDqhc0Fzj0yQ0OssDcoiIIoTZCaU/bVHqyj
         lJOBFris38tyDoUBnX+nvvilC49GC0sC78d4M=
Received: by 10.220.122.22 with SMTP id j22mr1301764vcr.52.1300731875885;
        Mon, 21 Mar 2011 11:24:35 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.33
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169629>

This is a set of changes I was working on last Sept-Nov; these changes
are not ready for git.git (other than perhaps patches 1 and 5), but I
figured it might be useful to send anyway because (1) it might serve
as notification to others of various edge and corner case issues that
exist, and (2) the work won't die if my laptop harddrive does.

I'm expecting to clean these up, though it may take me a month or two
before I get the time.

(Note that patch 5 contains a subset of b9b3eef (merge-recursive:
tweak magic band-aid 2011-03-17); I could have saved Junio some time
if I had submitted that earlier, and had remembered that change
instead of propagating the mistake.  Sorry about that.)

Most of what is included are new testcases exposing edge and corner
case bugs in merge-recursive that I found in a code audit, some of
which are marked as test_expect_success even though the test does not
succeed.  There may be a few tests that are just cases I was testing
for completeness or that I was worried about breaking with planned
changes.  I didn't try to figure out the right place to add all these
tests (we're out of space in the t60[23]x range and I wasn't sure if I
wanted to dump all of these into t6036), so I just named them
tempxx.sh.

Elijah Newren (10):
  merge-recursive: Remove redundant check for removing rename source
  Reminder to fix o->call_depth handling in conflict_rename_rename_1to2
  A bunch of fixes and FIXMEs
  Correct a comment
  merge-recursive: Fix sorting order and directory change assumptions
  Add a comment pointing out a bug
  Good testcases
  More test scripts
  Tests and fixes associated with rename/rename conflicts
  Add new testcase (temp14) showing how undetected renames can cause or
    spuriously avoid merge conflicts

 merge-recursive.c   |   86 ++++++++++++++++++++++--------
 t/t6020-merge-df.sh |   26 ++++++---
 t/temp1.sh          |  146 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/temp10.sh         |   41 ++++++++++++++
 t/temp11.sh         |   41 ++++++++++++++
 t/temp12.sh         |   59 +++++++++++++++++++++
 t/temp13.sh         |   79 +++++++++++++++++++++++++++
 t/temp14.sh         |   63 ++++++++++++++++++++++
 t/temp2.sh          |   86 ++++++++++++++++++++++++++++++
 t/temp3.sh          |   72 +++++++++++++++++++++++++
 t/temp4.sh          |   96 +++++++++++++++++++++++++++++++++
 t/temp5.sh          |   35 ++++++++++++
 t/temp50.sh         |   38 +++++++++++++
 t/temp6.sh          |   55 +++++++++++++++++++
 t/temp7.sh          |   34 ++++++++++++
 t/temp8.sh          |   37 +++++++++++++
 t/temp9.sh          |   73 +++++++++++++++++++++++++
 17 files changed, 1036 insertions(+), 31 deletions(-)
 create mode 100644 t/temp1.sh
 create mode 100755 t/temp10.sh
 create mode 100755 t/temp11.sh
 create mode 100755 t/temp12.sh
 create mode 100755 t/temp13.sh
 create mode 100755 t/temp14.sh
 create mode 100755 t/temp2.sh
 create mode 100755 t/temp3.sh
 create mode 100755 t/temp4.sh
 create mode 100755 t/temp5.sh
 create mode 100755 t/temp50.sh
 create mode 100755 t/temp6.sh
 create mode 100755 t/temp7.sh
 create mode 100755 t/temp8.sh
 create mode 100755 t/temp9.sh

-- 
1.7.4
