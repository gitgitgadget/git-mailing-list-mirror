From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/4] difftool: silence uninitialized variable warning
Date: Tue, 19 Feb 2013 21:35:25 -0800
Message-ID: <1361338528-17835-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U82LX-0000sC-2K
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 06:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab3BTFff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 00:35:35 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:53845 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab3BTFfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 00:35:34 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so2657102pbc.24
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 21:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8kSYeB5awJmvJRGKH/uOQ2Ksm5Sg5yTNP4slOKXW5F8=;
        b=L03OToKX4oTalJYbGSHxd9qrZlMhq642I7+kUJkzXkqn3RmeU7UlIQ2k4vM9j/E3yx
         45lcMwOsJQRjEtuU4oQGAKg9rBAKU3bbClyS+suPV1hQ23yLiFi7gTDNkqFqhIC3+1sf
         1bK/nApvnt85adcbE87FUw3LZP0yHfD+4zt35euTu/1eClN9kdTWnTv1mmTB/eZocWtH
         gROi5K1WYmzRsxwHYAjScpUgEOvMIOvf3lQc+ZnvRIZrHcCWWCJhPa8Ometh8C78iquF
         Ddc4ZOlHhEZjk9ixuPPKpA312ynul2a3RMpxWVrksp52W0G1LH3eAsQjW0hrGVWCbK13
         pEkQ==
X-Received: by 10.68.138.197 with SMTP id qs5mr46647842pbb.121.1361338534011;
        Tue, 19 Feb 2013 21:35:34 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id s9sm26625100pav.7.2013.02.19.21.35.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 21:35:32 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216676>

Git::config() returns `undef` when given keys that do not exist.
Check that the $guitool value is defined to prevent a noisy
"Use of uninitialized variable $guitool in length" warning.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Unchanged from last time but included in the series for convenience.

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
