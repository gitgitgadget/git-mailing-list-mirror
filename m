Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A49C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjAYREF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAYRED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 12:04:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF35883CC
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:04:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso2010409pjs.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqbNc/tkJ+KqEtMakilEMV++2DVEyc1WETBupio+pGg=;
        b=Cg97IkvHIF+LfjahrgJsqp5h8RofLPFs55Drnt7IhcTa+G9pxQ+PXnZtyR8FKE77pb
         qofR5UwD5021hYywn4ztkqGrtz1m1RmEqZ20UuF8cdPr/vtL52WWZrFFABWdFF5lcUwL
         KOnUuor+h9FgFthz2scgywvDGlXhxe0Vp5Ln6AFs/GBN3AdGLRCZf4DdkFVlnFAnLS5N
         QiXGy2noT0p6dOABUjAAS4qUVeWQJWK37nsAofv75S1CndUiX7rax2TupWEW514cfskQ
         v/6qYc+2BCzaT3MloQdf9xN+pBU1EQjeyIJOk/82FADWBcoRf/IrP6fXFmfriP02+CAK
         SqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bqbNc/tkJ+KqEtMakilEMV++2DVEyc1WETBupio+pGg=;
        b=OJioWh0pMX9pszWA45MAlsUxxB+Wxy4O+39zEBaDr9J480OF2TvZ2WmD9ARbEsLBCX
         5UqaNx/1XS1CN6FDQ5b4afgRk0Da3ZXc28JoPImGuF68M5eQWBa5d1hhh+aK4fdfTzMH
         /u4FCBBM/NH5WkcpdEG8Yjk6X3OGGzya0bkCF1lp3KZvqKIW/V17YCsEavUuJLVKpXQH
         oZ3DkPXNpDWumfILEox2QWoDHGwD9NMxCkNfO116HjA0Twn5bIwqhQVEYKujxhW+3arV
         0QIyIR23zG1Qqzi1oEQCqC3+I7N0JgCEK0bg/PRLqYk5DcUaadBVw9WqUUJSo11x8XPU
         fzng==
X-Gm-Message-State: AFqh2kqPmlf9Yhhye5MqXWm54VySmqNmpkMMnCpYeuozMD7nf7I7tf0W
        CnyQom/DvAL3bBqCIMfQg5Y=
X-Google-Smtp-Source: AMrXdXtv6lcW4LdpZU/y4yMSoZqMPAykTke/sH5OEWxwSvTljXSgBQQsN+cbMojIde5OTHQjrMzmEQ==
X-Received: by 2002:a17:902:9692:b0:189:5f5c:da1d with SMTP id n18-20020a170902969200b001895f5cda1dmr32341280plp.18.1674666242272;
        Wed, 25 Jan 2023 09:04:02 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b00186a2dd3ffdsm3896429plh.15.2023.01.25.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:04:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Szkoda <adaszko@gmail.com>
Cc:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
        <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
        <xmqq1qnjhlbf.fsf@gitster.g>
        <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
Date:   Wed, 25 Jan 2023 09:04:01 -0800
In-Reply-To: <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
        (Adam Szkoda's message of "Wed, 25 Jan 2023 13:46:36 +0100")
Message-ID: <xmqq4jsefsvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Szkoda <adaszko@gmail.com> writes:

> On Tue, Jan 24, 2023 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v2
>> > Pull-Request: https://github.com/git/git/pull/1270
>> >
>> > Range-diff vs v1:
>> >
>> >  1:  0ce06076242 < -:  ----------- ssh signing: better error message when key not in agent
>> >  -:  ----------- > 1:  03dfca79387 ssh signing: better error message when key not in agent
>>
>> This is a fairly useless range-diff.
>>
>> Even when a range-diff shows the differences in the patches,
>> mechanically generated range-diff can only show _what_ changed.  It
>> is helpful to explain the changes in your own words to highlight
>> _why_ such changes are done, and this place after the "---" line
>> and the diffstat we see below is the place to do so.
>>
>> Does GitGitGadget allow its users to describe the differences since
>> the previous iteration yourself?
>
> No, I don't think it does.   It got generated automatically without
> giving me an opportunity to edit.

Hmph.  

The text after "---" and before "Fetch-it-via:" does look like
something a human wrote.  The part often is byte-for-byte identical
duplicate of the proposed log message, but I think I have seen
patches via GitGitGadget that have different text there, and was
hoping perhaps the authors can use it to describe commentary for the
range-diff.

> Yep, removed.  It was largely accidental.
> ...
> Removed the superfluous {}.
>
> Thanks

Thanks.  Looking good.  Will queue and merge down to 'next'.

