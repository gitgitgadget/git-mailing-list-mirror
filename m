Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D55C3DA79
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 11:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLZLjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Dec 2022 06:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZLi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2022 06:38:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE41020
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 03:38:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b88so7928401edf.6
        for <git@vger.kernel.org>; Mon, 26 Dec 2022 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86Q5j7eblvUHBdypFOwlgWDplKzFuZRHJa4v0B+q65o=;
        b=Z0y6C51N/t8JNim+te490x3eheaYI+D0CGKUO8ns7XHQ6xQjGkRg1RUshfzhUQa3vD
         Sj4ARKt8OIlQnMe+j62ARxJpCsvF1BMlGSFGCg8pdGva7nay3sesOv1BIuJfHrw/Tadp
         8D20kCNIhs2LpfMf71B3GxoAd7ZhaBgPmCn3REECyryjU5zUHlv6x9mWl6YWUOugfo5a
         z2dmBl7IIuNH5x/VNl9LB6nyqCbU2y8uFV61ukanI8zW/nsRoweCt+piT5VOVqPvxB0Q
         t1mbY0dd0GLSjdP6vErVgXjPib/DNQgZbaE85z3wmkghjJ+jD+Ju1omrPYm/mKhwV1al
         egjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Q5j7eblvUHBdypFOwlgWDplKzFuZRHJa4v0B+q65o=;
        b=EwvbJyN6NHtlVgwsoRseNibG0Brb3O6g5sVYLZgcD/hH6O8JXZ/CoNx1gTJYhMf2EE
         YFANJvSijzcnaXLadSNPfv383PMCizQ3kanfy2heDrAV9H4bjNQ8FkMp+j9FIC0MysqQ
         CL/dWieg7rkRR3gZMGyiXK5Gt8L/uBS+uf008sJMXdBu1vpY7kl9cBATdAQovygkoUF9
         qyj8E5VJMTp8sOPcWdkYntG4JCfwrz2Udiuz8jSd2XqBHP2cjIlcGC5o1HaK/vaRpBxz
         IjUpAZcWMhVdHZCbyzmhaTzZBqHD9iuSNb0AhzIQ+/PWGPhBCMSuwUbGkoA67Q5zzfbc
         gc5w==
X-Gm-Message-State: AFqh2kqxDx3qWcn6chPxfVfs+YCMP/RwviFQSBEbzW17bq7ZBgja8jhm
        euF5Icxhv9PffIKTjJxKxu1IJ9rKygI=
X-Google-Smtp-Source: AMrXdXs1XWiDkNEs7sXsHoxXqujTAfje7OX2rNEzRdbFw1aDUCZrtTbinaiuYSply7lAT4loVezPhw==
X-Received: by 2002:a05:6402:d5c:b0:46b:444b:ec40 with SMTP id ec28-20020a0564020d5c00b0046b444bec40mr14860309edb.15.1672054736327;
        Mon, 26 Dec 2022 03:38:56 -0800 (PST)
Received: from gmgdl (2a02-a213-23c2-bf80-c530-8f19-38e6-f393.cable.dynamic.v6.ziggo.nl. [2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id et10-20020a056402378a00b00461cdda400esm4529606edb.4.2022.12.26.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 03:38:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p9lol-00963p-0c;
        Mon, 26 Dec 2022 12:38:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: cmake topics & js/ci-disable-cmake-by-default (was: What's cooking
 in git.git (Dec 2022, #07; Mon, 26))
Date:   Mon, 26 Dec 2022 11:52:43 +0100
References: <xmqqcz86n8bn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqcz86n8bn.fsf@gitster.g>
Message-ID: <221226.86y1quv1gw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I split up the previously merged to "next" ab/cmake-nix-and-ci and
submitted the uncontroversial parts of it as:

	https://lore.kernel.org/git/patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com
	https://lore.kernel.org/git/cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com
	https://lore.kernel.org/git/cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com

I think whatever happens with js/ci-disable-cmake-by-default that it
makes sense to pick up & integrate those.

It's all narrow fixes for specific issues, none of which cover the
area(s) that caused ab/cmake-nix-and-ci to be ejected from "next".

On Mon, Dec 26 2022, Junio C Hamano wrote:

> * js/ci-disable-cmake-by-default (2022-12-20) 1 commit
>  - ci: only run win+VS build & tests in Git for Windows' fork
>
>  Stop running win+VS build by default.
>
>  Will merge to 'next'?
>  source: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>

Per my feedback there, I still think it would make sense to at least
split up the "should we build with MSVC?" from the "do we use cmake, and
run the re-run tests we already ran with GCC with MSVC too?".

But I understand that Johannes disagreed with that, and didn't think
testing MSVC in addition to GCC & Clang was valuable.

What I'd like clarification on if this moves forward is what the status
of cmake in the tree is.

The reason I submitted ab/cmake-nix-and-ci was to make testing
cmake+ctest on *nix trivial, so that if I and others made Makefile
changes we could change & test the cmake recipe as well.

But now we won't even run that in CI, and "git-for-windows" will have
ownership of it.

Does that mean that for such Makefile changes we should simply leave out
the cmake changes, and rely on git-for-windows to "catch up" with its
cmake contrib component?

Ultimately I don't mind such an arrangement, but I think that
js/ci-disable-cmake-by-default brings us to a weird in-between
state. Just removing it from the tree and having git-for-windows carry
it would make sense.

So would IMO taking ab/cmake-nix-and-ci (or the restart of it above),
i.e. to have cmake fixes accepted in git/git.

But now we're moving to a state where such patches aren't welcome, but
we'll still carry inevitably bitrotting code in-tree, which we're
intentionally not testing anymore until it's merged to git-for-windows?

Thanks.
