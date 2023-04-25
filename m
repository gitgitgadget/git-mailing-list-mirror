Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D869C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjDYRfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjDYRfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:35:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90C146C8
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:35:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6670671e3so52145075ad.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682444144; x=1685036144;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LTV4HKT7qH764YlLhweTIRDqK8iMT8+YNCXHVSlpBfs=;
        b=lky23BpoYeo4gU8m6Bs1B4TMCM/zDBg6GTDVDeU0/SE/JNsQYXh0DNmzNJKCp5318Q
         V+d+xakxlVJ7Xgw0whms5CQ0/qILPjVS52KJdV0/Es0DTkZCUBMZYS90Bnr0hJe226ZN
         LNBAOudFc89C0e5hlJq/P/WrmaID5oKsQklEEAnzfFTIOP+m9xlsmUeP/664Mgwazs1r
         WKpieQPYRfrhileWTy/bYaLJZbdZZKvOD0L8/6AzaBBu/Pm/HmM4KWyXlJpJZNYd2j0u
         67vXkNROGBF3EIQ/C+sKMj4JiPUtivEg1ay4Fptzi0l6oQECC1xuRW57UeJCYAPMlPRc
         O0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444144; x=1685036144;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTV4HKT7qH764YlLhweTIRDqK8iMT8+YNCXHVSlpBfs=;
        b=V10FdJ6Y0yNoPVccOw4CvYLKQB2k2YSoSN77HoJV9KxosudF7tDrVkzZvS0JTLNh6P
         GkKL+csKcr51w2khLzP8SIhRu/jX1Bb9lDt7VYi2kQkINJe2UqBCzLWyAaygFAJPAiLt
         aJc4+jtP4w06M0/vPdcx8l4K4bRYTdEyfV/+Vz4ajXhJaikke3jEucQ3RlWIDdiZgAZ8
         +eu7XQ6kiuPVdo4PR9A1mU+5w+tlpe+p20rYkpqXVPylvx5ytLjWgnSg7Eg0LWfIOYLd
         naCq8eIMcCiWHx4uN7HPT70PkV+J00xZseC2DWq3nftdqgs4CcO1DSUkcwWQ3gOuGsvT
         wQPQ==
X-Gm-Message-State: AAQBX9d5bgiHy1gjhI5VkT4IE8kyXdPcQZUV0mbCT9al+KkTC+531GC2
        tz+m99Q/g2DCWAT+HnUwNeY=
X-Google-Smtp-Source: AKy350a9kCPzsUhrP8eaU6IBvVwGHzRenR4HRbu6CB+mUlhU4clpDpNePCpr8fPnDU8KaJJTvDx8dg==
X-Received: by 2002:a17:902:f684:b0:1a6:82a7:6e60 with SMTP id l4-20020a170902f68400b001a682a76e60mr23742931plg.47.1682444143737;
        Tue, 25 Apr 2023 10:35:43 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jh22-20020a170903329600b001a5262134d7sm8520267plb.202.2023.04.25.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:35:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <be86f9cac3e651ab5aab49f89b6506012b756dab.1682429602.git.dyroneteng@gmail.com>
Date:   Tue, 25 Apr 2023 10:35:43 -0700
Message-ID: <xmqqleif27bk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> When adding new notes or appending to an existing notes, we will
> insert a blank line between the paragraphs, like:
>
>      $ git notes add -m foo -m bar
>      $ git notes show HEAD | cat
>      foo
>
>      bar

That's a pointless piping to "cat".  Piping to "cat -n" might be a
good way to illustrate what happens, though, i.e.

    $ git notes show HEAD | cat -n
         1  foo
         2
         3  bar

I have no strong preference either way (the other more obvious
alternative is to just remove "| cat").
