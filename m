From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Blaming differences
Date: Wed, 20 Jun 2012 12:35:33 +1200
Message-ID: <CAFOYHZAyRUwnguvbkk_SDqiSJ=Z3mOdtDLZ+yQMep91cgK+Bww@mail.gmail.com>
References: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 02:35:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh8tX-0000bl-J3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 02:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab2FTAff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 20:35:35 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34060 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab2FTAfe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 20:35:34 -0400
Received: by wgbdr13 with SMTP id dr13so7360730wgb.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7NB6rHD2dSUibn5XXf1HUvqzj4141PXKsvoJ7sCozRY=;
        b=DyW/zE8Yr6he6MrOMOk7TSMm1vIftHJeuJJBfZyJI2Gr8gMoQ6g3apZxSgeyN+hZdT
         /9QaT8o7DKm9JbhgYasxgYNmTgMoMPsdPbNV4GAfee/FkmP8d2/dvp+rvUakhtxYsdn2
         z/e2rnOVtHV8uyomoE5xA9UP7BahKc+howqIH94E8MUtGlWOElx77GwjuLQLiIDSSn3W
         MOwOFfVlL2tft5heNw2jTEZEcvTHuMvM6NgelnUYPDy80AfdEK8KXx/d6sHEH7cb6kzU
         ks0gixJmpKB0R3WHVH8pMz2kj75yxws9E6XlByOcpc46wh4jzSqZ/2PTrEjjtdViLXcr
         NK7A==
Received: by 10.216.142.200 with SMTP id i50mr12598905wej.47.1340152533504;
 Tue, 19 Jun 2012 17:35:33 -0700 (PDT)
Received: by 10.216.4.134 with HTTP; Tue, 19 Jun 2012 17:35:33 -0700 (PDT)
In-Reply-To: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200279>

On Tue, Jun 19, 2012 at 10:56 AM, Phil Hord <phil.hord@gmail.com> wrote=
:
> I want something like a product of diff and blame. =C2=A0I want to se=
e some
> kind of "blame" output for each line of "diff -U0".
>
> I tried something like this:
> =C2=A0 git blame $changed_files
>
> Is there such a command already?
>
> I'd also like to do something of the inverse operation: =C2=A0I want =
to
> find commits within a range whose changes are NOT in some other
> commit. =C2=A0 So, say I have these four commits
> =C2=A0 A---B---C---D
>
> Where D was created by 'git revert B'.
> I'd like to find out somehow that this is equivalent to
> =C2=A0 A--C
>
> So that if I remove B and D completely, the with just A and C will ge=
t
> me to the same end result.
>
> Something like 'git list-contributors HEAD' which would show me A and
> C, since these are the only commits that appear in any 'git blame
> $any_file'.
>
> Do these tools exist? =C2=A0Is it too expensive?
>
> Phil
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

I've just run into a situation at $dayjob where something like this
would be useful for me so I thought I'd throw my use-case into the mix
if anyone decides to pick this idea up.

I'm doing a peer review of a modest project that's been developed off
in a branch of it's own before it will be merged back to master. Our
current policy is to let these project merges reflect reality warts an
all (e.g. leave in commits and their reverts even if the net result is
0 lines changed). I don't want to waist too much time reviewing commit
by commit, especially when one commit might heavily refactor code from
an earlier one. However looking at the full 'git diff project
^origin/master' is a bit more code that I can keep in my brain at one
time. What I'd find useful is the output of 'git diff project
^origin/master' marked up with the sha1s which I could then use as a
leaping off point.

Something like this could get me part way there

  for x in $(git diff --name-only project ^origin/master)
  do
    echo git blame project ^origin/master -- $x >$x.ann
  done

But I'd still have to figure out how to reduce the annotated files
down to something useful. The git blame -L option might help if I
could specify it multiple times and parse the diff output,
alternatively since it's not a huge number of revs I multiple
invocations of git blame would work for me. I'll have a go at hacking
something up after lunch.
