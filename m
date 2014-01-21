From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Tue, 21 Jan 2014 13:36:20 -0800
Message-ID: <xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 21 22:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5izs-0006Xu-3S
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 22:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbaAUVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 16:36:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbaAUVg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 16:36:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CF163025;
	Tue, 21 Jan 2014 16:36:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHRRX3dvnF8dsU3x7g7drvlHDt8=; b=HJ8tCW
	eEEDZ/ClFmql0yNz2Y0M1gQaB7bB/4mpOmM6BYaKLZtCBhE/P7+SX1fUIB7siMhk
	yUm4s3UKg+llxmO3TDs/xmRA1gRy9fXMOLGnD/8vOo4jf+mjD22BcrHEALlc0/JS
	a9xuF0OoVSCW+QlHfs5Sk1AJ3AU2PjYZZgGDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c7Pqi+1z33q2UK3Icj9n/YNYf024L5WZ
	5pe7kzWILrR7kloCTNC63bF3KIAm7lvMWqlfTizlzdYffSu069pwOQg4fOfsHsFi
	vcmBIJIBgDx14KyFtVAdqxArxQ2vobxQccHXnomfbtpe/zFPkjggB9JBI2vAZ7LQ
	OQFY5qSl+nM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3823B63024;
	Tue, 21 Jan 2014 16:36:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AD0163022;
	Tue, 21 Jan 2014 16:36:24 -0500 (EST)
In-Reply-To: <xmqqy529t5bb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jan 2014 13:04:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 139D103E-82E4-11E3-8C74-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240777>

Junio C Hamano <gitster@pobox.com> writes:

> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> If the git version number consists of less than three period
>> separated numbers, then the windows resource file compilation
>> issues a syntax error:
>>
>>   $ touch git.rc
>>   $ make V=1 git.res
>>   GIT_VERSION = 1.9.rc0
>>   windres -O coff \
>>             -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
>>             -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
>>   C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
>>   make: *** [git.res] Error 1
>>   $
>>
>> [Note that -DPATCH=rc0]
>
> Thanks for a report.  I've been wondering how many distros and
> packagers would have an issue like this when we go to 2-digit
> release naming.  Of course we knew everybody can grok 3-or-4 ;-)
>
>> In order to fix the syntax error, we replace any rcX with zero and
>> include some additional 'zero' padding to the version number list.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Hi Junio,
>>
>> This patch is marked RFC because, as I was just about to send this
>> email, I realized it wouldn't always work:
>
> Yeah, and I suspect that with the use of $(wordlist 1,3,...) it is
> not even working for maintenance releases.  Does it differenciate
> between 1.8.5.1 and 1.8.5.2, for example?.  Or does "windres" always
> assume that a package version is always 3-dewey-decimal (not 2, not
> 4)?

Perhaps like this?  Just grab digit-only segments that are separated
with either dot or dash (and stop when we see a non-digit like
'dirty' or 'rcX'), and make them separated with comma.

Note that I am merely guessing that "short-digit" version numbers
are acceptable by now after seeing

    https://sourceware.org/ml/binutils/2012-07/msg00199.html

without knowing the current state of affairs.  If that is not the
case you may have to count the iteration of the loop and append or
chop the resulting string as necessary.

 Makefile              |  2 +-
 gen-version-string.sh | 13 +++++++++++++
 git.rc                |  4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b4af1e2..329f942 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
+		-DVERSIONSTRING=$$(./gen-version-string.sh $(GIT_VERSION)) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
 ifndef NO_PERL
diff --git a/gen-version-string.sh b/gen-version-string.sh
new file mode 100755
index 0000000..00af718
--- /dev/null
+++ b/gen-version-string.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+IFS=.- result=
+for v in $1
+do
+	if expr "$v" : '[0-9][0-9]*$' >/dev/null
+	then
+		result=$result${result:+,}$v
+	else
+		break
+	fi
+done
+echo "$result"
diff --git a/git.rc b/git.rc
index bce6db9..6f2a8d2 100644
--- a/git.rc
+++ b/git.rc
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,PATCH,0
-PRODUCTVERSION  MAJOR,MINOR,PATCH,0
+FILEVERSION     VERSIONSTRING,0
+PRODUCTVERSION  VERSIONSTRING,0
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN
