Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CBEE49A0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 03:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjHWDcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 23:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHWDco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 23:32:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A54CF2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 20:32:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50095f6bdc5so892e87.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 20:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692761561; x=1693366361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3bz3XIJAcq93Ln5mBu2FC5vLkQ6BPh6T6UpA/AUrMA=;
        b=wqPc/hlzXD4nRHdDOebqC4mwSQWaUo76OS5uhFK0d1N0gOKzYlYJrB4HLSRPRJb5ge
         Bxn+gX+5jY248r71mN7ufqGWmmz77EVsewWqSgCg+RgiMXhRbFHx1REplUPe156pkKrK
         kGDktqIi9P00VCvrR1jeheDO0YQZW/KJ1qPuvlwkwpgUlNdwDXEeSm/YUjz0rx75oUTR
         sZah2JXT3Q+PTCNx0/tPltcadO/USMufZ8DsOsflLuiWfHOLxzgokrh6GFveZ3g03RQO
         6Yem9us6u2JGkNzPNHZM2Ljs5Mi7myuRzjZLDM8h9XqEnD+4+omSBFaSOTV3BqlRsiZm
         7uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692761561; x=1693366361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3bz3XIJAcq93Ln5mBu2FC5vLkQ6BPh6T6UpA/AUrMA=;
        b=j/3bbQsaf+CIGEyL1v4p4O2VQ+u4HyozOfY+0JsyRu2xtfc61KvyAuYXlpcxTXLNCF
         9M5fLaw9y7+UVOKi14UnQ8uTdFnpd+jzrn/oh8WFkOTOAhGA4KL6qatwMruBSNlmn+7k
         JUGLrjRB7aP2sgT5n5YKmrD6lvRYWtMYonifE/YdV8J30zq397orOTVe+tG9bQPtjizR
         xsL97r1UJUN0Ed64bDlx2MKVRDyfM33RI/W9GvhgJyljJEZ6qL1XN7uYU0ksRdbo8aNJ
         ZniLVFxwJ2rmWeNrLRDX0UbCwKOtLP/fsxMR3Sr6uakKdqMnjSifGgHctGmquhlHNywY
         Dl9A==
X-Gm-Message-State: AOJu0Yx1OvUEgwbCY6IjP5hdFXrMjP0wAsjTzFTZiZjYc+IW4gr6EKPP
        l95CxMXkMP3erDgoffGh8+2qsMBJEBdf1mkEPOlIx3IgqWhx/3ivQ+A=
X-Google-Smtp-Source: AGHT+IE+57PBCEUiP60p2s9UU2Yke5LZiYNuFOLl+dfTcV7BpftW2emRIGfhdRoPZwg1/TRZlJyM3Gdg+E88DF5nE1E=
X-Received: by 2002:ac2:44b9:0:b0:4ff:8df5:bf17 with SMTP id
 c25-20020ac244b9000000b004ff8df5bf17mr104653lfm.5.1692761560825; Tue, 22 Aug
 2023 20:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230817215325.2550998-1-taylorsantiago@google.com>
 <20230817215325.2550998-2-taylorsantiago@google.com> <20230821203051.GA1800481@coredump.intra.peff.net>
 <xmqqttsrn9l2.fsf@gitster.g> <CAKacvadS8X_nb6Z=yub9eJ54hRYWq4B7CYrWaw=uXBY8dPChYA@mail.gmail.com>
 <xmqqcyzeh6a2.fsf@gitster.g>
In-Reply-To: <xmqqcyzeh6a2.fsf@gitster.g>
From:   Taylor Santiago <taylorsantiago@google.com>
Date:   Tue, 22 Aug 2023 20:32:24 -0700
Message-ID: <CAKacvadHXrgVmAfT_W+wPyhhRP2hVXXcVRB3rX8ArKvqUpe=Ug@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config settings.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me.

Thanks for the info on the patch process. I also am sending this mail
in plain text mode so hopefully the mailing list doesn't drop it.


On Tue, Aug 22, 2023 at 6:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Taylor Santiago <taylorsantiago@google.com> writes:
>
> > Thank you! How would you like me to proceed? Should I submit the above =
as a
> > v2 of the earlier patch?
>
> There is nothing "above" as you seem to be top posting ;-)
>
> When somebody else helps by supplying an "squashable" patch, often
> people are expected to review it and then update their patch(es)
> using the given material to produce a v2.
>
> But as I said, the "squashable" one was only about the receive-pack
> side; even if you combined it with your original, tests for the
> fetch side were still missing, so it was not sufficient for a v2.
>
> As I didn't see your reply message (to which I am responding to)
> until now, mostly because it was dropped by the mailing list
> (perhaps it was an HTML e-mail from GMail or something???), I've
> further worked on the tests to cover the fetch side and sent out a
> full version (not a squashable, but just a replacement for the whole
> thing).  It is archived and viewable at
>
>   https://lore.kernel.org/git/xmqqpm3eh7f6.fsf@gitster.g
>
> Part of it is still your original patch, some material in its
> proposed commit log message was given by Peff, and the rest was
> written by me, so it carries names of three people.
>
> If the result looks acceptable to you, then saying "Yup, that looks
> good" would be the simplest answer to give to move things forward.
>
> Thanks.
