From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Revisiting metadata storage
Date: Fri, 16 Dec 2011 10:55:52 -0800
Message-ID: <CAE1pOi2GW=3o7QgTEcUYbjif3WokpVdgL6UdKXu9x0yKH-vrGw@mail.gmail.com>
References: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
	<87sjkx8gll.fsf@an-dro.info.enstb.org>
	<CAD77+gR=SjU0Ne9jort91pdHDA=RjkTJUJmnqKBipqoGUmoL_A@mail.gmail.com>
	<CAE1pOi2TGWmFErcKhQu-a37JjLh22O1zFYoBaVRyfBDFjOTE9Q@mail.gmail.com>
	<20111216075251.GA4048@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 19:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbcwn-000766-K1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 19:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535Ab1LPSzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 13:55:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53083 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760529Ab1LPSzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 13:55:52 -0500
Received: by yenm11 with SMTP id m11so2451840yen.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=34AGRDlkp9TOFBAFUhXZZLPl/MP5Etvy2t0g+dRMJuc=;
        b=OdC/lP4rxbRdBh1NteUpuhbHaNMTR8zyA2wdFdx9xKiCYQ18SJA1KqTvHVLrQr0I79
         FM1zrW4p+xL1FJBrUjrBgmYs5BcWKlCBtfUeFNvaFuAXkusG++qUxrKjbUuPI11oZvEJ
         nOTZFx54F5JL/B9U48ZnKmDvDtVVlzoM8mlZo=
Received: by 10.236.135.77 with SMTP id t53mr13712181yhi.49.1324061752034;
 Fri, 16 Dec 2011 10:55:52 -0800 (PST)
Received: by 10.236.27.200 with HTTP; Fri, 16 Dec 2011 10:55:52 -0800 (PST)
In-Reply-To: <20111216075251.GA4048@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187301>

On 15 December 2011 23:52, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hilco Wijbenga wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Right now every rebase means a full (and almost
>> completely unnecessary) rebuild.
>
> It sounds like what you are suffering from is that "git rebase" uses
> the worktree as its workspace instead of doing all that work
> in-memory, right?

Yes, I guess the problem is that it uses the worktree as its workspace.

(I know others disagree but to me it's a bug that Git touches files
that it doesn't actually change.)

> If I were in your situation, I would do the following:
>
> =C2=A01. Don't rebase so often. =C2=A0When wanting to take advantage =
of features
> =C2=A0 =C2=A0from a new upstream version, use "git merge" to pull it =
in. =C2=A0Only
> =C2=A0 =C2=A0rebase when it is time to make the history presentable f=
or other
> =C2=A0 =C2=A0people.

I usually rebase in the morning to get an up-to-date tree. Is that
considered too often? Perhaps it's my Subversion background but I'm
not comfortable diverging too much. Is that too paranoid? :-)

So IIUC, I can do "git rebase master" even after multiple "git merge ma=
ster"s?

> =C2=A0 =C2=A0This way, "git log --first-parent" will give easy access=
 to
> =C2=A0 =C2=A0the intermediate versions you have hacked on and tested =
recently.

Why is "git log --first-parent" important? I read "git help log" on
first-parent but that didn't really tell me much. Google was not very
helpful either.

> =C2=A02. When history gets ugly and you want to rebase to make the se=
ries
> =C2=A0 =C2=A0easier to make sense of, use a separate workdir:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch tmp; # make a copy to rebase

This is in my merged branch, right?

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd ..
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git new-workdir repo rebase-scratch tmp
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd rebase-scratch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git rebase -i origin/master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd ..
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ rm -fr rebase-scratch
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ cd repo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git diff HEAD tmp; =C2=A0 =C2=A0# Does t=
he rebased version look better?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git reset --keep tmp; # Yes. =C2=A0Use i=
t.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch -d tmp

Interesting. If I run the rebase after the merge, rebase appears to do
much less work. I.e. it appears to only touch files that have actually
changed. Is that true?

> =C2=A03. Once the rebased history looks reasonably good, be sure to r=
ebase
> =C2=A0 =C2=A0one final time and test each commit before submitting fo=
r other
> =C2=A0 =C2=A0people's use.
>
> Hope that helps,

Yes, thanks for pointing out yet more useful Git options. There seems
no end to them. :-)

Cheers,
Hilco
