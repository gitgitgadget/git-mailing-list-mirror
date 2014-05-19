From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v3 5/5] pretty.c: format string with truncate respects logOutputEncoding
Date: Mon, 19 May 2014 19:28:20 +0400
Message-ID: <8dbe3506315942709627102c133d555139ac68af.1400513063.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 17:29:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPV1-0004b3-W5
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbaESP3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 11:29:08 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65312 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbaESP3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:29:06 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so4107079lbj.24
        for <git@vger.kernel.org>; Mon, 19 May 2014 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=O8NtfHdXGT2UfEth+bADPPoNjFL/Mf8Dzco4MGKRQpw=;
        b=Hi50h4zxL+448vM029tfxzbl5xKXQasHiRxK04xxA9t4KRQsUkS+3kvL2LjcVKFrgR
         qw2By0O6T0oCyY5Jthq7UoBxwmp/ClNrgA+VyhbFXq822IpuaUNJzk2nBzjW90QO/0O8
         FsGjY1YQiGXx7Kew/1psZtxIhtOqQ8xaDCVwc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=O8NtfHdXGT2UfEth+bADPPoNjFL/Mf8Dzco4MGKRQpw=;
        b=X4oPTU+VhJ71iphHpdqetO3JZ1q75hJw03POhYlL8Dsj7wXOvHtkGto/pWkTwbgX0G
         OCFKLbu/am8JZDReLWol2KD4cTqJzLx4RyriW+3IqxurRqBjS3Ltxdbqk95SGch3gAZK
         CXTS5T+Hqwl2i4iONAIIWRdl6VJbPEPhOy9X79DK6c03CSCFYXWGyHHQnj8UXvF9wid5
         EIU0BqFClvstU4grmlkKfK78Ti+lZVFaQ94fQinNtNI3YWV1gK0nhfGHEq59uVUt+YlO
         4jRSomdo8OrsPZi1wxmVtUnO1XidamQ0+uXcTJHC8sxT8PZfzRSoMhdl/ZJqEzsZ7kKN
         FhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=O8NtfHdXGT2UfEth+bADPPoNjFL/Mf8Dzco4MGKRQpw=;
        b=I1L79PF4RWngI7Nhhqlg2j0HHN6ENNvCZryYKniL4iYTh+FebDBJt/2Eqe8fQAD1wp
         L3FVYT84dOsrB91MCC9r9RqIO4/WHc9raWRkbU00lsCOGYZlmO/33KzzDnuVlQpV+MJU
         E8y7LIH1phXSs4LV/239VQYVdqms0flaR82tO+X8lcpy06AXnodI9TBMyMV5OH9VFrNX
         sLs74wqrVMZQAedtrCmPjRTDhASPMe6NBJPa/C9tzpHd8QldXsu4/dxqrU1ud81f9X5I
         aOXVpfnWP5EotPFEVN4r+kfNbWJvRo82qIYve/sQigcvy1+1d8pQkG2YK/B51E9KfoFu
         bVUw==
X-Gm-Message-State: ALoCoQlw8YR3bxzqKH24xBNAgS59ssZV1VW1H5ZpZ+EcVGzps+0RCEdRj5Zml8zlW82HSAXj93x6
X-Received: by 10.112.13.72 with SMTP id f8mr25803726lbc.40.1400513344451;
        Mon, 19 May 2014 08:29:04 -0700 (PDT)
Received: from localhost (ppp91-77-214-38.pppoe.mtu-net.ru. [91.77.214.38])
        by mx.google.com with ESMTPSA id eo12sm18031725lbb.13.2014.05.19.08.29.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 May 2014 08:29:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400513063.git.Alex.Crezoff@gmail.com>
References: <xmqqfvk9a797.fsf@gitster.dls.corp.google.com> <cover.1400513063.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249588>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

In 7e77df3 (pretty: two phase conversion for non utf-8 commits, 2013-04=
-19)
'format_commit_item' function assumes commit message to be in UTF-8.
And that was so until ecaee80 (pretty: --format output should honor
logOutputEncoding, 2013-06-26) where conversion to logOutputEncoding wa=
s
added before calling 'format_commit_message'.

Correct this by converting a commit message to UTF-8 first (as it
assumed in 7e77df3 (pretty: two phase conversion for non utf-8 commits,
2013-04-19)). Only after that convert a commit message to an actual
logOutputEncoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
 pretty.c                      | 7 ++++++-
 t/t4205-log-pretty-formats.sh | 8 ++++----
 t/t6006-rev-list-format.sh    | 6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6e266dd..25e8825 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1507,13 +1507,18 @@ void format_commit_message(const struct commit =
*commit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
+	/*
+	 * convert a commit message to UTF-8 first
+	 * as far as 'format_commit_item' assumes it in UTF-8
+	 */
 	context.message =3D logmsg_reencode(commit,
 					  &context.commit_encoding,
-					  output_enc);
+					  utf8);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
=20
+	/* then convert a commit message to an actual output encoding */
 	if (output_enc) {
 		if (same_encoding(utf8, output_enc))
 			output_enc =3D NULL;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
index 74babce..c84ec9a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -220,7 +220,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
+test_expect_success 'left alignment formatting with trunc. i18n.logOut=
putEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 message ..
@@ -242,7 +242,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with ltrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 ..sage two
@@ -264,7 +264,7 @@ EOF
 	test_cmp expected actual
 '
=20
-test_expect_failure 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
+test_expect_success 'left alignment formatting with mtrunc. i18n.logOu=
tputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 mess.. two
@@ -420,7 +420,7 @@ initial...   A U Thor
 EOF
 	test_cmp expected actual
 '
-test_expect_failure 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
+test_expect_success 'left/right alignment formatting with stealing. i1=
8n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=3D$test_encoding log --pretty=3D"tforma=
t:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
 short long  long long
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a932f34..c6e9a73 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -259,7 +259,7 @@ commit $head1
 $added_iso88591
 EOF
=20
-test_format complex-subject-trunc %<($truncate_count,trunc)%s failure =
<<EOF
+test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -268,7 +268,7 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
=20
-test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s failur=
e <<EOF
+test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -277,7 +277,7 @@ commit $head1
 added (hi..f${added_utf8_part_iso88591}gt) foo
 EOF
=20
-test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s failur=
e <<EOF
+test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
--=20
1.9.2-15
