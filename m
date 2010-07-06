From: newren@gmail.com
Subject: [PATCHv2 0/5] D/F conflict fixes
Date: Tue,  6 Jul 2010 12:51:30 -0600
Message-ID: <1278442295-23033-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 20:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWD8Q-0007Kd-KQ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab0GFSoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:44:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57951 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0GFSoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:44:03 -0400
Received: by pvc7 with SMTP id 7so2756986pvc.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dqDJlLfKGsLg/hhHPCF/O7NYsVTjlzyiEIDGGG+WKDU=;
        b=eNXKdDFLQGR1U/GH75Tr9APw9+hmmo253iLjwYL84/M88tt7PPJxO1vfbG2o9fTyuc
         e4mHgwBsbmU+PbiwyIYUlOR4bNTfEe1JEctorudw3+hcTmB3wJ65UcAS6AzF3IxGOYcr
         RWwW5AcdxN7iQ/nvQ9zNu6j2KkMt3cFaHXJXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I16t+gYc0L28IBx9shygXsiJ8b7eDoZLBwLFSoWdYwULsGV4WWKdvrR8d5Q8MhyK8c
         zUmFNmF9paixn0lelH4o62w5jDgp8iDMXV5ZPn8dmgFS+rxv4xqP8zDRa/Q1X2V/GGB8
         wYHEbPS419cSlKyuVSpbCpOzwBXrEAygN8zh8=
Received: by 10.114.103.4 with SMTP id a4mr5814914wac.52.1278441842869;
        Tue, 06 Jul 2010 11:44:02 -0700 (PDT)
Received: from localhost.localdomain ([76.113.59.120])
        by mx.google.com with ESMTPS id c24sm86219693wam.7.2010.07.06.11.44.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 11:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.9.g45c1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150389>

This patch series fixes a number of spurious directory/file conflicts
and associated bugs appearing in cherry-pick, rebase, merge, and
fast-import.  It includes testsuite fixes for currently known failures
in both t6020-merge-df.sh and t6035-merge-dir-to-symlink.sh.

The right person to review the changes other than the simple
fast-import one is probably Dscho; in his absence, the next best as
far as I can tell is probably Junio or perhaps Shawn.  I hate to
overwork them even more, so if anyone else has some time to take a
look or even do some simple testing, it'd be much appreciated.  Shawn
is a natural choice for reviewing the (fairly trivial) fast-import
change.

Changes since the previous submission:
  * Significantly extended, clarified, or otherwise modified several
    of the commit messages
  * Rebased the series on top of maint (sorry about submitting
    relative to next!)
  * Added Alexander's signoff on his testcase
  * Moved the new rename+D/F conflict testcase to a different file
    since the testcase uses cherry-pick rather than merge.

Alexander Gladysh (1):
      Add a rename + D/F conflict testcase

Elijah Newren (4):
      Add additional testcases for D/F conflicts
      merge-recursive: Fix D/F conflicts
      merge_recursive: Fix renames across paths below D/F conflicts
      fast-import: Fix minor data-loss issue with directories becoming symlinks

 fast-import.c                   |    5 ++
 merge-recursive.c               |  106 ++++++++++++++++++++++++++++++++-------
 t/t3508-cherry-pick-merge-df.sh |   37 ++++++++++++++
 t/t6020-merge-df.sh             |    2 +-
 t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++-
 t/t9350-fast-export.sh          |   24 +++++++++
 6 files changed, 190 insertions(+), 21 deletions(-)
