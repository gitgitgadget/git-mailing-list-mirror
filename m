From: "Kevin Leung" <kevinlsk@gmail.com>
Subject: [PATCH] git-stash: Display help message if git-stash is run with wrong sub-commands
Date: Mon, 3 Dec 2007 10:34:05 +0800
Message-ID: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz18g-0001w5-1B
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXLCCeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXLCCeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:34:09 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:28562 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXLCCeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:34:08 -0500
Received: by mu-out-0910.google.com with SMTP id i10so419407mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 18:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5g1AehcUHMW3IKew2GM0BXS2nICb+T8SDJC4mrdC++4=;
        b=dt33NWO1RIjoVP7zdB67mce0C5zUMmrTXv9s9ipr38xjA4bSDZAgCWKPhTSArYkSA2n7aIUBcjJk6ZEC1/XnDSVLe4Tm84WXS9nPVeDxQFGOoiahYbUHfphIP8gp5UngQQXPQd3AJPh1JFISPaTSmiuApRufYiAgZJ9ceKpBXVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uYA90eHS4QFBexGWqPobOZJaIhG0PTaBifp+GIMIQ/iADEy7/SkPyyN3WI+tKynjkmaqi99SXPXVAKZRxo0b2aPcCJdTUWhonBVZ/Ok9uQVQI8OiNCq9Ss99zyLewIAveD9MI/CjSlqRkwCTJJJ8iDZZjYMHCwcMYqDStSEOW7Y=
Received: by 10.78.172.20 with SMTP id u20mr2629359hue.1196649245568;
        Sun, 02 Dec 2007 18:34:05 -0800 (PST)
Received: by 10.78.46.8 with HTTP; Sun, 2 Dec 2007 18:34:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66849>

The current git-stash behaviour is very error prone to typos. For example,
if you typed "git-stash llist", git-stash would think that you wanted to
save to a stash named "llist", but in fact, you meant "git-stash list".

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
---
 git-stash.sh |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 77c9421..a17cc25 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi

-USAGE='[ | list | show | apply | clear]'
+USAGE='[  | save | list | show | apply | clear ]'

 SUBDIRECTORY_OK=Yes
 . git-sh-setup
@@ -195,6 +195,10 @@ show)
        shift
        show_stash "$@"
        ;;
+save)
+       shift
+       save_stash "$@" && git-reset --hard
+       ;;
 apply)
        shift
        apply_stash "$@"
@@ -202,14 +206,12 @@ apply)
 clear)
        clear_stash
        ;;
-help | usage)
-       usage
-       ;;
 *)
-       if test $# -gt 0 && test "$1" = save
+       if test "$#" -eq "0"
        then
-               shift
+               save_stash && git-reset --hard
+       else
+               usage
        fi
-       save_stash "$*" && git-reset --hard
        ;;
 esac
-- 
1.5.3.7-dirty
