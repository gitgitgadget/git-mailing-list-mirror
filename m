From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [msysGit] Re: [PATCH 0/2] submodules: Use relative paths to gitdir
 and work tree
Date: Tue, 28 Feb 2012 20:33:25 +0100
Message-ID: <4F4D2C05.5070901@web.de>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org> <4F4A8EF2.3020901@web.de> <4F4BF357.8020407@kdbg.org> <4F4D23D8.1050208@kdbg.org> <7vehtezs6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Sns-0000tV-94
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321Ab2B1Tdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:33:35 -0500
Received: from fmmailgate07.web.de ([217.72.192.248]:48779 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966048Ab2B1Tdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:33:35 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id C6737CE984B
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 20:33:27 +0100 (CET)
Received: from [192.168.178.48] ([91.3.188.80]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LoYFm-1SeYmN3Ngg-00gEWt; Tue, 28 Feb 2012 20:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vehtezs6q.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:vyInt4HOrEzKKYr0iDtV5p7TP839li8xrXWnUKGW1C1
 xE6Pgte3pEVmqW6OgM58Xf07GkeLn0/cHVTYdn/Apmp2d+EwG5
 +rtLIgW5zT+Q6OGrtf0q3lRyjDQkcQKmlqsxQ3OhotQKczLAr9
 LNGfi34+ScEemdCa5xeulJAG10bnAG8s7u8g54dB/8ONe9jVe/
 rPCqSYxYO4Iz9Is5edNgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191773>

Am 28.02.2012 20:14, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> With the following patch on top of your always-use-relative-gitdir branch
>> from https://github.com/jlehmann/git-submod-enhancements the tests pass
>> on Windows.
>>
>> Thanks, Dscho, for pointing out the obvious.
> 
> The patch looks unintrusive and sane.
> 
> Thanks all three of you for looking into this.  Should I wait for a patch
> with nice write-up from one of you, or should I just come up with a random
> message and apply it locally avoiding roundtrip cost?

Thanks, but that interdiff needs all three patches from my branch to work
properly, while I only posted the first two here so far (without the third
one the gitfile still might contain the "c:/" notation even with J6t's diff
applied). I still need to remove the iffiness of my 2/2 patch and the third
one needs a test case too before I can repost that series.

>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index e1984e0..953ca5e 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -151,6 +151,9 @@ module_clone()
>>  
>>  	a=$(cd "$gitdir" && pwd)
>>  	b=$(cd "$path" && pwd)
>> +	# normalize Windows-style absolute paths to POSIX-style absolute paths
>> +	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} esac
>> +	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} esac
>>  	# Remove all common leading directories
>>  	while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>>  	do
> 
