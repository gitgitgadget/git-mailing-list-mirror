From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 1/2] t4205, t6006: Add failing tests for the case when i18n.logOutputEncoding is set
Date: Fri, 16 May 2014 19:40:32 +0400
Message-ID: <c4c360c3e6760128ae1326b7463da7130b01a7e9.1400254654.git.Alex.Crezoff@gmail.com>
References: <cover.1400254654.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:41:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlKFu-00020C-3i
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbaEPPlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 11:41:00 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35116 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbaEPPk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:40:59 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so2063103lbg.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Jtp53XdI899MaQ7QMKAVn4A0PKU3US3Gn7BwlR2rCkE=;
        b=npuadM2D99aPAJdUHQOWh3qSSzpFE0hbqYdDpEyVmCXp7jGyIxL+WTCgfGoGKdYD5v
         EHJO6pbKAI780X4Srwy2V9gLHxXix/9MKSwA+gl+60AXPNqwzsVCC9yFDd+yr0IKnsct
         9ZUIK/EE5ce5+l/uUdP5/EvnOnL+2l2UsZDDK8LXxcg6/j20jXhKbhSbVX+YSDTPd8pZ
         YX8uNVNlUDgDHWo7qJt6QUkuPRZ4LL0FnMloLcZqd4kP/aBKbXWZ5jZnFfGL6nMlIfcw
         ytoefWnKI2qCxcavPjurZ8Uec36JrPum2nsq+OZ8nKUQXVWsY+NlBr5HODDViVHraKFD
         o9IA==
X-Received: by 10.152.6.194 with SMTP id d2mr2324915laa.54.1400254858011;
        Fri, 16 May 2014 08:40:58 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id w5sm9877219law.14.2014.05.16.08.40.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 08:40:57 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <cover.1400254654.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400254654.git.Alex.Crezoff@gmail.com>
References: <CACsJy8B20XMiNqtG9c-cLERd8-zahcvWU=UnY80ZJUmLD91ZKg@mail.gmail.com> <cover.1400254654.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249351>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

There were no breakages as far as were no tests for the case
when both a commit message and logOutputEncoding are not UTF-8.

Add failing tests for that which will be fixed in the next patch.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
 t/t4205-log-pretty-formats.sh | 169 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t6006-rev-list-format.sh    |  75 ++++++++++++++++++-
 2 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 2a6278b..6791e0d 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -153,6 +153,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting. i18n.logOutputEncoding=
' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(4=
0)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two                            Z
+message one                            Z
+add bar                                Z
+$(commit_msg)                    Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty=3D"format:%h %<|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -166,6 +179,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting at the nth column. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%h %=
<|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1 message two                    Z
+$head2 message one                    Z
+$head3 add bar                        Z
+$head4 $(commit_msg)            Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty=3D"format:%<(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -179,6 +205,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'left alignment formatting with no padding. i18n.l=
ogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty=3D"format:%<(10,trunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -192,6 +231,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,trunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message ..
+message ..
+add bar  Z
+initial...
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty=3D"format:%<(10,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -205,6 +257,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,ltrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+..sage two
+..sage one
+add bar  Z
+..${sample_utf8_part}lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty=3D"format:%<(10,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
@@ -218,6 +283,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,mtrunc)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+mess.. two
+mess.. one
+add bar  Z
+init..lich
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting' '
 	git log --pretty=3D"format:%>(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -231,6 +309,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting. i18n.logOutputEncodin=
g' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%>(4=
0)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+Z                            message two
+Z                            message one
+Z                                add bar
+Z                    $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty=3D"format:%h %>|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -244,6 +335,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting at the nth column. i18=
n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%h %=
>|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1                      message two
+$head2                      message one
+$head3                          add bar
+$head4              $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty=3D"format:%>(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -257,6 +361,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'right alignment formatting with no padding. i18n.=
logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%>(1=
)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting' '
 	git log --pretty=3D"format:%><(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -270,6 +387,18 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting. i18n.logOutputEncodi=
ng' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%><(=
40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+Z             message two              Z
+Z             message one              Z
+Z               add bar                Z
+Z         $(commit_msg)          Z
+EOF
+	test_cmp expected actual
+'
 test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty=3D"format:%h %><|(40)%s" >actual &&
 	# complete the incomplete line at the end
