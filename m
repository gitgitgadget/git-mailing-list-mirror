From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 0/6] D/F conflict fixes
Date: Fri,  9 Jul 2010 07:10:50 -0600
Message-ID: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDLI-0004z2-BW
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0GINKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:10:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58593 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0GINKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:10:02 -0400
Received: by pxi14 with SMTP id 14so807474pxi.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IY4oIbVO6j9l/zjNUD1Nv/JoMeHXvsGGMVYhn048guI=;
        b=gao4P/ELpZf5n3nAA9/a6i6JuVnqrTxch3BDW9U6jbECIWWAmC3G5ZoPFXOZUmM50D
         1nz9nheO+eXs2Tv60Z/AkXGEbaWd0yCOnCIqge5WFvoKJQh1c+HbXczEoRPIzJTZCiYP
         68j6bhICEd9Iy7FQV26uj7AgQVT/w2q+EFI+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=app5xfyq8PGacjPdAy1trP9touqIFsMgKI3VCifISu9cjx/qE4ge4MGpg0xudduTHc
         fg3oe3h5YyVSn0QnxLQc/LQpehCFOwBjdonN70uJI3/CaB2fhZADg6qfaFIaRBbqwKDq
         SRze9d+c/qc9BPtWSUkeMoTp3p/fgVBBNAwC4=
Received: by 10.142.233.8 with SMTP id f8mr11749615wfh.229.1278680580716;
        Fri, 09 Jul 2010 06:03:00 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.02.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150665>

This patch series fixes a number of spurious directory/file conflicts
and associated bugs appearing in cherry-pick, rebase, merge, and
fast-export.  It also has a minor robustness improvement for
fast-import.  This series includes testsuite fixes for currently known
failures in both t6020-merge-df.sh and t6035-merge-dir-to-symlink.sh.

Changes since the previous submission:
  * Addressed comments from Junio in the previous round.

Alexander Gladysh (1):
      Add a rename + D/F conflict testcase

Elijah Newren (5):
      Add additional testcases for D/F conflicts
      merge-recursive: Fix D/F conflicts
      merge_recursive: Fix renames across paths below D/F conflicts
      fast-export: Fix output order of D/F changes
      fast-import: Improve robustness when D->F changes provided in wrong order

 builtin/fast-export.c           |   29 ++++++++++
 fast-import.c                   |    8 +++
 merge-recursive.c               |  108 ++++++++++++++++++++++++++++++++-------
 t/t3509-cherry-pick-merge-df.sh |   35 +++++++++++++
 t/t6020-merge-df.sh             |    2 +-
 t/t6035-merge-dir-to-symlink.sh |   64 +++++++++++++++++++++--
 t/t9350-fast-export.sh          |   24 +++++++++
 7 files changed, 247 insertions(+), 23 deletions(-)
