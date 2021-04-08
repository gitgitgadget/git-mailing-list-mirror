Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283CC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E970861159
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDHXzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:55:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9AC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:54:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g17so3049242ejp.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IKun+tDC078tmCJFZsl/iHeQqE54XNmqnbE4+GffzxQ=;
        b=c7Nwj82HfJN6U9IjTbt8pivnlomg9JCZo5FKPA5eA55lI9hcziFqvivMcwSN/UMmPz
         HT1QOuPPrqfOSED5itHFr4+uRaswpG15Iq0O5ijasU26CaQYmeiWeRy0FRmVgasQXxK8
         GhnZjCjq9Zby2YQXLOmvNMd2dSnX68xARdngyKFsXU1pox18QaNPxI0+rQ2CnvHJq603
         9R9wZOawCac4x6YCoLOrLit4Wt5PY+vszuOIXWlN6FWOSehlTA1pQ/6BGCr1wB0IfSmV
         wxr5pHuPDZ4Cw3Fug/UQiI/44bzX+9eK9Bk/rpJXuGrpV9X/Kup+HzbSImqfTmqiMH01
         cBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IKun+tDC078tmCJFZsl/iHeQqE54XNmqnbE4+GffzxQ=;
        b=jJeed8pLfekkYS0CUTUa0+/+h7VBsks60F0zd0gs/k+WO3FOI/B9eI7m/+jL7P8t28
         HUmph28bNo0/4p45IIZW+Bbo9/Vhnqv5tgbbk6guFaBsbCe6hwQvUpVEY8n/eftlEd5V
         nNz+9subgjhAgG2FWnl3n3fNfvuTNs5Op8QpG69STfDiCGOTZsNoQeK+800CtgJ2YRwu
         ttO3qxzEmGI6kpFAuDNxNdwd6hETili0e6wV0CFmKZCk/jv90phDQNtkx5GS8rr4uu98
         +fzJaYrMZRIVVcB2S4DLLLxyY5iAMGSrsrl9ArXjP+TjTTMYdViGZA+/dkJEGk/XbHeM
         mqhQ==
X-Gm-Message-State: AOAM533GotAgr5B7+x+Lq8AyQRH3q3IOqmiuRrgbuPLsorjrCIOezbFj
        QqZBIYVhXPLsN5XT103GmIP4dPRXvtsdfA==
X-Google-Smtp-Source: ABdhPJxlEZlwTE9UeT5AAODUevptHuD5eA+NJtTYC/owdLDUIus3ApOYaeTOA2AKQSmMd/72bj+F0A==
X-Received: by 2002:a17:906:694f:: with SMTP id c15mr4966363ejs.408.1617926086560;
        Thu, 08 Apr 2021 16:54:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r26sm465916edc.43.2021.04.08.16.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:54:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] git-send-email: refactor duplicate $? checks
 into a function
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
        <patch-2.5-f236f083e36-20210404T091649Z-avarab@gmail.com>
        <xmqqft0447lu.fsf@gitster.g> <xmqqpmz4qtxi.fsf@gitster.g>
        <xmqqft00qtrj.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqft00qtrj.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 01:54:45 +0200
Message-ID: <87tuoggwmy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> One big thing that is different between this version and the one in
>>> Emily's "config hook" topic is that this is still limited to the
>>> case where $repo exists.  In the new world order, it will not matter
>>> in what directory the command runs, as long as "git hook" finds the
>>> hook, and details of the invocation is hidden behind the command.
>>>
>>> I presume that Emily's series is expected to be updated soonish?
>>> Please figure out who to go first and other details to work well
>>> together between you two.
>>
>> Since I didn't hear from either of you, I'll queue with this
>> possibly bogus conflict resolution for now.
>>
>
> Well, I retract it.  This makes many steps in send-email tests
> fail.  For now, es/config-hooks topic is excluded from 'seen'.

Sorry about not replying earlier upthread. FWIW I didn't look deeply
into how the chdir etc. might interact with Emily's topic. I figured
we'd want the $? etc. cleanup first, and that just deleting most of that
code once we had some hook runner to shell out to would be easy.

> What's the status of that topic, if there weren't other topics in
> flight that interfere with it, by the way?  Is it otherwise a good
> enough shape to be given priority and stable enough to get other
> topics rebased on top of it?

I see I've mentioned [1] in passing to you before, but in summary I have
some major qualms about parts of it, but very much like the overall
direction/goal of having hooks in config.

Elevator pitch summary of the lengthy [1]: hooks in config: good, but
having a "git hook" command introduce some nascent UI for managing a
subset of git-config: somewhere between "meh" / "bad idea" (see security
concerns in [1]) / "not needed". I.e. I demonstrated that we can replace
it with a trivial git-config wrapper, if the series doesn't go out of
its way to make it difficult (i.e. we can/should stick all config for a
given hook in the same <prefix>, and not re-invent the
"sendemail.identity" special-case).

I'd very much like the author to respond to that :) And/or for others to
chime in with what they think.

1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