@@ -283,6 +412,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting at the nth column. i1=
8n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%h %=
><|(40)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+$head1           message two          Z
+$head2           message one          Z
+$head3             add bar            Z
+$head4       $(commit_msg)      Z
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty=3D"format:%><(1)%s" >actual &&
 	# complete the incomplete line at the end
@@ -296,6 +438,19 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'center alignment formatting with no padding. i18n=
=2ElogOutputEncoding' '
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%><(=
1)%s" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+message two
+message one
+add bar
+$(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &=
&
 	git log --pretty=3D"format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual =
&&
@@ -310,6 +465,20 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+	git commit --amend -m short --author "long long long <long@me.com>" &=
&
+	git -c i18n.logOutputEncoding=3Diso8859-1 log --pretty=3D"format:%<(1=
0,trunc)%s%>>(10,ltrunc)% an" >actual &&
+	# complete the incomplete line at the end
+	echo >>actual &&
+	cat <<EOF | iconv -f utf-8 -t iso8859-1 >expected &&
+short long  long long
+message ..   A U Thor
+add bar      A U Thor
+initial...   A U Thor
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
 	git tag -a tag2 -m tag2 tag1 &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9874403..09cdf24 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -12,12 +12,22 @@ test_tick
 # String "added" in German
 # (translated with Google Translate),
 # encoded in UTF-8, used as a commit log message below.
-added=3D$(printf "added (hinzugef\303\274gt) foo")
+added_utf8_part=3D$(printf "\303\274")
+added_utf8_part_iso88591=3D$(echo "$added_utf8_part" | iconv -f utf-8 =
-t iso8859-1)
+added=3D$(printf "added (hinzugef${added_utf8_part}gt) foo")
 added_iso88591=3D$(echo "$added" | iconv -f utf-8 -t iso8859-1)
 # same but "changed"
-changed=3D$(printf "changed (ge\303\244ndert) foo")
+changed_utf8_part=3D$(printf "\303\244")
+changed_utf8_part_iso88591=3D$(echo "$changed_utf8_part" | iconv -f ut=
f-8 -t iso8859-1)
+changed=3D$(printf "changed (ge${changed_utf8_part}ndert) foo")
 changed_iso88591=3D$(echo "$changed" | iconv -f utf-8 -t iso8859-1)
=20
+# count of char to truncate
+# numbers is chosen so, that non-ACSII characters
+# (see $added_utf8_part and $changed_utf8_part)
+# fall into truncated parts of appropriate words both from left and ri=
ght
+truncate_count=3D20
+
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
@@ -136,6 +146,13 @@ commit $head1
 $added
 EOF
=20
+test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
 test_format body %b <<EOF
 commit $head2
 commit $head1
@@ -239,6 +256,33 @@ commit $head1
 $added_iso88591
 EOF
=20
+test_format complex-subject-trunc %<($truncate_count,trunc)%s failure =
<<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part_iso88591}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part_iso88591}gt..
+EOF
+
+test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s failur=
e <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part_iso88591}gt) foo
+EOF
+
+test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s failur=
e <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part_iso88591}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part_iso88591}gt) foo
+EOF
+
 test_expect_success 'prepare expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
@@ -267,6 +311,33 @@ commit $head1
 $added
 EOF
=20
+test_format complex-subject-commitencoding-unset-trunc %<($truncate_co=
unt,trunc)%s <<EOF
+commit $head3
+Test printing of c..
+commit $head2
+changed (ge${changed_utf8_part}ndert)..
+commit $head1
+added (hinzugef${added_utf8_part}gt..
+EOF
+
+test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_c=
ount,mtrunc)%s <<EOF
+commit $head3
+Test prin..ex bodies
+commit $head2
+changed (..dert) foo
+commit $head1
+added (hi..f${added_utf8_part}gt) foo
+EOF
+
+test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_c=
ount,ltrunc)%s <<EOF
+commit $head3
+.. of complex bodies
+commit $head2
+..ged (ge${changed_utf8_part}ndert) foo
+commit $head1
+.. (hinzugef${added_utf8_part}gt) foo
+EOF
+
 test_format complex-body-commitencoding-unset %b <expected.utf-8
=20
 test_expect_success '%x00 shows NUL' '
--=20
1.9.2-17
