Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE165C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CE660FE3
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhEMLqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhEMLpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 07:45:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C85C06175F
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:44:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t4so39514206ejo.0
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QknEPk+uzxKxsRNPzRPq3yWkVTKs1x8g4cVJCvkO86A=;
        b=B3v0giKM7GrfHP/wHsGtRHSCcvRHhmbeEBzjnMsxyoI+9b0LDSa7cecKZBZBlaWRQR
         EAcF4LcmvsUXmrz5iFhnltfwrNQca8SqJ3htMb9Wzqm0YYGytqtPZ/rxB28mfX2woIUs
         5fa38CYS0kVt4tZSWSOMSAtuNnRKw8IawPH3sDKBH0Z35FoW5KD4lu++jZuklbJRZql4
         JPmiqdiqlFP9dQSdkY75nfNKaa+EYcZPTAnLwLIBvfKZ9mL297qJAkh4ayBMb8vw+rN3
         PKGncKdaMahfzLFW2kjeas6Psr4zcHMcxRXTEN8WkTJouBEadNdzhgDu2JeLbTR6TdEY
         ojyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QknEPk+uzxKxsRNPzRPq3yWkVTKs1x8g4cVJCvkO86A=;
        b=TvPYtU1vfib7HhnAS03pffzOlEOTZqm9PoQb57KUGB5TMf4jQYDphCoBu60u2fGTD5
         bdRv9+05afOJXTjgTwi/BLuTHFxZ/BZc1PhBq5pW/UugcBkWkkxo807+2V0ZEo1RYX6R
         R22lKnmsKtAiLnxgliH8Eqa+TjpWuh23kq83s0t4jn3I07EDVI2rst/xqraW85WmMjDu
         DTbsJ7KJi0mLdzF7am1cmzT5Q+dD0XZOKtMblY+i0VNTyKd8gjgxsSDaIhf8R7FyW+pg
         6FF9oL4RbbjgOTGuiBWXIyhjVA51W0l9jmn0LhDc3tZqZHFMijNQFJpRUsTey9T9ruOw
         MlWA==
X-Gm-Message-State: AOAM533ctX10R2HB5vdhGx3LtoFW13WWKGIJ9snASc5c5uZmN7rMDcXB
        7CEHWNDK8uymzBPSF+R8TUs=
X-Google-Smtp-Source: ABdhPJxLC6UqN26/KdQIleHF6JIHOOKIn+QALAOkEJgWTVIShexaVloa9OMov5XJx8y/RH+rup+DVA==
X-Received: by 2002:a17:906:79a:: with SMTP id l26mr42930634ejc.268.1620906278197;
        Thu, 13 May 2021 04:44:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c5sm2143926eds.94.2021.05.13.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:44:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/gc: warn when core.commitGraph is disabled
Date:   Thu, 13 May 2021 13:24:38 +0200
References: <510425b8b17411eb93770026b95c99cc@oschina.cn>
 <b87b12b4b3c311eba1fd0024e87935e7@oschina.cn>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <b87b12b4b3c311eba1fd0024e87935e7@oschina.cn>
Message-ID: <87k0o2svru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 13 2021, lilinchao@oschina.cn wrote:

>>
>>On Mon, May 10 2021, lilinchao@oschina.cn wrote:
>>
>>> From: Li Linchao <lilinchao@oschina.cn>
>>>
>>> Throw warning message when core.commitGraph is disabled in commit-graph
>>> maintenance task.
>>
>>Won't this cause the gc.log issue noted in
>>https://lore.kernel.org/git/87r1l27rae.fsf@evledraar.gmail.com/
>>
>>More importantly, I don't think this UX makes sense. We said we didn't
>>want it, so why warn about it?
>>
>>Maybe there are good reasons to, but this commit message / patch doesn't
>>make the case for it...
>>
> Uh, well, maybe I should argue for this patch a bit more.

> First this is in git maintenance task, I've read the link you post,
> and I feel it has nothing to do with=C2=A0maintenance task.

Yes, maybe the issue I noted with gc.log being populated because
something wrote to stderr won't happen here. I was just asking if you'd
taken it into account.

> Second I hope the `commit-graph` task can do the same thing with
> `incremental repack` task that to warn user when the related necessary
> setting is not yet ready, instead of running quietly, but doing
> nothing.

I agree that if you ask git to --do-stuff and core.stuff=3Dfalse then we
should probably emit a warning, "but you disabled stuff!".

In this case though, isn't the entry point just "incremental", we then
check should_write_commit_graph (as an aside, and not new in your
change, shouldn't this "is the config set" be moved there & be the first
thing we check?).

Then we run maintenance_task_commit_graph, where we see that the config
is disabled.

So aren't there users that want incremental maintenance, but have also
disabled core.commitGraph (or writeCommitGraph or whatever), that are
then going to get a warning about something they explicitly disabled?

Or is this warning just for cases where the user has somehow scheduled a
"commit graph" task, with config disabled, and the task can therefore
never do anything useful? I agree that in such a case it probably makes
sense to warn (or just exit non-zero?).

Anyway, I really do mean what I said about the "issue" being that the
commit message needs to "make a case for it". I.e. even as someone who's
hacked on the gc.c code (although not since "maintenance" became a
thing), I honestly don't know if this warning is OK, i.e. are we at the
point where we issue it where the user really wants the commit graph,
but we just have a misconfiguration?

I *suspect* not, and that it's going to be annoying to people who really
don't want the commit-graph, but who run "incremental", but maybe I'm
wrong.

If that is the case maybe there's still a case for saying something, but
that should probably be an advise(), not a warning().

Or the whole thing is fine, I honestly don't know :)
