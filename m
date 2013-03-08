From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Mar 2013 10:24:00 +0100
Message-ID: <5139AE30.6010200@web.de>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh> <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com> <513911B3.7010903@web.de> <7vr4jqkb9g.fsf@alter.siamese.dyndns.org> <51398CD5.1070603@web.de> <7v
 7glijoiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 10:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtXb-0001bV-I1
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933968Ab3CHJYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 04:24:12 -0500
Received: from mout.web.de ([212.227.17.11]:49784 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:24:10 -0500
Received: from [192.168.2.107] ([79.223.122.215]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MAMkU-1U3Orw24D4-00B9ZI; Fri, 08 Mar 2013 10:24:03
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <7v7glijoiy.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:KGRvdATCf204AXM+DqIeiA6MVKcSl/xLN57u4FC3pLC
 e7EJgTlgvjb4+Uwwv88oTgikMw6e6CEtuicKr6Yqym2K7HD/MZ
 zfnMiVh5oQE2f2iRj7Ur4LC3Z8+9ACbumkSVEYzcFi00ODN6Ml
 OASc0XR74hWZpF9MR7vNT6YpeHoTdMDFxB7wzSnc55+NHUCk7S
 0JAGg8Vg5vYi7tRaMYVmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217649>

On 08.03.13 09:15, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>> Doesn't this make one wonder why a separate bit and implementation
>>> is necessary to say "I am not interested in untracked files" when
>>> "-uno" option is already there?
>> ...
>> I need to admit that I wasn't aware about "git status -uno".
>=20
> Not so fast.  I did not ask you "Why do you need a new one to solve
> the same problem -uno already solves?"
>=20
>> Thinking about it, how many git users are aware of the speed penalty
>> when running git status to find out which (tracked) files they had c=
hanged?
>>
>> Or to put it the other way, when a developer wants a quick overview
>> about the files she changed, then git status -uno may be a good and =
fast friend.
>>
>> Does it make sence to stress put that someway in the documentation?
>>
>> diff --git a/Documentation/git-status.txt b/Documentation/git-status=
=2Etxt
>> index 9f1ef9a..360d813 100644
>> --- a/Documentation/git-status.txt
>> +++ b/Documentation/git-status.txt
>> @@ -51,13 +51,18 @@ default is 'normal', i.e. show untracked files a=
nd directori
>>  +
>>  The possible options are:
>>  +
>> -       - 'no'     - Show no untracked files
>> +       - 'no'     - Show no untracked files (this is fastest)
>=20
> There is a trade-off around the use of -uno between safety and
> performance.  The default is not to use -uno so that you will not
> forget to add a file you newly created (i.e safety).  You would pay
> for the safety with the cost to find such untracked files (i.e.
> performance).
>=20
> I suspect that the documentation was written with the assumption
> that at least for the people who are reading this part of the
> documentation, the trade-off is obvious.  In order to find more
> information, you naturally need to spend more cycles.
>=20
> If the trade-off is not so obvious, however, I do not object at all
> to describing it. But if we are to do so, I do object to mentioning
> only one side of the trade-off.  People who choose "fastest" needs
> to be made very aware that they are disabling "safety".
>=20
> That brings us back to the "Why a separate implementation when -uno
> is there?" question.
[...]
The short version:
The -uno option does exactly what the -c option intended to do ;-)
(The code path to disable the "expensive" call to read_directory_recurs=
ive()
in dir.c is slightly different).
Making benchmarks (again, sorry for the noise) shows that -uno and -c a=
re equally fast,
making 5 git status on a linux tree, take the best of 5:

git status
real    0m0.697s

git status -uno
real    0m0.291s

(with the patch) git status -c
real    0m0.289s


These are not really scientific numbers, but all in all we have motivat=
ion enough to drop
the "git status -c" patch completely.

My feeling is still that the suggested documentation "this is fastest" =
is not a good choice either.
Let me try to come up with a better suggestion.
/Torsten
=20
