Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABEC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 01:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhLVBGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 20:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhLVBGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 20:06:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7E8C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 17:06:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o6so2012849edc.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 17:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KUuwaxXWMha9puqWI5MJ1/oP+E701GkklLmgF9x27z0=;
        b=JZmS9h4i7JhtJny/5oSYl/IdQgqes7orkIuTaIkINo0OJejpZJSq77sDQZ0p7q5BjJ
         y8LgaV0h7SHderl5ptKjlL/wZGBcrshgIBQ0xoUnqhS19gqcMPo1IQDx0T7t8m+wwNK2
         k+b1EN25a1Cbn6Ku0jdCZ1y2u9m2No7h+Vqt0D3NboRiFSvSSDcNHdVjPZ1gApUkuJib
         4nCR7X/x1Sj94GM+6a07t0UrVLPe9cvsXYTXxAeVX4w/AB/vZn4k+IpgEmX/e6mux+2f
         Ax2hoU/7uJzMC7sWx9ZckqCv/XrmSQKGE77PjzNGiKNOmOPQ7Dm+KCYK7Zg7Gc6lPEBI
         XIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KUuwaxXWMha9puqWI5MJ1/oP+E701GkklLmgF9x27z0=;
        b=pwi1e/j/iwRLS/lj4vin55Ntdxbvbpn6rUrOjUtLdghkmFml5VNbH2DZgCUnyzmus+
         oPyikHt0NpClMNoSl6WF4Wh4UDZKSmiDiaX7zVjaXOQQ9DlB4LcuhunBRyVpIWzZC091
         1Pf3Fgp0NcXvpfOW58d+VNeUFhQWgjoTsQNn3XrEXVIeoWKOo7XSXwawKcvtYFzkoYkR
         FTdUj8J77+AHmXMzv3AHmZfVuYI+keoblVGi2uj48hn8wmRu31xRXLpqbYcxszjm8O5H
         ahmWDFxFU4CM4Tp60+wYnXs8V3ChIzwR7xsTsw+wxz1pD3Y9yOIIoP43Zj4PRz/YCEvW
         QWbQ==
X-Gm-Message-State: AOAM530nbgGmRcQplz6QzqbvoKqXcyve1c1IbOWgb9R2TOfca/DkMcPK
        Qf2Gj9EEgaLgueXvvNgDC6oPEHV5c4o=
X-Google-Smtp-Source: ABdhPJw2/+JtOFnTceHTQJodJOOKzyw7FhUuoWQpLUy7/V52LVCQDISUZ1wQI7ZW1QeRN1JJPYlnSQ==
X-Received: by 2002:a50:ed01:: with SMTP id j1mr752470eds.126.1640135159686;
        Tue, 21 Dec 2021 17:05:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k21sm120648ejv.178.2021.12.21.17.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 17:05:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzq4s-0011gl-J3;
        Wed, 22 Dec 2021 02:05:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 9/9] doc/diff-options: explain the new --remerge-diff
 option
Date:   Wed, 22 Dec 2021 00:47:29 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
        <211221.86zgotprz3.gmgdl@evledraar.gmail.com>
        <CABPp-BHDJMecupic=ybVhzZbRC5=WmY616JQdbfaqw_1A5sMHA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHDJMecupic=ybVhzZbRC5=WmY616JQdbfaqw_1A5sMHA@mail.gmail.com>
Message-ID: <211222.86mtktphxl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Elijah Newren wrote:

> On Tue, Dec 21, 2021 at 1:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> >
>> > Signed-off-by: Elijah Newren <newren@gmail.com>
>> > ---
>> >  Documentation/diff-options.txt | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/Documentation/diff-options.txt b/Documentation/diff-optio=
ns.txt
>> > index c89d530d3d1..b05f1c9f1c9 100644
>> > --- a/Documentation/diff-options.txt
>> > +++ b/Documentation/diff-options.txt
>> > @@ -64,6 +64,14 @@ ifdef::git-log[]
>> >       each of the parents. Separate log entry and diff is generated
>> >       for each parent.
>> >  +
>> > +--diff-merges=3Dremerge:::
>> > +--diff-merges=3Dr:::
>> > +--remerge-diff:::
>> > +     With this option, two-parent merge commits are remerged to
>> > +     create a temporary tree object -- potentially containing files
>> > +     with conflict markers and such.  A diff is then shown between
>> > +     that temporary tree and the actual merge commit.
>> > ++
>> >  --diff-merges=3Dcombined:::
>> >  --diff-merges=3Dc:::
>> >  -c:::
>>
>> This & 5/9 would I think be better squashed into their respective "main"
>> patches.
>
> I presume you mean the "main" patch for this one is 8/9.  I was trying
> to find a way to break up that large patch, but this is pretty small
> so...sure I'll squash it in.
>
> What are you referring to as the "main" patch for 5/9, though?  It
> only seems related to 6/9 and 7/9 to me, but I very deliberately split
> those patches off and don't want to confuse them with unrelated
> changes.  I disagree with combining 5/9 with either of those.

I just gave it a quick initial skim.

I have sometimes found it a bit harder to review your patches due to
over-splitting.

E.g. (went back and looked) here tmp_objdir_discard_objects() is
introduced in 1/9 but used in 8/9. "path_messages" is then introduced in
5/9 and used in 8/9, no?

Anyway, just a bit of feedback. FWIW not just bikeshedding. I do find
myself stopping at 1/9, paging to 2/9, searching for the function, not
there, checking 3/9 etc.

I realize this is a bit of a stones & glass houses comment, but I find
it a bit easier to review things when a patch is larger v.s. having it
split up in a way where preceding steps don't do anything yet except
wait for use by a subsequent patch.

0.02 etc.
