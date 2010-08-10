From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] git-notes: Run partial expensive test everywhere
Date: Tue, 10 Aug 2010 23:37:48 +0000
Message-ID: <1281483468-24388-1-git-send-email-avarab@gmail.com>
References: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 01:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiyOo-0007sb-3h
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 01:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991Ab0HJXiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 19:38:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46519 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0HJXiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 19:38:11 -0400
Received: by wyb32 with SMTP id 32so1247212wyb.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=B/9OMYMljO1ZDL3pYJaLe5DBLUBfpCro5h/pEcHyxaE=;
        b=MnItUlMqx0p+hUcAIgcVzqwjDS0J/XRfmgVvx0y+Rv9cAnF2nbtZOt0K8SoGTejGp1
         ngoSsir/SNiNMzicYPBjfay0bb93exV2pIFyv4HMPf8PHLahpzZyNMKHWbIFp9WXuzjh
         M/cVltlwY5JiLDRo/hg6gesYvQ3axepfxDRWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ubQEaiYLCrCu7LJ/uDWDFfZvB3qopAVve5fDO83HqLMqBnMybTf27mMW3aaSY9JkiS
         B2MyZrL1iifnrIpAks08wEUnxM+G4Ceh2plqMKvUYllbgaf55CaLalIZEQ4PjGqVaL/5
         IilrRjDxTK+nUfN5cwMGNe/LleH6eLVTO7sf8=
Received: by 10.227.134.210 with SMTP id k18mr15764566wbt.160.1281483489636;
        Tue, 10 Aug 2010 16:38:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm5998659wbb.8.2010.08.10.16.38.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 16:38:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153174>

The git-notes expensive timing test is only expensive because it
either did 10,100,1k and 10k iterations or nothing.

Change it to do 10 by default, with an option to run the expensive
version with the old GIT_NOTES_TIMING_TESTS=3DZomgYesPlease variable.

Since nobody was ostensibly running this test under TAP the code had
bitrotted so that it emitted invalid TAP. This change fixes that.

The old version would also mysteriously fail on systems without
/usr/bin/time, there's now a check for that using the multiple test
prerequisite facility.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Tue, Aug 10, 2010 at 21:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Tue, Aug 10, 2010 at 19:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> + =C2=A0 =C2=A0 =C2=A0 # Hack around multiple test prerequisites not=
 supporting AND-ing
>> + =C2=A0 =C2=A0 =C2=A0 # of terms
>> + =C2=A0 =C2=A0 =C2=A0 test_set_prereq USR_BIN_TIME+NOT_EXPENSIVE
>> + =C2=A0 =C2=A0 =C2=A0 test_have_prereq EXPENSIVE && test_set_prereq=
 USR_BIN_TIME+EXPENSIVE
>> +fi
>
> In retrospect this may have been some brainfried code, I'll check it
> out tomorrow.

Here's a patch that's not crazy. In v1 I was hacking around not having
a facility I already added to the test-lib (tired).

This patch goes on top of my "test-lib: Multi-prereq support only
checked the last prereq" patch, which fixes up the test prereq
facility so that it actually works.

 t/t3302-notes-index-expensive.sh |   32 ++++++++++++++++++++----------=
--
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-exp=
ensive.sh
index 361a10a..7c08e99 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -7,11 +7,9 @@ test_description=3D'Test commit notes index (expensive=
!)'
=20
 . ./test-lib.sh
=20
-test -z "$GIT_NOTES_TIMING_TESTS" && {
-	skip_all=3D"Skipping timing tests"
-	test_done
-	exit
-}
+test_set_prereq NOT_EXPENSIVE
+test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
+test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
=20
 create_repo () {
 	number_of_commits=3D$1
@@ -102,17 +100,27 @@ time_notes () {
 	done
 }
=20
-for count in 10 100 1000 10000; do
+do_tests () {
+	pr=3D$1
+	count=3D$2
+
+	test_expect_success $pr 'setup / mkdir' '
+		mkdir $count &&
+		cd $count
+	'
=20
-	mkdir $count
-	(cd $count;
+	test_expect_success $pr "setup $count" "create_repo $count"
=20
-	test_expect_success "setup $count" "create_repo $count"
+	test_expect_success $pr 'notes work' "test_notes $count"
=20
-	test_expect_success 'notes work' "test_notes $count"
+	test_expect_success USR_BIN_TIME,$pr 'notes timing with /usr/bin/time=
' "time_notes 100"
+
+	test_expect_success $pr 'teardown / cd ..' 'cd ..'
+}
=20
-	test_expect_success 'notes timing' "time_notes 100"
-	)
+do_tests NOT_EXPENSIVE 10
+for count in 100 1000 10000; do
+	do_tests EXPENSIVE $count
 done
=20
 test_done
--=20
1.7.2.1.295.gd03d
