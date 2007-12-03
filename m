From: "Kevin Leung" <kevinlsk@gmail.com>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run with wrong sub-commands
Date: Mon, 3 Dec 2007 11:36:59 +0800
Message-ID: <e66701d40712021936p10ee73ddj9696d3a8b4092127@mail.gmail.com>
References: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
	 <7vwsrwqysf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git ML" <git@vger.kernel.org>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 04:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz27i-00052X-0n
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 04:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbXLCDhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 22:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXLCDhF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 22:37:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:65321 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXLCDhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 22:37:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2621460nfb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 19:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QeZ6gmAd3DIiMckHDu5XshShcWBiWoiZTHrMtBxnP0A=;
        b=SfwIq31Gme3EJEqnJwzQj+oFvkxvGdc/ZPazFQCazMWBTEFSh3z+k5rYk7507KeeeWSgcQqxhLHLjovTutLUzLpexPlo3wiXp3M9nx16mpGMLWGZ0XV+t1OnUR+eMC+kg+EKQVSV9K6kz0a9pFSOwbUVeI5k7yOIxXuWQyafo7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NpBLeQ8/zEWSRIGopv11Nddfdgfqp/AUs+ROlKFQ6WK01rN+FgcEjnT5RoVkT9XGFgMtCmc9tLZVPUErD25tKIUY7LQBTkH/iqd6H8wRIpwEDzbV11wJt8hKVhogam0r+2YjsZ2vXsrCY8Qsowxn/R/QzHq5xkJfaZkHjsDwiY8=
Received: by 10.78.200.3 with SMTP id x3mr6799501huf.1196653019592;
        Sun, 02 Dec 2007 19:36:59 -0800 (PST)
Received: by 10.78.46.8 with HTTP; Sun, 2 Dec 2007 19:36:59 -0800 (PST)
In-Reply-To: <7vwsrwqysf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66853>

The current git-stash behaviour is very error prone to typos. For example,
if you typed "git-stash llist", git-stash would think that you wanted to
save to a stash named "llist", but in fact, you meant "git-stash list".

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
---

 Thanks, Junio. It should be alright now.

 git-stash.sh |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 77c9421..844a3e5 100755
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
+       save_stash "$*" && git-reset --hard
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
