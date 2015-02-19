From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Experience with Recovering From User Error (And suggestions for
 improvements)
Date: Thu, 19 Feb 2015 12:01:18 +0100
Message-ID: <54E5C27E.9060109@drmicha.warpmail.net>
References: <54E1C96D.2080109@active-4.com> <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com> <54E1F0AF.1070403@active-4.com> <54E45F74.6080907@drmicha.warpmail.net> <19A600EC-080C-48F1-A949-9A32AFC247E7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>,
	Armin Ronacher <armin.ronacher@active-4.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOOrJ-0005WJ-E5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 12:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbbBSLBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 06:01:23 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60193 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753066AbbBSLBV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 06:01:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9449C20B87
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 06:01:20 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 19 Feb 2015 06:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ttA3wuNdB0iSZVkPqS/BOs
	3cfA8=; b=ITW+SHZzTkU+2hSZ8QqBSpOnwdPLgoYq63PrVNIC8h2aY9J7nUxAV7
	D35AmgY0/1BPZSjuwNLpGuTAz/Pj3wVxZOa2uGghj+VKtpbQk1xN+v5FQ9DpdyMG
	TWchB4aAqE5ii31kc1Dj4lsj08MhULyPDokhC2fJvdVXWopvp32Mw=
X-Sasl-enc: lT9tad/OUS/m5K59tPJYuza0kPsG/n3VVapI7lPY/mn4 1424343680
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DC2D9C002A3;
	Thu, 19 Feb 2015 06:01:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <19A600EC-080C-48F1-A949-9A32AFC247E7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264090>

Kyle J. McKay venit, vidit, dixit 19.02.2015 02:17:
> On Feb 18, 2015, at 01:46, Michael J Gruber wrote:
>> Armin Ronacher venit, vidit, dixit 16.02.2015 14:29:
>>> Hi,
>>>
>>> On 16/02/15 13:09, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>>> We should definitely make recovery like this harder, but is there =
a
>>>> reason for why you don't use "git reset --keep" instead of --hard?
>>> This was only the second time in years of git usage that the reset =
=20
>>> was
>>> incorrectly done.  I suppose at this point I might try to retrain m=
y
>>> muscle memory to type something else :)
>>>
>>>> If we created such hooks for "git reset --hard" we'd just need to
>>>> expose some other thing as that low-level operation (and break =20
>>>> scripts
>>>> that already rely on it doing the minimal "yes I want to change th=
e
>>>> tree no matter what" thing), and then we'd just be back to square =
=20
>>>> one
>>>> in a few years when users started using "git reset --really-=20
>>>> hard" (or
>>>> whatever the flag would be).
>>> I don't think that's necessary, I don't think it would make the
>>> operation much slower to just make a dangling commit and write out =
=20
>>> a few
>>> blobs.  The garbage collect will soon enough take care of that data
>>> anyways.  But I guess that would need testing on large trees to see=
 =20
>>> how
>>> bad that goes.
>>>
>>> I might look into the git undo thing that was mentioned.
>>>
>>> Regards,
>>> Armin
>>>
>>
>> Are you concerned about the index only, not unstaged worktree change=
s?
>>
>> In this case, keeping a reflog for the index may help, and it would
>> somehow fit into the overall concept.
>=20
> There was this concept of a git stash checkpoint to save work in =20
> progress without creating a normal commit that I read about some time=
 =20
> ago (blog? Git book? -- don't recall) that was basically just this:
>=20
>    git stash save
>    git stash apply
>=20
> The problem with that is that it touches the working tree and can =20
> trigger rebuilds etc.  However, when I ran across the undocumented =20
> "git stash create" command I was able to write a simple git-checkpoin=
t =20
> script [1] that creates a new stash entry without touching the index =
=20
> or working tree which I find quite handy from time to time.

I think that would make for a nice additional command/mode that we coul=
d
support for git-stash.sh. Alle the pieces are there.

> So I think that what Armin originally asked for (create a dangling =20
> commit of changes before reset --hard) could be accomplished simply b=
y =20
> running:
>=20
>    git checkpoint && git stash drop
>=20
>> Otherwise, we would basically need a full stash before a hard reset.
>> That's not the first time where we could need a distinction between
>> "command run by user" and "command run by script". For the former, w=
e
>> could allow overriding default options, re-aliasing internal command=
s,
>> adding expensive safety hooks. For the latter we can't.
>>
>> It's just that we don't have such a concept yet (other than checking=
 =20
>> tty).
>=20
> But of course plugging that into git reset somehow is indeed the =20
> problem since you cannot alias/redefine git commands.
>=20
> -Kyle
>=20
> [1] https://gist.github.com/mackyle/83b1ba13e263356bdab0

Also, "git stash create" does the tree creation and object creation tha=
t
we wanted to avoid at least for scripts.

And "git reset --hard-but-safe" suffers from the user education problem=
s
that have been mentioned already.

Michael
