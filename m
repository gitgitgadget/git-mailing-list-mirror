From: newren@gmail.com
Subject: [PATCH 0/5] D/F conflict fixes
Date: Mon, 28 Jun 2010 19:12:11 -0600
Message-ID: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPLm-0006lJ-VW
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab0F2BKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:10:50 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46078 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0F2BKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:10:49 -0400
Received: by pxi8 with SMTP id 8so2060482pxi.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=3B0TiUZU/C9TAJce0128eNlXmMcCCake5lEgHhJ834w=;
        b=nBnHdjS+mVws8D2Ha2oOWYCdxMl6mkicJLFQoHTm77Bw3EQWKrWMB4FSlcEP2yXZFS
         7OraX9NG8qb0d19UAO9LNPVW2xpffA4k4FUdzwSXS3p5evoAeOoL8M8aFo+4YFc55mls
         KeMO22TH2w+Zb4NdXKhOG5sy9N3W5KH4Ak59k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EszjW3dpqzOQFYvC/tpIwxIs1xTKuDZwPWxhtTnd6FjSr1OdItwM6izss/9PJhe65w
         3/m3p+3h5muQYIce89LU+4lPxX/9ahTd3T7qA/C0m/nvmks1PDr/IM99ig0c/ODv5YjZ
         BgI3XDzxutTQBUmuRGT/2ym9cqNLAvEGEiocU=
Received: by 10.142.119.20 with SMTP id r20mr6776828wfc.15.1277773848773;
        Mon, 28 Jun 2010 18:10:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149873>

This patch series fixes a number of spurious directory/file conflicts
that I have (or have seen others) run across in cherry-pick, rebase,
merge, and fast-import, while fixing already known failures in both
t6020-merge-df.sh and t6035-merge-dir-to-symlink.sh.

It also involves an extra testcase posted by Alexander Gladysh to the
list on March 8; I hope it's not bad form for me to put his testcase
into the testsuite and submit it.

Alexander Gladysh (1):
      Add another rename + D/F conflict testcase

Elijah Newren (4):
      Add additional testcases for D/F conflicts
      merge-recursive: Fix D/F conflicts
      merge_recursive: Fix renames across paths below D/F conflicts
      fast-import: Handle directories changing into symlinks

 fast-import.c                   |    5 ++
 merge-recursive.c               |  106 ++++++++++++++++++++++++++++++++-------
 t/t6020-merge-df.sh             |   34 ++++++++++++-
 t/t6035-merge-dir-to-symlink.sh |   37 +++++++++++++-
 t/t9350-fast-export.sh          |   24 +++++++++
 5 files changed, 185 insertions(+), 21 deletions(-)
