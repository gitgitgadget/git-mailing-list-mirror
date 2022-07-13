Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiGMNYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiGMNYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:24:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE610B0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:24:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t1so4093685ejd.12
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B8Q3fFsBEK2tmHkfeKJpX6lmpRt2DxgAYbx3tXQs6F0=;
        b=Fq5P/fl1RCs/3dX0rsW9t0v8Sm5FoHi3i+JO4gEPDeTeXMR/kcmZk0wxWEAtKzTqCB
         yqvZMDW34LXECuBFCmplcADfk4klojMh50tRFsSSaHF0GSvcZ+DPaPVAx8Dho+qTdE4Z
         rfTGi7oZwMtvh0LKj5Mmmu/Kr8+tD/0LZXs1duMVdIsYiVlyq3/8Rn32F0snpF+Jh7QL
         fwmxv7m/VOl4fEkaD/ckdwoT0iUBEKHssan1ZRdO2N6SWXWK/qvPP61eWZnbl3V3fUqh
         To4EL0k++aeTN9q+SaMmjIR/5wed67L4DoUAU8Ks9ZQ42sDpGkqPHeFh3rx5wbAzma1B
         TGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B8Q3fFsBEK2tmHkfeKJpX6lmpRt2DxgAYbx3tXQs6F0=;
        b=t1G1LDfUQVs2gGBLiDqPYXVlJ6KXPvR7hNNpHs5VKQtZUfgvYsp+3WCmI9OiUbGxcq
         fu+xyruJAzMmKx9PTwz90LN7iGRz2wxCKbyZgn5RW6yhGlXB4Wh43JkVx/ankGlRXKYy
         EFW3Fk/pFbLHU5tpBDeYcsYufSwM5EaHID9pbTZmEKdsX7ue/k7bT+jhKHr5jmewIALs
         HMgF55J1lwEuh1Qszv6TcCknkPI3TiItLbOFSeDTk2109Mn0kTRyc8AbtuOqq6GKbS3Q
         Grp5XH8AP6lyS3F6ol5cxPk7gr7/Swf5l6PWBiP8xMY6mv8oG8ICMkFFqPxQK+v7yhmp
         eEPQ==
X-Gm-Message-State: AJIora+t85icKn0IJIaSBK3ceQ4AtnIpS6+NTR3sIPzDINbMNixk4WAG
        HGZcAWMQ+xHwEHkvdBbbYQg=
X-Google-Smtp-Source: AGRyM1sPUKy74n4nBglf/tYsig3ClzuUBRAe3qE+iUjFCo0V4SBbR+XYxkTtgAWPQhIMmW6OPyLxsw==
X-Received: by 2002:a17:907:2724:b0:72b:526f:6389 with SMTP id d4-20020a170907272400b0072b526f6389mr3514985ejl.289.1657718653952;
        Wed, 13 Jul 2022 06:24:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q7-20020a1709060e4700b006fe89cafc42sm5017259eji.172.2022.07.13.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:24:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBcLc-001kzN-N6;
        Wed, 13 Jul 2022 15:24:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Date:   Wed, 13 Jul 2022 15:18:29 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
 <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
 <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
 <220711.865yk47x54.gmgdl@evledraar.gmail.com>
 <bbfa1340-9cab-35d7-2245-f6f8369d5cd4@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <bbfa1340-9cab-35d7-2245-f6f8369d5cd4@gmail.com>
Message-ID: <220713.861qup403n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Phillip Wood wrote:

> On 11/07/2022 11:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Jul 11 2022, Phillip Wood wrote:
> [...]
>>> Thanks for showing this, it is really helpful to see a concrete
>>> example. I was especially interested to see how you went about the
>>> conversion without redefining standard library functions or
>>> introducing non-namespaced identifiers in files that included
>>> xdiff.h. Unfortunately you have not done that and so I don't think the
>>> approach above is viable   for a well behaved library.
>> Why? Because there's some header where doing e.g.:
>> 	#include "git2/something.h"
>> Will directly include git-xdiff.h by proxy into the user's program?
>
> No because you're redefining malloc() and introducing ALLOC_GROW() etc
> in=20
> src/libgit2/{Blame_git.c,Diff_xdiff.c,Merge_file.c,Patch_generate.c,Check=
out.c}
> and
> Test/libgit2/merge/files.c. It is not expected that including xdiff.h
> will change a bunch of symbols in the file it is included in.

...which is why if you read to the sha1collisiondetection commit below
you'd follow that up with including a header at the end of xdiff.h which
would do:

	#undef malloc

