Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7696BCCA47C
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 08:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiGOI27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGOI26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 04:28:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F0E37195
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:28:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so5422317edd.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JvxrNSshDWzKMhIJDfrYbFH0VJuiRiJFj7392TYcIok=;
        b=iIlrf6R73eCeaXAB74M0MS1lIszlnmjE7VMprCq5Cm7QJ4xdECH1HMb0pr0yMlTskX
         LBPR4ALyk88krer1nwLUV1Q4FyGaRPO61jNzHzsVaWHVzPRsigxwcNBdEUkm9syU02x8
         wNBCBkXeKlouZ1DSVXOVMEVaSn6iqEVWWeCpSJAnJoEZzVBzootdRYDAqMjnq5Yq1952
         oWa10BZpQ35FP2T8/EMS14oo88Dk0b7OgTyg4V8Rtk9haOwzOQmLpNl1jznB1g/73E5k
         xHqOZJzPTAN55/K0kzTfigap6qrFxm1jSb+sB2XU4fKTekRa50nWZ8MxAPRODy551Bsp
         gpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JvxrNSshDWzKMhIJDfrYbFH0VJuiRiJFj7392TYcIok=;
        b=i3fsRgMrGq4TBjyYkzcC2vJeTobDSaSkXYTnx+Eopw9UnETZ/Tg6UyOBw0M+Ym8xmg
         jzNLi2maln895rosepL5KkxKyAOVt6rVrUTGQOcSNd1VXquFtwLQY2hcHin7IDkZT+tl
         X0AV5kunOQHio2+mCaiYYvnLNFz73viNhHjTwZ/p9gUtW9Q4xH6HBeI8kiZUikY2kb3Z
         oQFQfAwwHeteFWHG2EHNdNNxmiQMMIpac3jMrx8CfAJes9efaGQ3avHCv9mfV7EXTp29
         2AZuCRyTCcybQ76O1Op4beRkgBrD1BiyDGdmUeS3Tt222AZSHrLH7RWuhPNQoXKvNs6f
         MVmQ==
X-Gm-Message-State: AJIora+wg+w/ZFOKpekqgLALeu2AQ/WfRVlAVPliUtHvfns32Qy+rVYt
        vo/hoOTns2VcMDoohGmdB6s=
X-Google-Smtp-Source: AGRyM1vD8+3+XAhjc5yx7lG6w6s9pbULZMqzio55tGDoz/wsd/oyY6DoOeS74XATJC3fnviQUfiLiA==
X-Received: by 2002:a05:6402:194d:b0:43a:82da:b0f3 with SMTP id f13-20020a056402194d00b0043a82dab0f3mr17232145edz.104.1657873735117;
        Fri, 15 Jul 2022 01:28:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id qx21-20020a170906fcd500b0072abb95c9f4sm1724463ejb.193.2022.07.15.01.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:28:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCGgv-002bIV-CQ;
        Fri, 15 Jul 2022 10:28:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
Date:   Fri, 15 Jul 2022 10:20:35 +0200
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g>
 <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com>
 <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
 <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
 <220712.864jzm65mk.gmgdl@evledraar.gmail.com>
 <YtCQl1oinrVnfa+6@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YtCQl1oinrVnfa+6@coredump.intra.peff.net>
Message-ID: <220715.86edym230a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Jeff King wrote:

> On Tue, Jul 12, 2022 at 11:16:10AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> I'm in favor of this. It would, of course, require extra
>> >> special-casing for Apple's clang for which the version number bears no
>> >> resemblance to reality since Apple invents their own version numbers.
>>=20
>> FWIW I was imagining just providing that -Wno-* on clang versions <=3D 1=
1,
>> not special-casing Apple's in particular.
>
> It's not about special-casing Apple in particular. It's that our
> detect-compiler script does not understand which version of clang is
> used for Apple's compiler. Their version numbers are totally mismatched.
>
> So you either have to say "turn off this warning for clang totally", or
> do the wrong thing when Apple's compiler is in use.

I missed the part where we don't even detect the version in that case,
but anyway, just turning it off on clang && OSX seems fine. This is
-Wmissing-braces, we'll catch it elsewhere (CI etc.)

>> I have a local patches that carry forward the idea I had in that thread,
>> i.e. to drop all this version detection insanity and just compile a C
>> program to detect the compiler.
>
> Hmm. I prefer your earlier suggestion to use "$(CC) -E". This tool has
> to run on every invocation of "make", so the lighter-weight it is, the
> better. You say later...

We only compile & run the binary once, then save the result to a *.mak
file, the intention is to get rid of running these binaries or script on
every single invocation.

>> The compilation is then triggered by the include in config.mak.dev,
>> which has a corresponding rule that creates the C program, then the
>> generated *.mak, so once we do it once we're only ever including an
>> already generated text file.
>
> but that implies we don't have a dependency on the compiler itself.
> You'd want to at least depend on the name of the compiler. But that
> would also miss if running "clang" changes which version of clang you're
> running. I know upgrading your compiler is rare-ish, but this is exactly
> the kind of thing I expect to bite at the most annoying time (when
> you're switching around versions to try to figure out how they behave).

That's true, I considered that OK, and still do. I.e. we use this for
config.mak, where we are opting you in to never flags.

If your compiler name changes your GIT-BUILD-OPTIONS will change, so
we'll re-build and re-detect.

But yes, if your CC=3Dgcc and you change gcc from under us we won't
re-detect and re-build.

But isn't that fine? You just won't get newer flags, you might downgrade
your gcc and get an error, but generally speaking make-based systems
really don't try to detect "anything on the OS" changed.

Still, I could easily add something where we one-off run "command -v
$(CC)", save that to a file, and then add that to our "make" dependency
tree.

So then if the compiler binary's mtime changes we'd re-build, and we
still wouldn't run something on every invocation.

It just seems to be quite pedantic about correctness, is all :)

>> 	#ifdef __clang__
>> 	#if __clang_major__ >=3D 7
>> 		fn(util, "NEEDS_std-eq-gnu99", "1");
>> 	#endif
>
> This is still gross version detection, but I don't think we can avoid
> it. However...

Yes, this part isn't really nicer, although with this method we could
also avoid this sort of thing by just trying the flag out & caching
that, but this seemed OK.

>> 	#if __has_warning("-Wextra")
>> 		fn(util, "HAS_Wextra", "1");
>> 	#endif
>
> ...this is much nicer. It could still be implemented purely via "-E", as
> far as I can see, like:
>
>   #if __has_warning("-Wextra")
>   HAS_Wextra =3D 1
>   #endif

*nod*, I wish GCC had that.=20

> But then we end up having to do version comparisons for gcc anyway:
>
>> 	#if __GNUC__ >=3D 6
>> 		fn(util, "NEEDS_std-eq-gnu99", "1");
>> 		fn(util, "HAS_Wextra", "1");
>
> so it feels like we're back where we started. You've just encoded the
> version checks in a different spot.

We're really not, the reason I did this was because i tried to add
support for xlc and suncc to this script, we don't even parse
detect-compiler on Solaris now, as its /bin/sh isn't compatible with
it. So to begin with we'd need to hoist the "shell detection and script
generation" out ...

> I dunno. I don't find this significantly less gross than the status quo.
> I don't mind getting the version via "-E" rather than "-v", but whether
> the policy logic is in cpp, or in shell, or in the Makefile, it still
> needs to exist. Putting it in cpp allows using has_warning(), but since
> that isn't available everywhere, I'm not sure it buys us much.

Compilers universally support "who and what am I?" via their native
macros, but we're trying to do it the really hard way via parsing
version output.
