Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F81C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 04:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjAAEZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 23:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjAAEZY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 23:25:24 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C186365
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:25:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n4so26052136plp.1
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzLvrafymUHWWft70WN9odhvA1r1kKnHtiKceSUxsjE=;
        b=Gk/poAxFsqalXn/VyUjsiUy3Ie5zch26RcOtJC+EI7YhJ8ZdtVm7t3lzkIGPd/asqs
         ad44rKsz5RltVCwYMU9v9wlzDHfWiNxJAGgRevrhP2MudbK3yxa1Wuhu8LKhZXUb0xHs
         zK1iUbLDWB8rh3Z36ljKiH9MVa2eUDDpnJDJAtrI8PYQ6wTFmpN52sRLh1wpJYT3/RV/
         vknrCAGv3sARgObg0uE09ACAILI/zUiBoKX24s5lXe8ie7Ak/hWcXAaYh4oKWgDSwvZU
         20FD+imAkkeP4kINsI9xqKbn6To3iiuOhvhbM0KxtoH1KmLAGbfn5P4JTbAh7K+s0yWn
         Nv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzLvrafymUHWWft70WN9odhvA1r1kKnHtiKceSUxsjE=;
        b=S0gacT6XTMZHvtuWqr0RrdspKoNcEcGeZhqhzy42uP0UAUuwUIGCDqPdqAUWvt4N8t
         fusQDKzA48E7g6DLCaFpyUoQI7i/oXWmz1MI8Eds0iyJHf1YHxdsaxAkZqdrvTxU6ymg
         cVkhsMm8WmYz/NqXjy9Zm6kFTapFVebp2EW3rXnH/F/+87ygqjMENODMikbmzBR+J4rw
         qplYrMqhijywk5Hq2K4MBfLt0OvYyqtmKt5TqNZBGKvFcillSurzrWPXhm9unZhNiNsv
         fw1fuvbxGloVRL1d1cjD8yzRVkdRolOksKwBUB9TV/9S/AxKaiRfROjfweEuslC57+kZ
         XPVA==
X-Gm-Message-State: AFqh2koKyUDcgnP6N1hehg1PczguXnCIGe2zrYTq3UoHBh89t4ILzQKy
        pgDQLflDA+OPrbhl8DQiBGM=
X-Google-Smtp-Source: AMrXdXuXByOQ6n83+AG+596o3shfnTBF0TGH/w6J/j9G+X3j76R4erQ1xgvklUIB6LbHZ+iaREi4FQ==
X-Received: by 2002:a05:6a20:1b1d:b0:ac:5429:e609 with SMTP id ch29-20020a056a201b1d00b000ac5429e609mr39796905pzb.32.1672547118422;
        Sat, 31 Dec 2022 20:25:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a125-20020a624d83000000b005771475561bsm16051030pfb.163.2022.12.31.20.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 20:25:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/10] builtin/revert.c: refactor run_sequencer() return
 pattern
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
        <patch-04.10-1e4e504c533-20221230T071741Z-avarab@gmail.com>
Date:   Sun, 01 Jan 2023 13:25:17 +0900
In-Reply-To: <patch-04.10-1e4e504c533-20221230T071741Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Dec
 2022 08:28:09
        +0100")
Message-ID: <xmqqcz7yhoeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Refactor the return pattern in run_sequencer() to make it easier to
> insert a "replay_opts_release()" call between the "fn(...)" invocation
> and the eventual return.
>
> Usually we'd name the "cbfun" here "fn", but by using this name we'll
> nicely align all the "cmd == ?" comparisons.

If the new helper function sequencer_remove_branch_state() is used
elsewhere in later steps of the series, it is great that it is
extracted out of an existing code to handle the 'q(uit)' action.

However, I'd not appreciate this change from if/elseif/... cascade
to ? : ? : cascade, mixed into a creation of the new helper
function.  Such a change forces all conceivable future command
handlers to take only r and opts, and that is not a consistency we
do not know we need (yet---YAGNI).

Then you do not even have to talk about cbfun vs fn ;-).

And if sequencer_remove_branch_state() is not reused elsewhere in
the series, then simply dropping this step would be great.

Thanks.
