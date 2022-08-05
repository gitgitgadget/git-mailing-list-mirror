Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92212C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiHEO4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiHEO4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:56:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897F4D807
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:56:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so1816798edb.9
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=WWmWbSR/us0k05ykrSxkbBozwvtRUboHX279jFUjIow=;
        b=Lu+16CjSYz7h9ZdvLhpWlmsFk0giaGe8mPNBykjr4lg+3z+D8PfCmScq3lbt0oTtzm
         Ak7xD/9wTImcUI6/cQpUsyp7ZJPiJGIFx91cRazyqFT4VdDtI7GkWwkbCNqzlaGQx90j
         EuF2yKgWP8DlSpzBV2xzJwIOb6h2YVuxXEmotOWJI9cKh4t2HRRdvLGB4gFSz5XMWcs0
         OrCGxLxrEb6Xv+7W4YTB7CthI8Nf6QtfxS0N6YAVeliEI3FpFolPxDcoCnNudAciAbTT
         2x5UZ7NBNMw/WPjaXRy1cJkG7bgzVUE9nJegNr7QAoudcYZA5TyQKyHRrWquMTPqTtWY
         WvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=WWmWbSR/us0k05ykrSxkbBozwvtRUboHX279jFUjIow=;
        b=02E1kVQPNNo//9Qd9ohKq5mODFA1Brrf6RCLyPvo9hepHVO5qm5iVlCbaCpv6StB1m
         q9f70XPUq13Rn6AGfjh4XZ0sQG+BKNhJqibivtaR8oHcuXEI3Xf9r1yH8vPZTfAOjs5b
         t9Ib854AWitjuFHmzVD3XXCJDj6PKOZ8teu+zG0hxIl+OFloGzcAUbwdVKJtypTVcy3Z
         DKs6GqVXTO4L16lpvecwW6cWkDpJ/EqLq/Iguu6Fx5fgjRjCemLKFouPfXowpEjiYgje
         GNCSLN53xvYND+qrI+Rvlc5KH0KJ7QQQtT5kfoYCDHmksZH/nZiGOlMkMVKgm+owcjx7
         33LA==
X-Gm-Message-State: ACgBeo28TqjmyO3/1Jwmn8biJvWJPCsatpq52os2nqT9V7YlmLB5Mrzn
        VaTMJIs9CcsPt7HHibQwIhA=
X-Google-Smtp-Source: AA6agR6OMQEmAarNQ3cQjhe8rt0wlFv2zxiqVvsoEiCxfoaLeAiLcPlQG9WtozLmhw6p9/6h6L8AfQ==
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr6920575edc.86.1659711369988;
        Fri, 05 Aug 2022 07:56:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ev18-20020a17090729d200b007306d3c338dsm1633419ejc.164.2022.08.05.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:56:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJykC-000ex4-0i;
        Fri, 05 Aug 2022 16:56:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Date:   Fri, 05 Aug 2022 16:50:11 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
 <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
 <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
Message-ID: <220805.86zggirb7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, Derrick Stolee wrote:

> On 8/4/2022 3:08 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> There's no lack of "stability", because the ref hiding only act on
>> what's known to be something we can ignore, because our git version
>> knows about it.
>>=20
>> If git v2.40 knows about refs/magical-1/* but not refs/magical-2/*, but
>> git v2.50 knows about both it's not a lack of stability that v2.40 shows
>> one decorated by default, but v2.50 shows neither.
>
> You are describing how the behavior changes between these versions on
> the same repository. That's what I mean by lack of stability.

If you want that forward-stability wouldn't another way to accomplish
this to put all of these new magical refs in the same refs/git-internal/
namespace, e.g. refs/git-internal/foo/, refs/git-internal/bar/?

>> But it's not just that I disagree, I genuinely don't get your POV
>> here.
>
> I'm optimizing for non-experts who never need any refs outside of the
> standard set.

Clearly, I'm wondering if we can find a way forward that doesn't change
existing long-statnding behavior and caters to the "stability" of future
inter-version behavior with this new class of refs.

> Now that this version removed the notes ref from the
> decoration, the stance for inclusion is simple:
>
>   If Git offers to color the namespace with color.decoration.<slot>,
>   then Git decorates with that namespace by default.

I'm a bit confused, sorry.

So aside from "notes", if we have a color.decoration.<slot> applying to
a ref now, it's a bug in your series if it's not showing up anymore?

I still find that inclusion criteria to be a bit odd, we've usually
considered colors optional sugar. Just because nobody bothered to add a
coloring config for it doesn't seem like a good reason to not show
something at all.
