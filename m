From: Jonathan del Strother <maillist@steelskies.com>
Subject: [PATCH] git-submodule should obey --quiet for subcommands
Date: Mon, 21 Sep 2009 17:46:33 +0100
Message-ID: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpm9z-0003pS-2Y
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 18:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbZIUQyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbZIUQyd
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 12:54:33 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:47327 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZIUQyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 12:54:32 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2009 12:54:32 EDT
Received: by vws41 with SMTP id 41so2097651vws.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=nmPhpMl328c4hpDdObfwHimgr3SiWq61lj965nSo5Lg=;
        b=JWiq0Nr19utOv/RyUufv5eEhZ/v4As7Qybzulm/UauLP/9MyaS0yluJf4567j/BrDg
         30u3aWVZ6i3I6MYJIb6TzstAZsDeolWsSactWM4FO8ir61EsOAWgzq31p8sOex5DF9b+
         HouQSmUeagHpANy0JqJyvkhf9YCeWZnqTqaUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=Tt65zs0/RjgbLvtZvJ+uSi/Mluad1czPXh37rONVFUZaiBzioAp1RwllyZ5x2lqQ3h
         AWJOSKbpAcOFcFjNurogL1ZjLfw24JIRoFCzfwbwAH+cgkBqmHrU0rYG6AqALc7LBI6L
         dcX6gZLiPHUqKNO5lgkGQ/0bOlCNHf2y4VXpg=
Received: by 10.150.1.5 with SMTP id 5mr8647735yba.285.1253551721905; Mon, 21 
	Sep 2009 09:48:41 -0700 (PDT)
X-Google-Sender-Auth: 5c5d06bdb048bf98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128896>

Make sure that --quiet is passed through to git-clone & git-fetch.

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---
clone & fetch are extremely noisy - perhaps something like the following?

 git-submodule.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bfbd36b..1e1066e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -106,9 +106,9 @@ module_clone()

 	if test -n "$reference"
 	then
-		git-clone "$reference" -n "$url" "$path"
+		git-clone ${GIT_QUIET:+-q} "$reference" -n "$url" "$path"
 	else
-		git-clone -n "$url" "$path"
+		git-clone ${GIT_QUIET:+-q} -n "$url" "$path"
 	fi ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
@@ -450,7 +450,7 @@ cmd_update()
 			if test -z "$nofetch"
 			then
 				(unset GIT_DIR; cd "$path" &&
-					git-fetch) ||
+					git-fetch ${GIT_QUIET:+-q}) ||
 				die "Unable to fetch in submodule path '$path'"
 			fi

-- 
1.6.5.rc1.44.ga1675.dirty
