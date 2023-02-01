Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D6C63797
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 20:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBAUmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBAUli (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 15:41:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348DD79F36
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 12:41:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mi9so9321088pjb.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMxqEXiHfjuxLI7+A0QPl1zS+vxIqOC798gmzv0XyBY=;
        b=IklZOCnimiq5jtbAXh2bAzd1faj6CeWjATsLuGFkg2+YxO0l1HMR4ialastoJxls4t
         ThZQ2C32bz6GRr79j2yH5B5YauRDZPH9U0KafsWvH/vDt4qw6ggTdgiEREnJ0JejQlcy
         RnoLUVcy5dln3zsl288r0ZuWrTERJw3wwrXEIB65de1MZsQQYnm5H7SP+mnyTG+PPPIs
         BQzrKgIuZM9Kq1uXMpXQ57txJlh4AlVJw6YTtr5lxQGh8Sc0yxdnNc4IeZY3uVeBrUwJ
         ENekzb/SAfljrw0ttwdIUqBKFALL0S1XI6fwl7wL8mAA5lQ5Ml+2PfG3KdBsZ43nq01Q
         QQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMxqEXiHfjuxLI7+A0QPl1zS+vxIqOC798gmzv0XyBY=;
        b=O7QPiFpoA99QnsYzOj5PV4yuQym/7N6g4Jpar2MAybiOyrusaaMUDzrWH281YO+7ag
         Es5MEFeQP5j5xJaw25qJi/jRJNLXUlGdM0AcDR8HeRgcYfJWaJyGXBsKUWRCiLv8/GmA
         CMAQIKHQ8vV7qP/8vEWPzjlZEeoO7VMXbutBns4dJAlsfpHBZXMIm95WNl/aBmS2qczV
         72mNcl5R3UsBi3Lw7NZRr2Eqg6+JPieMYTkiC3ClzPoK0NzuaAGNEYWyJUCQKyHC2wG+
         h8jAvfBvfdOtKa+kSDXODhalm94OzKKKPWm18W2srpzRNtCBpe8Z9DiX/b58l7IwTieU
         e7bQ==
X-Gm-Message-State: AO0yUKXM2WddjLP0Ni8l9i3pU6hqPcCXmqEznZZ3j1jQyb4xMnZenL+N
        gE2C3TrKYn8qvvteVrrw0ZwJGuRh5TU=
X-Google-Smtp-Source: AK7set/bOkZ/Y7aXzt6wAxyVZvPU5y1erjDrjl6iiEG+PY/MVoEBbpiT9fSrseRQrtiYkkc6ab35JQ==
X-Received: by 2002:a17:902:d154:b0:194:d609:e1ca with SMTP id t20-20020a170902d15400b00194d609e1camr2848956plt.54.1675284079402;
        Wed, 01 Feb 2023 12:41:19 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b0019719f752c5sm5577829plb.59.2023.02.01.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:41:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/6] hash-object: use fsck for object checks
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
        <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
        <Y9pgG10dAoQABGXG@coredump.intra.peff.net>
Date:   Wed, 01 Feb 2023 12:41:18 -0800
In-Reply-To: <Y9pgG10dAoQABGXG@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 1 Feb 2023 07:50:35 -0500")
Message-ID: <xmqqlelhyv81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>      ... So if that tree is fsck'd, and then
>      checks the blob during fsck_finish(), that should be enough.
>      Assuming that fsck complains when the pointed-to blob cannot be
>      accessed, which I think it should (because really, incremental
>      pushes face the same problem).

Yes.

>   2. We're not checking fsck connectivity here, and that's intentional.
>      So you can "hash-object" a tree that points to blobs that we don't
>      actually have. But if you hash a tree that points a .gitmodules
>      entry at a blob that doesn't exist, then that will fail the fsck
>      (during the finish step). And respecting the fsck_finish() exit
>      code would break that.

That's tricky.  An attack vector to sneak a bad .gitmodules file
into history then becomes (1) hash a tree with a .gitmodules entry
that points at a missing blob and then (2) after that fact is
forgotten, hash a bad blob pointed to by the tree?  We cannot afford
to remember all trees with .gitmodules we didn't find the blob for
forever, so one approach to solve it is to reject trees with missing
blobs.  Legitimate use cases should be able to build up trees bottle
up to hash blobs before their containing trees.

If you hash a commit object, we would want to fsck its tree?  Do we
want to fsck its parent commit and its tree?  Ideally we can stop
when our "traversal" reaches objects that are known to be good, but
how do we decide which objects are "known to be good"?  Being
reachable from our refs, as usual?

> So I dunno. The code above is doing (2), albeit with the inefficiency of
> checking blobs that we might not care about. I kind of think (1) is the
> right thing, though, and anybody who really wants to make trees that
> point to bogus .gitmodules can use --literally.

True.
