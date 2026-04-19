Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEB2EA732
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630703; cv=none; b=rICirY+Y1EO3mFNKklRZ9AoWv5+S+XLlZ31HvvxDPD9N3FaffSLPCOuFrx1GXm9j8CX877Bf3Miz1D5N8roAwl9ZwLCz5n58ESnLuRVBFfC7xV1PbXOCktSRi1866ypp5tdv5f5itfjaZZ9P2+sp0my0KaI6v0IoMvm6b2CLkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630703; c=relaxed/simple;
	bh=AMuiA5IvLxAOBcBNIRUIAiWZuKGjPoQ/1HDAXVie8YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeGdt6k3xeoreAe702AwraYcKY4hSTJAhXeShQeaUQCqvIBMMuG1dEXBbMDeVYakFDiit+yukUJLC+URhp4syn93WTzzkSkcSlr2p1FsuQ0iZVhoTrKZNR/V8J6kstM8Q6F9dclZYZ1TTiydU05NMOr4e6ZKbdhHyycCHOTgwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=GhrnBU6+; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="GhrnBU6+"
Date: Sun, 19 Apr 2026 22:31:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776630698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgxXfY9j7idrx7pVpKyEPE9/JCgyOzWnq+SssYBWsew=;
	b=GhrnBU6+xqW/aLbp/ATEamctnDVOydPKgGQyhDG4T1pHYSidz6mxRHNW+fwYdlwTh5P8oY
	xyiXHtpQngsdwnvSafd9vRRC7BWoVl+1/OcY9mEqWQZh2abZX/5iNxc2jewWjD5JJd6++y
	/7VdvyA8AdpTdLhRMlXnJS2+PRcpGQyy6b6kSiroQos6em9m2c4XDodEqUU0/msSQHkM1Y
	Y3NlTYZQsewlMLHtOCGdCuQSCoyvMFcMNQl0A8Nvvfeqq6FF2aiPxv/tIacoOUs6gu/Ryf
	Eg/L8shGcYKJHAhJIiMt7ehbgQo+qOg3UwqmSSOnCVXlMD3e9m06MB7cYcDjRw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aeUqSltEWIWaPDh3@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9473; i=mroik@delayed.space;
 h=from:subject:message-id; bh=AMuiA5IvLxAOBcBNIRUIAiWZuKGjPoQ/1HDAXVie8YQ=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp5TuUKFCvx7Zgcszv8d0D2Cwo2F2pD6Uii/8hr
 SoJUbr7tjiJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeU7lAAKCRBIeX6hnBm+
 0YYsD/42278/KagxZr6SHKlZfKhKXp+AZgi9lopH9CRkPl1slhpreRXemJsklnC4IhvX+ew1evx
 3QsBUUEynbaMf2U8DChOD1aMl2AMdawk2nGNSyS/blrlVVwq3lOLB+jranX6FmUPvTQ9llyM5YA
 AMLXDHbZ9S1ChaH1FT7WvS+/r3c0RaKYDflZebugQPpvOZNcLs/3M30d8ZvGvk5duBTrP5oG/BE
 UQTszECaSSoLr5/+Vox0qKV4md36XVnCiFkRTpuql+k5SlsYDm8p/1iOwFNdsxoxmIai02sQpnV
 DGBYHduul/42E94c3E8nS7Z/OpCZGAhc+NgDn+3kbktfiLVttbZ+Gvx6vKSv2rqgoQUWqfyd++8
 f4gzwQk4yI9vCaYVXCV2yu3tmvtmdfOgvrcRaIk5SSdzntcZowM7utbL1AVTS0x4IY1837/lsrK
 xRLWaog79dWWHUDq3ZOhpqXkdF8FbOJEAl+bujW2oPcO8sXGgLfv71PqDATo/pKIzhb4B5Ers7d
 bQtikZI6hyleOKtgiKyshDl0gKMhMU0AaR/N2gZL0tHW2+bnQUQV2Ii4w62jv8iqihiluKqIMaQ
 Q479mtDs5LS6LnBrpiHphPGVcbegYrY0Q1wfQ8hP97P0/Vwa8tMvmsaeaRCvW2HTF90C0pULHt2
 COVFl141S6N1AFg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
X-Spamd-Bar: -

