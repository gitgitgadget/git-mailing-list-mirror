From: SungHyun Nam <goweol@gmail.com>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Thu, 15 Feb 2007 09:55:55 +0900
Message-ID: <45D3AF9B.40205@gmail.com>
References: <45B6C1FB.7060005@gmail.com> <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BD4AA9.5090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 01:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHUuy-0007Qv-1E
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 01:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbXBOA4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 19:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXBOA4E
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 19:56:04 -0500
Received: from relaygw3.kornet.net ([61.74.75.198]:36954 "EHLO
	relaygw3.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbXBOA4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 19:56:02 -0500
Received: from [211.48.62.136] ([211.48.62.136]) 
          by relaygw3.kornet.net ([61.74.75.198]) 
          with ESMTP id 2007021509:55:56:633187.2046.24370096
          Thu, 15 Feb 2007 09:55:56 +0900 (KST) 
Received: from [61.83.195.103] ([61.83.195.103]) 
          by relay8.kornet.net ([211.48.62.136]) 
          with ESMTP id 2007021509:55:56:947553.27725.37919664
          Thu, 15 Feb 2007 09:55:56 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
In-Reply-To: <45BD4AA9.5090400@gmail.com>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39780>

Hello,

It seems the patch below work-around the problem.
I tested this patch several times after knowing the problem.

Thanks,
namsh

diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index d0af8c3..422922e 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -130,6 +130,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"

 check_result () {
+    [ -r current ] && rm -f current
     git-ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
     diff -u expected current
 }


SungHyun Nam wrote:
> Hello,
> 
> Johannes Schindelin wrote:
>> On Wed, 24 Jan 2007, SungHyun Nam wrote:
>>
>>> First of all, this problem always existed to me. I was lazy to report. 
>>> Please check the failure logs and my GIT build script below. [...] the 
>>> first test failed at 't1000-read-tree-m-3way.sh' always. And in this 
>>> case, 2nd test always succeeded.
>>>
>>> * FAIL 57: 5 - must match in !O && A && B && A==B case.
>>>         rm -f .git/index LL &&
>>>              cp .orig-A/LL LL &&
>>>              git-update-index --add LL &&
>>>              echo extra >>LL &&
>>>              git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
>>> 997bbc4a0a51e0574168a4f637739380edebe4d7
>>> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>>>              check_result
>> It is not directly apparent what is causing this error. Could you please 
>> change your script to use "-i -v" on the tests? I.e. instead of:
>> 	
>>> 	    if ! make test
>> this:
>>
>> 	    if ! (cd t; GIT_TEST_OPTS="-i -v" make)
>>
>> It should give us a better idea what happened, since we also see the 
>> error messages of the git commands.
>>
>> If it is still not apparent what went wrong, there is unfortunately no way 
>> around doing that particular test case manually, as to find out what went 
>> wrong. Since you seem to be the only one who can reproduce this bug, it 
>> boils down to you having to do the leg work.
> 
> I'm not sure I can believe my system, Windows or CYGWIN.
> It seems GIT has no problem.
> 
> Thanks,
> 
> 2007-01-25
> =========================================================================
> * expecting success: rm -fr [NDMALTS][NDMALTSF] Z &&
>      rm .git/index &&
>      git-read-tree 997bbc4a0a51e0574168a4f637739380edebe4d7 &&
>      git-checkout-index -f -u -a &&
>      git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
> 997bbc4a0a51e0574168a4f637739380edebe4d7
> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>      check_result
> t1000-read-tree-m-3way.sh: line 133: current: Permission denied
> * FAIL 46: 3-way merge with git-read-tree -m, match H
>         rm -fr [NDMALTS][NDMALTSF] Z &&
>              rm .git/index &&
>              git-read-tree 997bbc4a0a51e0574168a4f637739380edebe4d7 &&
>              git-checkout-index -f -u -a &&
>              git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
> 997bbc4a0a51e0574168a4f637739380edebe4d7
> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>              check_result
> make: *** [t1000-read-tree-m-3way.sh] Error 1
> 
> 
> 2007-01-29
> =========================================================================
> * expecting success: rm -f .git/index LL &&
>      cp .orig-A/LL LL &&
>      git-update-index --add LL &&
>      echo extra >>LL &&
>      git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
> 997bbc4a0a51e0574168a4f637739380edebe4d7
> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>      check_result
> t1000-read-tree-m-3way.sh: line 133: current: Permission denied
> * FAIL 57: 5 - must match in !O && A && B && A==B case.
>         rm -f .git/index LL &&
>              cp .orig-A/LL LL &&
>              git-update-index --add LL &&
>              echo extra >>LL &&
>              git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
> 997bbc4a0a51e0574168a4f637739380edebe4d7
> 76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
>              check_result
> make: *** [t1000-read-tree-m-3way.sh] Error 1
