From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Thu, 12 Aug 2010 17:40:44 -0500
Message-ID: <20100812224044.GK2029@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgTg-0005yc-L9
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761018Ab0HLWmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 18:42:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41368 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab0HLWmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 18:42:18 -0400
Received: by vws3 with SMTP id 3so1061378vws.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V93duER922iivK/uhxKHcox+n+/As3rja/ZceV79YH4=;
        b=Jw6lzmTYq3xrFZqQkj4S9JY3WkGqQYioO94U5NgoIxeBEBcTTEXp+vISC0USn14x8P
         5RlPAOf/7Vpjq1DESIEMHIz8twsdZsEyDT+Gisv4PjC/8ZxfxF4ARifgQEKuIloD13ga
         Fmll+vvtfajGvgW/yIFARB1UMWXfZOO9A0sUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xDIXTmeQof+zwnGjAQssvAyWweATaYpaQb4yDoCRrwATJJRUIGzWDeY46onXu6njgh
         PCbEy2rO+2w9hvGgOk654y3P1ENPMiVb3HWJUtj9XNGrTLWaa6mW/8s3EvNqjKrMqM1s
         Rsjvl5zNu/EO3iHY4fM9K3NKOrF7J3+kr3Sek=
Received: by 10.220.88.224 with SMTP id b32mr529228vcm.77.1281652937668;
        Thu, 12 Aug 2010 15:42:17 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id s29sm830432vcr.47.2010.08.12.15.42.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 15:42:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153436>

Johannes Sixt wrote:
> Am 8/12/2010 1:35, schrieb Junio C Hamano:

>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>>  - apply: Handle traditional patches with space in filename
>>  - t4135 (apply): use expand instead of pr for portability
>>  - tests: Test how well "git apply" copes with weird filenames
>>  - apply: Split quoted filename handling into new function
>> 
>> Looked Ok.  Will merge to 'next'.
>
> The test cases that work with files with tabs must have a prerequisite;
> see t3600-rm.sh.

Would this work?

-- 8< --
Subject: t4135 (apply): filenames with tabs are not usable on NTFS

Move the code setting up the FUNNYNAMES prerequisite from
v1.3.0-rc1~67 (workaround fat/ntfs deficiences for t3600-rm.sh,
2006-03-03) to test-lib and use it.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3600-rm.sh                    |   11 +++--------
 t/t4135-apply-weird-filenames.sh |   17 +++++++++--------
 t/test-lib.sh                    |   11 +++++++++++
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..a60b7c9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -14,15 +14,10 @@ test_expect_success \
      git add -- foo bar baz 'space embedded' -q &&
      git commit -m 'add normal files'"
 
-if touch -- 'tab	embedded' 'newline
-embedded' 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES
-else
-	say 'Your filesystem does not allow tabs in filenames.'
-fi
-
 test_expect_success FUNNYNAMES 'add files with funny names' "
+     >'newline
+embedded' &&
+     >'tab	embedded' &&
      git add -- 'tab	embedded' 'newline
 embedded' &&
      git commit -m 'add files with tabs and newlines'
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index f4c7e15..5c7165e 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -40,11 +40,12 @@ test_expect_success 'setup: test prerequisites' '
 try_filename() {
 	desc=$1
 	postimage=$2
-	exp1=${3:-success}
-	exp2=${4:-success}
-	exp3=${5:-success}
+	prereq=${3:-}
+	exp1=${4:-success}
+	exp2=${5:-success}
+	exp3=${6:-success}
 
-	test_expect_$exp1 "$desc, git-style file creation patch" "
+	test_expect_$exp1 $prereq "$desc, git-style file creation patch" "
 		reset_preimage &&
 		echo postimage >'$postimage' &&
 		git add -N '$postimage' &&
@@ -57,7 +58,7 @@ try_filename() {
 		test_cmp postimage.saved '$postimage'
 	"
 
-	test_expect_$exp2 UNIDIFF "$desc, traditional patch" "
+	test_expect_$exp2 ${prereq:+$prereq,}UNIDIFF "$desc, traditional patch" "
 		reset_preimage &&
 		echo preimage >'$postimage.orig' &&
 		echo postimage >'$postimage' &&
@@ -70,7 +71,7 @@ try_filename() {
 		test_cmp postimage.saved '$postimage'
 	"
 
-	test_expect_$exp3 FULLDIFF "$desc, traditional file creation patch" "
+	test_expect_$exp3 ${prereq:+$prereq,}FULLDIFF "$desc, traditional file creation patch" "
 		reset_preimage &&
 		reset_subdirs &&
 		echo postimage >b/'$postimage' &&
@@ -86,9 +87,9 @@ try_filename() {
 
 try_filename 'plain'            'postimage.txt'
 try_filename 'with spaces'      'post image.txt'
-try_filename 'with tab'         'post	image.txt'
+try_filename 'with tab'         'post	image.txt' FUNNYNAMES
 try_filename 'with backslash'   'post\image.txt'
-try_filename 'with quote'       '"postimage".txt' success failure success
+try_filename 'with quote'       '"postimage".txt' '' success failure success
 
 test_expect_success FULLDIFF 'whitespace-damaged traditional patch' '
 	reset_preimage &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 938fb24..5ba8723 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -907,6 +907,17 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
+# test whether the filesystem supports unusual filenames
+f1='newline
+embedded'
+if
+	>"$f1" 2>/dev/null &&
+	>'tab	embedded' 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES
+fi
+rm -f "$f1" 'tab	embedded'
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
-- 
1.7.2.1.544.ga752d.dirty
