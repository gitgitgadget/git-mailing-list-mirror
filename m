Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48864C28D13
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 11:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiHYLKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 07:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiHYLKp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 07:10:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4249D11C
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 04:10:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lx1so2398149ejb.12
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=LqHhlrHKu/1+gLsrtydPsyYZt22Iub0hTI5BAUR8GEI=;
        b=WqMuovg4PlSJFQtxlYEz3Mz7NuUp6rRvnrnG/syz8xO3Dpytw+933ZxGnrCaP9QC/y
         FGHY0xIWOXJX32+qW2cPW/Dt3+n36dYk35jqLj6FtZTHOIu2zWHi0qCXtDgdgR52uof+
         4FjV2RdCPW5LSjjTCMoF4bhWfbfYlNz8mwMwKHfRryLkpS7heQVFWfH0gZaJnP2dpnqb
         25Df3iHIlJk6lPKZiOU8lljdEaJlZIsQaQyZFazgo+UaWvsJGSZ/Do9TwGNqMMxmdi+s
         ymWPnRrRZeFPuuPMVfuEt7dTVrvun3/Nhx+GENWnNaM4vhpHNFxWoTjPgXayc85Uuiyw
         SLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=LqHhlrHKu/1+gLsrtydPsyYZt22Iub0hTI5BAUR8GEI=;
        b=H7S6UnCL0jPtSAxHR8rlQW925WQzQcVFXt5J7pp8yiPUSilYQF9dqoIUMvyfcRIipp
         1LNSErY4prJFsNPCRRX6O3CAFcTCzIe44CvdZ1X54gxjqIaoJbU2F4DFjRd8+ospsRds
         S5kbMYaqOeEPBRYiIsXWQK90iH6CYdlvRkyUKBCTb14o/57PTnauZnZKBQ9s9STFaN6R
         L3Y0t2uYTs6juKsVvNKLdqafKk7/vxF7ZVsnbVK3dqDLqGGsCS8/9Wh9UqbBCFmmLk9B
         p9xa3eP1Gw7vHrF0CWMY/LYxEoNF7GdFvlaQQ+hjWDTXgSNc92/uJfk3rU8LI3xosPw1
         sBEA==
X-Gm-Message-State: ACgBeo3oG7YgZUzv3X0I+awFEYgXiigHH/oDMGKAD+ApOc4kWX0/JpZA
        OicipEVAxXL51OP69WShknQ=
X-Google-Smtp-Source: AA6agR6TObAJnfuZYZ7nJ8vPI1oJDU53EIyWukCFvqreLHe4N1j5uDJ54Fowm4bfQCLtUyQ7nFZD1Q==
X-Received: by 2002:a17:907:a042:b0:73d:c891:2f6b with SMTP id gz2-20020a170907a04200b0073dc8912f6bmr1998370ejc.139.1661425843430;
        Thu, 25 Aug 2022 04:10:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709062f0900b00722e603c39asm2294559eji.31.2022.08.25.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:10:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oRAl0-001EnS-0N;
        Thu, 25 Aug 2022 13:10:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
Date:   Thu, 25 Aug 2022 13:00:19 +0200
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
 <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
 <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
Message-ID: <220825.86edx44lzh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 20 2022, Jeff King wrote:

> On Fri, Aug 19, 2022 at 10:58:08PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Yes, I spoke too soon, sorry. We still need ((unused)). FWIW the below
>> on top of master and doing:
>
> Right. Using ((deprecated)) is really just a substitute for the variable
> renaming part.
>
> And I agree it works as advertised, though I think I prefer the
> variable-renaming version.
>
> One, it feels like we're abusing the deprecated attribute here. The

Definitely, but structurally it seems like a better pick. I.e. isn't the
only problem with it the "deprecated" and its interaction with
-Wno-deprecated.

If the exact same feature existed as a "insert-custom-warning", which
would work exactly "deprecated" without the default warning "prefix"
would you think this would fit perfectly?

> ...
> -Wno-deprecated-declarations to get around _actual_ deprecated warnings
> (e.g., compiling with OPENSSL_SHA1=3DYes). And doing so would be cutting
> out half the protection of UNUSED() in that case.

This is mildly annoying, but I don't really think it's a practical
issue. We're talking about running this without
-Wno-deprecated-declarations in CI, and by default.

For unused parameters it's enough that we're catching them somewhere, or
in common compilation settings, we don't need to catch them
*everywhere*, do we?

IOW is anyone writing patches where they're testing with
-Wno-deprecated-declarations *and* adding unused parameters *and* won't
test without -Wno-deprecated-declarations before submitting them, *and*
nobody else will catch it?

> Likewise, one thing I like about the renaming is that it fails
> compilation regardless of -Werror. So it will be caught in any compile,
> no matter what. And I do automatically compile without DEVELOPER=3D1 when
> on a detached HEAD, because historical commits often trigger warnings.
> Go back far enough and OPENSSL_SHA1 was the default, which generates
> lots of warnings these days. :)

*nod*, I think this also goes the other way. It's nice to be able to use
DEVOPTS=3Dno-error to "get past" various minor issues. I consider an
unused parameter as being a minor issue. E.g. when ad-hoc cherry-picking
something to test on an older version it can be annoying to have to make
larger changes when a DEVOPTS=3Dno-error would do.

> And finally, I actually prefer the parentheses of:
>
>   static int register_ref(const char *refname, const struct object_id *oi=
d,
> 			  int UNUSED(flags), void *UNUSED(cb_data))

...and now to the real reason for the follow-up. You/Junio were CC'd,
but this is breaking coccinelle, see:
https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/

So, bikeshedding-wise I don't care to argue the point. But between odd
syntax highlighting and now one analysis tool barfing on it it's a bit
more than a bikeshed :)
