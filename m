Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B7C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiHKLEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiHKLEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:04:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EC94110
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:04:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j8so32851933ejx.9
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=nobyjFJNLDt8qzwoByiQMkz2s5ZCN38dTnePjkFRa2E=;
        b=Ck73U7eGcGIxspTJc7WScJCWb+p4LAj6UuMfgFBcvoqYoDzGrnJ9l7LFrr7zi1M/oH
         jfs7aGic1Iv2OEIC/Lvr/6nHYrE4A+a+oIPz1GTe/witG2lyW/JdjfSPouBXd74NZ2wl
         Q/waSUpRy7ikdzfYuhbqelkoNS+Y1/SVvN0A27XSPNYRwf9m5dXOPk5pBUaFt/T8ALPz
         3GjTGNR/PjWynoI3gaMCQeg9fw+04gpb5obAGuH7Tq7YMwZsApEBsaZIMRBY3Rh7R15K
         OwPcy9eG0wZYc74FhZiKCbYAFF1pENrGsq0PUFZSMIzNtg2Z5dsguLtD5PWB291HpTVB
         7PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nobyjFJNLDt8qzwoByiQMkz2s5ZCN38dTnePjkFRa2E=;
        b=VfpvxoQt/yKs2ek5aLO7LEtVb3CJiglyzD6hJtybqydsi+4z2/GHuCvyP37e2jLzEi
         AOrtjQq+z4zuen8kG/dwL4OY7oNeh2zzio85HApTHu4qUvxglahBmhF5X6oRDnSxcpDk
         wOdu/+awJrgca48JOVlJb+nCLedT4dvX0/jJauQrIyo8rwooycHV/HjL73NT/4hphXhX
         s7rReRKfSKG7OWIu/bmKD2Qd+Cqeb6kI2kfLA7148VGrYguz81F0O+1vSIQvSdFYwcIW
         LgJHlmfCDlVye7HzuBtyKuu27Uh4YyJPS4phyfvgUrpDsl+NKdlwhX+jOCm6kBeDrGDt
         Mq9w==
X-Gm-Message-State: ACgBeo2hKLaUBCU5NrV1xI+RbaYiri6waQj4Rz4yb8B+3cX+wKZaxf2Z
        NfM/kwQ/bu/YSqM1xFvspld1OW6s46w=
X-Google-Smtp-Source: AA6agR5HGB68dg7szWLk2NUdq0kKvyMybK+8U0upmOKC8wouSFWFOLcJjZwQLS4/ymo0eKWsZG0cCA==
X-Received: by 2002:a17:907:1361:b0:732:fefd:a25c with SMTP id yo1-20020a170907136100b00732fefda25cmr7261303ejb.669.1660215877937;
        Thu, 11 Aug 2022 04:04:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906314400b007309a570bacsm3376612eje.176.2022.08.11.04.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:04:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM5zQ-001Axa-1h;
        Thu, 11 Aug 2022 13:04:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
Date:   Thu, 11 Aug 2022 12:58:52 +0200
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-7-calvinwan@google.com>
        <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
        <CAFySSZBPoJC8je2jr4_nrrzdFG3=HuRcou6qjrJTNOzue1pvgQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAFySSZBPoJC8je2jr4_nrrzdFG3=HuRcou6qjrJTNOzue1pvgQ@mail.gmail.com>
Message-ID: <220811.86a68bqbwb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 08 2022, Calvin Wan wrote:

>> > Since the `info` command in cat-file --batch-command prints object info
>> > for a given object, it is natural to add another command in cat-file
>> > --batch-command to print object info for a given object from a remote.
>>
>> Is it ?:)
>
> Haha yes this could use a little rewording
>
>> > Add `remote-object-info` to cat-file --batch-command.
>>
>> I realize this bit of implementation changed in v4, i.e. it used to be
>> in "fetch", and I'm happy to have it moved out of there, we don't need
>> to overload it more.
>>
>> But I remember thinking (and perhaps commenting on-list, I can't
>> remember) that the "object-info" server verb was a bit odd at the time
>> that it was implemented. I understand the motivation, but surely it was
>> stumbling its way towards being something more generic, i.e. being able
>> to just expose cmd_cat_file() in some form.
>>
>> Which is one of the goals I've had in mind with working on fixing memory
>> leaks in various places, i.e. once you get common commands to clean up
>> after themselves it usually becomes to have a "command server".
>>
>> So (and I don't mind if this is longer term, just asking), is there a
>> reason for why we wouldn't want to do away with object-info and this
>> "cat-file talks to a remote", in favor of just having support for
>> invoking arbitrary commands from a remote.
>>
>> Of course that set of allowed RCE commands would be zero by default, but
>> if we had some way to define tha "cat-file" was allowed to be called,
>> and only if you invoked:
>>
>>         cat-file --batch="%(objectsize)"
>>
>> Or whatever, but over the v2 protocol, wouldn't we basically have
>> object-info in a more roundabout way?
>
> While I do think that if we did have a set of allowed RCE commands, this
> would be a good candidate to be one of those commands. I am worried
> about security, maintainability, and server performance risks this change
> would also carry. Figuring out which commands are secure and would
> not overload the server, and then maintaining that set seems like a much
> more worrisome design than having a secure git server.

I'm only suggesting that the interface be extendable enough to allow for
that, not that we do it right now, i.e. that the protocol command could
be:

	# With appropriate \0 delimiting etc.
	cmd cat-file -e <SHA1>

As opposed to something like:

	object-exists <SHA1>

But that we would *not* for now expose some mechanism where the server
operator could configure which arbitrary commands to allow, we'd just
intercept that specifically, and dispatch it to the appropriate code in
builtin/cat-file.c (or libify them enough to expose them, and then call
that).

Of course one of the points of doing so would be to eventually expose
the ability to run a larger set of safe commands remotely, if the server
operator agrees, but we'd leave that for the future.

Right now we'd get the benefit of not duplicating various parts of
existing code, and having a plain one-to-one mapping to existing
commands.

