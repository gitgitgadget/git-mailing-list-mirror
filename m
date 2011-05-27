From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH maint 0/3] do not write files outside of work-dir
Date: Fri, 27 May 2011 18:00:37 +0200
Message-ID: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:00:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPzT1-0000I9-K7
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab1E0QAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 12:00:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52882 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666Ab1E0QAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:00:46 -0400
Received: by eyx24 with SMTP id 24so709158eyx.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=ak0AUI8a57RELy5bQLcHmen/TRBmgECoe0dqHBv1Ow0=;
        b=lJjK7f67r2hC4CIOi1/I1q5TpcZjc4KQCrJrM9JwJ16QFXJR2qzlL9GbH70mBdemA6
         KXj2dFUlKWhRnSCWpe4tgHp6cUElcjkfDI2BvObb2E/meV2/POyWniHELUs5jdSqv+d9
         6tjIXO3/A+znydZVTV8kdoDxdl4z9r5tNVvio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gkIT743IUBQgkdb/OG0Vd4g501FZck4xd9cSyngfJl0NtH8NUSyAN1SgrClfc5DVhB
         4fAZkjyTzw1Gjfjlb6BoRAqyJTvAg8xM1dLo+bZI0fjlQdzxs39qCsNJjkKh8KIMmKai
         C0F36jtp5ZyRc7c0x30tZqMxhN0NiCARmH+Jw=
Received: by 10.14.126.200 with SMTP id b48mr857895eei.54.1306512045471;
        Fri, 27 May 2011 09:00:45 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm1338861een.1.2011.05.27.09.00.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 09:00:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3775.ga8770a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174625>

Theo Niessink has uncovered a serious sercurity issue in Git for Windows,
where cloning an evil repository can arbitrarily overwrite files outside
the repository. Since many Windows users run as administrators, this can
be used for very nasty purposes.

The first two patches fix "git add" so it reject paths outside of the
repository when specified in the "C:\..."-form on Windows.

Patch 3/3 makes sure we don't try to actually write to these files.

This series applies cleanly to 'maint', and I strongly encourage that
we apply at the very least 3/3 there.

Erik Faye-Lund (1):
  verify_path: consider dos drive prefix

Theo Niessink (2):
  A Windows path starting with a backslash is absolute
  real_path: do not assume '/' is the path seperator

 abspath.c         |    4 ++--
 cache.h           |    2 +-
 compat/mingw.h    |    9 +++++++++
 git-compat-util.h |    4 ++++
 read-cache.c      |    5 ++++-
 5 files changed, 20 insertions(+), 4 deletions(-)

-- 
1.7.5.3.3.g435ff
