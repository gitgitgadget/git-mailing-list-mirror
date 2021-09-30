Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B7C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D6761AAA
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbhI3XhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhI3XhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 19:37:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1FC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:35:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v10so28402149edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEY1quUdU2GniL25nwL3a6y/CjvCjjzMjpNL6scL58Y=;
        b=KpXFcNdyBr0TafhiMvhQ5Gcn8PAd/Bsq7XXVsjzpQD5MbOPsRBpMo/5tveyOJDdz42
         dbXlG2d27nWkK9Ea0hDXV1Axxgbf9v3JF0Bwp3PHYHHXKixDhnMPDwpxUYAR6iXhGFyC
         3FTrDmFXO4epSmBA6q1TAiRc2hNX39+K9XQwRBlnyER+ZAQVzFXhtM5xr2VuYX3kGDXt
         1Q17fqRq00mtVnw3zLWyP4yG5dCKgfny0QDWQVpkC8Fs0PQjzpATaWId9qnFcdGMLymf
         AZjnYpYfBAUCP8vzvBdQsxTLkp2u3V5a2gEM45PlwTJXxvnHnx+vkHinvj8vdq7wkUOV
         yiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEY1quUdU2GniL25nwL3a6y/CjvCjjzMjpNL6scL58Y=;
        b=nNwDhooPp6FUzpF/z3iQ6TfO3wWmvmFVhRiYuGdENWZIc+rMM5ry2VhOZAy4LJpgQo
         d5Eon2bAQo/lGMKVKl5mzwrhgiaZ/WKLcQUjB6ZwDA/C/rJSLRtNhaXCnEkKaLSoL3g6
         LhYpf3Ca7hrdm2K1MXqEWZMX1eJN4Lx0mhE1NQZN1gdG7s0hXEmCORA1AwQeX72Y3WJ4
         +WETE63FOX66ynwAIBbudJE1oo4Ymail9q6Nqp6dzFKzzWT6MV1Sr/Z8kG4mpyCOiclB
         TjL9nAECw4qfuYN7m+hMfOZJhodqrzY0qabH20RQXG9U3j8f/CfMWa9SezjV3lFKWtZ2
         hjXQ==
X-Gm-Message-State: AOAM530QTNyv5WseuUewQnj/1Ym6OxGUd8q6P0sNjNKrf1+y5KNWoCzo
        IoMQMhUiG6yqTg9P1DPV6QqPrqUR6a7+S+c0Ns8=
X-Google-Smtp-Source: ABdhPJzVez9x/X0RR0ardTuwkAelGXwqD2J3u9Rx93Wx9XxX/NxJTlZbfrFfS06kzVbHvG+LLSc5TZFiIXoqG9+qh5s=
X-Received: by 2002:a17:907:7664:: with SMTP id kk4mr2470710ejc.130.1633044926683;
 Thu, 30 Sep 2021 16:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210930170146.61489-1-davvid@gmail.com> <20210930170146.61489-4-davvid@gmail.com>
 <xmqq35plaetp.fsf@gitster.g>
In-Reply-To: <xmqq35plaetp.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 30 Sep 2021 16:34:50 -0700
Message-ID: <CAJDDKr78WcoWjeZqz3c_bdt3s0RRg8Hx9-wC1VFmpy2yPbpbqA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] difftool: refactor dir-diff to write files using a
 helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 3:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > This is cleanup refactoring that Junio suggested when
> > 5bafb3576a (difftool: fix symlink-file writing in dir-diff mode, 2021-09-22)
> > touched this area of the code.
>
> Not really what I would want to take credit for  ;-)

Likewise, even I don't like to take credit for my scrappy patches sometimes ;-)

I'll reword this to avoid mentioning the review context.


> > +static void write_entry(const char *path, const char *content,
> > +                     struct strbuf *buf, size_t len)
> > +{
> > +     if (!*content)
> > +             return;
>
> I am not sure "this function is unable to write an empty file" is a
> limitation we want to give to an otherwise more or less generic
> helper function that may be useful in this file (it probably is not
> very useful outside difftool, as what add_path() does seems quite
> specific to it).


Good point, I'll move the conditional checks into the call sites
rather than having it in the helper. It'll read a little more clearly that
way as well.


> Also, is "write entry" a good name for this helper?  The fact that
> the contents came from entry->$side is lost inside this callee.  It
> looks more like "create a file for <path> and write <content> to it",
> i.e. a variant of write_file() but inside the tree specified by the
> extra <buf, len> pair.  So perhaps
>
>         write_file_in_directory(buf, len, path, content);
>
> to match how the write_file() takes its parameters?  While
> write_file() takes a single pathname with the payload, this thing
> takes three parameters <buf, len, path> to specify to which
> "file-in-directory" the payload is written.
>
> > +     add_path(buf, len, path);
> > +     ensure_leading_directories(buf->buf);
> > +     unlink(buf->buf);
> > +     write_file(buf->buf, "%s", content);
> > +}
>
> Other than these two minor points, this looks good to me.

write_file_in_directory() is much clearer. I'll adjust the signature
in the next version.

Thanks for the review. I'll wait to hear back about 3/5 before sending v7.
-- 
David
