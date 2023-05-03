Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0ABC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjECVT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjECVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:19:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F06A75
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:19:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf21bb42bso32565175ad.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683148765; x=1685740765;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKxFBxwV+3rH2J8BQkGr4tHkgWHZyYK+r63G37scHNk=;
        b=FGd2gyaqtPR0NwWPf5vKTnMJItvjDL1cx1WGKoJK5GDspjcxY55hyQrWeg390YSt1j
         pjNcztNm9mxtmEGoIDF6jEN9BtbVRA6jKS43wp8DJ8Um056hu1Fhl/635m8EBpKl2/Yx
         mKhRJY09VH3XE6a4VzgY5vPm/FrNSqKr4rciLjSL5IVe9msmJ8zi5dnt4IPb8pTY5hYB
         zavZxKefzwNviSJaUXU4mAdjlR0xdQezbKYlDi7YrjtAVslXpBA8KL5tVUrIj6ku7NVh
         9EYS9XFQhqcXfOhbppNr/VpEbYqrRd9MnUGfm/jl8AN9RzbeigmW42e5sI+yFn4kxXFB
         TTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148765; x=1685740765;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKxFBxwV+3rH2J8BQkGr4tHkgWHZyYK+r63G37scHNk=;
        b=OtBb2Ul0Bpp8y/sjcsk7g2pq+Os56FRYhFFt3w8adR5udpjTSp4qMN6TYJXGyU1/+4
         F2jcLYDtCJUv/6Zj7g9ZJBbSx8fadE/8/5BewVpT8KQve3LMJXVGFsOojaAzoC2glAyd
         sq4XSkhl7ARwzP95s3/+TVi9C0qoesxzB3bWBtKAhaO4lmNfpF2sAxTjkZdMJ/cRnpXg
         cl7sC48OQcZMjGaTF7intYOconPJdI2SgWdxMygxOZ34/WRBgHfJyaDPG4SYeyPtC8sI
         wbbj1uZyWS2PcHFzVOTrLr4Civ+HdfB9i1XVFrr/nGeCic/37calXJF1YlLqMqc8lvgu
         ilXw==
X-Gm-Message-State: AC+VfDwxxfTnJooHc5vmOB7ApqYSzBLjrXOMPmL5THNmzTiuCXOX6OiA
        sYDsaXINKC2Avx6vOUOUvpYxWq/e5JY=
X-Google-Smtp-Source: ACHHUZ7/+zr7pUNWLYvRfZ3kg4mxF340fviBSddqHJOaiFI4i4wAsz+vPsGG3f5vRTVW2z5Mk2NFmA==
X-Received: by 2002:a17:902:9893:b0:1aa:ce4d:c77d with SMTP id s19-20020a170902989300b001aace4dc77dmr1396202plp.24.1683148764792;
        Wed, 03 May 2023 14:19:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001a1faed8707sm15193008plb.63.2023.05.03.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:19:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lukas Tenbrink <lukastenbrink@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff -U0 header off-by-one error when deleting no lines
References: <B097ECB7-1976-40FC-B91D-A60D648F973B@gmail.com>
Date:   Wed, 03 May 2023 14:19:23 -0700
In-Reply-To: <B097ECB7-1976-40FC-B91D-A60D648F973B@gmail.com> (Lukas
        Tenbrink's message of "Wed, 3 May 2023 22:48:44 +0200")
Message-ID: <xmqqednxp0ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Tenbrink <lukastenbrink@gmail.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Full reproduction:
>
> echo "A\nB\nC" > test1
> echo "A\nB\nC\nD\nE\nF" > test2

For many folks, the above will place one line each in these files.
For portability, you'd need to do something like

	printf "%s\n" A B C >test1
	printf "%s\n" A B C D E F >test2

> git diff -U0 test1 test2

> The actual output places the new text at line 3:
>
>> git diff -U0 test1 test2
> diff --git a/test1 b/test2
> index b1e6722..cead32e 100644
> --- a/test1
> +++ b/test2
> @@ -3,0 +4,3 @@ C
> +D
> +E
> +F

I think this is very much in line with how "diff -U0" by other
people do it, and any tool like "git am" that need to read "diff"
output need to understand how these output work correctly; "-U0"
output and ",1" that is omitted are things that have confused us
tool writers forever ;-).

With -U0, you'd get

    $ diff -U0 test1 test2
    --- test1       2023-05-03 14:02:27.718960038 -0700
    +++ test2       2023-05-03 14:02:20.094156573 -0700
    @@ -3,0 +4,3 @@
    +D
    +E
    +F

which has "-3,0" that says "there were 3 lines before this hunk that
did not have any line before the change".

This might be unintuitive, but it is specified by POSIX.  

Open

  https://pubs.opengroup.org/onlinepubs/9699919799/

and look for "@@".

    "@@-%s+%s@@", <file1 range>, <file2 range>

    Each <range> field shall be of the form:

    "%1d", <beginning line number>

    or:

    "%1d,1", <beginning line number>

    if the range contains exactly one line, and:

    "%1d,%1d", <beginning line number>, <number of lines>

    otherwise.

    If a range is empty, its beginning line number shall be the
    number of the line just before the range, or 0 if the empty
    range starts the file.

So a patch that adds lines to an empty file would look like

    $ diff -U0 /dev/null test1
    --- /dev/null   2023-04-29 22:24:54.395999895 -0700
    +++ test1       2023-05-03 14:02:27.718960038 -0700
    @@ -0,0 +1,3 @@
    +A
    +B
    +C

just as specified.  Note "-0,0" that says "there was no line before
this hunk before this change".
