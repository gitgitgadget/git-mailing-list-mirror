Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E074C91
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387148; cv=none; b=MtQu90Lg9QMf8PG4xkezZHjBjHq/O+hCVznmraSRoDBJZpaFnuANnB6ABJBKrbfw1aAThUhI9T5Dq4qranRPml0HOgiSM2hUit3GegOkpQkGp+LbJgikkhq19696iAKVukdrtlgo+TGmbsYdFEIy9Qi7ua7KwAhHwvk/VKv1AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387148; c=relaxed/simple;
	bh=aFdh7phHjMis1Cx7zAXIaRRxqg75C8mh4fF8LrjUIcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCSH6OHJbzpPd1A/2Nb2BpVPT5vUFPzNIWeuAZnio35R1Pokv1DA203cpYufyZq/CveOJMVaXmB+q+zCBRKuCTMgOFKJ+bqDMDpvgM2EgDJ0ZILMQjO1T4saIN2OitaBxvpAIyEdCB8A0lkHLif7sYgaoteg0wmVxrVGW1A9ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KDb306B2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KDb306B2"
Received: (qmail 27201 invoked by uid 109); 12 Nov 2024 04:52:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aFdh7phHjMis1Cx7zAXIaRRxqg75C8mh4fF8LrjUIcI=; b=KDb306B2ScTOF4Rpe0CHMOH2/1Rnr++SP1eIlFdGiRexBo3IFIWlWuk1Itu6ZknlCjidP9o4h02XOUQF+H9vAldvimPqPdpgk/Bce8E01R2PYv10rh2JyEKn6L1gqYBe3JEycU/6Oq9lddDKO2EOJ/5jucrYTG9EqhoM11H4bcGKcssBOQXnpweirznBJR3EppTtEBVg4NAzLWzM6ygJKkg5d9MzH8/G+ue56H+oKpV5GdqDGy2V3UuGsOs2qb/SFX63TZvOTGJYJ1BD1uWDcdEqPYY5XJ5obbVM9aCRadkgHWC276wEkcr2CG9YUq99T1zDMULEgyBJ/Galwyvt2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 04:52:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25262 invoked by uid 111); 12 Nov 2024 04:52:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 23:52:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 23:52:24 -0500
From: Jeff King <peff@peff.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <20241112045224.GA98197@coredump.intra.peff.net>
References: <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
 <20241112022104.GA77521@coredump.intra.peff.net>
 <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <941bae7b-83be-43f8-aaa3-43b4d9501690@gentoo.org>

On Mon, Nov 11, 2024 at 09:36:25PM -0500, Eli Schwartz wrote:

> >  - how would I know this option exists? I think you mentioned elsewhere
> >    in the thread the ability to ask about which options exist, but I
> >    couldn't find anything via "meson -h", etc.
> 
> 
> meson -h lists:
> 
> 
>     configure               Change project options
> 
> 
> Which could perhaps be reworded as it allows you to both view and change
> them.

Ah. I saw that, but I tried:

  $ meson configure build
  Meson configurator encountered an error:

  ERROR: Directory /home/peff/compile/git/build is neither a Meson build directory nor a project source directory.

which seemed like a chicken-and-egg (I cannot configure a build
directory until I "setup", but I cannot "setup" until I figure out the
configuration options that work).

But it seems:

  $ meson configure .

gives me a list, albeit with a warning about using the source directory.
It looks like just "meson configure" does the same, but somehow I didn't
try that. ;)

> >  - is there a way to put configuration like this in a file, similar to
> >    our current config.mak?
> 
> https://mesonbuild.com/Machine-files.html
> 
> machine files (passed via --cross-file or --native-file) allow you to
> define your toolchain, e.g. set up persistent CFLAGS and CC that you can
> store as a configuration file, check into git, share with people, etc.

Thanks. And sorry, I am being a bit more lazy than usual about going out
and reading documentation on my own[1].

My usual workflow is to symlink config.mak to my custom file (which of
course I maintain in another Git repo). And then "make" just does the
right thing, even if I'm moving around through history, bisecting, etc.

I think the meson equivalent is that I would "meson setup build
--native-file /path/to/my/config.mak" once, which would copy all of the
values in to that environment. And then starting ninja from that "build"
directory would presumably work throughout history. My config.mak does
have some runtime logic, though (e.g., when bisecting old commits it
relaxes the compiler options). It sounds like that would need to re-run
meson, and not work at the ninja level.

I'm also not clear on how to alternatively build with different
optimization levels, or with different sanitizers. Right now that is:

  # normal build and test some script
  make && cd t && ./t0000-basic.sh -v -i

  # now with sanitizer
  make SANITIZE=address && cd t && ./t0000-basic.sh -v -i

If I understand correctly, the workflow here is either to have two
separate build directories, or to "meson configure" between the two.
And AFAICT the tests _have_ to be run via "meson test" now, if we want
them to find the Git built in the separate directories.

-Peff

[1] I think my gut feeling is that these are questions that Patrick
    should be answering if he wants to sell the project on moving away
    from make. I know we can't expect to be spoon-fed all parts of a
    transition, but I am starting from the point of view of: I am
    perfectly happy with make, why do you want me to switch?

    Another thing I am observing about this is that "meson" is not
    really just replacing "make". It is also replacing autoconf to some
    degree in probing various things (like gettext). But that is not
    something I (or most developers) were using at all. So it is not
    just transitioning to a different piece of software, but also
    changing the fundamental approach. Though I imagine with the right
    --native-file options, I could disable all of the probing entirely.
