Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18019C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357011AbiBNRXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:23:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:23:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B31652DE
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:23:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so28257677edn.0
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DjFyd9HevqZ2zYxDQ8ZbuYeXw4V1nHRpEVHzUga8LBM=;
        b=Ms/iRK1EaiZgAbZNzWQaMxLgNgRY8d3YvLhkhnICZ4EKIzGvQHE+Wj65k+a5vFQEO8
         ds8tmKf+tP/C+9IsY8quUtD+gv98SFmZA8BJ9hcY3qV9oYKOX1btFpLBoO9JqUv8dRA8
         Bx3ePERPUVVfhHLNLrL4yH9yEQpsQcN9KYbCUEytZpdYoKo5jZ4F1fuuSx3eKQD7NEaB
         80aUbc2irGU4MqHXZd4kBnFtgJta7f5h0tMpCWDfkwLAhW4AR80QdkQom+VsyddtrtYA
         OSdLiAG/QQAxbqo2/w0xgmHe2QVTHF/ELwlpMxzdRQPBaI8wQzze12dHZdC5eUTjo7b/
         wbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DjFyd9HevqZ2zYxDQ8ZbuYeXw4V1nHRpEVHzUga8LBM=;
        b=VxziY9wGlwcbtd9B5hPjxyZOBySdNCJ/QoNyebsBYkgTw4dLcI7F2cmXev+weLech4
         t/Bd4mEgIAYvm/nplsEz2vz/cc3jQCA0hJj8pwxfw+uZzRWhQgBzH4GhPncUGrReTn+8
         6nQd/04vuFGKTcKcwnoIOjJM7cpqpn7YjI3buT/Ar2P4rL7wMZhG5DtNy2A/qia1tW/w
         gbVgER2nq5BzipFi1HEyeggQ4Cd/HZiUgSMxsNM7baDaqMpwDSscb7v1zjikvLDoVeDy
         ffgoDKrDxM9oGqeH8aOrQ0ew1U0Zr0fvgLkcc19m3Dr2F21EeCImrDyQ1NJhV0xy9JRx
         duOw==
X-Gm-Message-State: AOAM532o9HtBKre5H6+9RZBJ5bHq04mEk/SJD4sGPomhcg6nq9lSnyZN
        sK1RabyxVrqWXj3J23lmh5wOeYavr/Y=
X-Google-Smtp-Source: ABdhPJwcu5O2qs0VqYlKhZpvi5FEOxo8IVeHprrFO9ocRXRyP/hUPkcaCAVi5EjqaAsCTFoslZrLtg==
X-Received: by 2002:aa7:c883:: with SMTP id p3mr655003eds.446.1644859403285;
        Mon, 14 Feb 2022 09:23:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e4sm3812241ejm.116.2022.02.14.09.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:23:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nJf4L-001aug-SP;
        Mon, 14 Feb 2022 18:23:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
Date:   Mon, 14 Feb 2022 18:19:53 +0100
References: <20220208083952.35036-1-chooglen@google.com>
 <20220210092833.55360-1-chooglen@google.com> <xmqqv8xj71mt.fsf@gitster.g>
 <xmqqr18770pc.fsf@gitster.g>
 <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220214.86h791xsza.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> This seems to heavily conflict with "clone, submodule: pass partial
>>> clone filters to submodules, 2022-02-04" by Josh Steadmon
>>> <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
>>> in both builtins/submodule--helper.c and git-submodule.sh.
>>>
>>> It also removes the code that "submodule: record superproject gitdir
>>> during 'update', 2022-02-03" by Emily Shaffer
>>> <20220203215914.683922-5-emilyshaffer@google.com>, so what the other
>>> topic ends up adding to the shell script needs to eventually be
>>> redone in the C code.
>>>
>>> I think "superproject aware" topic would see a reroll due to a
>>> slight redesign.  I am not sure how solid the design of the
>>> "pass down partial clone filter" topic is at this moment.
>
> Hm, I haven't looked at where the conflicts are yet, but I'll get to it
> as I'm reviewing the rest of the feedback.

To save you some time, my v4 CL summarizes the semantic conflict between
the two:
https://lore.kernel.org/git/cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com/

I.e. Atharva Raykar had working C code to do what an older version of
that superproject config series was doing, but the semantics changed in
a later version. It needs some new usage of path.c (or similar) API
adjusted, but I didn't (and still don't) have time to look into it.

> [...]
>> I can merge this to seen minus the above two topics and get it
>> compile, but it also seems to have some interaction with 961b130d
>> (branch: add --recurse-submodules option for branch creation,
>> 2022-01-28) and makes the t3207, tests added by that other topic,
>> fail X-<.
>
> Oof, that's embarrassing of me, let me take a look at that. There's a
> nontrivial chance that the "branch --recurse-submodules" tests caught an
> actual regression.

FWIW one thing I did as an extra sanity check was to run the whole test
suite with --tee with/without this series (or rather, my earlier
version), and diffing the full test-results output (which you'll need to
save in-between the two runs, and IIRC hack t/Makefile to stop removing
it on successful runs).

There's a lot of differences in output due to general issues in the test
suite output not being reproducable (writing timestamps etc.), but I
could not find any issues with the "git submodule" output being
different, of course we may not have tests, or it may be piped to
/dev/null....

But I've found it to be a helpful additional validation technique for
this series & others where I'm not as confident in the test coverage.

