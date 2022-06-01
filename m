Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66476C43334
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 16:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354061AbiFAQ4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354159AbiFAQ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 12:56:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476EA33A6
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 09:56:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z18-20020a656112000000b003fa0ac4b723so1249554pgu.5
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Q4asNi5ftrkq/C+iMWpxVYKgtHZjvbf3yOyUy/8TnoU=;
        b=OiIBzQwDB43bAPhNSqjzO7VAHZpPobovCjrMeCP3Y3TeKg3h5OO2hJRck98g4ficZ+
         D+OcAL4rCuGFyxJDsPYmZrdLAEvQunrxS2mVtnzJP7kX/OWamitAmeLBahEHkJEKz6pI
         W3llUV1RP1zMbp/jgT8ZhBVibRJMoa7XvMV0Hk0J3cMoZ0Xe8Eodmlfct2qWWZhYXCIe
         LUpxb5y3PtIBxYf33Ucv8vwUxd9QK05VJr5S5Zm3G/mZLjdtCu+U+zVCdRu7UE8INb0f
         Ysv9lqhNZbYDFrDFHYIfgcmuJfKH8sCYjnC4hoBhsUC3AR1ptnQWcNWs/LifUpGUDXMJ
         tf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Q4asNi5ftrkq/C+iMWpxVYKgtHZjvbf3yOyUy/8TnoU=;
        b=A9VDSln27868P6Oj5+t2H+6fmZVUqxrSUMmxnewDnUA5o41GpTW28/npYdf35colN7
         zIrnknvdez62anConAMUDGrKUk8FF+it/3zGzowuG4/XtVvnBYfsceN+IXuvZyfGLyUv
         fvYBEMd64HY/8imH5xMV5cVq4V3gGHZhD2GcIGuXZODprQvtLThtIn/iWcAi7iKH7OS5
         5GxcjgEf6Fxccbjz7k97NZTwACD1QvV9Tk9EL2QawXQtoLdRyyIWWkyQvYI7B1zLGqOZ
         /M7UoAc8+eoYvk3jBUEB89mTWds6GD0r+wgQ3P0NvE63N4SH9vJnGL42Z2NFe315TGVO
         1UZw==
X-Gm-Message-State: AOAM532uCtNARJPRMvf3Fs7KPxrpRbfhSM0OB6fVJStumJLHooO6Fwj3
        D/2EaBob9KczIDCh8ptry6ZukpjyEW6zTA==
X-Google-Smtp-Source: ABdhPJzFzJ8F8EZwOgWAbBpy832z/eyzkly6SeBZ2VKbzgHRdGx/A6a1ibfH9exkTfnnlEEb/jKw3PBoyKsHEw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:246:b0:153:84fe:a9b0 with SMTP id
 j6-20020a170903024600b0015384fea9b0mr327426plh.163.1654102560066; Wed, 01 Jun
 2022 09:56:00 -0700 (PDT)
Date:   Wed, 01 Jun 2022 09:55:57 -0700
In-Reply-To: <220601.86leug261j.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lilpke31e.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
 <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
 <220601.86leug261j.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 2/2] remote.c: reject 0-length branch names
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, May 31 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> Branch names can't be empty, so config keys with an empty branch name,
>> e.g. "branch..remote", are silently ignored.
>>
>> Since these config keys will never be useful, make it a fatal error when
>> remote.c finds a key that starts with "branch." and has an empty
>> subsection.
>
> Perhaps this is fine, but I think this commit message (and I checked the
> CL too) really needs to work a bit harder to convince us that this is
> safe to do.

Fair.

> Are we confident that this is just bizarro config that nobody would have
> had in practice? In that case I think it's fine to start dying on it.
>
> But as I understand we previously just ignored this, then if there's any
> doubt about that perhaps we should start with a warning?
>
> Or are we really confident that this is an edge case not worth worrying
> about in that way, and that we can go straight to die()?

The case I want to make is even stronger than that - this is an edge
case that _we_ shouldn't worry about, and we should tell the _user_ that
their config is bogus.

It truly makes no sense because `branch..remote` fits the schema of
`branch.<name>.remote` where <name> is "", but "" isn't a valid branch
name (and it never has been AFAIK). So such a key would never be useful
to Git, and it would be extremely hacky for a non-Git tool to use such
a key.

I'm not sure how a user would generate such a key in the wild (e.g.
[1]). Maybe it was a typo, but more worryingly (I don't have evidence
for this, but it could happen), it might be misbehavior from `git
[branch|config]` that we never noticed because the bogus keys have flown
under the radar. If there really is a bug elsewhere, erroring out when
we see such keys might also alert us to the bug.

Perhaps I need to capture all of this in the commit message?

[1] https://lore.kernel.org/git/24f547-6285e280-59-40303580@48243747/
