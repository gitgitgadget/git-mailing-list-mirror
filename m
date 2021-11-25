Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F19C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 11:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhKYLa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhKYLai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 06:30:38 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108BC061394
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:19:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so24202669edd.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CPt3KoTctIRJHHzQsx2vE6PGFJeBrFZ4Stes13xyUbk=;
        b=qenWcxW5MJd/sa3mDKyCPHH1ZCWUCcaGbDoy61lK2IEyqR8qltkPeAIKBM0j+cowtq
         RceKPDGCQAweLPY8AJyeaBJz4hGjj3kxiv4ZNmFzrl0atx05od9GHPnljIY6rBKOzuLw
         Smio1dqAQzTTUCCOkOQmzCsIxE96YXT99+Hy982sEJ9QolV6lu57/osRqGJPjnoRKbGe
         vedbxANc68VyXsSALBOVhFRloAlyFne++qZ12N0CfSX0U6CsgpAQrhwKpHJEy5jZKUxN
         SSzTf/qS/4Kub1i+GrvYeUrgGbiMwqixdKN+HYUPIxKZAbLzqf+YVK5evpWG0FWcXiWJ
         3P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CPt3KoTctIRJHHzQsx2vE6PGFJeBrFZ4Stes13xyUbk=;
        b=mYRAUsaml1JWV++qF8NxJfDiH8vwXX1eMCbN8YldSb9m7Db/VXypCFs8O6ULJOTtk/
         WPETOZGVwB5U6UrRrVxMkKDiZDgoZeBTgUfUCs5TnwvrkwZxAtFjeCN374sxbeQhv0OC
         SQj6769UAqSGaOjUxgf6nWkNfQLwzYHYuzRmpffOFQAfTt11fliWNn7goicCrffvbV91
         LwFLjrm5OkJPXubFOPdqx7bCLcnANIHBbWIcmoKnfcyYJqEIO2FldF+jm2gEo68/nlqk
         sFg0mwrfBoIihh1ULftpAKr+toCxMp2EE6sz+qj5ujcOWb/P8/app/uon1vuoDcdLupU
         4Bxg==
X-Gm-Message-State: AOAM5321D+bnvboQ3+0N3Mt/KGkpNQS3GPbg+ImvdGdasfWsjgb60KWk
        Hn74nVaVg4bN9iG9mzHvv9HNG2r9KRI=
X-Google-Smtp-Source: ABdhPJy/XMH4Pu2u9EJzhI/SuBx9SLaKiD9vgruw8ZkjeOC70rhruzy89Gqjllv4zBxzByPPVsIe3w==
X-Received: by 2002:a17:906:2ada:: with SMTP id m26mr29744587eje.571.1637839189951;
        Thu, 25 Nov 2021 03:19:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bd12sm1640042edb.11.2021.11.25.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:19:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqCn6-0005Ee-Lt;
        Thu, 25 Nov 2021 12:19:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Date:   Thu, 25 Nov 2021 12:12:04 +0100
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
 <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
 <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
 <211124.86sfvld4cl.gmgdl@evledraar.gmail.com>
 <CABPp-BH_NfkzX5XkhPPpX1_bsR9kWGsBBdcUwikDWsA8jc6KJA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BH_NfkzX5XkhPPpX1_bsR9kWGsBBdcUwikDWsA8jc6KJA@mail.gmail.com>
Message-ID: <211125.86y25ciisr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 24 2021, Elijah Newren wrote:

> On Wed, Nov 24, 2021 at 6:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> I fleshened this out a bit in this WIP change:
>> https://github.com/avar/git/tree/avar/setup-handle-gone-directory +
>> commit:
>> https://github.com/avar/git/commit/97968518909eef88edba44973b7885d154b7a=
273
>
> Sweet!
>
>> As noted there there's some caveats, but so far nothing I spotted that
>> can't be overcome. It's particularly painful to test it because of an
>> implementation detail of our test suite, the bin-wrappers are
>> shellscripts, and the very first thing they do is reset $PWD (none of
>> which happens if you run the real "git" binary).
>>
>> That's b.t.w. the "shell-init" error you noted in
>> https://lore.kernel.org/git/CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZ=
eOH1kRw@mail.gmail.com/,
>> it's from the bin-wrapper.
>
> To be a bit more precise, the error/warning is from bash rather than
> the bin-wrappers specifically; for example, you can also trigger the
> same shell-init message with a simple `bash -c 'echo hello'` when your
> cwd has been deleted.

*nod*

>> I really wish we didn't have the bin-wrappers...
>
> I'm curious: is this issue the only reason, or am I reading between
> the lines correctly that you have additional reasons for that?

I think it sucks in general :)

This is a much bigger change than what's needed for this topic or the
proposed setup.c change I've got, but what we should be doing in general
with bin-wrapper is to not have them at all under RUNTIME_PREFIX=3DY
(which we can make the default), and simply have a built/ directory or
something, the structure of that directory will then 1=3D1 map to all the
relative paths you'd get if you did a "make install".

Currently in a built checkout you can do:

    ./git version

But not:

    # need to add --exec-path=3D$PWD
    ./git clone <http url>

Or:

    ./git send-email ...

Which all comes down to sillyness in how we try to discover these paths,
the *.mo files etc., there's also Perl-specific caveats in there.

We'd still need something like a shellscript wrapper for the case of
GIT_DEBUGGER, but we could just move that to being a compile-time flag,
i.e. we'd swap out the "git" binary for a shellscript that chain-loaded
to the "real" binary.

It probably matters a bit for e.g. test suite performance, currently we
spawn an extra shell for every single "git" invocation, but I mostly
care about it for correctness, e.g. in this case of $PWD munging, and
being able to have running a built binary from a checkout Just Work
without the wrapper.
