From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v5 0/5] Improving performance of git clean
Date: Sun, 26 Apr 2015 08:49:40 +0200
Message-ID: <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 26 08:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmGOa-00073B-9W
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 08:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbbDZGuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 02:50:09 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:34750 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbDZGuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 02:50:08 -0400
Received: by laat2 with SMTP id t2so60161329laa.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2lyzjS2Kc11tVpE5nRxGnLThKnylrD3KhCOjo9ETCKE=;
        b=er1fBcpRwwA6CcGmfqMg+XwWZQ5X9Bh1Deo2Hcem3jh1WUkJCLmm/DUMfY+g75zI+q
         f1IMZ+YTJ82rrlau4H7VaWirdWgCIcM2f9s6cF74A0iXNbRLfbIafzmJjgDzbD1JEQDh
         2JuMYf9LJmModSyQucJnmvgBLlYRnXnobfcygUMFfXXbvCNLY00Xxxn0Is5u1n5zcRL4
         +d/Xr/8OaXEPYu7/2x2M/iK+fA0QOqrES6LNVS4awvlisAMrK4V1VgP898tP4BLFkYZ4
         EaxMRWLiC13fQDJjVJW/fEMAIl9UosdRGf1bRXcMCTJNRLmS38mienq087Jfw111fr/6
         SajA==
X-Received: by 10.152.42.141 with SMTP id o13mr5278700lal.33.1430031006426;
        Sat, 25 Apr 2015 23:50:06 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id x2sm3884938laj.8.2015.04.25.23.50.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 23:50:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.gbb31afb
In-Reply-To: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267823>

Changes in v5:
* Added defines for read_gitfile_gently error codes.=20
  This was a silly mistake, sorry about that.

Erik Elfstr=C3=B6m (5):
  setup: add gentle version of read_gitfile
  setup: sanity check file size in read_gitfile_gently
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       |  26 +++++++++--
 cache.h               |  12 ++++-
 setup.c               |  88 ++++++++++++++++++++++++++++-------
 t/perf/p7300-clean.sh |  31 +++++++++++++
 t/t7300-clean.sh      | 126 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 261 insertions(+), 22 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc3.8.gbb31afb
