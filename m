From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/6] am --skip/--abort: improve index/worktree cleanup
Date: Sat,  6 Jun 2015 19:46:06 +0800
Message-ID: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 13:46:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1CYW-0004ya-FI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 13:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbbFFLqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 07:46:24 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34081 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbFFLqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 07:46:23 -0400
Received: by pdbki1 with SMTP id ki1so69833300pdb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UXfQHzHV6YkbJxtbGgx6p9LEKm3dTgZocyc/vj+Jh5k=;
        b=Ggzi3I9CgWyINU/e/ToUUGlL5SmTS239J6p0uhflHiJtx1t5G6PLhv3L5L8frg+tms
         eDy1DNIqU+/nS9VoqrBXMOyfMNU5xnt6EOwWt/o7RmUvg5G73IaVxAftjbMUeBtFnH8w
         xaDq8K4pvefd94vj98H4VKhQHhAc80q+BwQPIiUJmfRjpa7D/MtlV+y4Tw/BUSDD/MI4
         dtfsKWPJ2OwZEjAQVqK3lMLjRgtkOTB03lYoJEqL7Vig0emfZ6NBvq+Aog3ARJpeTLtH
         PLk+evxeNz+TSqx/Q7AvsMOXyWFxHewIaZWtA8sdocpZGiuaG93MtKN39Fh9HYjAouFw
         9s6Q==
X-Received: by 10.70.134.70 with SMTP id pi6mr13537127pdb.100.1433591183273;
        Sat, 06 Jun 2015 04:46:23 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id on3sm9344587pbc.69.2015.06.06.04.46.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 04:46:22 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270915>

Currently git-am attempts to clean up the index/worktree when skipping or
aborting, but does not do it very well:

* While it discards conflicted index entries, it does not remove any other
  modifications made to the index due to a previous threeway merge.

* It expects HEAD/ORIG_HEAD to exist, and thus does not clean up the index when
  on an unborn branch.

This patch series addresses the above two general problems by making the calls
to git-read-tree aware of the differences between our current index and
HEAD/ORIG_HEAD, and by explictly defining what happens when we are on an unborn
branch.


Paul Tan (6):
  am --skip: revert changes introduced by failed 3way merge
  am -3: support 3way merge on unborn branch
  am --skip: support skipping while on unborn branch
  am --abort: revert changes introduced by failed 3way merge
  am --abort: support aborting to unborn branch
  am --abort: keep unrelated commits on unborn branch

 git-am.sh           | 31 ++++++++++++++------
 t/t4151-am-abort.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 8 deletions(-)

-- 
2.1.4
