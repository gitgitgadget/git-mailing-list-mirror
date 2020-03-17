Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E2C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1205B20663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZd45RCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQR1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:27:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44412 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgCQR1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 13:27:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id w4so9144685lji.11
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=aL8HCbVQFq/Y2PHe5UmOb/qskDgIFf8oh69JxuyPbDQ=;
        b=hZd45RCcQAEWyuBZT6vNTWkqjNL2m4PqvyJcp6c0nPX0zdSWqi4W0eqkoA0/k1loRw
         D3nff/etZrWOQfoqfKikJI6ML9gjL/vVx21s2ra9wJMu1XHvSVmpdObA07YdQTMAq73B
         WBZvExCiCSjoqt8GY3LCMeQ2WSGworY5Vr+dC0qCOAwpv2BFH+sfJleZwcia0tmgRYD/
         fKC6bFQ9hKs0vRBr/aMw3qUoPVGg+9iKrGueKXPsuo9b66Qsm8M+JgQhKbehCsUvux3f
         1LdB9EFhVa4zo0LNAjQU91HIiYYL4jRFjSflR6MujG3DaJJQ7Ou8KSQulFrTrVE0Xs89
         yBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=aL8HCbVQFq/Y2PHe5UmOb/qskDgIFf8oh69JxuyPbDQ=;
        b=h0T92sg5gXGNNv2N94ra4mMwbxBnHgGe0pQ+SZWfXcfdW/HqZp3mr14uA56XcGuTuz
         m91E1qkRlVXPBfazHQhjUdpvppnBzz4WN1CQNh/LsdWsifpMdNc3oxF1fYK3IEN+C4q3
         t8aJSSe0mrhD2K0kjc0Ig3DAYzGQP5puzULHX24ZFTxEL9nsRH8TD02XYI9ULm6RRxHw
         MChrwfRrUVue0nQ3l5oO/wuDrOSw6PHoJGiURIcSGW1sbRCFbRofBCJaAiqVqzw5+4Nw
         OsCgdAgtHcGbX7VwD5Ypuf4V/+0omtBFmDH7OlUpFRPYA3U+e2zEIJHNvIAeXsTDCzcY
         /HGQ==
X-Gm-Message-State: ANhLgQ2sPnOapmJq3s1fP1v2un/xq7d724JhoNx9gX5boWMq+QR52HJG
        Cd48Sq8Q4Mhac359ot6Xft6U3mxQE8+MmHd6co6lCA==
X-Google-Smtp-Source: ADFU+vtki77iLnLhDC79g4EcC2XSmSW5Lv/D0BH4qxSp/FVWFnRpjE7YKt+Ztqo7VYnDXG+CBmPLjhqzIB6rCuXtUUg=
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr3765815ljk.220.1584466029199;
 Tue, 17 Mar 2020 10:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499DiCi3FJb9qWJNBNKyVQg_zYMgJRuYcH_pOP3LnGwk5Tg@mail.gmail.com>
 <CAHd499B+ro+d0bGA+-Y1Qnfkc1vMzXCnBfZmtZv+CscUXim=wQ@mail.gmail.com> <20200317171853.GA6598@coredump.intra.peff.net>
In-Reply-To: <20200317171853.GA6598@coredump.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 17 Mar 2020 12:27:00 -0500
X-Google-Sender-Auth: AUXuC38frZNP3XbmtUqG9_Ljvkk
Message-ID: <CAHd499AfYZth1oFii66iUMDJTKVaa-S1K37jt2V027EmYsGPkA@mail.gmail.com>
Subject: Re: Conditional newline in pretty format
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 12:18 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 17, 2020 at 10:37:13AM -0500, Robert Dailey wrote:
>
> > > It works perfectly right now except for the case where `%b` is empty.
> > > In that case, I just want one newline after `%s` instead of 2. Is
> > > there a way to make my second `%n` conditional on `%b` having a value?
> > [...]
> > Another solution I tried is `%+b`, based on this documentation:
>
> That's what I would have suggested. And it does seem to work if you do:
>
>   git log --format='* %s%n%+b'
>
> but not when you add in the indentation and wrapping:
>
>   git log --format='* %s%n%w(100,2,2)%+b'
>
> Which is unfortunate, but I think makes sense: the wrapping sees the
> extra newline as part of the text to be wrapped, so it gets folded into
> the first line.
>
> I think what you really want is a conditional that can cover multiple
> placeholders, and put the wrapped body inside that. You can do that with
> the for-each-ref placeholders, which have a real "%(if)...%(end)" block.
> But I don't think the pretty-format placeholders have an equivalent. It
> would be nice to unify them one day, but progress has been slow on that
> front.
>
> I wonder in the meantime if it would be possible to introduce a block
> syntax to the pretty formats, like:
>
>   git log --format='* %s%n%+{%w(100,2,2)%b}'
>
> or something. I don't know the conditional code well enough to say
> whether that would be a trivial patch or a horribly complicated one. :)

Thanks for the information. It could also be that for something this
complex, expecting Git to do it internally might be unreasonable. I'll
try to come up with a bash script to replace the alias. It'll be a lot
more verbose but I can take more of a "string builder" approach in an
actual script which might be more intuitive. I just wanted to check
for any bugs/built-in behavior before I go that route.
