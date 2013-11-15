From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/6] t6300 (for-each-ref): don't hardcode SHA-1 hexes
Date: Fri, 15 Nov 2013 16:29:04 +0530
Message-ID: <1384513148-22633-3-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHG3-0007F8-5U
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758311Ab3KOLIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:12 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64042 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758274Ab3KOLIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:06 -0500
Received: by mail-pb0-f50.google.com with SMTP id xb12so3410438pbc.23
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7LtfBSpJO7h9gtqrG/b1KK4J+s9rbCMUi/SRPzX+YZ4=;
        b=xspNyprcNBM8SBRLUrURskSekyhXterfxc8f01Czx7l59/q9HqAtswiWUNPhQJ0jU6
         Gt73PNQmuc+n0YXNn4LqoarRwgfFROgqV2flqWnNdTiEZXM6h2OWlM+7IuwZOM8K5jOZ
         vKL1i1idNnjo4T35fRVyz2VprZ4qfHdu2egsVCOyFBpu+3m7yGs8wn4q+Cz9pWg1uRJC
         bOSXCaci+lzD/QogobF8ljKm98U8y0lx+uYeVpwnLOqkafBUZr1rInLKpzl1wuBah064
         XQsXa0Lw6E5Pd5O5aFn/ptQWjN+sM3G/OXa3OWOZ1l8SggbWRXWYufO/Rola5a78rJc2
         ToDA==
X-Received: by 10.66.161.194 with SMTP id xu2mr6316947pab.120.1384513685760;
        Fri, 15 Nov 2013 03:08:05 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:05 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237901>

Use rev-parse in its place, making it easier for future patches to
modify the test script.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6300-for-each-ref.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 72d282f..e1f71ff 100755
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
1.8.5.rc0.6.gfd75b41