etc., so you wouldn't leak that macro beyond the code that needs it, and
you wouldn't leak the xdl_* macros either, which are purely needed
internally in that code. So even aside from my suggestion of doing it
this way it seems to me the structure has macro hygene issues worth
fixing, see e.g. how we have refs-internal.h v.s. refs.h in git.git for
similar reasons.

>> I admit I didn't check that, and assumed that these were only
>> included
>> by other *.c files in libgit2 itself. I.e. it would compile xdiff for
>> its own use, but then expose its own API.
>> Anyway, if it is directly included in some user-exposed *.h file
>> then
>> yes, you don't want to overwrite their "malloc", but that's a small
>> matter of doing an "#undef malloc" at the end (which as the below
>> linked-to patch shows we'd support by having macros like
>> SHA1DC_CUSTOM_TRAILING_INCLUDE_UBC_CHECK_C).
>> Aside from what I'm proposing here doing such "undef at the end"
>> seems
>> like a good idea in any case, because if there is any macro leakage here
>> you're e.g. re-defining "XDL_BUG" and other things that aren't clearly
>> in the libgit2 namespace now, no?
>>=20
>>>> Now, I think that's obviously worth adjusting, e.g. the series I've got
>>>> here could make this easier for libgit2 by including st_mult() at leas=
t,
>>>> I'm not sure what you want to do about regexec_buf().
>>>> For the monkeypatching you do now of creating a "git-xdiff.h" I
>>>> think it
>>>> would be very good to get a patch like what I managed to get
>>>> sha1collisiondetection.git to accept for our own use-case, which allows
>>>> us to use their upstream code as-is from a submodule:
>>>> 	https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fc=
ef
>>>
>>> Thanks for the link, That's a really good example where all the
>>> identifiers are namespaced and the public include file does not
>>> pollute the code that is including it. If you come up with something
>>> like that where the client code can set up same #defines for malloc,
>>> calloc, realloc and free that would be a good way forward.
>> I don't need to come up with that, you've got the linker to do that.
>> I.e. for almost any "normal" use of xdiff you'd simply compile it
>> with
>> its reference to malloc(), and then you either link that library that
>> already links to libc into your program.
>> So if you use a custom malloc the xdiff code might still use libc
>> malloc, or you'd link the two together and link the resulting program
>> with your own custom malloc.
>> As explained in the previous & linked-to threads this is how almost
>> everyone would include & use such a library, and indeed that's how git
>> itself can use malloc() and free() in its sources, but have options to
>> link to libc malloc, nedmalloc etc.
>> But instead of using the linker to resolve "malloc" to git__malloc
>> you'd
>> like to effectively include the upstream *.[ch] files directly, and
>> pretend as though the upstream source used git__malloc() or whatever to
>> begin with.
>> I don't really understand why you can't just do that at the linker
>> level, especially as doing so guards you better against namespace
>> pollution. But whatever, the suggestion(s) above assume you've got a
>> good reason, but show that we don't need to prefix every standard
>> function just to accommodate that.
>> Instead we can just provide a knob to include a header of yours
>> after
>> all others have been included (which the libgit2 monkeypatches to xdiff
>> already include), and have that header define "malloc" as "git__malloc",
>> "BUG" as "GIT_ASSERT" etc.
>> And yes, if you're in turn providing an interface where others will
>> then
>> include your header that's doing that you'll need to apply some
>> namespacing paranoia, namely to "#undef malloc" etc.
>> But none of that requires git to carry prefixed versions of standard
>> functions you'd wish to replace, which the patches here show.
>>=20
>>> I do not think we should require projects to be defining there own
>>> versions of [C]ALLOC_*() and BUG() just to use xdiff.
>> No, I don't think so either. I.e. the idea with these patches is
>> that we
>> could bundle up xdiff/* and git-shared-util.h into one distributed
>> libgit, which down the road we could even roll independent releases for
>> (as upstream seems to have forever gone away).
>> Whereas the proposals coming out of libgit2[1] for generalizing
>> xdiff/
>> for general use seem to stop just short of the specific hacks we need to
>> get it running for libgit2, but e.g. leave "xdl_malloc" defined as
>> "xmalloc".
>> That isn't a standard library function, and therefore the first
>> thing
>> you'd need to do when using it as a library is to find out how git.git
>> uses that, and copy/paste it or define your own replacement.
>> Whereas I think it should be the other way around, we should
>> e.g. ship a
>> shimmy BUG() that calls fprintf(stderr, ...) and abort(), but for
>> advanced users such as libgit2 guard those with "ifndef" or whatever, so
>> you can have it call GIT_ASSERT() and the like instead.
>> 1. https://lore.kernel.org/git/20220209013354.GB7@abe733c6e288/

^ I.e. this.
