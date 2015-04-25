From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v4 0/5] Improving performance of git clean
Date: Sat, 25 Apr 2015 11:06:36 +0200
Message-ID: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylw3K-00051K-0z
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 11:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbbDYJGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 05:06:55 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36431 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbbDYJGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 05:06:52 -0400
Received: by lagv1 with SMTP id v1so50327390lag.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=/x0+pTPhZyhSm9Kiuiio06X1R81/QnRxYG6lDU9B9Rw=;
        b=ZwgfK8lRY6ZQfFKsl49I4D3BaLq8oszrEjdC9ypYgC0C/PH4h9JobgswDJGiYJTazZ
         pIJJ77AlbP2XC16z16/54UNvtyYTWYL2nPAsLUJ6QJ2vTZAdwLAba5grBpNW6IQqC32s
         aT7WUB0ig3B+5vtadiX8WtJpPDqBBiOPlZu82BAlRfSQQwWT2hXAvTNv4CHibjAaE82P
         AEGCPXXt1pFCB8oZweUscNRHIEp/jKEz1wXBt+wks0S4yRBTDi3floc3hLyIMA5Jld11
         07Wx5sHpEX3vRAsB8DX5lBCwdcOL/I0ea5Wp52jHv/h/Q+SF2ptKGspi+IGHeAOjNPi4
         SwAQ==
X-Received: by 10.152.22.168 with SMTP id e8mr2076433laf.27.1429952810775;
        Sat, 25 Apr 2015 02:06:50 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id r6sm3249243lbw.10.2015.04.25.02.06.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 02:06:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267784>

v3 of the patch can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/267422

Changes in v4:
* changed some tests to use more meaningful dir names.
* fixed performance test by doing "git clean -n" to avoid
  timing setup code. Increased test size to 100000 directories
  (~0.5s runtime).
* changed interface of read_gitfile_gently to be able to
  return error code.
* fixed a compiler warning in read_gitfile_gently ("warning:
  =E2=80=98dir=E2=80=99 may be used uninitialized in this function").
* added sanity check of git file size in read_gitfile_gently
* updated commit message in [5/5] to more clearly motivate
  remaining behavioral changes of git clean.

Thanks to Junio C Hamano and Jeff King for comments and help on v3.

Erik Elfstr=C3=B6m (5):
  setup: add gentle version of read_gitfile
  setup: sanity check file size in read_gitfile_gently
  t7300: add tests to document behavior of clean and nested git
  p7300: add performance tests for clean
  clean: improve performance when removing lots of directories

 builtin/clean.c       |  26 +++++++++--
 cache.h               |   3 +-
 setup.c               |  88 ++++++++++++++++++++++++++++-------
 t/perf/p7300-clean.sh |  31 +++++++++++++
 t/t7300-clean.sh      | 126 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 252 insertions(+), 22 deletions(-)
 create mode 100755 t/perf/p7300-clean.sh

--=20
2.4.0.rc3.8.g4ebd28d
