From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Fri, 31 Jul 2015 19:37:08 +0200
Message-ID: <55BBB244.3060309@virtuell-zuhause.de>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
 <20150713131107.GC1451@serenity.lan>
 <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
 <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
 <20150730112940.GL14935@serenity.lan>
 <20150731121646.Horde.Mk6NzRZAsrRNDCE_y2uEdQ1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 31 19:37:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLEFE-0007Nl-MD
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 19:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbbGaRhN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2015 13:37:13 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:34541 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752985AbbGaRhM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2015 13:37:12 -0400
Received: from p54bfb10d.dip0.t-ipconnect.de ([84.191.177.13] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1ZLEF3-0005F2-Es; Fri, 31 Jul 2015 19:37:09 +0200
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150731121646.Horde.Mk6NzRZAsrRNDCE_y2uEdQ1@webmail.informatik.kit.edu>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1438364232;0fba71e6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275056>

Am 31.07.2015 um 12:16 schrieb SZEDER G=C3=A1bor:
>=20
> Quoting John Keeping <john@keeping.me.uk>:
>=20
>> On Thu, Jul 30, 2015 at 01:24:03PM +0200, SZEDER G=C3=A1bor wrote:
>>>
>>> Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:
>>>
>>>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>>>> ---
>>>>> John Keeping <john@keeping.me.uk> hat am 13. Juli 2015 um 15:11
>>> geschrieben:
>>>>> git-rebase.sh contains:
>>>>>
>>>>>     if test "$action" =3D "edit-todo" && test "$type" !=3D "inter=
active"
>>>>>     then
>>>>>         die "$(gettext "The --edit-todo action can only be used d=
uring
>>> interactive
>>>>> rebase.")"
>>>>>     fi
>>>>>
>>>>> I wonder if it's worth doing a similar check here, which presumab=
ly
>>>>> means testing if "$dir"/interactive exists.
>>>>
>>>> Good point. Thanks for the hint.
>>>
>>> Perhaps the subject line could say "completion: offer '--edit-todo'
>>> during interactive rebase" to be a bit more specific.
>>>
>>>> contrib/completion/git-completion.bash | 6 +++++-
>>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/contrib/completion/git-completion.bash
>>>> b/contrib/completion/git-completion.bash
>>>> index c97c648..b03050e 100644
>>>> --- a/contrib/completion/git-completion.bash
>>>> +++ b/contrib/completion/git-completion.bash
>>>> @@ -1668,7 +1668,11 @@ _git_rebase ()
>>>> {
>>>>     local dir=3D"$(__gitdir)"
>>>>     if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; t=
hen
>>>> -        __gitcomp "--continue --skip --abort"
>>>> +        if [ -d "$dir"/interactive ]; then
>>>
>>> This doesn't work for me, I think it looks for the right file at th=
e
>>> wrong place.  During an interactive rebase I have no
>>> '.git/interactive' file but a '.git/rebase-merge/interactive', so I
>>> never get '--edit-todo'.
>=20
> Just noticed another issue here: it looks for a directory, though it
> should look for a file.
>=20
>=20
>>> After some playing around and a cursory look at the source it seems=
 to
>>> me that I have '.git/rebase-apply' during a "regular" rebase and
>>> '.git/rebase-merge' during an interactive rebase, and git-rebase.sh
>>> checks the presence of the 'interactive' file only in
>>> '.git/rebase-merge'.  It's not clear to me yet whether it's possibl=
e
>>> to have a '.git/rebase-merge' without the file 'interactive' in it.
>>> If it is possible, then I'd like to know with which commands and un=
der
>>> what circumstances.  If it isn't, then we wouldn't have to look for
>>> the file at all, because checking the presence of the directory wou=
ld
>>> be enough.
>>
>> "git rebase --merge" will use ".git/rebase-merge" without creating t=
he
>> "interactive" flag.
>=20
> Oh, right, thanks.  I should have remembered, I wrote the test of the
> prompt script for that case...
> (On a related note: is it possible to have a '.git/rebase-apply'
> directory, but neither 'rebasing' or 'applying' files within?  The
> prompt script has a long if-elif chain with such a branch, and I
> remember wondering how I could trigger it for testing.)
>=20
> Anyway, so this could be something like (modulo likely whitespace dam=
age):
>=20
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 07c34ef913..fac01d6985 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1667,7 +1667,10 @@ _git_push ()
>   _git_rebase ()
>   {
>       local dir=3D"$(__gitdir)"
> -    if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; the=
n
> +    if [ -f "$dir"/rebase-merge/interactive ]; then
> +        __gitcomp "--continue --skip --abort --edit-todo"
> +        return
> +    elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; t=
hen
>           __gitcomp "--continue --skip --abort"
>           return
>       fi

This looks much better than my attempt. Thanks.

How is the protocol now? Do I reroll and add=20
Helped-By: John Keeping <john@keeping.me.uk>
Completely-Overhauled-And-Properly-Implemented: SZEDER G=C3=A1bor <szed=
er@ira.uka.de>
?

Thomas
