From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC PATCH] GIT-VERSION-GEN: restrict tags used
Date: Wed, 12 May 2010 01:33:18 +0800
Message-ID: <1273599198-1008-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 11 19:37:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBtOT-0006zO-SG
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 19:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab0EKReE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 13:34:04 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43943 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0EKReB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 13:34:01 -0400
Received: by wwi18 with SMTP id 18so107653wwi.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/tH4f03uWbWn/lNKKvN/jdnqTXAbjGiNRSHGywD1jEU=;
        b=L7Hg2X7oYAsK0p2OIrfgBq4EGF/IXC641CJn4RcHmfwXKkgsCusMHYfDcpm9L0/kSN
         2QWKjD2Mg6rYNH7IVnT/skPvWftTeYmIQB9IQHAfZ9V16tZNc9pSUj3eoJLmYu/WvwIO
         dQPDazI1gND4V1E8z2TEnNRMT1NvAr3QxKMMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=h2b76+pp2DsahcTUon4wO/3kkYwOXD2ZLd+WYwaon6F2mxUdpRgG6LmACAp5QSIIqB
         gAe7A78FJH3CGyWaW4qsMnu6awSeFFo45nqm0zPs0kIVp1MVJFRhtQH1OhcSV7aMoYl/
         dmD0DF2HTQLPNqXGodMYfM5/F5SEzwbjeggI0=
Received: by 10.227.135.6 with SMTP id l6mr5570525wbt.60.1273599239527;
        Tue, 11 May 2010 10:33:59 -0700 (PDT)
Received: from localhost.localdomain (cm37.zeta153.maxonline.com.sg [116.87.153.37])
        by mx.google.com with ESMTPS id j8sm23014340gvb.1.2010.05.11.10.33.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 10:33:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146903>

Restrict the tags used to generate the version string to those that
begin with "v", since git's tags for git-core (ie. excluding git-gui)
are all of the form "vX.Y...".

This is to avoid using private tags by the user in a clone of the git
code repository, which may break certain machinery (eg. Makefile).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Ran into this after tagging a topic branch and running make.

  Although a "v.*" match does not guarantee the non-usage of private
  tags, I feel it's an acceptable level of accuracy.

  After this patch, perhaps we could advertise somewhere to git hackers
  that tags beginning with "v" should be avoided.

 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 59219bd..28b4d56 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,7 +12,7 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v*" --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
--
1.7.1.189.g07419
