From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] t4014-format-patch: Call test_tick before committing
Date: Sat, 28 Aug 2010 01:58:15 +0530
Message-ID: <1282940896-18350-2-git-send-email-artagnon@gmail.com>
References: <1282940896-18350-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op5ZE-0001vz-5K
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab0H0UaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:30:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58803 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0H0UaU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:30:20 -0400
Received: by mail-yx0-f174.google.com with SMTP id 6so1264295yxg.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2Wlzjx+0cNgAmY6Lfnm1oJjzYW+sDMrY/UdQsbWfibw=;
        b=clMSnIPO8qeiazufnBn7Wohbb8wgkTbAMKxmlJKjaquy3OVzhhmoPldifJEXi1v/OF
         j6XlDOpPQp06rvFRuddtTiHSTIus5CEonrRZUd+5TaS2duxbTg/6ZazJUQtFhqNP/Jl4
         QRd8f3DSYbwDsgk6+oMT5zIkJ+zp0mJnc2y4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HmjaQKnTHqsJMx++LL5ddz3p1Vl5DSB8rvHwSaSECZIGbZW8Z9B+w+GbvAn3oAgJOY
         fQuv2uNJsB77AqnJtOgj6NuIxMBv6zmCqWUyEXLFuKb81nKfFz/iy1vr8FSVmsoI4Ev1
         yiShQnRwuvB2yYaTGdIpyY6f1mFVXE8JxNQoQ=
Received: by 10.100.196.13 with SMTP id t13mr1526298anf.65.1282941020470;
        Fri, 27 Aug 2010 13:30:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e18sm3996898ana.15.2010.08.27.13.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 13:30:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282940896-18350-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154617>

Call test_tick before attempting to commit in the setup routine to
preserve the order of the commits.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4014-format-patch.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f87434b..a77eeed 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -12,24 +12,29 @@ test_expect_success setup '
 	for i in 1 2 3 4 5 6 7 8 9 10; do echo "$i"; done >file &&
 	cat file >elif &&
 	git add file elif &&
+	test_tick &&
 	git commit -m Initial &&
 	git checkout -b side &&
 
 	for i in 1 2 5 6 A B C 7 8 9 10; do echo "$i"; done >file &&
 	test_chmod +x elif &&
+	test_tick &&
 	git commit -m "Side changes #1" &&
 
 	for i in D E F; do echo "$i"; done >>file &&
 	git update-index file &&
+	test_tick &&
 	git commit -m "Side changes #2" &&
 	git tag C2 &&
 
 	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >file &&
 	git update-index file &&
+	test_tick &&
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
 	git checkout master &&
 	git diff-tree -p C2 | git apply --index &&
+	test_tick &&
 	git commit -m "Master accepts moral equivalent of #2"
 
 '
-- 
1.7.2.2.409.gdbb11.dirty
