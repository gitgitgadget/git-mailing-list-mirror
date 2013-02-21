From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/4] difftool: silence uninitialized variable warning
Date: Wed, 20 Feb 2013 20:03:45 -0800
Message-ID: <1361419428-22410-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 05:04:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8NOP-0000UR-00
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 05:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab3BUEDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 23:03:55 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51773 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3BUEDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 23:03:54 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so3271952pbb.18
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 20:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=DF/SCestHlPRqml+gjzEiZmFCm2n2+eKIzbb0aeU5D8=;
        b=NEcGLC17/EDQI4bV+DX6ofjtnjAP7jY6xWc70T87xLAEqnG/Kokb2JmrrxLHadQanc
         wmBF2G9+aqTfR+5Kukw3JMipKvTUFPVNSK7wNiTtT4wYgh/rVkn/cUYk930iA/mEPluk
         GB+QHU+2YxHnYWmBQV0gqfgNyFVN7F6iJitedieO2KeAK/wzMPdGPmpmWZatNM2cbrrN
         3AR+KECPGI1fh+nlOF4biFOAqgJGZKsLZBwgSlMsU0+V1UTm+mCF4UUY6T48ipN8qlXh
         igGTJfq6gxnajrbljhz0hkXs8LoMJyPINh6whHCffIZgQyBfN0KJGNGwYatcB6hR1UcI
         BiFA==
X-Received: by 10.66.76.41 with SMTP id h9mr57716199paw.1.1361419433667;
        Wed, 20 Feb 2013 20:03:53 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id qp13sm23808911pbb.3.2013.02.20.20.03.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 20:03:52 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216746>

Git::config() returns `undef` when given keys that do not exist.
Check that the $guitool value is defined to prevent a noisy
"Use of uninitialized variable $guitool in length" warning.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged since v1.

 git-difftool.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 0a90de4..12231fb 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -336,7 +336,7 @@ sub main
 	}
 	if ($opts{gui}) {
 		my $guitool = Git::config('diff.guitool');
-		if (length($guitool) > 0) {
+		if (defined($guitool) && length($guitool) > 0) {
 			$ENV{GIT_DIFF_TOOL} = $guitool;
 		}
 	}
-- 
1.8.2.rc0.20.gf548dd7
