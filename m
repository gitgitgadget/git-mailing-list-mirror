From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v2 0/3] Improving performance of git clean
Date: Sat, 11 Apr 2015 18:43:03 +0200
Message-ID: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 18:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgyVK-0005ik-ER
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 18:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbbDKQn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 12:43:26 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:33900 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbbDKQnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 12:43:25 -0400
Received: by laat2 with SMTP id t2so32040595laa.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=+nY3qK//BAJLRjDy8xRcEwULVDMz+LY3+pYVPjQATZk=;
        b=fgH9QAakLOJYzUF5QvhjSngqOG+uB6EvKkEYqcphZCyzIMgcVFaLVT7yLCPwVMkOHX
         J2z82sv1BE69H8FeXB510hEK8HI0Fml+m0DaBYgb/6g/4A7DAfrkcZCIRpzJF/eYrFoR
         dJfZo0/4eKPMru0m3Dpm+WZT3foZFeXmfY+Ow5EY8kTS6h/EuvsVCDEBex+nr4ko5BVi
         W0xWx8a9V1bknMDrm9lLE+/7gLQMnSnbifkkm+bgZvBQ46i75N5b4ZShO/wJsnsIA4QY
         YD2ywLEWJ0BbOQTg/AURS0VKrp1YPjtiCUkcMxzhedUDwZlbdndIxqC2jf6chjEG8HBQ
         NyGA==
X-Received: by 10.152.87.162 with SMTP id az2mr6270079lab.58.1428770603525;
        Sat, 11 Apr 2015 09:43:23 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id kx8sm501395lbc.3.2015.04.11.09.43.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2015 09:43:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267023>

v1 of the patch can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=3D2=
66839

changes in v2:
* fixed commit message,
  "p7300: added performance tests for clean"
  change to:
  "p7300: add performance tests for clean"
* simplified test code
* removed non portable ls -A in test
* removed non portable $(seq ) in test
* fixed missing " || return $?" in test
* fixed missing sub shell for 'cd' command in test
* fixed broken && chains in test
* added assert new clean.c:is_git_repository to guard against
  negative array index
* use size_t instead of int for strbuf->len

fixes held back for cleanup patches:
* fixed existing broken && chains
* added assert in existing code to guard against
  negative array index

Thanks to Eric Sunshine and Torsten B=C3=B6gershausen for the very help=
ful
review!


Erik Elfstr=C3=B6m (3):
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       | 24 ++++++++++++++---
 t/perf/p7300-clean.sh | 37 ++++++++++++++++++++++++++
 t/t7300-clean.sh      | 72 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 129 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc0.37.ga3b75b3
