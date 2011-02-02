From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Wed, 2 Feb 2011 17:19:49 +0100
Message-ID: <AANLkTimoj2o0h-YEAaMi_LWK9gDTg8uzg6w2eLyMg_Ki@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net> <AANLkTimqQtLB--7pwwTALmcchnNCX0nm4Rfx8w1gp74T@mail.gmail.com>
 <201102021651.21669.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 17:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkfRM-0008Te-SI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 17:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab1BBQUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 11:20:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58767 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab1BBQUL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 11:20:11 -0500
Received: by qwa26 with SMTP id 26so134552qwa.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 08:20:10 -0800 (PST)
Received: by 10.229.211.138 with SMTP id go10mr8361774qcb.195.1296663609871;
 Wed, 02 Feb 2011 08:20:09 -0800 (PST)
Received: by 10.229.215.129 with HTTP; Wed, 2 Feb 2011 08:19:49 -0800 (PST)
In-Reply-To: <201102021651.21669.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165917>

On Wed, Feb 2, 2011 at 4:51 PM, Johan Herland <johan@herland.net> wrote=
:
> On Wednesday 02 February 2011, Santi B=E9jar wrote:
>> On Wednesday 02 February 2011, Johan Herland wrote:
>> > Proposal:
>> >
>> > Currently, git stores remote refs in the local repo by default as
>> > follows:
>> >
>> > =A0Remote repo =A0 =A0-> =A0 Local repo
>> > =A0---------------------------------------------------------
>> > =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD =A0=
(implicit)
>> > =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/*
>> > =A0refs/tags/* =A0 =A0 =A0 =A0 refs/tags/* =A0 =A0 =A0 =A0 (implic=
it, autofollow)
>> > =A0refs/replace/* =A0 =A0 =A0(TBD)
>> > =A0refs/notes/* =A0 =A0 =A0 =A0(TBD)
>> >
>> > Instead, we should change the default ref mappings into the
>> > following:
>> >
>> > =A0Remote repo =A0 =A0-> =A0 Local repo
>> > =A0--------------------------------------------------
>> > =A0HEAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0refs/remotes/$remote/HEAD
>> > =A0refs/heads/* =A0 =A0 =A0 =A0refs/remotes/$remote/heads/*
>> > =A0refs/tags/* =A0 =A0 =A0 =A0 refs/remotes/$remote/tags/*
>> > =A0refs/replace/* =A0 =A0 =A0refs/remotes/$remote/replace/*
>> > =A0refs/notes/* =A0 =A0 =A0 =A0refs/remotes/$remote/notes/*
>>
>> [...]
>>
>> > - We might want to generalize the handling of "$remote/$head" into
>> > allowing shorthands like "$remote/$tag", "$remote/$replace" and
>> > "$remote/$note" as well (provided, of course, that they match
>> > unambiguously).
>>
>> [...]
>>
>> > [2]: When looking up a shorthand tag name (e.g. v1.7.4): If a loca=
l
>> > tag (refs/tags/v1.7.4) is found, then we have an unambiguous match=
=2E
>> > If no local tag is found, we look up the tag name in all configure=
d
>> > remotes (using the method described in [1]). If the tag name exist=
s
>> > in one or more remotes, and those remotes all agree on its ultimat=
e
>> > object name (after applying e.g. ^{commit} or whatever is
>> > appropriate in the context of the lookup), then we also have an
>> > unambiguous match. However, if the tag name exists in multiple
>> > remotes, and they do NOT all agree on its ultimate object name,
>> > then the shorthand tag name is ambiguous and the lookup fails. The
>> > user can always resolve this ambiguity by creating a local tag
>> > (refs/tags/v1.7.4) pointing to the desired object.
>>
>> And the other way around. What would be the output of "git name-rev"
>> , "git describe", "--decorate", and such? $remote/tags/$tag?
>> $remote/$tag? $tag?
>>
>> I would say $remote/$tag for "git name-rev" and "--decorate" but $ta=
g
>> for "git describe" as it is usually used to create files, i.e.
>> git-1.7.4.261.g705f.tar.gz. And I think many people, me included, do
>> not expect to have an / in the "git describe" output, at least in th=
e
>> default output (in contrast with the --all flag).
>
> Thanks for raising an important point.
>
> I don't buy the file name creation argument, as 'describe' is used fr=
om
> many different contexts, and file name creation is nowhere documented
> as one of its primary objectives.

Yes, I know it is used from many different contexts, but one important
one is the creation of the tar files, even git.git's Makefile assumes
this. But as at the end we agree...

>
> Still, the objective of 'describe' is to create a human-readable stri=
ng
> that tries to say something meaningful about a commit in relation to
> its preceding history, while at the same time uniquely identifying th=
e
> commit. The "uniquely identifying" part is taken care of by
> the "-g<SHA1>" part of the output, while the initial "<tagname>-<n>"
> part makes it human-friendly. Therefore, we only care that the
> <tagname> is fairly unambiguous in the mind of the reader. From this
> perspective, which of the alternatives makes more sense? I would
> disqualify "$remote/$tag" and "$remote/tags/$tag", since the $remote
> name is repo-specific, and 'describe' output is often passed around
> between multiple developers/repos. Hence, I think that "$tag" is a go=
od
> choice for 'describe'. If "$tag" is ambiguous in the current repo, th=
en
> an "ambiguous tag" tag warning can be printed, but I would still
> use "$tag".
>
> When it comes to 'name-rev' and '--decorate', those are (AFAICS) much
> more repo-specific, and seldom passed between users. Also, they don't
> have the "-g<SHA1>" part from the 'describe' output. Hence, in this
> case, I consider unique identification (unambiguity) much more
> important than not displaying $remote names. Therefore, I'd propose
> using the shortest unambiguous alternative.

I agree. Something like this I had in mind :)


>
>> Another point to consider is if we want a default remote for tags, a
>> config tags.defaultRemote (TBD), defaulting to origin, specifying th=
e
>> default remote for tags. There would be a hierarchy: local tags,
>> default remote tags, remote tags. With this if one tag is on multipl=
e
>> remote the tag from the default remote always wins.
>>
>> In this way all the tag related input/output would no change much.
>> For example all the decoration would be $tag instead of origin/tag.
>
> Agreed, tags.defaultRemote (or tags.preferredRemote if I'm allowed to
> bikeshed) may be a valuable addition. Another way to achieve this wou=
ld
> be to explicitly copy tags from the preferred remote (e.g. origin)
> directly into refs/tags. I.e. in addition to the (new) default tag
> refspec
>
> =A0 =A0 =A0 =A0+refs/tags/*:refs/remotes/origin/tags/*
>
> you could add an _additional_ refspec
>
> =A0 =A0 =A0 =A0refs/tags/*:refs/tags/*
>
> that would also copy all of origin's tags directly into your local ta=
g
> namespace.

Yes, you always can add this refspec but I don't want to pollute my
"strict" local tags. And moreover with the config tags.preferredRemote
you can change from one preferred remote to another just changing a
config.

> Thanks for the feedback! :)

Thanks for the proposal!

HTH,
Santi
