From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v7 0/5] Improving performance of git clean
Date: Tue,  9 Jun 2015 20:24:34 +0200
Message-ID: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2OJE-0001os-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbFISbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:31:33 -0400
Received: from mail-la0-f67.google.com ([209.85.215.67]:35135 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbbFISbb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:31:31 -0400
Received: by lams18 with SMTP id s18so2707066lam.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rLl3pvLDfzwRWFOBDJUz0I4qKpXm7vMK3S9anbddLzg=;
        b=u9sBLHQyhX8uqf2/kff/5hmImkePr95e4k/vsSOhNWTAWsiSDUx4qyC8Y1CPirbjyR
         jUPXzua5IH862LXPFf22aN/j+DQ5K2HgepMgffWCY8JZybbhYypo1l9+lmAVdw4OB7Mr
         5wANDipyixM8L9d2X2u33QeEre5CF0XqbdMCvkvBvtejHZNVGsq6daCBrlRuGUtwi3WI
         L4FJi4SC3mGd3CaOnQfp9ucSAUtm1J4d2EJycg4moZC9iMyYTezW2FqvqhtTw/sfjld4
         5V+80iXH7FqnG5iX2p1nsedg/+G8agGffU795TvvMWJstAIwIGl7gck6SoeRV7YXuf5n
         ffMQ==
X-Received: by 10.112.17.68 with SMTP id m4mr24027102lbd.10.1433874312376;
        Tue, 09 Jun 2015 11:25:12 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id bm5sm285250lbc.45.2015.06.09.11.25.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jun 2015 11:25:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271220>

Here is a reroll of this series (after much delay).

Changes in v7:
* changed order of file size and file open error check in read_gitfile
* resolved conflicts with nd/multiple-work-trees. This removed the
  need for is_git_directory_gently that was added in v6 and simplified
  some error cases.

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
2.4.3.373.gc496bfb
