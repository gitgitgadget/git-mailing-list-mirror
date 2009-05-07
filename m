From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 11:47:03 -0400
Message-ID: <4A030277.2000708@SierraAtlantic.com>
References: <83prfbhasp.fsf@kalahari.s2.org>	<4A01E64C.7050703@SierraAtlantic.com> <7vvdoet13g.fsf@alter.siamese.dyndns.org> <4A028A0A.5070003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Hannu Koivisto <azure@iki.fi>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 07 17:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M25p5-0007cQ-GI
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 17:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760393AbZEGPri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757630AbZEGPrh
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 11:47:37 -0400
Received: from mail200.messagelabs.com ([216.82.254.195]:44636 "HELO
	mail200.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757080AbZEGPrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 11:47:36 -0400
X-VirusChecked: Checked
X-Env-Sender: Don.Slutz@SierraAtlantic.com
X-Msg-Ref: server-15.tower-200.messagelabs.com!1241711255!29169593!2
X-StarScan-Version: 6.0.0; banners=sierraatlantic.com,-,-
X-Originating-IP: [206.86.29.5]
Received: (qmail 28417 invoked from network); 7 May 2009 15:47:36 -0000
Received: from seng.sierraatl.com (HELO USFREEX1.us.corp.sa) (206.86.29.5)
  by server-15.tower-200.messagelabs.com with SMTP; 7 May 2009 15:47:36 -0000
Received: from usbosex1.us.corp.sa ([192.168.17.34]) by USFREEX1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 May 2009 08:47:11 -0700
Received: from [127.0.0.1] ([208.37.241.146]) by usbosex1.us.corp.sa with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 May 2009 11:47:05 -0400
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A028A0A.5070003@viscovery.net>
X-OriginalArrivalTime: 07 May 2009 15:47:05.0983 (UTC) FILETIME=[12A0A0F0:01C9CF2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118487>

Here is a change back to using spaces.  It also includes a change
to test for the code working.  Squash on top.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/README                    |    4 ++--
 t/t0000-basic.sh            |   13 ++++++++++++-
 t/t1004-read-tree-m-u-wf.sh |    2 +-
 t/test-lib.sh               |    7 +------
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/t/README b/t/README
index 49c3a51..c61e1d4 100644
--- a/t/README
+++ b/t/README
@@ -200,9 +200,9 @@ library for your script to use.
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
 
-   An optional parameter <prereq> is a '+' separated list of prerequisite
+   An optional parameter <prereq> is a space separated list of prerequisite
    tokens.  The test will be skipped if the test environment lacks any of
-   the prerequiste feature listed (see below for commonly used
+   the prerequisite feature listed (see below for commonly used
    prerequisites).
 
    Example:
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ca4fc..58bac69 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -67,7 +67,18 @@ donthaveit=yes
 test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be 
skipped' '
     donthaveit=no
 '
-if test $haveit$donthaveit != yesyes
+test_set_prereq HAVEBOTH
+haveboth1=no
+test_expect_success 'HAVEBOTH HAVEIT' 'test runs if both prerequisites 
are satisfied' '
+    test_have_prereq "HAVEIT HAVEBOTH" &&
+    haveboth1=yes
+'
+haveboth2=no
+test_expect_success 'HAVEIT HAVEBOTH' 'test passes if both 
prerequisites are satisfied' '
+    test_have_prereq "HAVEBOTH HAVEIT" &&
+    haveboth2=yes
+'
+if test $haveit$donthaveit$haveboth1$haveboth2 != yesyesyesyes
 then
        say "bug in test framework: prerequisite tags do not work reliably"
        exit 1
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 8683189..eb60f80 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work 
tree' '
 
 '
 
-test_expect_success SYMLINKS+SANITY 'funny symlink in work tree, 
un-unlink-able' '
+test_expect_success 'SYMLINKS SANITY' 'funny symlink in work tree, 
un-unlink-able' '
 
        rm -fr a b &&
        git reset --hard &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2d12799..dd3b8d7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,13 +263,8 @@ test_set_prereq () {
 }
 satisfied=" "
 
-# prerequisites can be concatenated with '+'
 test_have_prereq () {
-       save_IFS=$IFS
-       IFS=+
-       set -- $*
-       IFS=$save_IFS
-       for prerequisite
+       for prerequisite in $(echo $*)
        do
                case $satisfied in
                *" $prerequisite "*)
-- 
1.5.4.2


-------- Original Message --------
Subject: Re: Tests in Cygwin
From: Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
CC: Don Slutz <Don.Slutz@SierraAtlantic.com>, Hannu Koivisto 
<azure@iki.fi>, git@vger.kernel.org
Date: 5/7/2009 3:13 AM
> Junio C Hamano schrieb:
>   
>> Don Slutz <Don.Slutz@SierraAtlantic.com> writes:
>>
>>     
>>> A lot of these failures are do to running as root (member of
>>> Administrators)....
>>>       
>> Perhaps we can do this to reduce the noise level.
>>     
>
> Thank you for this patch. Unfortunately, it does not work as intended
> because the call to test_have_prereq in test_skip does not split
> the prereq tokens so that tests with space-separated prerequisite tokens
> are always skipped.
>
> My first attempt to solve that is to remove the quotes from the
> test_have_prereq call in test_skip; but I think that this simple
> solution is rather unintuitive, and will look like a bug if you inspect
> the code again in two months.
>
> You could squash in the patch below, where I chose to concatenate
> tokens with '+' because I dislike the extra quoting that is otherwise
> necessary at the call site. The downside is that it plays games with
> IFS, which you might find too ugly and not worth it. It's your call.
>
> BTW, I didn't dare test this as root on my production system; I'll do
> that later today elsewhere.
>
>
> diff --git a/t/README b/t/README
> index a532c32..49c3a51 100644
> --- a/t/README
> +++ b/t/README
> @@ -200,7 +200,7 @@ library for your script to use.
>     <script>.  If it yields success, test is considered
>     successful.  <message> should state what it is testing.
>
> -   An optional parameter <prereq> is a space separated list of prerequisite
> +   An optional parameter <prereq> is a '+' separated list of prerequisite
>     tokens.  The test will be skipped if the test environment lacks any of
>     the prerequiste feature listed (see below for commonly used
>     prerequisites).
> @@ -260,7 +260,8 @@ Prerequisites
>  -------------
>
>   POSIXPERM	The filesystem supports POSIX style permission bits
> - BSLASHPSPEC	???
> + BSLASHPSPEC	Backslashes in pathspec are not directory separators
> +                (i.e. they are not converted to forward-slash)
>   EXECKEEPSPID	The process retains the same pid across exec(2)
>
>   SANITY		Test is not run by root user, and an attempt to an
> diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
> index eb60f80..8683189 100755
> --- a/t/t1004-read-tree-m-u-wf.sh
> +++ b/t/t1004-read-tree-m-u-wf.sh
> @@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
>
>  '
>
> -test_expect_success 'SYMLINKS SANITY' 'funny symlink in work tree, un-unlink-able' '
> +test_expect_success SYMLINKS+SANITY 'funny symlink in work tree, un-unlink-able' '
>
>  	rm -fr a b &&
>  	git reset --hard &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1922e0b..2d12799 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -263,7 +263,12 @@ test_set_prereq () {
>  }
>  satisfied=" "
>
> +# prerequisites can be concatenated with '+'
>  test_have_prereq () {
> +	save_IFS=$IFS
> +	IFS=+
> +	set -- $*
> +	IFS=$save_IFS
>  	for prerequisite
>  	do
>  		case $satisfied in
>
>   



__________________________________________________________________________________________________________________
DISCLAIMER:"The information contained in this message and the attachments (if any) may be privileged and confidential and protected from disclosure. You are hereby notified that any unauthorized use, dissemination, distribution or copying of this communication, review, retransmission, or taking of any action based upon this information, by persons or entities other than the intended recipient, is strictly prohibited. If you are not the intended recipient or an employee or agent responsible for delivering this message, and have received this communication in error, please notify us immediately by replying to the message and kindly delete the original message, attachments, if any, and all its copies from your computer system. Thank you for your cooperation." 
________________________________________________________________________________________________________________
