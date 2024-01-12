Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E932EAFF
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
References: <ZZ77NQkSuiRxRDwt@nand.local> <87v880m6r3.fsf@gentoo.org>
 <ZaB-ayQuGqrS-mL0@tapette.crustytoothpaste.net>
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Sam James <sam@gentoo.org>, me@ttaylorr.com, git@vger.kernel.org, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Helge Deller
 <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>,
 arsen@gentoo.org, Antoni Boucher <bouanto@zoho.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Date: Fri, 12 Jan 2024 08:24:46 +0000
Organization: Gentoo
In-reply-to: <ZaB-ayQuGqrS-mL0@tapette.crustytoothpaste.net>
Message-ID: <87jzofrlm4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> [[PGP Signed Part:Undecided]]
> On 2024-01-11 at 11:45:07, Sam James wrote:
>> Something I'm a bit concerned about is that right now, neither
>> rustc_codegen_gcc nor gccrs are ready for use here.
>> 
>> We've had trouble getting things wired up for rustc_codegen_gcc
>> - which is not to speak against their wonderful efforts - because
>> the Rust community hasn't yet figured out how to handle things which
>> pure rustc supports yet. See
>> e.g. https://github.com/rust-lang/libc/pull/3032.
>
> Is this simply library support in the libc crate?  That's very easy to add.

[CC'd the rustc_codegen_gcc maintainer as well as some folks who have
tried using rustc_codegen_gcc for their distributions.]

Evidently not on the last point? ;)

Even just patching it in downstream isn't easy because you then have to
do it for many many packages. But after that PR stalling because of the
policy issue, there wasn't really anywhere to go, because of the
chicken-and-egg situation.

Let alone then, once the libc crate has it, going around and wiring up
in other crates.

The discussion on the PR seems clear that the intention is to not add
it until some policy is revised/formulated? I also don't want to have
to have that debate with every crate just because rustc doesn't support
it.

>
>> I think care should be taken in citing rustc_codegen_gcc and gccrs
>> as options for alternative platforms for now. They will hopefully
>> be great options in the future, but they aren't today, and they probably
>> won't be in the next 6 months at the least.
>
> What specifically is missing for rust_codegen_gcc?  I know gccrs is not
> ready at the moment, but I was under the impression that
> rust_codegen_gcc was at least usable.  I'm aware it requires some
> patches to GCC, but distros should be able to carry those.
>
> If rust_codegen_gcc isn't viable, then I agree we should avoid making
> Rust mandatory, but I'd like to learn more.

It's in a general state of instability. There's still *very* active work
ongoing in libgccjit (by the rust_codegen_gcc maintainer).

I'd say "you need to patch your GCC" is probably not a good state of
affairs for using something critical like git anyway, but even then,
I'm not aware of anyone having used it to build real-world common
applications using Rust for a non-rustc-supported platform, at least
not then using those builds day-to-day.

So, even if we were willing to chase the active flurry of libgccjit
patches (which is wonderful to see!), it's a significant moving
target. In Gentoo, we're probably better-placed than most people
to be able to do that, but it's still a lot of work and it doesn't
sound very robust for us to be doing for core infrastructure.

We have a lot of packages in Gentoo - partly actually stuff in the
Python ecosystem - where we're very excited to be able to use
rust_codegen_gcc (or gccrs, whichever comes first inreadiness, surely
rust_codegen_gcc) for alt platforms, but it's just not there yet.
