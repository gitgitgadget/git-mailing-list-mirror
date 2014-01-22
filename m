From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Wed, 22 Jan 2014 07:55:40 +0100
Message-ID: <52DF6B6C.4020708@viscovery.net>
References: <52DD857C.6060005@ramsay1.demon.co.uk>	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>	<52DEF9F2.1000905@ramsay1.demon.co.uk> <xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 22 07:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5rj8-0004n6-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 07:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbaAVGzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 01:55:51 -0500
Received: from so.liwest.at ([212.33.55.18]:57583 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbaAVGzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 01:55:50 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1W5riv-0006x5-FS; Wed, 22 Jan 2014 07:55:41 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0D8AD16613;
	Wed, 22 Jan 2014 07:55:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240815>

[Cc Pat, who added git.rc]

Am 1/22/2014 0:48, schrieb Junio C Hamano:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>>> Note that I am merely guessing that "short-digit" version numbers
>>> are acceptable by now after seeing
>>>
>>>     https://sourceware.org/ml/binutils/2012-07/msg00199.html
>>
>> Ah, nice find!
>>
>> I will test your patch (below) and let you know soon, but it looks
>> good to me. (I can't test it tonight, unfortunately.)
> 
> One thing to note is that I don't know why the existing code dropped
> the fourth digit from the maintenance series.

I don't know either. But it does not really matter. When there are 4
digits in the FILEVERSION and PRODUCTVERSION statements, then the user
does not see them as-are, but, for example, 1.8.1283 for
FILEVERSION 1,8,5,3 (1283 = 5*256+3). Therefore, I think that there is
no point in providing 4 numbers, and the patch below should be
sufficient.

diff --git a/Makefile b/Makefile
index b4af1e2..99b2b89 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
+	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
 ifndef NO_PERL
diff --git a/git.rc b/git.rc
index bce6db9..33aafb7 100644
--- a/git.rc
+++ b/git.rc
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,PATCH,0
-PRODUCTVERSION  MAJOR,MINOR,PATCH,0
+FILEVERSION     MAJOR,MINOR,0,0
+PRODUCTVERSION  MAJOR,MINOR,0,0
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN
