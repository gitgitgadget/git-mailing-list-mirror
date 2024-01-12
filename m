Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454F6DCF0
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zoho.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=bouanto@zoho.com header.b="Ggev4phl"
ARC-Seal: i=1; a=rsa-sha256; t=1705070818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gVQbmHY++V1f4CIoXh4+fMMp37xdMz5P/twxQuwfXXo4I9GRy+ZUyqHMTz5T3ibJUGDf0icjh63NL5dd08ZSBXiVsMAugMsGre//YpRSbbUkhSr6nSwrl7fRL6TV7NXjUdHR3W6iaJ6/YEDh3hkA6QS88iN+Vl+8jiHYl/gicmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705070818; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JI9MFuiHBhfVMuyv26HNOejO23ktSBibpPQywig+lg8=; 
	b=fRu/yEPN8cD4YRAndrdOaNO3ZlbGYGdJehToL3pl6YMXvsBYm7yIPhNwU10YkImF/RRWqdpypgKLugD/LWudBX8zs5G9WC+T+gj3uB6HGgSyw/xKDxyWPVxjbGOSDqsKJFw62jOuqmWes4inUzjfcG13ZoCwl4ORka2Wd0PGttw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zoho.com;
	spf=pass  smtp.mailfrom=bouanto@zoho.com;
	dmarc=pass header.from=<bouanto@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705070818;
	s=zm2022; d=zoho.com; i=bouanto@zoho.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Feedback-ID:Message-Id:Reply-To;
	bh=JI9MFuiHBhfVMuyv26HNOejO23ktSBibpPQywig+lg8=;
	b=Ggev4phlaYdkON1nLUPo7OKsujAXTTEsSNGlWILoNs35q+fd9M/C7+lahX9b6So7
	4g+ZaCNGkSEesOcg2KO2J0ElyteNVuCpRxcEPf0n83Ih79SRVolZWUWNq8s599G7zUg
	FL7mu8Fxm8XQ7Q0rkbEneSFzUNELIZ9elQCob/60=
Received: from [192.168.1.172] (38.87.11.6 [38.87.11.6]) by mx.zohomail.com
	with SMTPS id 1705070816846927.1694142921847; Fri, 12 Jan 2024 06:46:56 -0800 (PST)
Message-ID: <b6fc8dd7be709b350bd50fa507ae03f4c3c89d8d.camel@zoho.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
From: Antoni Boucher <bouanto@zoho.com>
To: Sam James <sam@gentoo.org>, "brian m. carlson"
	 <sandals@crustytoothpaste.net>
Cc: me@ttaylorr.com, git@vger.kernel.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Helge Deller <deller@gmx.de>, John David
 Anglin <dave.anglin@bell.net>, arsen@gentoo.org
Date: Fri, 12 Jan 2024 09:46:54 -0500
In-Reply-To: <87jzofrlm4.fsf@gentoo.org>
References: <ZZ77NQkSuiRxRDwt@nand.local> <87v880m6r3.fsf@gentoo.org>
	 <ZaB-ayQuGqrS-mL0@tapette.crustytoothpaste.net> <87jzofrlm4.fsf@gentoo.org>
