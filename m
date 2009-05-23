From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] t/t3400-rebase.sh: add more tests to help migrating git-rebase.sh to C
Date: Sun, 24 May 2009 01:31:02 +1000
Message-ID: <1243092662-19897-1-git-send-email-pclouds@gmail.com>
References: <7vr5yibknm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 04:37:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M83a7-0005wB-Mc
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 04:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbZEXCce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 22:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZEXCcd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 22:32:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:57513 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZEXCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 22:32:32 -0400
Received: by rv-out-0506.google.com with SMTP id f9so818670rvb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=i5DtrpeupH1CMTJjQtAWlvWNs6gmHrc5K2aQr3vq43E=;
        b=GBPNJCTQAyKTA7yFHlHPgq3ZsRtvpRcDVswqS2QdiGQ0ToE+MWBigwRYSIxqqkIvvo
         7BYvGd3WxuvBe4+FG+XLBt7sn2WsPO2OxYn8ZJCyaPVwX8ytQrMpt9p33xg5rJe221SL
         naX+fZzVwV/excMgZEJyMOwlCDpyRifGhq93Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b8pg2IBCNjucEs5eNk5hJEM+XH5ovSZUhoG1L6Nm9/lN5KBDj6AHDt9wgecHyNRWjD
         r5KtABg0JXpisZ2HaV4i9ok2tC1QoGUn0vsbSicZVnd1SPZ8nZW35ZyaqSmi/H8n+TsD
         S4pirGq38KeKqRz35pxVqILnS+pU3YRCbYo3U=
Received: by 10.140.139.4 with SMTP id m4mr2164715rvd.213.1243132354194;
        Sat, 23 May 2009 19:32:34 -0700 (PDT)
Received: from dektop ([121.91.81.118])
        by mx.google.com with ESMTPS id f21sm14802042rvb.55.2009.05.23.19.32.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 19:32:33 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun, 24 May 2009 01:31:03 +1000
X-Mailer: git-send-email test
In-Reply-To: <7vr5yibknm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119810>

These new tests make sure I don't miss any check being performed before
rebase is proceeded (which is well tested by other tests)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Fixed pipe stuff, test_must_fail and spaces

 t/t3400-rebase.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6e391a3..7f62bfb 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -41,9 +41,40 @@ test_expect_success \
      git tag topic
 '
=20
+test_expect_success 'rebase on dirty worktree' '
+     echo dirty >> A &&
+     test_must_fail git rebase master'
+
+test_expect_success 'rebase on dirty cache' '
+     git add A &&
+     test_must_fail git rebase master'
+
 test_expect_success 'rebase against master' '
+     git reset --hard HEAD &&
      git rebase master'
=20
+test_expect_success 'rebase against master twice' '
+     git rebase master 2>err &&
+     grep "Current branch my-topic-branch is up to date" err
+'
+
+test_expect_success 'rebase against master twice with --force' '
+     git rebase --force-rebase master >out &&
+     grep "Current branch my-topic-branch is up to date, rebase forced=
" out
+'
+
+test_expect_success 'rebase against master twice from another branch' =
'
+     git checkout my-topic-branch^ &&
+     git rebase master my-topic-branch 2>err &&
+     grep "Current branch my-topic-branch is up to date" err
+'
+
+test_expect_success 'rebase fast-forward to master' '
+     git checkout my-topic-branch^ &&
+     git rebase my-topic-branch 2>err &&
+     grep "Fast-forwarded HEAD to my-topic-branch" err
+'
+
 test_expect_success \
     'the rebase operation should not have destroyed author information=
' \
     '! (git log | grep "Author:" | grep "<>")'
--=20
test
