From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2] fix update-hook-example to work with packed tag references
Date: Wed, 25 Jun 2008 12:26:55 +0400
Message-ID: <1214382416-6687-1-git-send-email-dpotapov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 10:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQMF-0004aS-65
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 10:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYFYI1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbYFYI1F
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:27:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:32819 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYFYI1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:27:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1328690fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VUXsU3vCeLwjXKec2o5V49xpfnMx7JbbwWxTNK1d9c8=;
        b=Ygw1L95wTow4V6QeNGzUfGUsT+kk6B5H5lxoe6kIG5XKId4UGSn3w9XhE/hRAO7CUc
         ci/F4Cd+SrLy/5bACxfYk5R75nEvyiePBEMSNjUyaVV5HUW/O1S6ZP1creQF/6eT5+tS
         DBRJWsXVTOoBqU01nLQ4D7simCRPr5Ocqfk6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CO8YfNYq+9XRdjjosChjA/e1o3c6MwuApHlvYswaQoLYpowkDAnj740paf9mEULUq+
         U2RLr8JhF5947w83w174FW0GX5s7GUqwGWtswIxTXalBJSTEO/lJkhUZaQHinOGt1A5i
         OqadUtgFYsG/bHrVtTToApq8UXGenL1uGAdkA=
Received: by 10.86.65.9 with SMTP id n9mr10027343fga.69.1214382420672;
        Wed, 25 Jun 2008 01:27:00 -0700 (PDT)
Received: from localhost ( [85.140.171.249])
        by mx.google.com with ESMTPS id d4sm12616098fga.8.2008.06.25.01.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 01:26:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86253>

The update-hook-example used 'test -f' to check the tag present, which
does not work if the checked reference is packed. This check has been
changed to use 'git rev-parse $tag' instead.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/howto/update-hook-example.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 88765b5..a8d3bae 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -68,7 +68,7 @@ function info {
 # - Branches should only be fast-forwarded.
 case "$1" in
   refs/tags/*)
-    [ -f "$GIT_DIR/$1" ] &&
+    git rev-parse --verify -q "$1" &&
     deny >/dev/null "You can't overwrite an existing tag"
     ;;
   refs/heads/*)
-- 
1.5.6
