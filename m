Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4CBC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 13:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjBCNjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjBCNjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 08:39:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4179CBE
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 05:38:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dr8so15322411ejc.12
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 05:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzwJD2mTr81NyF5rMcCDUyUIzwXL2Jwt9wl4GPaYO50=;
        b=KdFEQ1U7p2mzs8KGImGev4i+I7MQHyczHxeRHgVosIgUjWRiYWj3FLxBW+QNgZphXH
         3Yfet6wv7fmZjoS+re+Gg9baz6nTSxmDhJ3IaRF2waAGOkOGD8Kt6vFhr+XQltUu/YSh
         BpqRSfexiGGHLohQNtaYtFtid0LNY9rcX5WT5jv0UAEqHyX1xKzH2MvUPQc7kae6VwOH
         yfuAYjdURun5vXvZleac4niLrrcdYzXchyBgWLwZplUWp616u+1HpSXGujMI0FiPUYxy
         CXjnarvPJOaQJ+8Q+7Ig+OLnGbXVA1AttvVKIJdwNlTAwDWBP5H5ZRZiYNpr0EbIjozw
         9HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzwJD2mTr81NyF5rMcCDUyUIzwXL2Jwt9wl4GPaYO50=;
        b=xlGsG3T/jyazfrJQ8z11V2t4rUSGa11qjoFwHs0gZiS3oH7Cu2EIeR34IR2sIZopN1
         bhRQQxbxFSo4ojOaPqFgdafLwjGBQDvDdQ2ZP7NtSnAi35PG1dlDiXQM2PhD2dzJogIv
         ilC5soZqfjfSmh5/9QVdg9aPM4wuSgHgnpigxCyD3uFq7bewanbvKHN/T9rJGhdBgjxc
         yBiUNZ174oOYPF3aj+sru9003+htsvkpf1rI98ncWI0XtExIzRCHqb2Q3xNQrVdJkW8t
         /v2u0htPtAFiAFpIQXAuqOYQBRoKiz5SPLYDb0rKOUSX30d4fnORTP/gywp+S/NDPzCZ
         1LWw==
X-Gm-Message-State: AO0yUKXJHcbq7bScSzKOWir/iguxRqWoKkhGRpzpwBDFWVCElfHWu/Qh
        0ubfoFHtr2anNp/Q4jr2DV/Kt0XAwvtNxAl8
X-Google-Smtp-Source: AK7set/bXWJA9BaaBFkqWwZwEJKq3yh7Ty76ImsgiDq5ymI8rhpxKWs+cGxB744iFaaEWUkWKuuQSw==
X-Received: by 2002:a17:907:9851:b0:872:45d3:dcfa with SMTP id jj17-20020a170907985100b0087245d3dcfamr9892112ejc.42.1675431537631;
        Fri, 03 Feb 2023 05:38:57 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709064b1600b008786675d086sm1396406eju.29.2023.02.03.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 05:38:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNwHI-000DEJ-1Z;
        Fri, 03 Feb 2023 14:38:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Joey Hess <id@joeyh.name>, Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Fri, 03 Feb 2023 14:32:08 +0100
References: <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
        <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
        <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
        <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
        <20230201122152.GJ19419@kitsune.suse.cz>
        <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
        <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
        <CANgJU+VNY-VziRijSwyb1WF9s31hKroK+2VJ0qEGiYweiA59Ug@mail.gmail.com>
        <Y9q129WbseimgeBS@mit.edu> <Y9wo4iH2crlt26+d@kitenet.net>
        <Y9yHWFh0ijwrqhOX@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9yHWFh0ijwrqhOX@mit.edu>
Message-ID: <230203.86o7qac1hr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Theodore Ts'o wrote:

> On Thu, Feb 02, 2023 at 05:19:30PM -0400, Joey Hess wrote:
>> In my opinion as the original developer of pristine-tar, it's too
>> complicated to be usefully used by git. The problem it solves is of a
>> larger scope than the problem git has here. (I hope.)
>
> Well, the problem which I believe folks on this thread are trying to
> deal with is a way to reconstruct a bit-for-bit compressed tarball of
> a particular release in a way that minimizes the cost of storage in
> the git tree.  One way of doing that would be to guarantee that git
> archive would return something which is always bit-for-bit identical.
> Another way is to use something like pristine tar.

I think that's what this side-thread has devolved into, but I honestly
don't see how that's useful or more than tangentally related to the
problem noted at the start of the thread.

If you are writing a new system that consumes "git archive" output
something like what I'm proposing to add in [1] should nicely sidestep
this issue, just checksum the uncompressed archive (assuming you're OK
with our soft "tar" guarantees), or "git tag -v" (if you can) etc.

That part of the docs is just a summary of what Konstantin Ryabitsev
pointed out in a side-thread.

One might also imagine any other number of trivial solutions to the
problem, e.g. people interested in this can unpack the archive, and then
(needs to guarantee sorted order, which I think find(1) doesn't, but
just as a POC):

	(cd unpacked && find . -type f -printf "%f\n" -exec cat {} \; | sha256sum)

Or whatever.

But any such solution to the abstract problem isn't going to help the
existing users whose systems broke because they were assuming certain
things about the "git archive" output.

For those users I think (as my proposed series does) we should just do
whatever we can do limit the disruption, as my proposed [2] does by
switching back to "gzip".

For those users who are creating new systems that might use "git
archive" today we then just need to update the documentation going
forward. Maybe those could use "pristine-tar", or perhaps they can use
some entirely different distribution mechanism.

1. https://lore.kernel.org/git/patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com/
