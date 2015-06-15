From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v8 0/5] Improving performance of git clean
Date: Mon, 15 Jun 2015 21:39:50 +0200
Message-ID: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 21:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aF8-0003xd-DL
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbbFOTkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 15:40:22 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:35117 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbbFOTkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:40:21 -0400
Received: by labko7 with SMTP id ko7so64828278lab.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rWaoHymUPaXGF8apqdvxZlIT8EBUPTq3ZXsi68QGmUg=;
        b=vAwcqoYrP3dFwsuLe0PpmVHciz/nqBKccPPifSFg+dUEzSG0QYfDWivQOZtCByDFab
         Om5LkF76FE/g2BNeaCpahaljjzem0wIr6JumjczM0eOW8tOdIc8LQg888PC3b3iAXbq5
         FuMuC7KKPVJx5bGIJ3CiO5YGQBe4dg541VMUroM+LAKkGIAFPX562wR64HHAd1q7ru07
         JbVi6SflKbpYbrj+79jngbMqLqWKTA9ds3wElLyoTYbk6v350/cZEpRrpF0tVU/qUGKq
         LGCI8Cyf4AsI6wdYSjR5oLFc6716PEULMT3ZVFGSNI9evpZ4uMagmHyPhiO/NvZhgnjn
         ufdQ==
X-Received: by 10.112.199.10 with SMTP id jg10mr1737260lbc.24.1434397220044;
        Mon, 15 Jun 2015 12:40:20 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id a7sm2923526lbc.36.2015.06.15.12.40.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 12:40:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271713>

This is v8 of this series. v7 can be found here:

http://thread.gmane.org/gmane.comp.version-control.git/271220

Changes in v8:
 * change name and type of file size limit variable in read_git_file_ge=
ntly


Erik Elfstr=C3=B6m (5):
  setup: add gentle version of read_gitfile
  setup: sanity check file size in read_gitfile_gently
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       |  30 +++++++++--
 cache.h               |  12 ++++-
 setup.c               |  91 +++++++++++++++++++++++++-------
 t/perf/p7300-clean.sh |  31 +++++++++++
 t/t7300-clean.sh      | 140 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 280 insertions(+), 24 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.3.373.gc496bfb.dirty
