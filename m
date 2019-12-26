Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A53C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA10206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC8AY698"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLZVmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:42:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45167 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:42:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so13436174pgk.12
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 13:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZygxoWpBut9p+CWGYfFZARctpgkhN2QxBnqD/QEgT0=;
        b=SC8AY698oaXyUiUbBeozU0aq67XcjdC2tPq/CTwJV+43tyVF9IvC+yK1vwLpfoD6Rn
         h92Luvne/HfOc+XNYkVrf2K1tMKtJ7f9HBedDO6ytiOx5Ta0yvXV4PvEUzUAxjMw85Em
         1kkHWyLJRMEo7JckUpUooNEefG7b4n6prpgrqNFuTuLTtHms11z2o35kB3vsA8JFYhzT
         BCbFQQ05oNpH4uFP7YEjqvr+6/VnGgVZkVDJUP+4KXwlMczWYdcFHEaOjKODt07jv4bm
         czqtWesYJ9zlIc58hPBcG+pPkFUsRRhahBumfEoe3l5fGHmnzEwVFNqm0G3iG3oFJ9MW
         1+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZygxoWpBut9p+CWGYfFZARctpgkhN2QxBnqD/QEgT0=;
        b=Sp1ipGznsPDu+bE8MO+I4WYP4W43MkDLD5azZkFJ1Wfp3XRfZuCry1ndAABqQomBVV
         +hRXdSxVWR0Wu66p6iRHT6R0SBUGyMjTEOiI7QZuNvvViN7dPPWoUJBY3m55pb0MOChJ
         Mm7Apqx+O7Is9YMiSuPN5znb0NrmNyhCBfvTSZyT1MJmaFJ2AA1KTKY6w+fEjkxYMH5P
         ux49NqARzvO3i1ynSt2M0mFNHdM01+G/orU9P2GPg118CEI6y3rXLQ8PxyeW4p0mlm5Z
         7dTtlreGr1ppcjAIjlavIsswFGke5tMqoRyhuaqUcV830T7CuTjX68/f5YAinZqcruUX
         wfcQ==
X-Gm-Message-State: APjAAAUTPsX+q11f1FD629vQD7uhO00Fd+4jX/nOLlN3Nk+6HRsFxD4I
        u8QFxIw6rCdSQjqOykq9SJY=
X-Google-Smtp-Source: APXvYqwtmUCXHX0vKEbdrfCk0rinYnM9ip5X2ECj4YvlN+9uNvMdZOW+y0bGVtmCk1ThH3nVK3fcGA==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr50929350pfb.118.1577396568053;
        Thu, 26 Dec 2019 13:42:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a26sm28859133pfo.27.2019.12.26.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:42:47 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:42:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
Message-ID: <20191226214245.GA186931@google.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
 <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
 <20191226200316.GD170890@google.com>
 <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Thu, 26 Dec 2019, Jonathan Nieder wrote:
>> Johannes Schindelin wrote:

>>> Arguably, this is the wrong layer for that error, anyway: As long as the
>>> user never checks out the files whose names contain backslashes, there
>>> should not be any problem in the first place.
[...]
>>          between the lines of this commit messages I sense that there
>> *are* repositories in the wild using these kinds of filenames.
>>
>> Can you say more about that?  What repositories are affected?  Do they
>> contain such filenames at HEAD or only in their history?  If someone
>> wants to check out a revision with such filenames, what should happen?
>
> Yes: https://github.com/zephyrproject-rtos/civetweb contains history where
> at some stage, by mistake, a directory was called `\`. It has been fixed a
> long time ago, but users obviously still want to be able to clone it ;-)

Thanks.

What should and does happen if someone tries to check out an offending
revision?

[...]
> I added this paragraph to the commit message:
>
>     Note: just as before, the check is guarded by `core.protectNTFS` (to
>     allow overriding the check by toggling that config setting), and it
>     is _only_ performed on Windows, as the backslash is not a directory
>     separator elsewhere, even when writing to NTFS-formatted volumes.
>
> Does that clarify the issue enough?

It helps: that tells me why the check is only performed on Windows.

Since this only affects Windows, please only take this review as data
about how someone read the patch.  The patch doesn't make non Windows
specific code any *less* maintainable, and as a general presumption I
assume that the Git for Windows maintainer knows best about what is
needed for maintainability of Windows-specific code.

But the commit message and docs still don't describe what the desired
behavior is.  For example, should I be able to check out a revision
with a backslash in it (e.g. via Git skipping the offending entry), or
is the intended behavior for it to error out and prevent checking out
such versions of code?

Is there anything we can or should do to prevent people checking in
new examples of paths with backslash in them (on all platforms)?

Thanks,
Jonathan
