Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF7FC433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 05:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7563564FCA
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 05:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBFFiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 00:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhBFFit (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 00:38:49 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56725C061756
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 21:38:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u66so7959093oig.9
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 21:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UMcVZ/HaoBWVO8OpIqDiTYONS2Ru9CDBlKN1p81CDg=;
        b=pm4zfupKYeZ7AJ2Ori0Mopp4Vj6eWRKBEkScj5vOIZANSOHIFuG9oqfSIAiv8O5sCc
         Q+TrIyq9ek8m848WsAmlFDob/4tCP+8NmdYKQY2ZAV1MpHUd6oJ4kXhQRJtrmXR6jp+P
         jzH2XmC7UtA+L1NKLF3PgGb4UiJpWE93utaAMfuIQCaFE8Ah7J6yQKJaMGjis0vAIUR/
         gGfE2yvOadjBwbcuYhKbMNzKwdSiSS2P9ww3vSG/BI19M6CIHWarV9JQ3MgKEJZ0oSZk
         ntCnQRigAVZbuTP7rL46/JMHPZoR0vIBRp/lTxwsH3Ykb6hc9msl7JIPSpUDqUMNIUAz
         PFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UMcVZ/HaoBWVO8OpIqDiTYONS2Ru9CDBlKN1p81CDg=;
        b=jdbdCgUcw1t9cuqpklKHUV6/V121T1YooEdqaNmz51IjoiF0CJMEz7H5hMHU1kfZQJ
         2c7HMvnLfxCZeO96nvQevvjfFTja8bFVydDuoHHQ7vFUbfB7v6lf6U6aBVWeRTC6LqKR
         RGyVfzTCIyiUWfpal5wSigb9+k1ODRRwR9J3gfYvI63SJYNlU/m5wHl5pTDwEGB3OGFj
         GJZDjVPPu1n2e+Sjxy7H4WJhaBk1ov9Dje3kUcmAYQPEZgX5qCbBj8OG/6aeQFjOWmBo
         4PneAYQOuYEYnr5n0MuEdLkkswHrws/VN3tKjWXprVC4bXahjjvC7FrQI7J9X/1voji/
         UNRQ==
X-Gm-Message-State: AOAM533Zv3QyWOiL+wndQghH59BmlRaqJMrpIc0VKwait4eCZy4ROyy2
        715FbEGSwe5jVZ0oQEBlaIPWmDVf2TtlLxzxX2c=
X-Google-Smtp-Source: ABdhPJwKo1V7Jmhlc/nYo8b3lbHWQG/S3iW30XpvVkQFSFY9JZ2EOVBIwYRZdvVNe2VTD/Wwk8N5y0EkLyfQb2tNpiE=
X-Received: by 2002:aca:b255:: with SMTP id b82mr5079746oif.98.1612589888760;
 Fri, 05 Feb 2021 21:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
 <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
 <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
 <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com> <xmqqmtwi1g6u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtwi1g6u.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 6 Feb 2021 11:07:57 +0530
Message-ID: <CAPSFM5c0yi=c6=q07X=0NBPiNn87eCq26CGwigwtyRRx2F9+mw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 6 Feb 2021 at 00:43, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> Correct, except that it shouldn't be on top of the 'next' branch.
>
> Please "git log --first-parent --oneline master..next" to find the
> tip of what got merged, and build on top of that instead.  I.e.
>
>     $ git show -s --oneline \
>         "origin/next^{/ branch 'cm/rebase-i' into }"
>     4f9aa6cec3 Merge branch 'cm/rebase-i' into next
>     $ git checkout -b my-follow-up-topic 4f9aa6cec3^2
>     ... work work work ...
>
> That is what we mean by "after getting merged to 'next', the topic
> gets polished incrementally".
>
> Alternatively, you can have branches from the broken-out repository
> handy, e.g.
>
>     $ git remote add brokenout https://github.com/gitster/git
>
> and you'd find the topic as I see it like so:
>
>     $ git fetch brokenout
>     $ git log --oneline brokenout/master..brokenout/cm/rebase-i
>

Got it, thanks all for guiding. I will update soon.

Thanks and Regards,
Charvi
