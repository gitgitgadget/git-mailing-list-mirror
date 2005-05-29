From: Jochen Roemling <jochen@roemling.net>
Subject: Re: [COGITO PATCH] Allow file list for cg-add through stdin
Date: Sun, 29 May 2005 22:22:57 +0200
Message-ID: <429A24A1.1010402@roemling.net>
References: <4299FE8A.1060207@roemling.net> <20050529180442.GK1036@pasky.ji.cz> <429A0818.6080807@roemling.net> <20050529184642.GL1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 29 22:31:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcUH8-00085y-ML
	for gcvg-git@gmane.org; Sun, 29 May 2005 22:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVE2UXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVE2UXN
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 16:23:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:21207 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261431AbVE2UW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 16:22:58 -0400
Received: from p54AAFF39.dip.t-dialin.net [84.170.255.57] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwtQ-1DcUJF1yFr-0008MU; Sun, 29 May 2005 22:22:57 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050529184642.GL1036@pasky.ji.cz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>But a patch for cg-add processing directories recursively would be great
>anyway... ;-)
>
>  
>
Okay, okay, what about this one:


[Cogito PATCH] Add directories recursively  with cg-add

Signed-off-by: Jochen Roemling <jochen@roemling.net>

--- a/cg-add

+++ b/cg-add

@@ -10,12 +10,11 @@

 [ "$1" ] || die "usage: cg-add FILE..."

-for file in "$@"; do

-	if [ -f "$file" ] || [ -h "$file" ]; then

-		echo "Adding file $file"

-	else

-		die "$file does not exist"

-	fi

-done

+TMPFILE="${TMP:-/tmp}/$(basename $0).$$.tmp"

-git-update-cache --add -- "$@"

+find $@ -type f > $TMPFILE || die "not all files do exist, nothing added"

+

+cat $TMPFILE | awk '{print "Adding file "  $0}' 

+cat $TMPFILE | xargs git-update-cache --add -- 

+

+rm -f $TMPFILE

