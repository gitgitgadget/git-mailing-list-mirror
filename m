From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH/RFC 1/2] pull: pass the --no-ff-only flag through to
 merge, not fetch
Date: Thu, 1 Dec 2011 12:18:54 -0500
Message-ID: <CAJYzjmep7sKxiSNhMzAX2DRYJhANDQkPL5pX4HOZ9CssJxcWbw@mail.gmail.com>
References: <1322703537-3914-1-git-send-email-naesten@gmail.com>
	<7vborsq45x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 18:19:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWAHk-0003fD-TB
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 18:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab1LARS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 12:18:56 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57356 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab1LARSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 12:18:55 -0500
Received: by eaak14 with SMTP id k14so2394556eaa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 09:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hSrK8VtkLLP1TfzsPgY6pomo+3L4C1fY/TvgHbFg/XM=;
        b=InG/llsLUTOgWmp5y3mmxZtAbSAJbVVBn4YsXidYLfS/dtx+/Z9Re9u8GdbfWDfRx3
         SaRsqxfkCWRL1EAkv1Jt9H5lAYQZjpOX7ciLshTOgDyqp2E6XkEhy1KKgGq86Gh7luUG
         IbUIxyIu+CoxsTHA1//4NGBWB8/Ksftr5mF+s=
Received: by 10.227.207.133 with SMTP id fy5mr3270382wbb.23.1322759934320;
 Thu, 01 Dec 2011 09:18:54 -0800 (PST)
Received: by 10.180.103.228 with HTTP; Thu, 1 Dec 2011 09:18:54 -0800 (PST)
In-Reply-To: <7vborsq45x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186177>

On Wed, Nov 30, 2011 at 11:58 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Samuel Bronson <naesten@gmail.com> writes:
>
>> Without this, pull becomes unusable for merging branches when the co=
nfig
>> option `merge.ff` is set to `only`.
>>
>> Signed-off-by: Samuel Bronson <naesten@gmail.com>
>
> I wonder why you need this. We have "git config --unset merge.ff" aft=
er
> all. From purely mechanstic point of view, being able to temporarily
> defeat a configuration variable makes perfect sense, but from the poi=
nt of
> view of workflow, I am not sure if it is a good thing to even allow i=
t in
> the first place in this particular case.
>
> Setting merge.ff to 'only' means you are following along other people=
's
> work and making nothing new on your own in this particular repository=
, no?
> Hence you won't be asking the upstream to pull from this repository, =
which
> in turn means that even if you made a merge by temporarily defeating =
the
> configuration setting with this patch, your future pulls will no long=
er
> fast forward, until somehow the upstream gets hold of your merge comm=
it.

Actually, I wanted to set merge.ff to only avoid *accidentally*
merging origin/master onto my local master, when I would likely to
prefer to either rebase my work onto it, or retroactively put my work
in a branch and merge that *into* the real master branch; I would then
override only when I explicitly did want a merge.

(I actually have commit access to the repository in question, but wish
to avoid making others' commits to master look as if they were on side
branches.)

> By the way (this is a digression), I also have to say --no-ff-only is=
 too
> *ugly* as a UI element, even though I know "git merge" already allows=
 it
> by accident.
>
> "ff" is a tristate. By default, fast-forward is done when appropriate=
, and
> people can _refuse_ to fast-forward and force Git to create an extra =
merge
> commit. Or if you are strictly following along, you can say you _requ=
ire_
> fast-forward and reject anything else. So it may make the UI saner if=
 we
> updated the UI to allow users to say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--ff=3Dnormal =C2=A0 =C2=A0 the default
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--ff=3Dnever =C2=A0 =C2=A0 =C2=A0same as -=
-no-ff that forces an extra merge commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--ff=3Drequired =C2=A0 same as --ff-only
>
> while keeping the current --ff-only and --no-ff as backward compatibi=
lity
> wart.

Hmm, yes, I had noticed that it was a tristate (merge.ff clearly is),
and I guess --no-ff-only is a pretty ugly flag. I do have to ask,
though: why give --ff these new values? Wouldn't it make more sense to
reuse the values accepted by merge.ff; namely, 'true' (the implied
default), 'false', and 'only'?

Otherwise, this looks like a very nice way to implement what I want: I
guess it is probably a mistake that the existing (documented) flags do
not behave in this way?
