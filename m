From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 2/6] t6300 (for-each-ref): don't hardcode SHA-1 hexes
Date: Mon, 18 Nov 2013 23:09:09 +0530
Message-ID: <1384796353-18701-3-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwF-00046v-D1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab3KRRsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:40 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:58810 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab3KRRsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:37 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so1301224pde.41
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwC4yL6BfqGM6zUD1qh6UZbf6l/KoxR6GH0QVj2nsdk=;
        b=SiZ6+B/i/UEywEtfecH9V396RcLt6GDR837+qV9Q371qIPmRE6Z1nE0EEqp0u2bv9T
         yrqIPoO68tLdCxvHVMNNAQzX7pzG3s8GHQgXbgJHntalPgbN2QQRCwKyD+jYHCZRj4VR
         ZnAjfKIdxyfxFUVtrKHwUhFh+t8aRKLsOz3TmtGS+PjybDmNs0+tsylFgpi63ItowDP5
         E6hkX63VaWak1nyp3l1JbG2PPRps3Btfow7aySrBQwBy46HbvlaLWlw0C00g1rnsHSec
         hEvmImW+s63IJ0UezLg8EYxXl52qbowDuBjHOm43YMb9InelRj9xuh7CTnMuKI49dH1O
         Xaag==
X-Received: by 10.66.136.131 with SMTP id qa3mr22365730pab.77.1384796915943;
        Mon, 18 Nov 2013 09:48:35 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:35 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237997>

Use rev-parse in its place, making it easier for future patches to
modify the test script.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6300-for-each-ref.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 64301e7..675c2a2 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -49,8 +49,8 @@ test_atom head refname refs/heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head objecttype commit
 test_atom head objectsize 171
-test_atom head objectname 67a36f10722846e891fbada1ba48ed035de75581
-test_atom head tree 0e51c00fcb93dffc755546f27593d511e1bdb46f
+test_atom head objectname $(git rev-parse refs/heads/master)
+test_atom head tree $(git rev-parse refs/heads/master^{tree})
 test_atom head parent ''
 test_atom head numparent 0
 test_atom head object ''
@@ -82,11 +82,11 @@ test_atom tag refname refs/tags/testtag
 test_atom tag upstream ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
-test_atom tag objectname 98b46b1d36e5b07909de1b3886224e3e81e87322
+test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag tree ''
 test_atom tag parent ''
 test_atom tag numparent ''
-test_atom tag object '67a36f10722846e891fbada1ba48ed035de75581'
+test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
@@ -302,7 +302,7 @@ test_expect_success 'Check short upstream format' '
 '
 
 cat >expected <<EOF
-67a36f1
+$(git rev-parse --short HEAD)
 EOF
 
 test_expect_success 'Check short objectname format' '
@@ -453,9 +453,9 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
-cat >expected <<\EOF
-408fe76d02a785a006c2e9c669b7be5589ede96d <committer@example.com> refs/tags/master
-90b5ebede4899eda64893bc2a4c8f1d6fb6dfc40 <committer@example.com> refs/tags/bogo
+cat >expected <<EOF
+$(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
+$(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
 EOF
 
 test_expect_success 'Verify sort with multiple keys' '
-- 
1.8.5.rc0.5.g70ebc73.dirty
