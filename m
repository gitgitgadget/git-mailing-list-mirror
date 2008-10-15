From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] git-mergetool: properly handle "git mergetool -- filename"
Date: Wed, 15 Oct 2008 00:39:53 -0700
Message-ID: <36715524a8e3a4688024cc1e23dd1518c4df71a0.1224056291.git.davvid@gmail.com>
Cc: git@vger.kernel.org, tytso@mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq15j-0001GN-EB
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYJOHpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYJOHo7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:59 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54639 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYJOHoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:55 -0400
Received: by gxk9 with SMTP id 9so6446572gxk.13
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BV0gp3SbyI0M3KGEtTenqqQFKVol+YCxh6TPdhuEKBc=;
        b=OJAhAkxp6a6ATQTQRObgafuJeBzkS0as8exST4Wj+DjF6wwpSQETcyVkaOpTseTRhY
         eM/gxHzXogX6jBIOY2bZzkyx4pcrSNtNs+SJ9HKG07/VpsQhXkvqqmFrFc9JOuuY63N3
         9RzR/8D0iUdFfugcr6vxZ7GBNxTWC56KJjxYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=noID4Lkd2IlnlzoK9IrW8pwTeUOkKKBB43uTEQebT8xDwEUoR2ARTs+BDsfX/qu+G/
         q5ofDtcEwlUsRCTD7Jc6OBXVVcKL9QweTNObp+s8TZvOZYaUKjGinIMxH97KOLxNGACd
         ZqVAQGDQWIT+blDokI5nGLkv/fcZlzuLV6uD4=
Received: by 10.142.155.4 with SMTP id c4mr326826wfe.9.1224056694135;
        Wed, 15 Oct 2008 00:44:54 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 28sm23153990wfd.4.2008.10.15.00.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Oct 2008 00:44:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.2.532.g84ed4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98252>

git-mergetool has an entry for "--" in its command-line parsing code
to designate the end of option processing.  It was not calling shift,
though, which caused git-mergetool to incorrectly use "--" as the
merge filename.

This patch fixes this bug and updates the usage and documentation
to include [--] in the options spec.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-mergetool.txt |    2 +-
 git-mergetool.sh                |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e0b2703..475db72 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [<file>]...
+'git mergetool' [--tool=<tool>] [--] [<file>]...
 
 DESCRIPTION
 -----------
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94187c3..1b0dfec 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [file to merge] ...'
+USAGE='[--tool=tool] [--] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
@@ -296,6 +296,7 @@ do
 	    esac
 	    ;;
 	--)
+	    shift
 	    break
 	    ;;
 	-*)
-- 
1.6.0.2.532.g84ed4c
