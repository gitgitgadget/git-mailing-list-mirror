Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D9C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJERUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJERUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 13:20:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4E6292D
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 10:20:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so15793217pgs.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCzOW4PKJNShYuo8jDSassR1z3xr31LxY2At9AOINtw=;
        b=WethcznSvTM5I9qXtuJJzz4tJ+3Cce+VxlR9Oiw613eFVj+n7YqKpg7UEGSnLDP5/x
         MwIxcJrliBWPtEyIHq4rt41WgeKLZRB21fdsRpDgR78NB+KkQRES7gP+Jh8cZXmqoFrD
         edQlYsa0mJ/AkR6bxVW77pfW01Ee2dDtLt/NfKm3UvVgBGz+JeeG/RBCSDC+KiElczvG
         +kZ9izB9Th00+CvutFbDzYwPeJcij4oC7Xb7iAeRL0PPdDvwC55WWk6zt/A1/O6VXr3E
         WNJjtdHP3QVGH0t72kw+jb5OgrggmPVL/gpIgyeKCgSO1OJzVFlc6p9f7SdUOdwHFHAC
         bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCzOW4PKJNShYuo8jDSassR1z3xr31LxY2At9AOINtw=;
        b=E95uKo8IHHbXi+sUVY9Ib7oVLAI+ywa6EEnga8Swc5hEumyGIbhWCQjilM5VIxxrZ5
         9hDX1WBJ2ETj4sEpcsy0in/Jk++4qOV4jZT16UVblpl2iA09+tfisiqymvVH/t3fibJ0
         Ohb39fDExRjdcJEqKGR3A5WWkpTIX4XIN+tpJmnxYEi54Kdov6dQ/Bcd9NWKYfglGwZM
         8GkxWAOcW7MW0R7LcmI9RdyQvCsK/IVdjHwLkH2Rzb0V4QW0V5myFQuNnK/o2Uk8SZjE
         2naHqHtLgk2Q2bslVdBgLoATyQBXjBu+ctYHBjzubjd8LUjUrMs64SdK0TeOGyNkfyAZ
         blkA==
X-Gm-Message-State: ACrzQf1lX30nAhTkm6uoHuSTu97futVNNpXx1gI6GpGmVoy48Ct+3vqt
        CmMS7EiMyTbmW6M0VIaZ0kg=
X-Google-Smtp-Source: AMsMyM4qzsXVq8HQ1z5oNE71AffD9VIMfyH6GbIfo/AvZAEgDQUZGyj5m8Yn2VXabGn+Lbtp6cx0dg==
X-Received: by 2002:a63:886:0:b0:45a:6d71:ef2a with SMTP id 128-20020a630886000000b0045a6d71ef2amr760809pgi.292.1664990447815;
        Wed, 05 Oct 2022 10:20:47 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00174f61a7d09sm10787148plf.247.2022.10.05.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:20:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/36] doc txt & -h consistency: make "rerere"
 consistent
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
        <xmqqmtaf2xig.fsf@gitster.g>
        <221003.86sfk5tgrs.gmgdl@evledraar.gmail.com>
        <xmqqczb8yk8h.fsf@gitster.g>
        <221004.86fsg4t3x2.gmgdl@evledraar.gmail.com>
Date:   Wed, 05 Oct 2022 10:20:46 -0700
In-Reply-To: <221004.86fsg4t3x2.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 04 Oct 2022 09:50:48 +0200")
Message-ID: <xmqqilkyqj9t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Not really.  A <pathspec> is a set of <pathspec element>s, so
>> writing "<pathspec-element>..." and "<pathspec>" are equivalent.
>
> So, "yes"? I.e. leaving aside "pathspec" or "pathspec-element"
> "<pathspecs>" is redundant to "<pathspecs>..." in this intpreretation?

If you leave it aside, then the answer becomes meaningless, no?

> But for any given "<x>" the "<x>" is not the same as "<x>..."?

Correct.  "<collection-of-xs>" is equivalent to "[<x>...]", but
"<x>" is not equivalent to "[<x>...]" (with or without [] around the
latter).

> But that's really not what we mean most of the time, we *don't* want
> that "..." on the argument to "--opt", because it only takes one
> argument.

Yes.  So an option that takes a single pathspec element should say
as such, I would think.

But I thought that I have already said we should shrink the scope of
this series, concentrating on making -h output and doc match, while
adjusting the body text in the doc to match the phrasing used in the
SYNOPSIS updated to match -h output, so this whole thing is outside
the scope of this topic, I would say.

Thanks.


