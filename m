From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [msysGit] Re: [PATCH 0/2] submodules: Use relative paths to gitdir
 and work tree
Date: Tue, 28 Feb 2012 20:21:01 +0100
Message-ID: <4F4D291D.6000200@web.de>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org> <4F4A8EF2.3020901@web.de> <4F4BF357.8020407@kdbg.org> <4F4D23D8.1050208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Sbs-0007wy-ND
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab2B1TVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:21:12 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:58880 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab2B1TVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:21:11 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 3662672E0A95
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 20:21:07 +0100 (CET)
Received: from [192.168.178.48] ([91.3.188.80]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LbZpT-1Sid2p3TQ3-00kNuu; Tue, 28 Feb 2012 20:21:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F4D23D8.1050208@kdbg.org>
X-Provags-ID: V02:K0:tt8t/gMQxYcsie9jpRu4Am7xr1mPuOwkMZhWZoyINNn
 j70ZWaF+T074nhwwYTGWoxvB5ikTz2VOkZdUCFdksV+5VsyfB9
 3QrR7pXErC9Bzre8O8oW9sDBaZovbXohEBTT7zAlR2LqR/Ro7m
 /D9sOiVoUyMP255hphqrCQp8VAK/Qweh6R5rv0rLmUJ/w8a94h
 bRjcoV1MKsRcD2CE2+BQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191769>

Am 28.02.2012 19:58, schrieb Johannes Sixt:
> Am 27.02.2012 22:19, schrieb Johannes Sixt:
>> Am 26.02.2012 20:58, schrieb Jens Lehmann:
>>> -       gitdir=$(git rev-parse --git-dir)
>>> +       gitdir=$(git rev-parse --git-dir | sed -e 's,^\([a-z]\):/,/\1/,')
>>
>> I don't like pipelines of this kind because they fork yet another
>> process. But it looks like there are not that many alternatives...
> 
> With the following patch on top of your always-use-relative-gitdir branch
> from https://github.com/jlehmann/git-submod-enhancements the tests pass
> on Windows.
> 
> Thanks, Dscho, for pointing out the obvious.

Thanks for helping to test and fix that on the Windows side. Do you want
to post a commit based on the the interdiff below so I can apply it on
top of my branch? Then I would make this a four patch series in the next
round.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index e1984e0..953ca5e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -151,6 +151,9 @@ module_clone()
>  
>  	a=$(cd "$gitdir" && pwd)
>  	b=$(cd "$path" && pwd)
> +	# normalize Windows-style absolute paths to POSIX-style absolute paths
> +	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} esac
> +	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} esac
>  	# Remove all common leading directories
>  	while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
>  	do
> 
