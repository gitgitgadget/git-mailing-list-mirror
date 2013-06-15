From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] GIT-VERSION-GEN: support non-standard $GIT_DIR path
Date: Sun, 16 Jun 2013 01:01:11 +0200
Message-ID: <20130615230108.GA21005@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 01:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnzTE-0006Ke-Ti
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 01:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab3FOXBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 19:01:17 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:43910 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab3FOXBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 19:01:16 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so1412927wev.2
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 16:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=bhGECJU1Mb73MJbxU1nCDsP+Rx8RqVAKA+tV4/mTgvk=;
        b=asFKgG/trYv5rbE1XGoCnZrqtqAJXJaKISJaSOkE7G9yLr/Ay0Jy2UFo3meu47UhMN
         FwbQZQH3Bb50Qcl0FyWoic6BQ7akM0TdFmkYk2HMGO3faBozOBIDgCkwnM0W00PseXrN
         O9hLJATr8IzYp1PdePfdKkBt11c3Mg1OX6kBNDVslOLSlbGHdu7tUnsTamQmEHbpeeP6
         KXjy0LuTPugCBPzREujTpaEMHbBDZleqGpjqZeqlHmnUDFDKIOHJYTaHtwIWfc7JiGsT
         f59+smKfXRoNpsVfITC+BrmIUrCirCx8eLaj1IsdmQLGQpRszvy0IoFgQpbi6HWLKnjT
         j2zg==
X-Received: by 10.194.179.33 with SMTP id dd1mr4576185wjc.51.1371337275080;
        Sat, 15 Jun 2013 16:01:15 -0700 (PDT)
Received: from kaarsemaker.net (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id ft10sm12474425wib.7.2013.06.15.16.01.13
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 16:01:14 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmFAAlnp1YDZz2M20QcB5evCi6n/9fdaoTqFKyR/DQyRADbRNgoTguHKrcLXYOavS7ASEk6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227974>

make and make test both work when $GIT_DIR isn't .git, but make dist
included a bogus GIT-VERSION-FILE.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 I'm doing daily builds of git, using many workers and a shared git.git,
 with per-worker checkouts, it would be really useful if GIT-VERSION-GEN
 actually supports this and doesn't generate a fairly bogus
 GIT-VERSION-FILE.

 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 390782f..7dcca28 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -11,7 +11,7 @@ LF='
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d .git -o -f .git &&
+elif test -d .git -o -f .git -o test -d $GIT_DIR &&
 	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
-- 
1.8.2.4.g940421e
