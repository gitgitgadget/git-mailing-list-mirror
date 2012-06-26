From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Tue, 26 Jun 2012 21:59:16 +0200
Message-ID: <4FEA1494.404@web.de>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org> <1340621820-19448-2-git-send-email-mgorny@gentoo.org> <4FE898BC.2020307@web.de> <CABURp0od-nNFVhLQU9BsiJ=wXkdneJfhxun_PHOfV=sgzOFShg@mail.gmail.com> <4FE8D380.20803@web.de> <CABURp0qFXGs6wqFbz28OKywVsFu23JKfhS8uLsen-nqhBvDAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjbv4-00026T-49
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab2FZT7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 15:59:22 -0400
Received: from mout.web.de ([212.227.15.4]:64011 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab2FZT7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 15:59:21 -0400
Received: from [192.168.178.48] ([79.193.92.179]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MOipW-1SoXas2l1i-006U2w; Tue, 26 Jun 2012 21:59:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CABURp0qFXGs6wqFbz28OKywVsFu23JKfhS8uLsen-nqhBvDAiw@mail.gmail.com>
X-Provags-ID: V02:K0:11AsIv95oVMaq1LzatZCReBE3LEgQQtDR192FP+3fnL
 AcEEsHMpK9TKk58numoQL36ZAISYlBwgeiMeAXqu7fE37/NPXZ
 udf2Vx/5ssvzEwNCgHeXPhsKBBXDrSNJogsQC1z3KUioZ2BLyW
 wJ64zhcx0CAmTlyIBc5gcYFzxxf+Zdg49Js16yZp/LH4VVAf+m
 /lGHaP3no6rYG1ts3+G3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200678>

Am 26.06.2012 21:12, schrieb Phil Hord:
> On Mon, Jun 25, 2012 at 5:09 PM, Jens Lehmann <Jens.Lehmann@web.de> w=
rote:
>> Am 25.06.2012 22:53, schrieb Phil Hord:
>>> On Mon, Jun 25, 2012 at 12:58 PM, Jens Lehmann <Jens.Lehmann@web.de=
> wrote:
>>>> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
>>>>> Add an 'rm' command to git-submodule which provides means to
>>>>> (semi-)easily remove git submodules.
>>>>>
>>>>> Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>>>>> ---
>>>>> Right now, it requires the submodule checkout to be removed manua=
lly
>>>>> first (so it does not remove unstaged commits), and just removes
>>>>> the index entry and module information from config.
>>>>>
>>>>> I based it on 'cmd_add' code trying to preserve the original codi=
ng
>>>>> standards.
>>>>
>>>> I really like the goal of this patch but would prefer that "git rm=
"
>>>> learns how to remove submodules instead of adding more code to the
>>>> git-submodule.sh script.
>>>
>>> I would like to see both supported, eventually. That is, git-rm and
>>> git-submodule-rm should both work.  It would make sense to me when =
I
>>> am looking for the counterpart to 'git submodule add' to find it un=
der
>>> 'git submodule rm', and also under 'git submodule --help'.
>>
>> Hmm, as long as "git submodule rm" would just use "git rm" under the
>> hood and not its own scripting that would be ok.
>=20
> Maybe it would be better if 'git-rm' would use 'git submodule rm'
> under the covers.  This would keep the .gitmodules (etc.)
> manipulations out of the hair of the git-rm machinery.

I disagree, me thinks submodules should become first class citizens.

> Also, I hope 'git submodule rm foo' would fail if 'foo' were not a su=
bmodule.

Yes, it should. But that'd be easy to test there.

>>> In the special case of a submodule which does not use a gitfile, I =
am
>>> not even sure if any of the submodule files should be removed. If t=
hey
>>> are, what state does that leave the submodule repository in?  A
>>> checked-out workdir whose files are all removed?  'git-status' woul=
d
>>> be very noisy in this case.  I'd rather expect this to behave the s=
ame
>>> as if I checked out a previous commit which did not have the submod=
ule
>>> added yet.  Today, this leaves the submodule in-place and it shows =
up
>>> as an untracked file.  I don't know a better way to handle that,
>>> though I expect it would be ok remove all the files even in this ca=
se
>>> (if the workdir is not dirty and if the head commit is current in t=
he
>>> superproject).  But it seems extreme to do all of that and then lea=
ve
>>> the .git directory lying about in the former submodule directory.
>>
>> Good point. Another option would be to move the git directory into
>> .git/modules of the superproject before removing the files, then nex=
t
>> time it's updated it'll use gitfile. But maybe that's a problem whic=
h
>> will go away anyways as all submodules cloned with newer git use
>> gitfiles anyway.
>=20
> I like this idea, but it seems a little presumptuous.  The new
> behavior might cause a few panicked users to spend the day rebuilding
> their "lost" repository.

Me thinks we should teach "git rm" only to remove the submodule when
the --recurse-submodules option is used with it (which is what "git
submodule rm" would do). Then later the to be added "autoupdate"
submodule config  setting (which I intend to use for automatic
submodule updates during checkout, merge, etc. too) could enable this.
No surprises for users who didn't ask for it.

>  Maybe we can make this an explicit action.
> "git submodule convert-to-gitfile"  :-)

I like it!
