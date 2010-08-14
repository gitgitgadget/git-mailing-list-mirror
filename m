From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Fri, 13 Aug 2010 21:27:03 -0500
Message-ID: <20100814022625.GA4199@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <20100812224044.GK2029@burratino>
 <4C65BCD2.6000701@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 04:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok6UH-000351-Nu
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 04:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab0HNC2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 22:28:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52722 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756630Ab0HNC2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 22:28:37 -0400
Received: by gxk23 with SMTP id 23so1212159gxk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QTESHgvlH4fV/xy52NHVmFjOBKba7Lozn9uOju6/KMI=;
        b=dS/Ta850tRZ6p7evD5hZsSkA8rZpd46EN8u2wLhJgIfbUlbr2GCvEiugSzwmDtTc+f
         F0rH+o9G+4a3/a6osafneRaio1ymmVQ18vkD/GlsGKeztmaE9SHqbn4d26BcVtJGhPYi
         uxCUWafPTdj5ZHQ4fvRuk/eFd7CFVARPMgSvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CwmzJrBvMaMTRY6LB6wLIen28+zuvtmcQ7w5NDGYdEL/lxhMEu3s1EjMARCEtiZjmt
         I17O8eGw2AS5BtxOBpHY5wZhu9Lm1b4NGYQNhiRok95AA47BahiKuco07EPKOSfkQAPt
         00EswzerxMAwWht8bx7GcsFFY8Kpw4NgcFo0I=
Received: by 10.101.136.30 with SMTP id o30mr1602150ann.224.1281752916410;
        Fri, 13 Aug 2010 19:28:36 -0700 (PDT)
Received: from burratino ([64.134.175.141])
        by mx.google.com with ESMTPS id t24sm5256353ano.32.2010.08.13.19.28.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 19:28:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C65BCD2.6000701@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153542>

Johannes Sixt wrote:
> Am 13.08.2010 00:40, schrieb Jonathan Nieder:

>> Would this work?
>>
>> -- 8<  --
>> Subject: t4135 (apply): filenames with tabs are not usable on NTFS
[...]
> No, it needs this squashed in

Ah, makes sense.  Here=E2=80=99s another rough patch.  Patch is against
jn/apply-filename-with-sp + ab/test.  Not signed off because I am not
sure about the licensing of expand.sed (and I would rather see some
other fix instead).

-- 8< --
Subject: t4135 (apply): tweaks for Windows

=46ilenames with tabs are not usable on NTFS, so mimic the code setting
up the FUNNYNAMES prerequisite from v1.3.0-rc1~67 (workaround fat/ntfs
deficiences for t3600-rm.sh, 2006-03-03) and use it.  The code is not
shared in test-lib.sh to avoid wasting time on that check while
running other tests.

Backslashes is the path separator on Windows, so it cannot be used
in filenames (see v1.6.3-rc0~93^2~6, t3700: Skip a test with
backslashes in pathspec, 2009-03-13).

=46ilenames starting with a quotation mark do not behave well in msys
(see v1.7.0-rc0~94^2, t4030, t4031: work around bogus MSYS bash path
conversion, 2010-01-01), so skip those tests on Windows.

=E2=80=9Cexpand=E2=80=9D is not available in msysgit.  Use a sed script=
 by Greg Ubben
to replace it.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Not-signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4135-apply-weird-filenames.sh |   70 ++++++++++++++++++++++++++++++=
++------
 1 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-fil=
enames.sh
index f4c7e15..08f8fe2 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -10,7 +10,7 @@ test_expect_success 'setup: empty commit' '
 	git tag preimage
 '
