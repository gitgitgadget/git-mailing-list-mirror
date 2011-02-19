From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t7500-commit.sh: use test_cmp instead of test
Date: Sat, 19 Feb 2011 18:29:09 +0000
Message-ID: <1298140149-13652-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 19:29:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqrYq-0005Uy-9p
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 19:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab1BSS3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 13:29:35 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61658 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab1BSS3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 13:29:34 -0500
Received: by ewy5 with SMTP id 5so1959918ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=BWtg4eLakwjt3dNKlh+kWODV+L2rnPwcZDf39qSWEao=;
        b=YW5c+cesre+QY+rofom+AlWmIuBa5JnfEk3aRP4iGwDfnxXGVJWu4jHSSoaEzpm3s0
         myx2+oxs4Bu9IuBZqy8NS9V/66/yjRc6mZ62sX8KJKWBtB80oFI5nUSUJOo2uRsRwdXr
         r9cZFG4mKruvZqVkih9gz2LLBgMt20vbwEDm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Kqhu/gNig+fugB/qwM402tjwQzreYTfmYQrzMEmLiwvyP5xWS3Virpw/nJkqor1tEP
         ApVPJBUU1CQreRgj+KOQ3iIhfpj3pgX1G/35cWVPJZdWUTL94hTgQubvV/dGgDSrJ+A2
         ejCB5sBs92Xu8yMXzqHoIWdqMwOsOY6aZA5c8=
Received: by 10.14.48.71 with SMTP id u47mr2379998eeb.44.1298140172923;
        Sat, 19 Feb 2011 10:29:32 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id u1sm3157398eeh.22.2011.02.19.10.29.32
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 10:29:32 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167305>

Change commit_msg_is() in t/t7500-commit.sh to use test_cmp instead of
the shell's test function. Now if a test fails we'll get test_cmp
output showing us what failed.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7500-commit.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 162527c..d551b77 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -10,7 +10,12 @@ Tests for selected commit options.'
 . ./test-lib.sh
=20
 commit_msg_is () {
-	test "`git log --pretty=3Dformat:%s%b -1`" =3D "$1"
+	expect=3Dcommit_msg_is.expect
+	actual=3Dcommit_msg_is.actual
+
+	printf "%s" "$(git log --pretty=3Dformat:%s%b -1)" >$expect &&
+	printf "%s" "$1" >$actual &&
+	test_cmp $expect $actual
 }
=20
 # A sanity check to see if commit is working at all.
--=20
1.7.2.3
