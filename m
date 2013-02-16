From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/4] difftool: silence uninitialized variable warning
Date: Fri, 15 Feb 2013 21:47:43 -0800
Message-ID: <1360993666-81308-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 06:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6adG-0001dB-D7
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 06:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab3BPFry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 00:47:54 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:43371 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3BPFrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 00:47:53 -0500
Received: by mail-ia0-f177.google.com with SMTP id k38so3784992iah.8
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jQo8V6RWm3pFuyjGOO8GuZ7hGqEoE72fSUHy+w3OGrY=;
        b=nCsz8WP2v0/JS5rtGTNw7lYOom7dAXIzY58nl0ylWfzkILE7en+oVBmaCwbpniBwbM
         8JJrWrGdsBNljYYSYPjD8KLG4TFEECsjHC4NyCpXh5CQG9zf97T3oeE6zzW1+rdrLqRf
         HQc8nLfgr5oMJuIlg5N+jzgM3WSWSt0UAMyavGoIrzSPZUZFWZBGOQHmVbsGlnrevKLF
         XmekY5uwmkfSpuVArRg9q4kByEzcKOWJsHJsTV7abjY4bm/4eH6jYnSDL2+3AhgoeTqy
         ItrHoOsVfgW6tn0mnMwztK982a+qCxnHrCJop6xQhW4PGLXnKd/i+ifsHVRYG95+7TFC
         3sjw==
X-Received: by 10.50.157.138 with SMTP id wm10mr1521859igb.103.1360993672704;
        Fri, 15 Feb 2013 21:47:52 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id z1sm6255743igc.1.2013.02.15.21.47.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 21:47:51 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.623.g622c8fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216372>

Git::config() returns `undef` when given keys that do not exist.
Check that the $guitool value is defined to prevent a noisy
"Use of uninitialized variable $guitool in length" warning.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
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
1.8.1.3.623.g622c8fc
