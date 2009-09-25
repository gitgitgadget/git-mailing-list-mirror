From: Christian Himpel <chressie@googlemail.com>
Subject: [PATCH 2/2 v2] git-am: force egrep to use correct characters set
Date: Fri, 25 Sep 2009 17:45:39 +0200
Message-ID: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
References: <dc8a4205128d65e69587292a42c714792315a9df.1253891124.git.chressie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 17:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrD0z-0004zZ-Bf
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbZIYPpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZIYPpi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:45:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34065 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbZIYPph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:45:37 -0400
Received: by fxm18 with SMTP id 18so2301707fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MCGabme0iO0tRaT1CGkOP0+MAwbwAu8kA8gK+Jl64u0=;
        b=Ix4Gyp8bVky1S+z6+k18ed1A4nq0eo/0Oq9g7hbJEFJDDrjMeWnz9HlS1Bp3i9r8lP
         Pq62TzfKhldQiUOOlws0sbrSSHDN9F8O+eSIwNwcrew0VNMq66sucxPzubaIIx81uSee
         r4MGeNh6jXOoTABUldsyfQDwkIVVYrdvapIbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VXHbQMCYpWhPuGaVssQsKgXu5x7/Bsvowo7e/JQsP39SSZEf1R+MjVY6xPqNUg+TT9
         dtZX4tVH3NbOBo/cRdpjMQ56oP6BSO97JjjWdwbMgS285e2qJusaOGrXPCVtPm/jNjz0
         xMaNnk92YHurcU1TuNb8wfjIH3hc+m3QHtUd0=
Received: by 10.204.154.131 with SMTP id o3mr255129bkw.66.1253893540255;
        Fri, 25 Sep 2009 08:45:40 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id 9sm3658545fks.24.2009.09.25.08.45.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 08:45:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dc8a4205128d65e69587292a42c714792315a9df.1253891124.git.chressie@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129093>

According to egrep(1) the US-ASCII table is used when LC_ALL=C is set.
We do not rely here on the LC_ALL value we get from the environment.
---

This is probably a saner approach :)

 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 0ddd80f..c132f50 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -205,7 +205,7 @@ check_patch_format () {
 			# and see if it looks like that they all begin with the
 			# header field names...
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
-			egrep -v '^[!-9;-~]+:' >/dev/null ||
+			LC_ALL=C egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
 	} < "$1" || clean_abort
-- 
1.6.4.4
