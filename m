From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v4 2/2] push: teach --recurse-submodules the on-demand option
Date: Mon, 12 Dec 2011 16:16:19 -0500
Message-ID: <CABURp0okOmsk4JV9Ku5pHJb5vT-kr_fmweNNBKZ_OoRyfZan=Q@mail.gmail.com>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-3-git-send-email-iveqy@iveqy.com> <7vmxemls8z.fsf@alter.siamese.dyndns.org>
 <20111017190749.GA3126@sandbox-rc> <7vr52bjljd.fsf@alter.siamese.dyndns.org> <4E9DE883.9050105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDEt-0004ty-Cf
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab1LLVQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 16:16:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47323 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab1LLVQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 16:16:42 -0500
Received: by faar15 with SMTP id r15so1733030faa.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8bBfNWyjHwESZGZD7omDZw+bLxZp3xaMRLAOPSxq+jc=;
        b=kDYZziswslnJ449JAOR13RjmNxvy+dWcUff5uCoo86t6vLyCf4IlKgUBGG2MC/HUzq
         mYDhSt1P36I+OW5wTZatLNsqmjCay2Qs629oryq5SGiPHyfeyjVM/qAoeyGGv2TBvXoS
         RTNdKHIvpLTzIqJTZOxO6c8aeplfYm7hkzeF4=
Received: by 10.180.106.70 with SMTP id gs6mr23425847wib.41.1323724601292;
 Mon, 12 Dec 2011 13:16:41 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Mon, 12 Dec 2011 13:16:19 -0800 (PST)
In-Reply-To: <4E9DE883.9050105@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186953>

On Tue, Oct 18, 2011 at 4:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 18.10.2011 00:33, schrieb Junio C Hamano:
>> The very first step for floating submodules support would be relativ=
ely
>> simple. We could declare that an entry in the .gitmodules file in th=
e
>> superproject can optionally specify which branch needs to be checked=
 out
>> with something like:
>>
>> =A0 =A0 =A0 [submodule "libfoo"]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 branch =3D master
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 path =3D include/foo
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 url =3D git://foo.com/git/lib.git
>>
>> and when such an entry is defined, a command at the superproject lev=
el
>> would largely ignore what is at include/foo in the tree object recor=
ded in
>> the superproject commit and in the index. When we show "git status" =
in the
>> superproject, instead of using the commit bound to the superproject,=
 we
>> would use include/foo/.git/HEAD as the basis for detecting "local" c=
hanges
>> to the submodule.
>
> Yup. And the presence of the "branch" config could tell "git submodul=
e
> update" to fetch and advance that branch to the tip every time it is =
run.
> And it could tell the diff machinery (which is also used by status) t=
o
> ignore the differences between a submodule's HEAD and the SHA-1 in th=
e
> superproject (while still allowing to silence the presence of untrack=
ed
> and/or modified files by using the diff.ignoreSubmodules option) and
> fetch would just stop doing any on-demand action for such submodules.
> Anything I missed?
>
>> We could even declare that the gitlink for such a
>> submodule should record 0{40} SHA-1 in the superproject, but I do no=
t
>> think that is necessary.
>
> Me neither, e.g. the SHA-1 which was the submodules HEAD when it was =
added
> should do nicely. And that would avoid referencing a non-existing com=
mit
> in case you later want to turn a floating submodule into an exact one=
=2E


I'm sorry I missed this comment before.

I hope we can allow storing the actual gitlink in the superproject for
each commit even when we're using floating submodules.  I
thought-experimented with this a bit last year and came to the
conclusion that I should be able to 'float' to tips (developer
convenience) and also to store the SHA-1 of each gitlink through
history (automated maybe; as-needed).

The problem with "float-only" is that it loses history so, for
example, git-bisect doesn't work.

The problem with "float + gitlinks", of course, is that it looks like
"not floating" to the developers (git-status is dirty unless
overridden, etc.)

Is there a deeper reason this wouldn't be possible?

Phil