Autocrypt: addr=bouanto@zoho.com; prefer-encrypt=mutual;
 keydata=mQENBFOSMLQBCADO5aw6Ys8thMQUNzrwAnfJX2wbgWiz0pQ01DjYj22eeIpChkoZn6LWdt4dieq30u2rFi/yQzJ02foHwI2+aL9rU6xz/x4TwqyRJQGMOqklNc3R+pdXmH4WDQkQDWmLxvc07vu+zb8Tx5A6pMDh4J2ncCEhLEUcH39Yq/yg4eBnFwUX6N7kakvHrnScGNqhnSFCacoJeMJUAR+1G7VBSBd++jmnHLnx3mj7QkRZVECJUw2zqiv1yReCC6GU4SvqLjdqm5ZGeoWOqD/NHjBRoEeOVjzp6M/qOjjWRbkJVqmvgfcD8UytSSqqboR35YFT4L+rZt2ri3T12MJb3i5syCAXABEBAAG0IUFudG9uaSBCb3VjaGVyIDxib3VhbnRvQHpvaG8uY29tPokBVgQTAQgAQAIbIwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAFiEEOELC4Uw1Jeb66YE6RVeGAwR4zcEFAlz4QM4FCRLMEZoACgkQRVeGAwR4zcFBQQf/afttJrA/puADQZhrDfkgr0MFvq6iB+GCy1b8BkXimk1TOXTPt87YLehSeijNu3JkYhl5eRc87BNfU9J87KfI/KIy6hZxqlDXk16FhW9bw/7wYEA0hpb3MUn7xLElXDT0ZHaD+KTe8Oun7qfzgx5RlL6r/WODf3CkSpO085R/rfeBqDEx9mVlhDWgq6Az3CZoD+3CqiCKVqmDuHTWz4kwrd9AM5eVcLvvLKnZIdoIp+G5Ao6BvaGlZyfenN1iOSjLy2NXNt4MnUt0lUYEP5KSIIRhHQ8xkUbj7eWUmaahkxhNb3fH3sAPwGnRZrPpb4rgYzNmSk63wWMh9M2xk+rLb7kBDQRTkjC0AQgAumZzsAV/UFWI+dpzebQfma36kKYZZFuseant5sq/HWP553XQ/U6ttJiKyN5MpCqtxvCAoRplf42YhlHuFqgf73WJxoJ6Y+sdyqoBSwlR+
	gzAneAmsa8gmmY0wawH0Z2leazjKuS7mJjVEQZg0ZGsiCVRGeRnDqFGzDEzDc9ngWKSoTq0fKzlGy1X85OrtmUrvEbhSo6HP+FoeunHkIqrxu3w3vDoFEXxVQlKI6V3I4nCz5n6DB8WR3L7nsiiTnOiGirPw1ngvWFLW86kkA4FJpayc8Xl3va3SLY+2y4yuROboX2DVI4AC/Qeug/mDiBicPxkP6YfUartQRMe6obkEQARAQABiQE8BBgBCAAmAhsMFiEEOELC4Uw1Jeb66YE6RVeGAwR4zcEFAlz4QRsFCRLMEecACgkQRVeGAwR4zcE56ggAgTgrJInBKC+7552Dpccuo6Clh3wZfjlNLv9/6r5lKEbaNzaTrfhPiAP4WgnluIUmj8amOFLFJpj+BAVNOXpZ4D2R3o9ch8z7fot+fW4Yw+PKIxH4I2xEys8ndoEB3aiQwHjKcGIhkIU7uyMJFQr2aWjdTY0gmXw0YZueHOSLgo7uX4XKxB8fEO/yto/Tff2YBAAq+AtNwt+Gh5YS9rZw7rwUTWMi84yVOlc+zRE79E9NJkvdTwX7IJYo64VzIRNfgHsn7QNdVzuM1XIFHl+Glk6cIlI8s6BO7nEoCn3hTF104fQTAO3fEs+XXZOKXo2lk8faowEoPq5r58StrV0nyg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Feedback-ID: rr080112281fe87be69d4c4b71283273d10000977a807b6f8c29cbe27b8e12f616c0fc43ed6d02c14fa047a04b:zu08011226498a14e08f36f51541d23dea00008041e47e3d62df7ec85f21819152f8513457c0cc8b90a961:rf08011231da3a0b4509253d273e9f841d000035b050c0826f0098faa0012c16a16a6d4029958eac83f8b9d22b2b2afc14fa0a277dc0:ZohoMail
X-ZohoMailClient: External

While usable, there are a few things missing in rustc_codegen_gcc:

 * Unwinding doesn't work correctly when compiling Rust code in release
mode.
 * Rustup distribution: might not be mandatory, but I guess it would be
very helpful to have an easy way to install rustc_codegen_gcc and being
able to pin to a specific version.
 * Debug info: again might not be mandatory, but would be helpful.
 * Have not been tested on many platforms: these platforms had a few
tests, so while it's possible to use Rust on them, that doesn't mean
everything works (in particular, I know that changes will be needed to
both the Rust spec file and the standard library =E2=80=94 or its tests =E2=
=80=94 for
m68k): SuperH, ARC, m68k [1] and there's currently someone
experimenting on AVR. Related to the platform support, could you please
send me a list of platforms where git is officially supported?
 * Not sure if it would be needed, but the new inline asm syntax is not
