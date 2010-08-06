From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Fix spurious conflicts with pull --rebase
Date: Fri,  6 Aug 2010 08:05:01 -0600
Message-ID: <1281103503-27515-1-git-send-email-newren@gmail.com>
Cc: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 16:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNWE-0001tW-Tb
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966Ab0HFOD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 10:03:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33173 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab0HFODZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 10:03:25 -0400
Received: by wyb39 with SMTP id 39so7779343wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=eZXjB5xiMaH2YUQKOIpLi+XN1Cfls9JIttkbN4W94TE=;
        b=SG5Jdl4PJ0RQTS6y1DcWjVuC+8728niC942nhneJpoOJ5Qn54rjFTPiUtPNjiwLLa2
         hgzL2JHIQb1i2j9j0bPTP+IZBoxEnX/hWTJJotWE2xTo/sJYyLTjr1V8EVJnlyLUgq7D
         2wLDGmCv0TfA8rVlBjFt31VAT9vXDbT29Um4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GzkEX+nTCJc2Cfi5r3Zr8Ci0Hihgfj4cczQj4PPlutfZoPgx8KZIm+8b72G5I0HFRj
         rbj360jyfsrpEbLQzz4aAHGJ/L4VF6IiC8TjMuIQ+AGflInT9IFYP/oM3uNyslKfSDE8
         f0/OJ3wBQ7ADvXQm8LI4m6RGyppOMr8NLu63s=
Received: by 10.216.164.21 with SMTP id b21mr955813wel.28.1281103403353;
        Fri, 06 Aug 2010 07:03:23 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o84sm867954wej.13.2010.08.06.07.03.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 07:03:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152782>

This patch series fixes git pull --rebase failing to detect if "local"
patches are already upstream in cases where the upstream repository is
not itself rebased.  Also in the non-rebased upstream case, this
series avoids checking/applying more patches than needed (i.e. avoids
having rebase work on commits which are already reachable from
upstream).

It would be nice to make 'git pull --rebase' able to detect if patches
being applied are already part of upstream in cases where the upstream
repository has been rebased.  As far as I can tell, that would require
changes to format-patch to allow it to be told what 'upstream' is, and
some changes to git-pull.sh/git-rebase.sh to pass it this information.

Elijah Newren (2):
  t5520-pull: Add testcases showing spurious conflicts from git pull
    --rebase
  pull --rebase: Avoid spurious conflicts and reapplying unnecessary
    patches

 git-pull.sh     |   34 ++++++++++++++++++++-----------
 t/t5520-pull.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 12 deletions(-)
