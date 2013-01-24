From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
Date: Thu, 24 Jan 2013 13:10:25 +0400
Message-ID: <cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 10:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyIqF-0002p5-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 10:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab3AXJLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 04:11:01 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:33273 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3AXJK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 04:10:57 -0500
Received: by mail-la0-f45.google.com with SMTP id er20so4374963lab.32
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 01:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=W5GcspYS+rONPGp61Il7lSbUMdcuUABhmgNzOiBwqyg=;
        b=SWGIK3lsyWG5pms4ghhP9I0i/bGGzyTbmtZPZiMneknXmpxGYYqfHAVXxOQiZ1lBfj
         NgivdvFE737BqPy6CbMzrzmwmrvSnHXhKJRloRhtErJvr9DcPoe4L7h6rPQLYWKp6ShI
         pjMOREFhkymkQrzlQ8upYbiQYfwr6HfO7q8/XztRiQstS/25wsoytOCWADYF4bVCyxBt
         hhEFx/nDpPsy52+Pq14LhLUyZ8WugmtxxRJclxEk9DaO36MFdZj0FVO0AJzf8lmYRWa0
         hm7vFU0/kTE6+FYjjPDNTqMyNIhCxoE1sQ9U5T4Ntpeprh7796o/3UBjD5Mjvd4sErIq
         4vbg==
X-Received: by 10.152.132.137 with SMTP id ou9mr1170766lab.7.1359018656084;
        Thu, 24 Jan 2013 01:10:56 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id j9sm8776515lbd.13.2013.01.24.01.10.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 01:10:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 4EA58600CC;
	Thu, 24 Jan 2013 13:11:35 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1359018188.git.Alex.Crezoff@gmail.com>
References: <20110921004602.3d59bed4@zappedws> <cover.1359018188.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214420>

The expected SHA-1 digests are always available in variables.  Use
them instead of hardcoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t6006-rev-list-format.sh | 130 +++++++++++++++++++++++++------------=
--------
 1 file changed, 72 insertions(+), 58 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f94f0c4..c248509 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -6,8 +6,19 @@ test_description=3D'git rev-list --pretty=3Dformat tes=
t'
=20
 test_tick
 test_expect_success 'setup' '
-touch foo && git add foo && git commit -m "added foo" &&
-  echo changed >foo && git commit -a -m "changed foo"
+	touch foo &&
+	git add foo &&
+	git commit -m "added foo" &&
+	head1=3D$(git rev-parse --verify HEAD) &&
+	head1_7=3D$(echo $head1 | cut -c1-7) &&
+	echo changed >foo &&
+	git commit -a -m "changed foo" &&
+	head2=3D$(git rev-parse --verify HEAD) &&
+	head2_7=3D$(echo $head2 | cut -c1-7) &&
+	head2_parent=3D$(git cat-file -p HEAD | grep parent | cut -f 2 -d" ")=
 &&
+	head2_parent_7=3D$(echo $head2_parent | cut -c1-7) &&
+	tree2=3D$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ") &&
+	tree2_7=3D$(echo $tree2 | cut -c1-7)
 '
=20
 # usage: test_format name format_string <expected_output
@@ -19,49 +30,49 @@ test_cmp expect.$1 output.$1
 "
 }
=20
-test_format percent %%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format percent %%h <<EOF
+commit $head2
 %h
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 %h
 EOF
=20
-test_format hash %H%n%h <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-131a310eb913d107dd3c09a65d1651175898735d
-131a310
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
+test_format hash %H%n%h <<EOF
+commit $head2
+$head2
+$head2_7
+commit $head1
+$head1
+$head1_7
 EOF
=20
-test_format tree %T%n%t <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-fe722612f26da5064c32ca3843aa154bdb0b08a0
-fe72261
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format tree %T%n%t <<EOF
+commit $head2
+$tree2
+$tree2_7
+commit $head1
 4d5fcadc293a348e88f777dc0920f11e7d71441c
 4d5fcad
 EOF
=20
-test_format parents %P%n%p <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-86c75cf
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format parents %P%n%p <<EOF
+commit $head2
+$head1
+$head2_parent_7
+commit $head1
=20
=20
 EOF
=20
 # we don't test relative here
-test_format author %an%n%ae%n%ad%n%aD%n%at <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format author %an%n%ae%n%ad%n%aD%n%at <<EOF
+commit $head2
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 A U Thor
 author@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -69,14 +80,14 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format committer %cn%n%ce%n%cd%n%cD%n%ct <<EOF
+commit $head2
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
 Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 C O Mitter
 committer@example.com
 Thu Apr 7 15:13:13 2005 -0700
@@ -84,21 +95,21 @@ Thu, 7 Apr 2005 15:13:13 -0700
 1112911993
 EOF
=20
-test_format encoding %e <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format encoding %e <<EOF
+commit $head2
+commit $head1
 EOF
=20
-test_format subject %s <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format subject %s <<EOF
+commit $head2
 changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 added foo
 EOF
=20
-test_format body %b <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+test_format body %b <<EOF
+commit $head2
+commit $head1
 EOF
=20
 test_format raw-body %B <<'EOF'
@@ -110,17 +121,17 @@ added foo
=20
 EOF
=20
-test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<EOF
+commit $head2
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
 EOF
=20
-test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<'EOF'
-commit 131a310eb913d107dd3c09a65d1651175898735d
+test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<EOF
+commit $head2
 =1B[1;31;43mfoo=1B[m
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 =1B[1;31;43mfoo=1B[m
 EOF
=20
@@ -131,39 +142,42 @@ This commit message is much longer than the other=
s,
 and it will be encoded in iso8859-1. We should therefore
 include an iso8859 character: =C2=A1bueno!
 EOF
+
 test_expect_success 'setup complex body' '
-git config i18n.commitencoding iso8859-1 &&
-  echo change2 >foo && git commit -a -F commit-msg
+	git config i18n.commitencoding iso8859-1 &&
+	echo change2 >foo && git commit -a -F commit-msg &&
+	head3=3D$(git rev-parse --verify HEAD) &&
+	head3_7=3D$(echo $head3 | cut -c1-7)
 '
=20
-test_format complex-encoding %e <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+test_format complex-encoding %e <<EOF
+commit $head3
 iso8859-1
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head2
+commit $head1
 EOF
=20
-test_format complex-subject %s <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+test_format complex-subject %s <<EOF
+commit $head3
 Test printing of complex bodies
-commit 131a310eb913d107dd3c09a65d1651175898735d
+commit $head2
 changed foo
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head1
 added foo
 EOF
=20
-test_format complex-body %b <<'EOF'
-commit f58db70b055c5718631e5c61528b28b12090cdea
+test_format complex-body %b <<EOF
+commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
 include an iso8859 character: =C2=A1bueno!
=20
-commit 131a310eb913d107dd3c09a65d1651175898735d
-commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+commit $head2
+commit $head1
 EOF
=20
 test_expect_success '%x00 shows NUL' '
-	echo  >expect commit f58db70b055c5718631e5c61528b28b12090cdea &&
+	echo  >expect commit $head3 &&
 	echo >>expect fooQbar &&
 	git rev-list -1 --format=3Dfoo%x00bar HEAD >actual.nul &&
 	nul_to_q <actual.nul >actual &&
--=20
1.8.1.1.10.g9255f3f
