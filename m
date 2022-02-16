Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62398C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiBPQDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiBPQDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:03:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57E1EFC53
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:02:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so1973848edk.12
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0uNdjCRihoYw2QAC5A3Ov5dsP2Q4uKTaUP2MWZM63oQ=;
        b=cuWnjQiSJe8i0yBeE+cAUTC1CM9o3x1WwVvYVn54fZcXtdRti2iWEo4Rvus6PeXLON
         kbE/gbP/70t80JJC7MqvXjFhbaf14XffzsDzPQuP47qIzhybYNc4UTFhu6qHl1apJ1wy
         pgXk66N/Ym+PYCqv7Hv16A6PPApzgJXQ869JCf7PwSmb6uuySKWqEn/Uf+KXQvOIA1u1
         OG9KJSuaNyrQy2hP7yKzsJ7xM8jpOscc5hnaZRsAO2Bl3qbzEJMgSsa26SqleqIdsqj7
         bTBTvqdzXkBwKa418KdiwX56dtlQk+mI9hprFQ66i3bz9IdlLPtDMJ3vaIO0M8Hecily
         iKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0uNdjCRihoYw2QAC5A3Ov5dsP2Q4uKTaUP2MWZM63oQ=;
        b=6oyTdD4lakmYoqrF/2hz02svNsZ/OkCtOidhKTbXr8c74Dwtb8CFibRFyqwUElj9lW
         7SdSl4MzTXq8LUWOfQaGB/v3PYtOc3v87YdcABW7G0GCyV0dB7kL+VPykXxjn1a1uhBf
         47xPIIj0dnF/gsr9LpdnJ+CNzG22xqzbuKf8lDXNMZBJnlQ/bqb+9oByaxvB8oJR7bNH
         A5iS6l4Z50J2TngQack8H6HjsV6oqcHWuYMU5TouLbxj/dLOQfJhI56eT8A2FKOQTavy
         LMqNcWmY5Rr/DU7PvdxSy0pQvL8bwAvUF6n04EUymQLIOxZxPGut4+WfKp5LELArjfpC
         Ghyw==
X-Gm-Message-State: AOAM530Hv6reS/s+yAf4NvZ6S6xPsEmj9u84oJSiSA9ZQwFsqp8Sc24F
        /wCQIP0g0HpBJTZTb6TatVov6QTXRhG7yvGD9sI=
X-Google-Smtp-Source: ABdhPJxbgRAkORgLBtaawgCDbUum3BehnJYj0iUb6Tt/UzOZA8KjkLZR3DaG4F0ptz2zrkZp7/0zEH1oIb+MJOXqB7M=
X-Received: by 2002:a50:9ea2:0:b0:409:5438:debf with SMTP id
 a31-20020a509ea2000000b004095438debfmr3739843edf.126.1645027370144; Wed, 16
 Feb 2022 08:02:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com> <d50d804af4e17ff1613ae40e3b5cf1b1bd0986a0.1642175983.git.gitgitgadget@gmail.com>
 <220216.86sfsjur8m.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.86sfsjur8m.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:02:38 -0800
Message-ID: <CABPp-BGD4m-QzQ+qqLc4QzP6-HcJDi2RAmzf+=dhxpvPjrRVEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] t1011: add testcase demonstrating accidental loss
 of user modifications
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 12:53 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jan 14 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> > [...]
> > +     test_path_is_file init.t &&
> > +     grep -q dirty init.t
> > [...]
> > +     test_path_is_file init.t &&
> > +     grep -q dirty init.t
>
> Maybe I'm missing something, but can these two just be:
>
>     grep dirty init.t
>
> I.e. won't grep report errors appropriately here, e.g.:
>
>     $ grep foo t
>     grep: t: Is a directory
>     $ grep foo x
>     grep: x: No such file or directory
>
> The only prior art I could find was the same pattern in your c449947a79d
> (directory rename detection: files/directories in the way of some
> renames, 2018-04-19).
>
> It's probably good to lose the "-q" too, unless this output is way too
> verbose without it. In any case the errors wouldn't be affected.

Fair point.  I believe my original test during development was just
test_path_is_file, then I came back later and decided I should check
the contents weren't lost.  A test_cmp might be a better choice to
replace both of these, because we don't really want to check that it
just has "dirty" somewhere in the file, but that it's been left alone
and only has those contents.
