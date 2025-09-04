Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA972FC882
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993995; cv=none; b=cD6Ee77wG4lQg7bAcyTWL2C6ePCtuOYs2FOeqH0ax/k6LA8y0hRmH7/lXOQIE9tj5xNUDAVq5Mm5rUOJEwStAualGvBIJjP7nPf0sXD+JA61XRSGukSF5bfklMO6coa7q3g2i5z6UpwprYay3Itm9yeLP7/WA7WC7TgMOc9JgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993995; c=relaxed/simple;
	bh=28/dzEPb0UWRc1Bf1SQXNrYqQXqm60r9evd4CsfAcSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDiJIHWR5R71Mt48mYVMe4u31fRO4jTgqw45Nxf2wZr5Ks7I/NzCK6AXuF5rHuKMAETeu3DGD8QpIZrCuQbRbPY5K4q1ENCraIjbGgx9kJQ2R/8WX3LC9yJpcAqcyrIj3QD4WmIwTyNBjL2YJYnDttWOopwtccF02dpd3Xv2j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 31A35340D2B;
	Thu, 04 Sep 2025 13:53:10 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Junio C Hamano
 <gitster@pobox.com>,  Taylor Blau <me@ttaylorr.com>,
  rsbecker@nexbridge.com,  'Elijah Newren' <newren@gmail.com>,  'Kristoffer
 Haugsbakk' <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  'Christian Brabandt'
 <cb@256bit.org>,  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli
 Schwartz' <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,
  'Collin Funk' <collin.funk1@gmail.com>,  'Mike Hommey' <mh@glandium.org>,
  'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben
 Knoble'" <ben.knoble@gmail.com>,  'Ramsay Jones'
 <ramsay@ramsayjones.plus.com>,  'Ezekiel Newren'
 <ezekielnewren@gmail.com>,  'Josh Steadmon' <steadmon@google.com>,
  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aLl6iFXeAvL_hvqR@pks.im>
Organization: Gentoo
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<aLfU5sEa-RE3X4G2@pks.im>
	<aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
	<aLl6iFXeAvL_hvqR@pks.im>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Thu, 04 Sep 2025 14:53:07 +0100
Message-ID: <87v7lymiik.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 04, 2025 at 12:57:25AM +0000, brian m. carlson wrote:
>> On 2025-09-03 at 05:40:54, Patrick Steinhardt wrote:
>> > If I had the choice, I'd much rather adopt an ancient version of Rust if
>> > it means that more platforms can support it.
>> 
>> I think you may be assuming that gccrs targeting Rust 1.49 will
>> magically make it work on more platforms than upstream Rust will.
>> That's not the case.
>
> I don't have enough context to be able to tell. I'm mostly going by what
> the gccrs maintainers themselves are saying. But if I'm misunderstanding
> what gccrs will bring to the table I'm happy to be corrected.
>

(I also think it's obvious that once gccrs can handle 1.49, we will have
to put effort into making things build with it. Not sure who wanted or
claimed magic. I just think relyling on a single implementation isn't a
good idea.)

> [snip]
>> > I think adopting Rust as a mandatory dependency out of nowhere would not
>> > be playing nice. It may require significant effort from distros to adapt
>> > to the new reality, so we should give them time to do so.
>> 
>> We've actually had this discussion on the list several times where we've
>> proposed the inclusion of Rust.  This is not the first time it's come
>> up, or the second.  It was explicitly mentioned a year ago on the list
>> that we wanted to adopt Rust in the notes from the Contributor Summit.
>> 
>> There has been plenty of notice that this is coming down the line.  It's
>> not accurate to claim it's "out of nowhere" nor to claim that people
>> have not had plenty of time to port their systems.
>> 
>> Distros and porters should not be insensible to the increasing use of
>> Rust or the need for them to get their systems working.  For instance,
>> you cannot run a GNOME or MATE desktop environment without librsvg2,
>> which is written in Rust.  Python's cryptography package adopted Rust
>> over four years ago and there was the same gnashing of teeth[1], yet
>> little progress has been made by porters on the same affected
>> architectures since that time.  In that time, Debian has bootstrapped
>> and released an entire RISC-V port, complete with Rust.
>
> Discussions of theoretical nature are one thing though. The transition
> that is actually happening is a different thing, and distributions will
> need to prepare for this. We already had multiple distro maintainers
> coming into these discussions saying that this will require a bunch of
> work, which should be an indicator to us that we need to take it slow.
> We should accommodate for that.

I imagine most distributions have absolutely zero awareness of this
thread or plans for git. See below.

>
> [snip]
>> It should be stated that there is a very easy way to get Rust working,
>> and that's to port LLVM to the platform in question.  IA-64 was removed
>> in 2009, but it might be possible to resurrect that out of tree if
>> there's interest and maybe even get it re-accepted upstream.  I'll point
>> out that AIX, Solaris, and QNX have done the necessary porting work to
>> get LLVM and Rust working over the past couple years, so it's not out of
>> the question for other platforms to do so as well.  And, for the
>> avoidance of doubt, I would be absolutely delighted if we were able to
>> support additional platforms with Rust as well.
>
> I cannot really say how hard or easy it is to port LLVM to a different
> platform. I'd be surprised though if that work really was that easy.

I think it's an interesting characterisation indeed.

>
>> Also, the approach of making it an optional component directly
>> contradicts the proposed policy I wrote up.  That's a recipe for
>> additional burdensome work maintaining two implementations, when we
>> actually want to make it easier for people to contribute functionality.
>> It also doesn't provide any of the memory safety benefits or address any
>> of the concerns from governments, security professionals, and other
>> parties about the real and substantial risks of continuing to develop in
>> C.
>
> The only reason why we want to have it as an optional component is to
> make the transitioning period easier for downstream distributors. And
> the intent is not to convert major components -- it should be trivial
> components that we can use as test balloons, similar to how we did it
> for all of our C99 test balloons.

Yes, even if it were just for one release, having it optional for
something would mean we can adjust packaging without some huge pressure
where git had 0 Rust in one release and then mandatory Rust in another.

(I would of course prefer far more than one release, but I've tried
throughout this thread to give options even if the one I'd prefer isn't
pursued, not "teeth gnash").

sam
