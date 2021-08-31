Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACFC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EBE601FD
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhHaNJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhHaNJd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:09:33 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F59C061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:08:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ew6so10272994qvb.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O6Z2nT3kSftvN49mhkjNKwnl3jfo0mg1q/Yt4INt5Zg=;
        b=QHFXRwTTkVhRjDuhxufh9Evcqn/RLAodF9FycQCacqa9pMeo2yGh8SMJaXK7wcXxzw
         qlcBIeofee4acPdaRgWgaVQlI6d6EwUVHIdP7961n7o/BomB6rUPfKGxG6NPmo+wKNCR
         aEQ/tzICvrDkTnYIySUeoZ1ouGd3sqeerNM3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O6Z2nT3kSftvN49mhkjNKwnl3jfo0mg1q/Yt4INt5Zg=;
        b=GTv4UAWr5t5pPRe6FS8jENYUc5wwxY3cbbXzPK0CQnZrri/xGE4psf3DKOWkoq3RI/
         HoUSlwzV0jShGZ+WO+p7GCKuHwt20MhNO1INmmH+3NFkwS+yfPoE4di8HqdrvnaPN733
         /SKp8xOjTCXcAl/i7KbYB+l+9cAkqtDiOxlfmaGsMVcBjbU7OonkIkeingJ/XTKyUKIV
         kb0XJshE2cl2BPz0EcPUo6MeNxqLHXzxneT2vh9jxrxF2GPHnwGjgtAl6Mc0RxIW7UuI
         C8fh+gSozUCsFQIYN/xSC/NMt2T1Mi76DwowsSArXtL7wuMzs+iaHIaA/cCplgLwSMuL
         JgWA==
X-Gm-Message-State: AOAM533yj6toebZYBnbo4Iz7d5DBQZ5c1dI7BEyL1TJj7beRwgS2eqfo
        TPuBdMjpG5cRpwhPlOBT3oFz0fsPNUgpSnaE8Lot5A==
X-Google-Smtp-Source: ABdhPJz8B/72QfzMxwQJb708DBDQ+GoVOULlglefXThUAs4qrA32XT7Z8Swn3T7iI/xFiYZTS2lhivP8psLXsuI6pWk=
X-Received: by 2002:a0c:d412:: with SMTP id t18mr19810325qvh.53.1630415315892;
 Tue, 31 Aug 2021 06:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbl5ic19t.fsf@gitster.g> <20210831093444.28199-1-jacob@gitlab.com>
 <YS4DmlJdjxeo+QI0@coredump.intra.peff.net>
In-Reply-To: <YS4DmlJdjxeo+QI0@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Tue, 31 Aug 2021 15:08:25 +0200
Message-ID: <CADMWQoPerffQcTfKh3bfesjgHaBqXGzW2805knyRW3R_q4V-YA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] send_ref buffering
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 12:25 PM Jeff King <peff@peff.net> wrote:
> I do think it would be nice to take the packet_writer
> interface further (letting it replace the static buf, and use stdio
> handles, and using it throughout upload-pack).
I would like that too, for the sake of neatness and general
performance, but I don't have the time to take on a larger project
like that at the moment.

> Does the 64k buffer actually improve things? Here are the timings I get
> on a repo with ~1M refs (it's linux.git with one ref per commit).
Thanks for challenging that. I have a repeatable benchmark where it
matters, because each write syscall wakes up a chain of proxies
between the user and git-upload-pack. Larger buffers means fewer
wake-ups. But then I tried to simplify my example by having sshd as
the only intermediary, and in that experiment 64K buffers were not
better than 4K buffers. I think that goes to show that picking a good
buffer size is hard, and we'd be better off picking one specifically
for Gitaly (and GitLab) that works with our stack.

>   Summary
>     'GIT_REF_PARANOIA=3D1 git.compile upload-pack .' ran
>       2.17 =C2=B1 0.02 times faster than 'git.compile upload-pack .'
>
> It's not exactly the intended use of that environment variable, but its
> side effect is that we do not call has_object_file() on each ref tip.
That is nice to know, but as a user of Git I don't know when it is or
is not safe to skip those has_object_file() calls. If it's safe to
skip them then Git should skip them always. If not, then I will err on
the side of caution and keep the checks.

Jacob