On Sun, Apr 19, 2026 at 03:12:27PM -0400, D. Ben Knoble wrote:
> On Sun, Apr 19, 2026 at 2:11 PM Mirko Faina <mroik@delayed.space> wrote:
> >
> > On Sun, Apr 19, 2026 at 08:06:24AM -0400, Ben Knoble wrote:
> > > The original handles multiple reverse options inverting each other…
> > >
> > > > +    } else if (starts_with(arg, "--reverse")) {
> > > > +        if (!skip_prefix(arg, "--reverse=", &optarg)) {
> > > > +            if (argc < 2) {
> > > > +                revs->reverse = 1;
> > > > +                return 1;
> > > > +            } else {
> > > > +                optarg = argv[1];
> > > > +            }
> > > > +        }
> > > > +
> > > > +        if (!strcmp(optarg, "after")) {
> > > > +            revs->reverse = 1;
> > > > +        } else if (!strcmp(optarg, "before")) {
> > > > +            revs->reverse = 2;
> > > > +        } else {
> > > > +            revs->reverse = 1;
> > > > +            return 1;
> > > > +        }
> > > > +
> > > > +        return optarg == argv[1] ? 2 : 1;
> > >
> > > …which I don’t see here.
> > >
> > > I’m not familiar with this parsing code though so I can’t add much about the test other than to say it is a bit hard to follow :/
> >
> > Given that it is no longer binary handling multiple reverse can't simply
> > be inverting bits, it wouldn't make sense. This is done before the walk
> > itself, so even from the POV of the user it wouldn't make much sense to
> > reverse multiple times as the order of the applied options before this
> > patch (commit limiting options then reverse) doesn't change.
> >
> > This doesn't break any tests so I assumed it was fine.
> 
> I think I mean that
> 
>     git log --reverse --reverse
> 
> shows commits in the same order as "git log"; what should
> 
>     git log --reverse=after --reverse
> 
> do? Or what about preserving the behavior of the original "git log
> --reverse --reverse," which I don't think is done here?

Yes, this is what I was getting at. Since it is no longer binary what
would a double reverse mean? What if "--reverse=after --reverse=before"?
How should that be handled?

> Granted, I don't see this ability documented, and I cannot tell how
> many may scream if we change this behavior, so it's a bit
> hypothetical. But there is an argument for backward compatibility as a
> default, which I think we'd need to justify changing. Perhaps in the
> proposed log message?
> 
> (The original seems nonsensical to type, but of course you can imagine
> alias.A=log --reverse <other-stuff>, and then sometimes you want to do
> "git A --reverse" to un-reverse the commits.)

Will do in v2.

> > > I haven’t looked, but it would be nice if we could use an enum instead. Unfortunately that would probably take up more space in the struct, and I suppose the bit-packing is done intentionally for performance.
> >
> > Could define new macros so that the readers don't have to mentally keep
> > track of which value rapresents what. I didn't think that was
> > necessary, should I change it?
> 
> Yeah, a few `#define`d constants would make things more readable to
> me, at least, since we can't use the enum without space concerns
> (unless there's a way to bit-pack the enum to only 2 bits?).

Will do in v2.

> > > >    if (revs->reverse_output_stage) {
> > > > +        if (revs->reverse == 2 && revs->max_count == 0)
> > > > +            return NULL;
> > > > +
> 
> PS: something I spotted on a second read. [Ignoring reverse=after
> mode] This hunk looks to me like a nice little optimization (return
> nothing if we know max_count says we yield no commits). Of course, I
> could see that being viable early in the function, right? When asking
> get_revision for commits, if max_count is 0, just return NULL.
> 
> For reverse=after mode, this condition is only true if the max_count
> was 0 in the previous conditional, also, since we use max_count=-1
> before iterating get_revision_internal. That means the original
> max_count isn't touched. At any rate, it _seems_ to me that the whole
> function could benefit from this optimization… but I wonder if it is
> _necessary_ for correctness of reverse=after in some way that I'm not
> seeing? Since the current version doesn't need the early bailout, why
> does reverse=after?

Just to clarify, "reverse = 2" is "--reverse=before" and not
"--reverse=after".

With "reverse = 2", the snippet of code you're referencing is not an
optimization but a requirement for correctness. With "reverse = 1" we
just keep the max_count as is and it's used by get_revision_internal()
to stop if that limit is reached. What we find in 'reversed' are already
just the commits we need to return.

With "reverse = 2", we first set max_count to -1 and then retrieve the
whole history, then we set max_count to its original value. Then we
return the commits on each call of get_revision(). Now, unlike with
"reverse = 1", we have the whole history in 'reversed', because of that
we need to know when to stop. That's the reason we decrement max_count
only for "reverse = 2" and why "max_count == 0" is checked only for
"reverse = 2".

> > > >        c = pop_commit(&revs->commits);
> > > > +        if (revs->reverse == 2)
> > > > +            revs->max_count--;
> > >
> > > Hm. Why do we decrement here? Again, not an area I’m familiar with, but a bit surprising.
> >
> > get_revision() (in revision.c) handles the reverse option and updates
> > the "struct git_graph". get_revision() then calls
> > get_revision_internal(), which handles commit boundaries and max_count,
> > here is where it gets decreased. Since max_count gets decreased
> > everytime get_revision_internal() is called, if we were to leave
> > max_count as is before the walk (in get_revision() at line 4558), the
> > walk would stop before reaching the root commit. This is why the current
> > --reverse option is applied only after commit limiting options. So
> > instead we set max_count at -1 walking the whole history and storing it
> > in 'reversed'. Now we're in "reverse_output_stage = 1", and in this
> > state we never call get_revision_internal() again, instead we pop
> > commits from 'reversed'. Because of this we have to handle max_count
> > outside get_revision_internal(), so we decrement it in the snippet of
> > code you referenced.
> >
> > A bit verbose but hopefully it'll get my point across.
> 
> I don't 100% follow, but I'm out of my depth :)
> 
> I think I see that get_revision() effectively has 2 modes pertaining
> to reverse: reverse and reverse output stage (the former falls
> directly into the latter, though).
> 
> After some setup, the reverse mode calls get_revision_internal() as
> you said. That decrements max_count as a way of counting how many
> commits we've seen through the loop, so if we asked for 5 we'd only
> process 5 commits.
> 
> Then we fall into the output stage mode, which pops a commit [1].
> 
> With this patch, in reverse=after we disable max_count in the first
> (reverse) mode, as you said. Ok: we get the whole (filtered) history
> then, at which point we can now shrink. That makes sense.
> 
> Then in the reverse output stage mode, we pretend to have one less
> max_count. That's what I can't figure out. Is it because of the
> pop_commit()? I guess I'm not totally seeing how that interacted with
> the max_count in the original code: does the current code yield one
> extra commit in get_revision_internal() ?

I'm not sure I understand what you're referencing with "Then in the
reverse output stage mode, we pretend to have one less max_count".

If you're referring to line 4573, then...

> You wrote that "we never call get_revision_internal() again," but I
> don't see why that's true with this patch and not true before it.
> 
> I do agree that _somebody_ has to handle max_count after
> get_revision() returns with reverse=after. I'm just not sure what
> 
>     if (revs->reverse == 2)
>         revs->max_count--;
> 
> is doing.

...we're not pretending we have fewer commits. Every subsequent call to
get_revision() after the first call will never enter the branch at line
4548 and will only enter the branch at 4568. Everytime we pop a commit
from 'reversed' we decrease max_count so we can limit only to the amount
of commits the user wants.

So, to recap, with "reverse = 2", on the first call to get_revision() we
walk the whole history and store it in 'reversed' in reversed order and
return the first commit.
On subsequent calls to get_revision() we do not walk the history again,
we simply return the commits that have been stored in 'reversed'.
Everytime we pop a commit we have to decrease max_count, and we check
againts max_count to know if we shouldn't return anymore commits (by
returning NULL).

> Of course if I'm the only one confused and others make sense of it,
> that's ok, too.

No, I completely understand. I did have to retouch the function a few
times after writing the tests :P

> [1]: I traced this to 498bcd3159 (rev-list: fix --reverse interaction
> with --parents, 2008-08-29), but I can't fathom what the pop is doing
> there.

It's pretty much doing the same thing it does now, it's returning stored
commits. In both versions, the initial setup when "revs->reverse" is
true, becomes "dead code" after the first call.

Thank you
