Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47237C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3124861053
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKAUI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhKAUIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:08:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF9DC0613F5
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 13:05:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m14so15212311edd.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jtIZcGkKANkHZykd7YHh65abq+wCZzcvoRA3Om389Pg=;
        b=LzTXFyLNudNj+cN/2vyoyLFAUmaPhsGjnRQKGjn7cTtJa/yyXPEMVMIbkSBZhcjndv
         fmYgoPOp13zSihxQjNC6lUl47QUIoE7hnOViq1Nbhd3WkCXG5oNTHVHLJm4J5Q9TRVn4
         z2kFYDrXixW425Or+oIOoLCOLv/DiursbmV2KQuaZwDJ7KNNbF6qHhxzACcUDI2p3U88
         YIGRHy3Kf+padNbESijpq8wX+h7Wbw2ukyNjUz27fSIEQr6wQYI1bBUlT5wYp3A/lD6c
         yduMb52GBtRHp7g/AkVzDU+FnyVGbFolUau2rzFsqTFILaNi1fdGWDF8i9Ck3dMA0u+x
         Y3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jtIZcGkKANkHZykd7YHh65abq+wCZzcvoRA3Om389Pg=;
        b=g0Z8f26DrYr7YA0Ux/fK+mHfNW1/Xe6uH/T0uo3dKsn0vepulxGejm4dzCK6ItfTnq
         oaczCnJImLQseh/VLKu79L5mK8zKY5TnSaIGIuEv+Z57TY5W698uFv9q1awO+Ljj41g4
         eNRXkTTu1poNxkcUqNg1mG6+qqgNxS2X805L6PBmIV9gLTdIbEObf4W7zZRmDBRBsj13
         1J9IDCJriXOICegTmCIBH1YfABul0Nyww+EBKGrEwKsz4UhpoqaqFjWu0KWMtRtGAeER
         T6w8F1iNHdGyHsbieXvMdrV4w6AZez2eM01APd9H21pAu/z8VvWM7LJmRTegluQbzek4
         vCww==
X-Gm-Message-State: AOAM530Y7Eg8ekv+YCTR9ZnGYxCJL74f2icY+RfaykU9cZp+x/S7BByU
        /6DB5vWU+KbxOH6Ww+7KExR0SYM13YNROwuU
X-Google-Smtp-Source: ABdhPJzZ1kd8C9Ot9JgSQtK2BQIutL3Qlx3YV84uO2nL/OKLHouX3iP+gX2TDEF4bxqoiG4nCpIYFw==
X-Received: by 2002:a05:6402:42cd:: with SMTP id i13mr44345005edc.396.1635797136151;
        Mon, 01 Nov 2021 13:05:36 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qk16sm7488302ejc.12.2021.11.01.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:05:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhdYl-002BwR-8f;
        Mon, 01 Nov 2021 21:05:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        users@linux.kernel.org, tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Date:   Mon, 01 Nov 2021 21:02:34 +0100
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
 <20211101190905.M853114@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211101190905.M853114@dcvr>
Message-ID: <211101.86bl333als.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 01 2021, Eric Wong wrote:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
>> Hi, all:
>> 
>> Per exhibit a, what should we do in the situation where we discover unicode
>> control characters in an email?
>> 
>> 1. Warn and strip these chars out, because they are extremely unlikely to be
>>    doing anything legitimate in the context of a patch (unless someone is
>>    sending patches for docs actually written in RTL languages)
>> 2. Warn and error out, refusing to produce an mbox
>> 3. Just warn and produce an mbox anyway
>> 
>> I'd normally do #3, but with many people piping things to git-am, I'm not sure
>> if it's the safest choice.
>> 
>> Exibit a: https://lwn.net/Articles/874546/
>
> +Cc: git@vger
>
> IMHO, defense for this belongs in git-am (which already checks
> things like whitespace).

It checks whitespace because that's something that's commonly a source
of patch corruption. I'm not adverse to adding this to core.whitespace,
but trying to catch malicious injected code seems like a rather big
expansion of its scope, particularly since:

    "[...]sending patches for docs actually written in RTL languages[...]"

Or just code? People write comment and even in their native languages,
and not all projects are as anglo-centric as those hosted on kernel.org.

I haven't checked what the overlap is between solving this issue & i18n
support, but we definitely should not be assuming that git's only using
by kernel.org users & similar, even something as relatively obscure as
git-am.
