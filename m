From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] GIT-VERSION-GEN: restrict tags used
Date: Wed, 12 May 2010 11:29:20 +0800
Message-ID: <1273634960-2728-1-git-send-email-rctay89@gmail.com>
References: <AANLkTim8SRUEaNWyBF_iRQstu84r9eAaUd0a9KLj6OtR@mail.gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 12 05:29:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC2dx-000830-52
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 05:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab0ELD3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 23:29:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56518 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab0ELD3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 23:29:47 -0400
Received: by pvh11 with SMTP id 11so207611pvh.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tC4wGsZbuRnhdKirh6G++Ta6xH1cEA+HyajfRdGd6O8=;
        b=uYLCD2Rglzl5NPv9gOksnoP5UiqOJ+gASsr/asIdcnOhUqneLOcnXgcZCG6B5waGUs
         cNJChLFG7khd5fq4EOc33wG/fICdhzAYToWgrwfxHwDfCD1p1+tuKgpsat/CUyvUo/b/
         u/P9x3k6kbFSQI8cMhr+DC5z3BkmPKxt1ypLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Fu+QMu6o/sM6bEhgeMA7vr5v5y4sNJCRuYhPLXKOZaexgfZvE7li3CP2ioKB5JtY03
         AuuyKDpaw8xAuiCcl8MPssK9NuowkwVh2aPds/DdVRWzz8Q4BU+xlgmHY5GpWC/vsvGs
         kke7m3uKF/3GIW9UnmnefvF4UTNX40m0a//3Y=
Received: by 10.114.2.17 with SMTP id 17mr5301188wab.35.1273634985722;
        Tue, 11 May 2010 20:29:45 -0700 (PDT)
Received: from localhost.localdomain (cm37.zeta153.maxonline.com.sg [116.87.153.37])
        by mx.google.com with ESMTPS id d20sm40646646waa.3.2010.05.11.20.29.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 20:29:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <AANLkTim8SRUEaNWyBF_iRQstu84r9eAaUd0a9KLj6OtR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146918>

Restrict the tags used to generate the version string to those that
begin with "v", since git's tags for git-core (ie. excluding git-gui)
are all of the form "vX.Y...".

This is to avoid using private tags by the user in a clone of the git
code repository, which may break certain machinery (eg. Makefile, gitk).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Changes from RFC:

    - used "v[0-9]*" instead of just "v*"
    - mentioned gitk as another piece that may break

 GIT-VERSION-GEN |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 59219bd..e45513d 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,7 +12,7 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
-	VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
+	VN=$(git describe --match "v[0-9]*" --abbrev=4 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
--
1.7.1.189.g07419
