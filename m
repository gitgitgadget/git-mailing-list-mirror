Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D712C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5660EE5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 01:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhIWBSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 21:18:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA7C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:16:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so17096035edt.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BOSM2nTjzatTc+Xw4kisw+rhHSowk5oSFOZTDheLfBw=;
        b=kmSIyjXDCovHH6NglxNZZH/kHWXoX0eQFZwQXbgYjoa3Qcf0IrCa5uFEJhWhmAkbvv
         FSWflGPJi5Tgp9MTSjXEhITB+/p+n0e5L06OatgEan8o3NkZXd65yanuPt7fJU1cTngx
         co8JtlUgeQSHZiuwycDw2w5XpjjH1wZpwPxmPxK7b87VkUV0rjkcfA+gYvQJJN/zIJ1q
         gLiRZQ0wdEXn6ncX54bGnmhhW7H6wFSVSn0Grnw6kXjmkmkJFK/iY34FXSNFqCh0Q4aY
         y3MAA9Dwa7PyhNxkJSJWSvxB+MYX4gZenqN+SWSzZA7ESou7JpqQfOOEzFJGPOcg8c83
         ikuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BOSM2nTjzatTc+Xw4kisw+rhHSowk5oSFOZTDheLfBw=;
        b=xMYtE+ndGJ9v4eLIA0wILcW/jUA0aDhu6Hk+tUx6fCCTgmSHRqbsMhxFm6smTfD9R6
         1BjyfeY4dFkiReqtEjt+sA2VZeOLGIOrmB4RW1Loa8kQAsdNDU8RdXr2lGxYXyxv21Rn
         J+VREJXnp8tLRcgWiyPUe4xTSqx4u/+qPoc+QEEl0cCnCDbgZbZ618bxZYs0bzsmkbm+
         BWHyj4H/AZUJN/+2hMAwQ2BefgLBzJ8A5BwhfpbeVAP3ykkYml3mO/qkuQn1NYehcMGv
         inTT2CcjOYAxjMYH1pg1cE0FYfyd0B0I7N6HsYtys5RAsiwSqEmDcHcAeRCJmxz0IDmv
         l/3A==
X-Gm-Message-State: AOAM532wXsUE1xdcfEjFskhOBsusbAb7ZfWGgrM0mT+ZKhDbrbUhncPN
        bM2nlpdHXx9KGT6Ja70J/tg=
X-Google-Smtp-Source: ABdhPJyPvpfWa+r9Y5yQzSsHjfF92WEPikr3y47bsBaP3vDEtQIV7iZcxs58UJYXjofkyBQ52L7WEg==
X-Received: by 2002:a17:906:48e:: with SMTP id f14mr2179647eja.433.1632359792756;
        Wed, 22 Sep 2021 18:16:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k15sm1872876ejb.92.2021.09.22.18.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:16:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
Date:   Thu, 23 Sep 2021 03:07:04 +0200
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
 <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
 <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
 <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
 <xmqqsfxw42c1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqsfxw42c1.fsf@gitster.g>
Message-ID: <87pmt05bww.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>>>> At the heart of my unease is dependencies (or rather the lack) for
>>>> the 'synthetic object files' *.hco and *.sp. (Also, the addition
>>>> of even more 'shrapnel' to the build directories - I wrote a patch
>>>> to remove the useless *.hcc files just after commit b503a2d515e was
>>>> included, but didn't get around to submitting it).
>>>=20
>>> I don't consider them shrapnel if they're holding useful results. :)
>>
>> Heh, yes I am a bit of a curmudgeon! :D
>
> We do not necessarily have to have these files immediately next to
> the corresponding source file.
>
> For example, we could give .shrapnel/ hierarchy to *.hco and *.sp
> files, so that for revision.c and compat/bswap.h, we'd create
> .shrapnel/revision.sp and .shrapnel/compat/bswap.hco files that will
> not be so cluttering ;-)

I've got some WIP efforts in other areas to do that for some other
rules.

The problem is that you need to "mkdir .shrapnel" to create a
".shrapnel/revision.sp". So you need the ".shrapnel/revision.sp" to
depend on the ".shrapnel".

Except you'll find that the na=C3=AFve implementation of that fails, since
any file you create will bump the mtime of the containing directory, so
you'll keep re-making ".shrapnel/revision.sp" because ".shrapnel"
changed, because ".shrapnel/revision.sp" changed...

This is why we have the "missing_dep_dirs" hack for
"COMPUTE_HEADER_DEPENDENCIES" in the Makefile, i.e. we'll make the
directory, but only if it doesn't exist, we bypass the normal "make"
dependency mechanism.

Another way to deal with it is to have say a
build-stuff/dropit-here/file.gen that you build from a top-leve file.c,
then depend on a "build-stuff", that does a "mkdir -p
build-stuff/dropit-here", I used that trick in another case where the
file.gen were not nested.

But for creating subdirs etc. you'll quickly get into a lot of
nastyness, which I'd prefer to just avoid here.

We already have e.g. the *.hcc files, let's leave generating these on
the side somewhere to some more general topic, which could also move the
*.o files out of the top-level if we're caring about the cleanliness of
the top-level directory.
