From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 17:26:46 +0900
Message-ID: <20090123172646.6117@nanako3.lavabit.com>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org>
 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
 <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
 <20090123094529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQHS8-0006f7-9R
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZAWI12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 03:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZAWI11
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:27:27 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52083 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbZAWI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:27:26 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id C85F4C8898;
	Fri, 23 Jan 2009 02:27:25 -0600 (CST)
Received: from 8620.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id P9WDIFBZTHR3; Fri, 23 Jan 2009 02:27:25 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=S896scUtnqmcr+0Q4yrQRHV2b18Pk28u8wl9n12v5oDXBseWERpBpIOLnThrS+Lb/+zluBU2F/a+a/niI2oFnIKwB/l0QpdarqY95HXx/QMapCqBiSEqsJEOkJAx0NrGZucmAIW1rddk2O3tTNpTDzHSKuxzH1Ig7KCJe/48jvM=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vwscm1nic.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106856>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>:
>>
>>> Perhaps something like this totally untested patch.
>>
>> You have test scripts already, but you say it is untested?
>
> Correct.  I did not run that new test, let alone existing ones ;-)

I applied your patch and run the test suite, including the new one, and=
 they passed.

I tried to write a new option I said that I wanted in my previous messa=
ge.  Here is a patch.

--->8---
Subject: [PATCH] git-am: Add --ignore-date option

This new option makes the command ignore the date header field recorded=
 in
the format-patch output.  The commits will have the timestamp when they
are created instead.

You can work a lot in one day to accumulate many changes, but apply and
push to the public repository only some of them at the end of the first
day.  Then next day you can spend all your working hours reading comics=
 or
chatting with your coworkers, and apply your remaining patches from the
previous day using this option to pretend that you have been working at
the end of the day.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 git-am.sh     |   12 +++++++++++-
 t/t4150-am.sh |    9 +++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e96071d..eb88d90 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -24,6 +24,7 @@ r,resolved      to be used after a patch failure
 skip            skip the current patch
 abort           restore the original branch and abort the patching ope=
ration.
 committer-date-is-author-date    lie about committer date
+ignore-date     use current timestamp for author date
 rebasing        (internal use for git-rebase)"
=20
 . git-sh-setup
@@ -135,6 +136,7 @@ sign=3D utf8=3Dt keep=3D skip=3D interactive=3D res=
olved=3D rebasing=3D abort=3D
 resolvemsg=3D resume=3D
 git_apply_opt=3D
 committer_date_is_author_date=3D
+ignore_date=3D
=20
 while test $# !=3D 0
 do
@@ -172,6 +174,8 @@ do
 		git_apply_opt=3D"$git_apply_opt $(sq "$1$2")"; shift ;;
 	--committer-date-is-author-date)
 		committer_date_is_author_date=3Dt ;;
+	--ignore-date)
+		ignore_date=3Dt ;;
 	--)
 		shift; break ;;
 	*)
@@ -379,7 +383,13 @@ do
=20
 	GIT_AUTHOR_NAME=3D"$(sed -n '/^Author/ s/Author: //p' "$dotest/info")=
"
 	GIT_AUTHOR_EMAIL=3D"$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE=3D"$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	case "$ignore_date" in
+	    t)
+		GIT_AUTHOR_DATE=3D"$(date -R)"
+		;;
+	    '')
+		GIT_AUTHOR_DATE=3D"$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	esac
=20
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8d3fb00..5ecf456 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -277,4 +277,13 @@ test_expect_success 'am without --committer-date-i=
s-author-date' '
 	test "$at" !=3D "$ct"
 '
=20
+test_expect_success 'am --ignore-date' '
+	git checkout first &&
+	test_tick &&
+	git am --ignore-date patch1 &&
+	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	echo "$at" | grep "+0000"
+'
+
 test_done
--=20
1.6.1.224.gb56c7

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
