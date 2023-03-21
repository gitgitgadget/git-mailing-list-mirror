Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADCDC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 16:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCUQdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUQdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 12:33:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF641B2CE
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:33:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a16so11738953pjs.4
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679416418;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2cVDOc0nBwCSBSpLWpxbY81j2mU+Ix6LJNRE2U+YlVQ=;
        b=YDgo3yWSACxr34GaHQK0NvZqSnvUYr93BXtaxqsq/BcqqyZlq8KQtAlnrMWKqhQQpI
         NINk/Fp2q5SqSMpDepKBQfK0H+CxB302v/cKWptMjGF3Bo4ubyJn7pN0BzodfYln01HB
         eg0YLTPAofcCbP+J5bN0/OMQcnDJSGP5n6M49IjZe6cVhAo5KVL7ieZp+RfgGFvXe0r0
         Nz08oGoRUJOqRTKFT9gxRTG1WK/tsvSN2rpMXukm1HMWfAgdxQ/5Rodacon7bNV+ZpdT
         OxtLDYVmswbsCK/75C1UtwnJAmljDZP2oRVXpY1VyF62XaLWJZi/mrAKLBtZ9581WgXt
         +M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416418;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2cVDOc0nBwCSBSpLWpxbY81j2mU+Ix6LJNRE2U+YlVQ=;
        b=Oy/Rsx/M/Bjb9a8SmY3ZpijwvxoDjIHT1d9ev/bumi0rK/XMoY7RXAh/QlC/SADNLy
         v7mb5kHoKfHlWOHsgHxBbTP2EJK6FDMPCwpn9CDCkxBmd6xFqGhTvy7MwDRlRVoAAXhw
         VjefJkDa8dhoAjg+FCY2+h1uYeiuJfhaiipfnZrRyeN0OHYzycRY1ZOVl0oR8rBqAQw5
         +7DlmbYEzJJ+gQvXeSxRfcFmzyC4Z+25EK2Wmw4pbdVZ9aKfUFDtB2/V/uGjm7sY0Q3i
         iVEhJEAbWogwRYBR5zAWopriU6C3n6pc8LFxGVCJRpKQabjNtbX/J9y8512+ZDbXb9yT
         Cx2g==
X-Gm-Message-State: AO0yUKXh7plols6N4SWRyTXjaurNPLaq3bSHpfHGFXOJJzx0IYylWAi+
        ByAJqujkDVEwSBmSwIu2ffyoO5cShzs=
X-Google-Smtp-Source: AK7set9vMb0L4tvXo+AH6q9m5CIJIMe6XCZa81NOiEXRF2XFJk3CMXHki96kqb1s9rvZfmLA65Bcwg==
X-Received: by 2002:a17:902:c40c:b0:1a1:b52d:68e1 with SMTP id k12-20020a170902c40c00b001a1b52d68e1mr3776227plk.32.1679416418367;
        Tue, 21 Mar 2023 09:33:38 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a072aedec7sm9055950plb.75.2023.03.21.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:33:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephane Odul <stephane@clumio.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Mathias Krause <minipli@grsecurity.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Suspected git grep regression in git 2.40.0
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
Date:   Tue, 21 Mar 2023 09:33:37 -0700
In-Reply-To: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com> (Stephane
        Odul's message of "Tue, 21 Mar 2023 01:04:08 -0700")
Message-ID: <xmqqttyejc7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: on the CC: line, summoned a few people who may know a lot more
about pcre than I do]

Stephane Odul <stephane@clumio.com> writes:

> We have a CI pipeline on a private repository that started failing
> consistently while running `git grep -P` commands. The command
> fails with an exit code of -11 and is failing pretty
> consistently. With prior versions of git there is no issue
> whatsoever, but with 2.40.0 it always fails on the same
> call. Other git grep calls are fine, but that one is failing
> consistently.
>
> I was not able to reproduce locally but my main machine is an M1
> MacBook Pro, the CI pipeline runs under Kubernetes in AWS and the
> container is based on Ubuntu 20.04 with the git client installed
> via the PPA.
>
> The error is for this pattern `git grep -cP '^\w+ = json.load'`.
>
> As a workaround we tried to download and install the microsoft-git
> v2.39.2 deb package since it allows us to downgrade, but then the
> git grep commands just got stuck.

One "grep -P" related change we had recently between 2.39 and 2.40
was

    50b6ad55 (grep: fall back to interpreter if JIT memory
    allocation fails, 2023-01-31)

The code tries to figure out at runtime if pcre engine has
functioning JIT by making an extra JIT compilation of a sample
pattern and when it fails with a specific reason, fall back to
interpreted pattern matching.  The change made the code to emit a
bit more detailed information when it fails, but a controlled exit
from the codepath should give $?=128, not 11.

So the above commit may or may not be related.  It could be that the
version of pcre library linked to Git 2.40 and older Git you are
running in your CI environment has been updated.

Does it make a difference if you disable JIT by prefixing the
pattern with (*NO_JIT)?

Thanks.