=20
-test_expect_success 'setup: clean-up functions' '
+test_expect_success 'setup: helper functions' '
 	reset_preimage() {
 		git checkout -f preimage^0 &&
 		git read-tree -u --reset HEAD &&
@@ -20,6 +20,44 @@ test_expect_success 'setup: clean-up functions' '
 	reset_subdirs() {
 		rm -fr a b &&
 		mkdir a b
+	} &&
+
+	cat <<-\EOF >expand.sed &&
+	#! /bin/sed -f
+	#  @(#)14apr89/31aug01 expand.sed by Greg Ubben
+
+	/	/!b
+
+	# Change the text before a tab to
+	#   text<MARKER>text<TAB><8 blanks><TAB>
+	#
+	s/\([^	]*\)	/\1Q&        	/g
+
+	# Reduce the text between the marker and the tab to less
+	# than eight characters.  We have to put in 8-(length MOD 8)
+	# blanks, and this effectively does the modulo operation.
+	:a
+		s/Q[^	]\{8\}/Q/g
+	ta
+
+	# The buffer is now:
+	#   text<MARKER><(length MOD 8) characters><TAB><expansion><extra bla=
nks><TAB>
+	#                -----------------------------------------
+	# Notice that the expansion is 8-(length MOD 8), so the
+	# underlined part is exactly nine characters.  That is how
+	# we discard the extra blanks and the tabs.
+	#
+	s/\(Q.\{9\}\) *	/\1/g
+
+	# We have now:
+	#         text<MARKER><(length MOD 8) characters><TAB><expansion>
+	#
+	# so we discard everything between the marker and the tab
+	#
+	s/Q[^	]*	//g
+	EOF
+	expand_tabs() {
+		sed -f "$TRASH_DIRECTORY/expand.sed" "$@"
 	}
 '
=20
@@ -34,17 +72,25 @@ test_expect_success 'setup: test prerequisites' '
 	if diff -pruN 1 2
 	then
 		test_set_prereq FULLDIFF
+	fi &&
+
+	test_when_finished "rm -f \"tab	embedded.txt\"" &&
+	test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
+	if touch -- "tab	embedded.txt" '\''"quoteembedded".txt'\''
+	then
+		test_set_prereq FUNNYNAMES
 	fi
 '
=20
 try_filename() {
 	desc=3D$1
 	postimage=3D$2
-	exp1=3D${3:-success}
-	exp2=3D${4:-success}
-	exp3=3D${5:-success}
+	prereq=3D${3:-}
+	exp1=3D${4:-success}
+	exp2=3D${5:-success}
+	exp3=3D${6:-success}
=20
-	test_expect_$exp1 "$desc, git-style file creation patch" "
+	test_expect_$exp1 $prereq "$desc, git-style file creation patch" "
 		reset_preimage &&
 		echo postimage >'$postimage' &&
 		git add -N '$postimage' &&
@@ -57,7 +103,8 @@ try_filename() {
 		test_cmp postimage.saved '$postimage'
 	"
=20
-	test_expect_$exp2 UNIDIFF "$desc, traditional patch" "
+	test_expect_$exp2 ${prereq:+$prereq,}UNIDIFF \
+						"$desc, traditional patch" "
 		reset_preimage &&
 		echo preimage >'$postimage.orig' &&
 		echo postimage >'$postimage' &&
@@ -70,7 +117,8 @@ try_filename() {
 		test_cmp postimage.saved '$postimage'
 	"
=20
-	test_expect_$exp3 FULLDIFF "$desc, traditional file creation patch" "
+	test_expect_$exp3 ${prereq:+$prereq,}FULLDIFF \
+				"$desc, traditional file creation patch" "
 		reset_preimage &&
 		reset_subdirs &&
 		echo postimage >b/'$postimage' &&
@@ -86,16 +134,16 @@ try_filename() {
=20
 try_filename 'plain'            'postimage.txt'
 try_filename 'with spaces'      'post image.txt'
-try_filename 'with tab'         'post	image.txt'
-try_filename 'with backslash'   'post\image.txt'
-try_filename 'with quote'       '"postimage".txt' success failure succ=
ess
+try_filename 'with tab'         'post	image.txt' FUNNYNAMES
+try_filename 'with backslash'   'post\image.txt' BSLASHPSPEC
+try_filename 'with quote'       '"postimage".txt' FUNNYNAMES success f=
ailure success
=20
 test_expect_success FULLDIFF 'whitespace-damaged traditional patch' '
 	reset_preimage &&
 	reset_subdirs &&
 	echo postimage >b/postimage.txt &&
 	! diff -pruN a b >diff-plain.txt &&
-	expand diff-plain.txt >damaged.diff &&
+	expand_tabs diff-plain.txt >damaged.diff &&
=20
 	mv postimage.txt postimage.saved &&
 	git apply -v damaged.diff &&
--=20
1.7.2.1.544.ga752d.dirty
