From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 3/6] gitk: On Windows use a Cygwin-specific flag for kill.
Date: Sun, 27 Jul 2008 10:20:02 +0400
Organization: TEPKOM
Message-ID: <200807271020.02415.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com> <200807271018.22969.angavrilov@gmail.com> <200807271019.17267.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzd3-0003G8-TU
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbYG0GUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYG0GUN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:20:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:53892 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYG0GUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:20:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893222fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VINIz8C5sSpHiyHw7skNcMbUMEfbpZhclkmYcOx8jL4=;
        b=p2CW8jBlrZrqBm0Q68oiXXK1dyZKwLo2oF76Aza2mX9WDmf5zE997o0rPjXdhHxbkn
         WPA3hUi+iAV8Sp3F8qFGafL5RBsFTm9Hj5bRQt3TTw6952FZsXs8SsmB1TBymXchuNo7
         sHS/v06GJ1jfJ5QPGt5LEXAarmqmMybcY87mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cReyOupD4NI2jT1IC00EDuL1WJ0X3XHkoXjuY9VEqQXTMI3I/LXpTILLWNyYwPZkvK
         /ippqAF/DhEzctpg1I9nNaI0JiSRfq4eXKv0Ehx4KoaYiBteH0GI3op4SF2WhkGBh8h6
         bd4wqJDj5bwWu3CyWN4iHo4CsSSYqyRJ7uzXY=
Received: by 10.86.66.11 with SMTP id o11mr1388970fga.69.1217139610515;
        Sat, 26 Jul 2008 23:20:10 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm13871741fgg.0.2008.07.26.23.20.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:20:09 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271019.17267.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90317>

Date: Tue, 15 Jul 2008 00:35:42 +0400

MSysGit compiles git binaries as native Windows executables,
so they cannot be killed unless a special flag is specified.

This flag is implemented by the Cygwin version of kill,
which is also included in MSysGit.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index b523c98..d7fea26 100755
--- a/gitk
+++ b/gitk
@@ -388,7 +388,12 @@ proc stop_instance {inst} {
     set fd $commfd($inst)
     catch {
 	set pid [pid $fd]
-	exec kill $pid
+
+	if {$::tcl_platform(platform) eq {windows}} {
+	    exec kill -f $pid
+	} else {
+	    exec kill $pid
+	}
     }
     catch {close $fd}
     nukefile $fd
-- 
1.5.6.3.18.gfe82
