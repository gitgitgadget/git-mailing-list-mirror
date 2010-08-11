From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] git-am: Ignore whitespace before patches
Date: Wed, 11 Aug 2010 19:57:25 +0000
Message-ID: <1281556645-23361-1-git-send-email-avarab@gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHQv-000864-Ez
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab0HKT5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:57:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab0HKT5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:57:38 -0400
Received: by wwj40 with SMTP id 40so541704wwj.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DhVs2FiG3fg+8/0Olinz7P3jiZyCXTaN3SX5LWoDMU4=;
        b=qB6RBPYAtnGLk/ff2GtsfeQdt5OJf022n6h4FZL4yPWObmXJIJ+fabTmkajsvzQShS
         a3B8KN06fS5rOzdPhoclHdPRyM+1A8MEoNF/S9SNREtiXgl6WtsQovk4sUCq6hcwGZ+n
         gzxv2juS6fqjHUvo3BsV05+BHu5OcKBYFDfug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qLav/YS6GPllyu+06o6Qk1q5adjNyefuf+Y2bhx+9QjE69CtI7C7RuibGSAbPVgmTv
         dllgyhA0duM/O7amRNp770uc2UivDaCIBGuEJEihK8xmUgT0uzgyNd01vIMuGQYQ0bFv
         iVYzxidpVw/juG8OEdBuhpIrjqkppyp+ncb+0=
Received: by 10.227.144.206 with SMTP id a14mr17160980wbv.112.1281556655933;
        Wed, 11 Aug 2010 12:57:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm417706wbb.14.2010.08.11.12.57.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:57:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153296>

Change git-am to ignore whitespace (as defined by sh's read) at the
beginning of patches.

This makes git-am work with patches downloaded from the GMail web
interface, here's an example from a raw Gmail attachment produced with
`hexdump -C':

    20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 20  |                =
|
    20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  |               .=
|
    52 65 74 75 72 6e 2d 50  61 74 68 3a 20 3c 61 76  |Return-Path: <av=
|

Having to tell GMail users that they must manually edit their patches
before git-am will accept them (as this article does:
http://evag.evn.am/git/git-and-gmail) isn't optimal.

This change is probably useful for other things than GMail patch
downloads, whitespace is also likely to appear if the user copy/pastes
the patch around, e.g. via a pastebin, or any any number of other
cases. This change harms nothing and makes git-am's detection more
fault tolerant.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I originally sent this on July 8 but it was never picked up. Junio comm=
ented:

>> Whitespace is also likely to appear if the user copy/pastes the patc=
h
>> around, e.g. via a pastebin, or any any number of other cases. This
>> harms nothing and makes git-am's detection more fault tolerant.
>
> Actually cut-and-paste is often a major source of whitespace breakage
> (including tabs silently being expanded), and I personally think a pa=
tch
> like this to encourage the practice is going in a wrong direction.

I disagree and think git-am should be smarter. Any human looking at
something like a GMail mail.txt download will clearly see that it's a
patch, but git-am is pedantic and doesn't skip past whitespace at the
beginning of the file.

I think it should have more smarts and less pedanticness, and I run
into this bug every time I download a patch via GMail.

So please pick it up, thanks.

 git-am.sh     |   16 +++++++++++++++-
 t/t4150-am.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e7f008c..4ed8544 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -173,7 +173,21 @@ check_patch_format () {
 	# otherwise, check the first few lines of the first patch to try
 	# to detect its format
 	{
-		read l1
+		while read -r line
+		do
+			case "$line" in
+				"")
+					# Just skip whitespace
+					continue
+					;;
+				*)
+					# First non-empty line
+					l1=3D$line
+					break
+					;;
+			esac
+		done
+
 		read l2
 		read l3
 		case "$l1" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 810b04b..3d089de 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -318,6 +318,36 @@ test_expect_success 'am without --committer-date-i=
s-author-date' '
 	test "$at" !=3D "$ct"
 '
=20
+test_expect_success 'am applying a patch that begins with an empty lin=
e' '
+	git checkout first &&
+	test_tick &&
+	echo > patch1-white &&
+	cat patch1 >> patch1-white &&
+	git am patch1-white &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" !=3D "$ct"
+'
+
+test_expect_success 'am applying a patch that begins with many empty l=
ines' '
+	git checkout first &&
+	test_tick &&
+	echo "   " > patch1-white2 &&
+	echo "  " >> patch1-white2 &&
+	echo " " >> patch1-white2 &&
+	echo "" >> patch1-white2 &&
+	echo " " >> patch1-white2 &&
+	echo "  " >> patch1-white2 &&
+	echo "   " >> patch1-white2 &&
+	cat patch1 >> patch1-white2 &&
+	git am patch1-white2 &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" !=3D "$ct"
+'
+
 # This checks for +0000 because TZ is set to UTC and that should
 # show up when the current time is used. The date in message is set
 # by test_tick that uses -0700 timezone; if this feature does not
--=20
1.7.2.1.295.gdf931
