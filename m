Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F80C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjDRQeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDRQeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 12:34:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D97B450
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:34:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso1924205b3a.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 09:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681835656; x=1684427656;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXSdYQGVrhTp4Wv/mv9v7kK56S2Eh+evJ33raq4fdc0=;
        b=RflT6gr9Eu/pDkCAJY06b79h7Ej6+7xdF9CSUoyevjcC9fhig48b205T2YpwpoX7wp
         /gZtez0GOd6F8WiYcShZNQKHgc4cL1QiQsCXTx4BsED99S7eXlUEzVMdpSg8BUhHg1Wu
         Sr4Xljc79irYVh2XcbHWOFRhvcF5atBwWVLOd9TuoOPc31g683xUSlVa2MAGnj5EMiwE
         TpNKbRK9PM0UCNMe/5imq4efqTOrbrPGdY4VFUcyU+hwcWD/qiCDLH/pazwy3ztZUPsr
         HVrII4yNcCp1dK2odPmlE75BD0WaqCIsgov2CqLzs2kGOMnV1WOtTxosjaZQ0HrU64bp
         tCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835656; x=1684427656;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXSdYQGVrhTp4Wv/mv9v7kK56S2Eh+evJ33raq4fdc0=;
        b=cc1c9QOSpVYqnRWHd3Wkmx1qcoGcCFS2+UWdIqN0aYyXSwiXn8yj1Q+6KyFXzuerMy
         LuA/9+c7Z53Uhrwbl0yLQg6YNOY4C0PIkhnT9LYibGTpzr5/xNr8LU4BFMiXq8ho0AxD
         5houxS7j2glIbRnvCg1AAHQKiUNQmWS+uXeUJNPYRzW2KK6D7/1TiG7xBudDgjJylvNg
         FRCzFyZkIuSWzc5ztEs//BiiWs1Kfox4t6QJwObadWv3gjaqcklbihGCYYCwdg5mcx4B
         gBcPmx+n6Igvm02KeCs3NW/Z/IVetwm/Jc6JVTiG0NYQY8YCm/js3Gg3zzbNKB0MhbTb
         vwTw==
X-Gm-Message-State: AAQBX9e1PNjok8RP3GrsTejZ/5eVst4TKlAvFeivjMdI0n8ouJCON4dL
        h6O8sfcLAEAHGB9CbaLMuy1ZUsnLL0E=
X-Google-Smtp-Source: AKy350a7fkkIpDBJXuub3UOuqAxGFgYGIgBDpL8fPFj6X21QQl8cingNH23I1976c1xsRCkU3VmNNA==
X-Received: by 2002:a05:6a00:2312:b0:63b:8702:4a41 with SMTP id h18-20020a056a00231200b0063b87024a41mr345615pfh.25.1681835655970;
        Tue, 18 Apr 2023 09:34:15 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b00631fecabdcfsm9784724pfi.97.2023.04.18.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:34:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <20230417093255.31079-3-jacobabel@nullpo.dev>
        <xmqq8reqkyfz.fsf@gitster.g>
        <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45>
Date:   Tue, 18 Apr 2023 09:34:15 -0700
In-Reply-To: <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45>
        (Jacob Abel's message of "Tue, 18 Apr 2023 03:53:55 +0000")
Message-ID: <xmqqsfcxdu9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

>> So "sh t2400-*.sh -x -i" already shows "cat actual" output.  Try
>> the attached patch on top of this one and running it would show
>> the above message shown by test_must_be_empty and the contents of
>> the file 'actual'.
>
> That should not be the case.

Here is how it fails and test_must_be_empty complains that the
"actual" file is not empty, if you run the script with "-x -i" after
applying the patch in the message you are responding to on top of
this step.

    expecting success of 2400.37 'add --quiet':
            test_when_finished "git worktree remove -f -f another-worktree" &&
            test_when_finished cat actual >&2 &&
            git worktree add --quiet another-worktree main 2>actual &&
    echo foo >>actual &&
            test_must_be_empty actual

    ++ test_when_finished 'git worktree remove -f -f another-worktree'
    ++ test 0 = 0
    ++ test_cleanup='{ git worktree remove -f -f another-worktree
                    } && (exit "$eval_ret"); eval_ret=$?; :'
    ++ test_when_finished cat actual
    ++ test 0 = 0
    ++ test_cleanup='{ cat actual
                    } && (exit "$eval_ret"); eval_ret=$?; { git worktree remove -f -f another-worktree
                    } && (exit "$eval_ret"); eval_ret=$?; :'
    ++ git worktree add --quiet another-worktree main
    ++ echo foo
    ++ test_must_be_empty actual
    ++ test 1 -ne 1
    ++ test_path_is_file actual
    ++ test 1 -ne 1
    ++ test -f actual
    ++ test -s actual
    ++ echo ''\''actual'\'' is not empty, it contains:'
    'actual' is not empty, it contains:
    ++ cat actual
    foo
    ++ return 1
    error: last command exited with $?=1
    not ok 37 - add --quiet

Observe what test_must_be_empty does in the last part of the
transcript above.  If you run it without "-i", then the trace will
show "cat actual" twice (one from test_must_be_empty above, then a
redundant one from the test_when_finished).

Another reason why we shouldn't add this to test_when_finished is
because it would not help those who run the tests with "-i" option.
The test_cleanup handlers are meant to be "clean-up" routines, and
they are not run when the user uses "-i", intending to go into the
test directory after seeing the test fail and inspect what is left
there.