supported on architectures not supported by rustc.
 * I also expect bad compilation in some cases.

> Is this simply library support in the libc crate?  That's very easy
to add.

We might also need to update the object crate.

As for the progress, we plan to have most of the patches merged for
libgccjit 14, but one important one will be missing because it's not
ready (the one for try/catch that is necessary to support Rust panics).
I expect there will be much less patches for libgccjit 15: probably
try/catch and bug fixing for the most part.
We also plan to have rustup distribution in the coming months, so
that's something that will help for adoption.
Along with rustup distribution, we plan on making architectures
currently not supported by rustc usable more easily in the coming
months.

Recently, I built and ran the tests of a dozen of the most popular
crates and all of their tests passed [2]. And rustc_codegen_gcc was
already able to build the Rust compiler in March 2022 and while not
completely working, the resulting compiler could compile a "Hello,
world!" [3].

[1] https://github.com/rust-lang/rustc_codegen_gcc/wiki
[2]
https://blog.antoyo.xyz/rustc_codegen_gcc-progress-report-26#state_of_compi=
ling_popular_crates
[3] https://blog.antoyo.xyz/rustc_codegen_gcc-progress-report-10

On Fri, 2024-01-12 at 08:24 +0000, Sam James wrote:
>=20
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > On 2024-01-11 at 11:45:07, Sam James wrote:
> > > Something I'm a bit concerned about is that right now, neither
> > > rustc_codegen_gcc nor gccrs are ready for use here.
> > >=20
> > > We've had trouble getting things wired up for rustc_codegen_gcc
> > > - which is not to speak against their wonderful efforts - because
> > > the Rust community hasn't yet figured out how to handle things
> > > which
> > > pure rustc supports yet. See
> > > e.g. https://github.com/rust-lang/libc/pull/3032.
> >=20
> > Is this simply library support in the libc crate?=C2=A0 That's very eas=
y
> > to add.
>=20
> [CC'd the rustc_codegen_gcc maintainer as well as some folks who have
> tried using rustc_codegen_gcc for their distributions.]
>=20
> Evidently not on the last point? ;)
>=20
> Even just patching it in downstream isn't easy because you then have
> to
> do it for many many packages. But after that PR stalling because of
> the
> policy issue, there wasn't really anywhere to go, because of the
> chicken-and-egg situation.
>=20
> Let alone then, once the libc crate has it, going around and wiring
> up
> in other crates.
>=20
> The discussion on the PR seems clear that the intention is to not add
> it until some policy is revised/formulated? I also don't want to have
> to have that debate with every crate just because rustc doesn't
> support
> it.
>=20
> >=20
> > > I think care should be taken in citing rustc_codegen_gcc and
> > > gccrs
> > > as options for alternative platforms for now. They will hopefully
> > > be great options in the future, but they aren't today, and they
> > > probably
> > > won't be in the next 6 months at the least.
> >=20
> > What specifically is missing for rust_codegen_gcc?=C2=A0 I know gccrs i=
s
> > not
> > ready at the moment, but I was under the impression that
> > rust_codegen_gcc was at least usable.=C2=A0 I'm aware it requires some
> > patches to GCC, but distros should be able to carry those.
> >=20
> > If rust_codegen_gcc isn't viable, then I agree we should avoid
> > making
> > Rust mandatory, but I'd like to learn more.
>=20
> It's in a general state of instability. There's still *very* active
> work
> ongoing in libgccjit (by the rust_codegen_gcc maintainer).
>=20
> I'd say "you need to patch your GCC" is probably not a good state of
> affairs for using something critical like git anyway, but even then,
> I'm not aware of anyone having used it to build real-world common
> applications using Rust for a non-rustc-supported platform, at least
> not then using those builds day-to-day.
>=20
> So, even if we were willing to chase the active flurry of libgccjit
> patches (which is wonderful to see!), it's a significant moving
> target. In Gentoo, we're probably better-placed than most people
> to be able to do that, but it's still a lot of work and it doesn't
> sound very robust for us to be doing for core infrastructure.
>=20
> We have a lot of packages in Gentoo - partly actually stuff in the
> Python ecosystem - where we're very excited to be able to use
> rust_codegen_gcc (or gccrs, whichever comes first inreadiness, surely
> rust_codegen_gcc) for alt platforms, but it's just not there yet.

