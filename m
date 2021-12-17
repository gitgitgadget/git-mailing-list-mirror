Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB0C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhLQW1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLQW1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:27:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46101C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:27:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so13258700edd.3
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Pl3gt5KDh5d2SB7vtMHNgiI0ILJIMJH7bAwLvzRBjEI=;
        b=Ba8+xZTbKs2SxXidKPa7cbDsv/nFg40nMzs0C2JPQpSwUBGEnJZFx5ThLPAjmfuXBt
         pqNJTgM25rWehs9obfsUavBVK9OnQOVAPD64gMaWn6W1DbyWsdo1NZqmG5MLsPIA3mFS
         FydJbkS8qaDNPLIxdg/pbI3oQlDsffMC0ZkmHqD2VLAnwl07r++b1RCrQLJHOK3JvTQy
         uta5Unl+0J6Z2eALamMIYh74diFEDRZK4KT7APewMfy07trTIfMDEq1ZiBE409B/ODBK
         7cgsujYnxGZaWN2sZt0SaH5cNQPAimzcZBSFuvpqffUybPRcucu1o01MGc0Uz7YJV+ks
         LPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Pl3gt5KDh5d2SB7vtMHNgiI0ILJIMJH7bAwLvzRBjEI=;
        b=zp4jMoHa6Mx6/RzZfT9Xg7zprNbvtGuUCfjXPYdzPfk9nlIrWDzz29Z1zN8q1SzUeu
         nO06OuTl5n0WXkBdYIpOlNPj8Q9e1Q8qOFqKCDrtxcsC8mmfDsvWMJmMH6YKy+UFm9hl
         DQ709tbwesVjkpdmCwYmZhfPH5lP/knSZcEaclDakbnVyUDISf9l4w1kfx3bVnVrwBCm
         sA2O9qUl73xmsf1dPD82mltwgfvnMERy1579nViX5dkjhLtz0iLjdjhdWXrHBajRqMS1
         ouBWJt+SZDKIQfs1siGyPCU2+IEcJUE9f/PwiUojTsMQeYkYnRlLu0h/Ui8Ei89qpCk3
         GYgg==
X-Gm-Message-State: AOAM530kfvwp5D6mxcKnH8gTkgA8sWf4faE0RO81mXyuAocyen42WwGJ
        7AEe8mS5h2pStfiJUpgjgiyykwysy2n7Mg==
X-Google-Smtp-Source: ABdhPJwqTksMtd/+/3gSI+VJRxqGbk87F0cg1dvXAYtcBF4GpUZKB7o2A5M6YezyKCVWtivYj4u1Fw==
X-Received: by 2002:a17:906:1d58:: with SMTP id o24mr3917003ejh.121.1639780065779;
        Fri, 17 Dec 2021 14:27:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb31sm336791ejc.76.2021.12.17.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:27:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myLhY-000DG4-G5;
        Fri, 17 Dec 2021 23:27:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4204 is not sanitizer clean at all
Date:   Fri, 17 Dec 2021 23:23:00 +0100
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
        <xmqqtuf86t7z.fsf_-_@gitster.g>
        <211217.861r2bal75.gmgdl@evledraar.gmail.com>
        <xmqqk0g32c06.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqk0g32c06.fsf@gitster.g>
Message-ID: <211217.86a6gyyihr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This change looks good to me.
>>
>> FWIW this is not a mistake on my part, but something I'm perfectly aware
>> of. I don't consider it to be "brekage".
>>
>> We have plenty of place in the test suite where we hide exit codes on
>> the LHS of a pipe, or where we call a function that doesn't &&-chain its
>> git invocations.
>>
>> In those cases we can and usually will "succeed" under LSAN, because it
>> allows the program to emit its full output, and will abort() at the very
>> end.
>
> But pipes do not hide ONLY deaths by sanitizer.  And by relying on
> the presence of pipe hiding deaths of git tools to mark the script
> sanitizer-clean, the TEST_PASSES_SANITIZE_LEAK=3Dtrue line adds an
> unnecessary road-block for those who are cleaning up the "git whose
> crash are hidden by being on the left hand side of the pipe"
> pattern.
>
> I do not know what to call it if not "breakage".

Yes it's broken as far as the test is concerned. I meant as far as
"GIT_TEST_PASSING_SANITIZE_LEAK" goes I consider it somewhere between
"meh" and "don't care yet".

I.e. these are pretty irrelevant for finding leaks, as we've got a huge
deluge of them elsewhere. At some point we might have a last few stray
memory leaks in git hidden by such patterns, but we're very far away
from that.

Sometimes fixing those is trivial as in 3247919a758 (commit-graph tests:
fix error-hiding graph_git_two_modes() helper, 2021-10-15), and
sometimes we'll find that the test was broken all along in some other
subtle way, as in the a046aa38ca9 (commit-graph tests: fix another
graph_git_two_modes() helper, 2021-10-15) follow-up.

But as to the "roadblock" I don't mind the
TEST_PASSES_SANITIZE_LEAK=3Dtrue being removed from the script at the
slightest sign of trouble. Nobody should have to shift gears and chase
down some memory leak in "git log" just because they needed it for their
test setup.

And I'd very much prefer that to UNLEAK() just to avoid that
TEST_PASSES_SANITIZE_LEAK=3Dtrue removal, because it makes fixing the leak
itself harder as far as what topic to target, re-adding
TEST_PASSES_SANITIZE_LEAK=3Dtrue once it's fixed etc. goes.
