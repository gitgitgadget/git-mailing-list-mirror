From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] test-lib: Multi-prereq support only checked the last prereq
Date: Wed, 11 Aug 2010 12:04:38 +0000
Message-ID: <1281528278-15659-1-git-send-email-avarab@gmail.com>
References: <20100811014325.GA4169@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 14:05:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjA3G-0005Tk-77
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab0HKMEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 08:04:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37549 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0HKMEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 08:04:51 -0400
Received: by wwj40 with SMTP id 40so14161716wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5JUnsEbkS5dDrZ8D45WR/wRRjXStnD7uuTbpXRxiRsQ=;
        b=GsGNem8fCEFYZHNJODJdi/I7GYDmvowJkmy6sNtrr5aSZNBGFBC9+F9JmYIw5cQnGC
         XHNUHR5efqJVqhUAddNcNo8VKeIIwaH9DcXi5WGlZUjVzGYGnyni+QnZgDAAE5gyUYbm
         dpNMqepyUNgYqqjfEPQqe7ftAuG/350wgFf0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FqAZca7FiXnxDQIEdDUz3+knWwOPficskyYOB/2O9sJuKLM3XECBk0NUwJmukMNk1a
         s/pZc2AhEXExNXtEYo+zrPuGQkbumuoSJHtDzoINsAwFkG8FZX+XE2kl7uVQduQQszzj
         Ng7IvhicJfFkXTp5Q0GfI0UIymHXh947oftgM=
Received: by 10.227.23.193 with SMTP id s1mr16055333wbb.219.1281528290087;
        Wed, 11 Aug 2010 05:04:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm22902wbe.5.2010.08.11.05.04.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 05:04:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <20100811014325.GA4169@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153226>

The support for multiple test prerequisites added by me in "test-lib:
Add support for multiple test prerequisites" was broken.

The for iterated over each prerequisite and returned true/false within
a case statement, but since it missed a return statement only the last
prerequisite in the list of prerequisites was ever considered, the
rest were ignored.

=46ix that by changing the test_have_prereq code to something less
clever that keeps a count of the total prereqs and the ones we have
and compares the count at the end.

This comes with the added advantage that it's easy to list the missing
prerequisites in the test output, implement that while I'm at it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This v2 patch has a new commit message.

On Wed, Aug 11, 2010 at 01:43, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The clever for-loop (which I blindly copied from Junio)
>
> You did not copy his =E2=80=9Creturn=E2=80=9D statement, though. :)

Oops, yeah. I copied it from some mix-match of different
patches. Corrected the patch message for that.

> Wouldn=E2=80=99t
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! : nope ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1 ;;
>
> be simpler?

Yeah, that'd make it work, but I wanted to add something that spewed a
complete listing of missing prereqs for ecah test, bailing out with a
return wouldn't do that.

 t/t0000-basic.sh |    6 +++++-
 t/test-lib.sh    |   21 ++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2887677..9602085 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,7 +84,11 @@ donthaveit=3Dyes
 test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test=
 to be skipped' '
     donthaveit=3Dno
 '
-if test $haveit$donthaveit !=3D yesyes
+donthaveiteither=3Dyes
+test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test=
 to be skipped' '
+    donthaveiteither=3Dno
+'
+if test $haveit$donthaveit$donthaveiteither !=3D yesyesyes
 then
 	say "bug in test framework: multiple prerequisite tags do not work re=
liably"
 	exit 1
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e73fff..8c8e129 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -337,15 +337,30 @@ test_have_prereq () {
 	IFS=3D,
 	set -- $*
 	IFS=3D$save_IFS
+
+	total_prereq=3D0
+	ok_prereq=3D0
+	missing_prereq=3D
+
 	for prerequisite
 	do
+		total_prereq=3D$(($total_prereq + 1))
 		case $satisfied in
 		*" $prerequisite "*)
-			: yes, have it ;;
+			ok_prereq=3D$(($ok_prereq + 1))
+			;;
 		*)
-			! : nope ;;
+			# Keep a list of missing prerequisites
+			if test -z "$missing_prereq"
+			then
+				missing_prereq=3D$prerequisite
+			else
+				missing_prereq=3D"$prerequisite,$missing_prereq"
+			fi
 		esac
 	done
+
+	test $total_prereq =3D $ok_prereq
 }
=20
 # You are not expected to call test_ok_ and test_failure_ directly, us=
e
@@ -408,7 +423,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (prereqs: $prereq)"
+		say_color skip "ok $test_count # skip $1 (missing $missing_prereq of=
 $prereq)"
 		: true
 		;;
 	*)
--=20
1.7.2.1.295.gdf931
