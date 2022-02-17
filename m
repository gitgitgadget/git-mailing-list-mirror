Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CECBC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 05:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiBQFoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 00:44:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBQFoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 00:44:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222527FB88
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 21:44:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v20-20020a1709028d9400b0014ca63d0f10so2083706plo.5
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 21:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=AXI4H0t/px/bKlJz0SJhu8Z5NoRTxY0HtqI3uND4Cvk=;
        b=CdnNmkjwihNf9ByCuZISf9CiFtJPJZTT1Xp93fk4Q6NY6LbBIG1aE7LIQK7xc9snxX
         6rAIzBm+rQyK5Vu+fzf9yZu0zDH5mnLo1Ros9xXvBml1FZvrmzaukGwQVIbVFbh/znSm
         GgqNp7anIdKYS3BlgjNdF2F5VbYPBp4R4U4gTPyZmlOBnuyKryW2PMdR5rMPZnaX/MpC
         PEtLykbYkNZXEXzdJomq4DdXNhtiB+V+5T1CYWg+xObG3fQiK4lbbZrmwCDx7zDEh0SP
         kRL6RzS+euwd/SneXY9ONjFGlDtEjYg2bVpKA3tL4uc08yIGWmsjQNNificVQncwP3M7
         1eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=AXI4H0t/px/bKlJz0SJhu8Z5NoRTxY0HtqI3uND4Cvk=;
        b=FCHgrAlXvAZR3zeRdoUWxr7r9MXG3ymgELM7PrGJtoOklviqjDmmrYuq1UrH0imU5B
         QBl/CQ0R0jtjXBcpSTLNxKN/0/MqZVh1RZ/m/1XBGbS4jvhOsalMNmL3Z25aIkd7SY6M
         iwmHlOo0j4ipPJzNIu8oo1dukt+VZUi5gkMP0iAQJREsfA64fm/aTrWyVY3RcztxHPjy
         wo7P6692d/Lkiomin/EFsh0ohg4DyFdy8KwIvGW36bPvZMd8XR7DwaHMQsZDZSIzdJln
         CWRO2lzT4m316zO1IhhUWfK4HXkSc2unkRd22TtH0jr73HcZwILzg2r3qb/LRTiQQiQP
         DqCw==
X-Gm-Message-State: AOAM531xttFUhcVQM+Z4vXPJGzAxPuK+x/uPTJz2lsyZDFLax6N7zvQ0
        ++6p7qh1wodcv4W8x9cQYr5zYfeevAtXig==
X-Google-Smtp-Source: ABdhPJwrM+6udQYongrDt7OwmVXWUxx4jamFP1j6XgxCge4lAJixb9YFjKzuUrTgvVOjTkU/Y9ZU7Yombc7H9A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:bb0d:b0:1b8:a958:543d with SMTP
 id u13-20020a17090abb0d00b001b8a958543dmr1444596pjr.51.1645076649233; Wed, 16
 Feb 2022 21:44:09 -0800 (PST)
Date:   Thu, 17 Feb 2022 13:44:07 +0800
In-Reply-To: <220212.868rugxhq0.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l4k4y59p4.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <220212.868rugxhq0.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 10 2022, Glen Choo wrote:
>
>> Atharva Raykar (6):
>>   submodule--helper: get remote names from any repository
>>   submodule--helper: refactor get_submodule_displaypath()
>>   submodule--helper: allow setting superprefix for init_submodule()
>>   submodule--helper: run update using child process struct
>>   builtin/submodule--helper.c: reformat designated initializers
>>   submodule: move core cmd_update() logic to C
>>
>> Glen Choo (11):
>>   submodule--helper: remove update-module-mode
>>   submodule--helper: reorganize code for sh to C conversion
>>   submodule--helper run-update-procedure: remove --suboid
>>   submodule--helper run-update-procedure: learn --remote
>>   submodule--helper: remove ensure-core-worktree
>>   submodule--helper update-clone: learn --init
>>   submodule--helper: move functions around
>>   submodule--helper: reduce logic in run_update_procedure()
>>   fixup! submodule--helper run-update-procedure: remove --suboid
>>   fixup! submodule--helper run-update-procedure: learn --remote
>>   fixup! submodule: move core cmd_update() logic to C
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>   builtin/submodule--helper.c: rename option variables to "opt"
>>   submodule--helper: don't use bitfield indirection for parse_options()
>>   submodule tests: test for init and update failure output
>
> I think sending a version of this with the fixups squashed in as a v8
> would be good, and perhaps addressing some of my comments.
>
> I don't know if my suggested split-up of "prep fixes" into another
> series would be a good thing to pursue overall, perhaps Junio will chime
> in on how he'd be most comfortable in merging this down. I'd think
> splitting such trivial fixes into their own series be easier to review,
> but perhaps not.

Combing through the patches again, I couldn't really convince myself
that the patch 4..9 prep fixes make sense as obvious standalone fixes,
except maybe:

- patch 4 submodule--helper: run update using child process struct
- patch 8 submodule tests: test for init and update failure output
- patch 9:  087bf43aba submodule--helper: remove update-module-mode

But, since the 'final' patch (ignoring the fixup!-s) is consuming a huge
chunk of the work anyway, here's an alternative patch organization with
the fixup!-s squashed:

=3D Move 'easy' and 'obviously correct' code from sh->C
- patches 8-9   Cleanup and introduce tests
- patches 1-4   Refactor existing functions, which enables..
- patches 10-14 Move 'obviously correct' pieces of logic from sh-> C

=3D Finalize move from sh->C
i.e. combine "run-update-procedure" and "update-clone" into "update"
- patches 5,7     Cleanup and prep
- patches 6,15-16 Shrinking the diff
- patch 17        Implement "git submodule--helper update"=20

I'll send this if there are no objections :)
