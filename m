From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Sun, 13 Nov 2011 00:07:19 +0200
Message-ID: <CAMP44s06p+KyJAu4ddiCa8CFRq5eogbqxxJU16Z-SUb3GSp67Q@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
	<20111108181442.GA17317@sigill.intra.peff.net>
	<CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
	<20111111181352.GA16055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 12 23:11:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPLmt-0000yM-1N
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 23:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab1KLWHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 17:07:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40034 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1KLWHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 17:07:20 -0500
Received: by iage36 with SMTP id e36so5526966iag.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 14:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8HjDA/uE0+kKmnzcYt0d7F5tpeb+Zr7KYdQlsHgpObo=;
        b=JhVyLBtLcgkhbv2jYDjAUcjCVszlUvkKN++ua+HsPDm0M+rub0eeTOHPnB8LdL4c0+
         /wseiMX50L4LhBOx3QdQAXJp5XmuTJf7jUHgbqkIwGK87ZPgDrsnC3jwIZRwPVOIweqN
         xEjzMDTRwDyuSZoWhDHBNSgLWQAoAXsK2WG+g=
Received: by 10.68.60.225 with SMTP id k1mr32035755pbr.25.1321135639531; Sat,
 12 Nov 2011 14:07:19 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Sat, 12 Nov 2011 14:07:19 -0800 (PST)
In-Reply-To: <20111111181352.GA16055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185318>

On Fri, Nov 11, 2011 at 8:13 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 11, 2011 at 02:30:48PM +0200, Felipe Contreras wrote:
>
>> > Doesn't --all mean all refs, including tags and branches?
>>
>> Nope, only branches, try it. I also found it strange. And what is
>> more, you can't use --all and --tags at the same time. Totally
>> strange.
>
> Yeah, you're right. Sorry for my confusion.
>
> So in that sense, it is poorly named, and "--branches" (or "--heads")
> would be more accurate. At the same time, it is probably more likely
> what the user wants to do (you almost never want to push "refs/remote=
s",
> for example).

But you do want to push tags, and --all --tags doesn't sound right; if
I'm pushing everything, why do I specify I want to push more stuff.
And then, why it --all --tags disallowed?

> So I am a little hesitant to suggest changing it, even
> with a warning and deprecation period.

It is confusing and wrong, what more reason do you need?

>> And yes, in this particular use-case that's what I am trying to avoi=
d,
>> but in other use-cases (like creating a new repo and pushing
>> *everything*), a *true* --all would be nice.
>
> Right. It looks like that is just spelled "--mirror" (which gives you
> pruning also), or "refs/*:refs/*" (without pruning). The latter is ev=
en
> more flexible, as you could do "refs/*:refs/foo/*" to keep several
> related backups in one upstream repo.

So, we agree that --all is the same as 'refs/heads/*'. Therefore we
already have this mixture of refspecs and options.

> Just to get back to the original patch for a second: are we in agreem=
ent
> that what you want to do with "sync" is almost possible now (modulo a
> separate --prune option), and that there is a separate issue of makin=
g
> friendlier syntax for a few common refspecs?

Yes.

>> > We could add syntactic sugar to make
>> > --branches mean "refs/heads/*". But I do worry that pseudo-options=
 like
>> > that just end up creating more confusion (I seem to recall there b=
eing a
>> > lot of confusion about "--tags", which is more or less the same th=
ing).
>>
>> But it's not, that could explain part of the confusion. I think thes=
e
>> would be totally intuitive.
>>
>> =C2=A0--branches
>> =C2=A0--tags
>> =C2=A0--other
>> =C2=A0--all
>> =C2=A0--update
>> =C2=A0--prune
>
> My problem with them syntactically is that you have option-looking
> things that are really not flags, but rather syntactic placeholders f=
or
> refspecs.

We already have those: --all -> 'ref/heads/*', --tags -> 'refs/tags/*'.

> So you have:
>
> =C2=A0git push --prune remote --branches
>
> which looks wrong from the perspective of usual option-parsing rules.
> And does:
>
> =C2=A0git push remote --prune --branches
>
> work? Or:
>
> =C2=A0git push --prune --branches remote
>
> ?
>
> I think we could make them all work if we want. But somehow the synta=
xes
> just look wrong to me. Using a non-dashed placeholder for special
> refspecs makes more sense to me like:

I don't see any problem with making them all work.

> =C2=A0git push --prune remote BRANCHES
>
> and then it really is just a special way of spelling "refs/heads/*". =
But
> then, I also think it's good for users to understand that the options
> are refspecs, and what that means. It's not a hard concept, and then
> when they inevitably say "how can I do BRANCHES, except put the resul=
t
> somewhere else in the remote namespace", it's a very natural extensio=
n
> to learn about the right-hand side o the refspec.
>
> Of course I also think BRANCHES looks ugly, and people should just le=
arn
> "refs/heads/*".

Look, I'm all in favor of people learning stuff, but I have been
involved in Git since basically day 1, and up to this day I was (am?)
not familiar with refspecs, I don't use them regularly, and never
really had a need to, and that's fine. People are already complaining
about the learning curve of git, and what you are suggesting is that:

Instead of doing:
% git push remote --branches --tags

They should do:
% git push remote 'refs/heads/*' 'refs/tags/*'

I disagree, I think refspecs should remain as plumbing, and there must
be a porcelain way to achieve the options I proposed.

> I dunno. Maybe my brain is fried from knowing too much about how git
> works. I don't have much of an "ordinary user" perspective anymore.

Maybe :)

>> But what about 'git fetch'? You didn't comment anything. I think we
>> should try to be consistent in these imaginary future options, maybe
>> to devise a transition, or at least to identify good names for the n=
ew
>> options.
>
> Yeah, fetch makes it harder because the options may have subtly
> different meanings. Using non-option placeholders would work around
> that. You would still have options for pruning, which to me is not
> really a refspec, but an option that acts on the refspecs.
>
> From the list in your previous email, you wrote:
>
>> --prune -> rename to --prune-tracking?
>> --prune-local (new; prune local branches that don't exist on the rem=
ote)
>
> I think --prune wouldn't need renaming. If you fetch into tracking
> branches, then pruning would prune tracking branches. If you fetch as=
 a
> mirror (refs/*:refs/*), then you would prune everything.

I'm not going to investigate the subtleties of these different setups,
I'm going to put my common user hat and ask; how do I fetch as a
mirror?

> And "--prune-local" doesn't seem like a fetch operation to me. Either
> you are mirroring, and --prune already handles it as above. Or you ar=
e
> interested in getting rid of branches whose upstream has gone away. B=
ut
> that's not a fetch operation; that's a branch operation.

This would make things more confusing to the user.

Say on one side I do this push?
% git push test --prune 'refs/heads/*' 'refs/tags/*'

What do I do in the other side to synchronize the repo?
% git fetch test --prune-local 'refs/heads/*:refs/heads/*'
'refs/tags/*:refs/tags/*'

I would prefer this of course:
% git fetch test --all --prune-local

But you are saying it should be:
% git fetch test 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
% git branch --prune-remote test

That doesn't sound right to me; mixing branch operations with a specifi=
c remote?

Again, I think conceptually it's much easier to think about these
operations to be related to a specific remote, sure, fetch and push
mostly deal with specific remotes, but even more 'git remote'.

--=20
=46elipe Contreras
