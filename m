From: Nicolas Sebrecht <ni.s@laposte.net>
Subject: [PATCH] git-am: print fair error message when format detection fails
Date: Tue, 14 Jul 2009 08:39:33 +0200
Message-ID: <beef9dfceed12f279bc27fbecf82118761cada49.1247553436.git.ni.s@laposte.net>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Nicolas Sebrecht <ni.s@laposte.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 08:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQbgG-0003JT-I8
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 08:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbZGNGjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 02:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbZGNGjw
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 02:39:52 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:48346 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbZGNGjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 02:39:52 -0400
Received: by ewy26 with SMTP id 26so3051273ewy.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=M/If7X8nBrQytPc/93iX5N4vDZov3hra9whPUJezueM=;
        b=wdVpeL/osExjRJF0wBC1Hd+YNfugfyyx0NJSIQjvVxJ4sqxIh46x7pfvfs7VtqJ9pY
         YU2u4I55ABuajyHmTUlU9w+X3vQ4uHTy0lpwLCwbF4W1M6kjGGQYsKxksX0o8vr2NEYN
         ljUb3FZvzNI07TiorTvv9ASQOELCt9mJXW0rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=AmGzucvcIs/9fFdwZqGfiCkggGXFvSaPS2X7KRjhEn5Lu5+3C6BykQzIXLUFVPYI8w
         zP9mlH4NSpj6v1Hvt7JDdfHoKDZ+NGRefyrLHewEbmx7oChTBbyqvo9R/aex5DOMNqOC
         yaYpiy/bUgUcji9fEJiIIJNpMgCWK/LgA595s=
Received: by 10.211.180.15 with SMTP id h15mr27656ebp.72.1247553590682;
        Mon, 13 Jul 2009 23:39:50 -0700 (PDT)
Received: from localhost (91-165-132-96.rev.libertysurf.net [91.165.132.96])
        by mx.google.com with ESMTPS id 10sm14617eyd.47.2009.07.13.23.39.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Jul 2009 23:39:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.121.g2937a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123221>

Avoid git ending with this message:
	"Patch format  is not supported."

Signed-off-by: Nicolas Sebrecht <ni.s@laposte.net>
---
 git-am.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..ca73c88 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -254,7 +254,11 @@ split_patches () {
 		msgnum=
 		;;
 	*)
-		clean_abort "Patch format $patch_format is not supported."
+		if test -n "$parse_patch" ; then
+			clean_abort "Patch format $patch_format is not supported."
+		else
+			clean_abort "Format patch detection failed."
+		fi
 		;;
 	esac
 }
-- 
1.6.4.rc0.121.g2937a.dirty
