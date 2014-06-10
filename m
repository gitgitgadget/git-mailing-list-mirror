From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 15/20] t/t5000-tar-tree.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 23:47:49 +0200
Message-ID: <53977D05.5070505@web.de>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com> <1402066563-28519-16-git-send-email-gitter.spiros@gmail.com> <20140610200804.GD72977@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: David Aguilar <davvid@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTtu-00032G-67
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbaFJVsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 17:48:08 -0400
Received: from mout.web.de ([212.227.15.4]:56672 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbaFJVsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:48:07 -0400
Received: from [192.168.178.27] ([79.253.174.32]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0McWnE-1XC0ma3wcy-00HgFm; Tue, 10 Jun 2014 23:48:05
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140610200804.GD72977@gmail.com>
X-Provags-ID: V03:K0:mwmqgxgceswun/RLDUr2Yd1WjQYyhRtmv0bECpViNEz92DJWhQ2
 VulI9v5MvJgH+svKjfpoThpl+O3F5zh0Vq4U7zLtz/zuME9Tuvq/4qIVefaYjPiljBk7FZ+
 PA/FKqPGdLZj6DQnY+UAwZBox+NkZvHUeNmCf14DpqxQtZMTZrH08Mm7XOWp8ud/8hn8gkz
 6PefIhln59ljpX0P5NTvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251264>

Am 10.06.2014 22:08, schrieb David Aguilar:
> [Resent using Ren=C3=A9's correct email address this time, sorry for =
the noise]
>
> On Fri, Jun 06, 2014 at 07:55:58AM -0700, Elia Pinto wrote:
>> The construct is error-prone; "test" being built-in in most modern
>> shells, the reason to avoid "test <cond> && test <cond>" spawning
>> one extra process by using a single "test <cond> -a <cond>" no
>> longer exists.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>>   t/t5000-tar-tree.sh |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
>> index 74fc5a8..ad6fa0d 100755
>> --- a/t/t5000-tar-tree.sh
>> +++ b/t/t5000-tar-tree.sh
>> @@ -72,7 +72,7 @@ check_tar() {
>>   			for header in *.paxheader
>>   			do
>>   				data=3D${header%.paxheader}.data &&
>> -				if test -h $data -o -e $data
>> +				if test -h $data || test -e $data
>>   				then
>
> This looks okay, but it raises a question for the original author
> (Ren=C3=A9, I think that's you so I've added you to the To: line).
>
> Should that be "test -f" instead of "test -e"?

With -f instead of -e the function would ignore pax path headers for=20
directories and special files.  The latter is not relevant for git at=20
all and we don't currently have a test for long directory names, but wh=
y=20
restrict the code to handle only regular files?

A better change would be adding tests for symlinks and directories with=
=20
long names.

>
> This is a very minor note and should not block this patch.
> It's probably a change that's better made in a follow-up patch.
>
>>   					path=3D$(get_pax_header $header path) &&
>>   					if test -n "$path"
