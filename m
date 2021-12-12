Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A27C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 22:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhLLWjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 17:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLWjw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 17:39:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F7CC06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:39:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so45732790edb.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wB/hqYQesr77eDQ9g2PdCHSbPvrS5zamFRvy0j8m8WQ=;
        b=jDbCL/8Rc5V1jq+1G2aOI5dKRBDyzFxwi7MwevEdQSX5S+He0XvL3cB0HC82vsBk+A
         FF/8Qd6zD+b4Bor9hEYBiFE88NMFKBlTCaeUMIFmW6v5nSrD0EJ/7IAAwM+24EbtSk7k
         DdsZoGkO71le5QjNJvgoyBQ/nvWPYFxXeomEYDMAN1UKP41sq+JfpRtSuA6/SSuMWf/6
         MH+iKbBPIQxPCZJ9IPWKvTlILVUvahfZ/OJiRlDD2vy/EXhilmx2fXV0VGNQEQq178WA
         SNYkoVLaBKEsT1XddjrtqS+e9VVwv5RyXBJjq6RGhDzhG0Q3Toif2aau+Adk9H/KvLPE
         +cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wB/hqYQesr77eDQ9g2PdCHSbPvrS5zamFRvy0j8m8WQ=;
        b=wesXNEgkjUsgcV6pfhP9aRGHuS01xnJnJa28g98/x+7lRG7G2zPKoFc8AajxWN09/q
         XFb2yrG1H/KBba8LtdVcSoBQhr8wmsbItAzn7bA89guy3A72oLPpBIC3TpSLf2QrUkhA
         BBzTLrNu04/kI580y2ufbqN2aNHKtyLeLzD9oWQuDk/6J/3l9200w6wyUw1b4sbdADa9
         JwJSzcWZnHgHgcqzGXwhAcWuK1HehAmCMqlcZOi6LLKt0+ST3Mr1vu2kcvZoiGvjbJCY
         LS6//Fjn5xQh7LVFaO0Ki4w94c6O5Xl31ZVyT4eZ6PSysTxOBRPJVo2h2p6O1IL6iL2a
         yW2w==
X-Gm-Message-State: AOAM530pl0ko3ube7y3Uo/sHgWAC2gfYeZTJcCKO3vO+JSWFMpS85Ogb
        ri/sB64ZoZHc6jJe8bF5prA=
X-Google-Smtp-Source: ABdhPJwfk2FQCrbnp2X1TZ/Y4GZNlJXb7u4GOXJMGByv2WV1sMha8r6QPN9e7tNIlEJkvQeCHN+d0A==
X-Received: by 2002:a17:907:60c9:: with SMTP id hv9mr38923936ejc.482.1639348790330;
        Sun, 12 Dec 2021 14:39:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jz4sm4830875ejc.19.2021.12.12.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 14:39:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwXVU-000foW-BZ;
        Sun, 12 Dec 2021 23:39:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Oakley <andrew@adoakley.name>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>, git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2 1/3] git-p4: remove support for Python 2
Date:   Sun, 12 Dec 2021 23:01:27 +0100
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
 <20211210153101.35433-2-jholdsworth@nvidia.com>
 <20211212175054.5d3c11af@ado-tr.dyn.home.arpa>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211212175054.5d3c11af@ado-tr.dyn.home.arpa>
Message-ID: <211212.86k0g9a1mz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 12 2021, Andrew Oakley wrote:

> On Fri, 10 Dec 2021 15:30:59 +0000
> Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>> The motivation for this change is that there is a family of issues
>> with git-p4's handling of incoming text data when it contains bytes
>> which cannot be decoded into UTF-8 characters. For text files created
>> in Windows, CP1252 Smart Quote Characters (0x93 and 0x94) are seen
>> fairly frequently. These codes are invalid in UTF-8, so if the script
>> encounters any file or file name containing them, on Python 2 the
>> symbols will be corrupted, and on Python 3 the script will fail with
>> an exception.
>
> As I've pointed out previously, peforce fails to store the encoding of
> text like commit messages.  With Windows perforce clients, the encoding
> used seems to be based on the current code page on the client which
> made the commit.  If you're part of a global organisation with people
> in different locales making commits then you will find that there is
> not a consistent encoding for commit messages.
>
> Given that you don't know the encoding of the text, what's the best
> thing to do with the data?  Options I can see are:
>
> - Feed the raw bytes directly into git.  The i18n.commitEncoding config
>   option can be set by the user if they want to attempt to decode the
>   commit messages in something other than UTF-8.
> - Attempt to detect the encoding somehow, feed the raw bytes directly
>   into git and set the encoding on the commit.
> - Attempt to dedect the encoding somehow and reencode everything into
>   UTF-8.
>
> Right now, if you use python2 then you get the behaviour as described
> in the first of these options.  It doesn't "corrupt" anything, it just
> transfers the bytes from perforce into git.  If you use python3 then
> git-p4 is unusable because it throws exceptions trying to decode things.
>
> [...]
>
> I think that this is the problem which really needs solving.  Dropping
> support for python2 doesn't make the issue go away (although it might
> make it slightly easier to write the code).  I think that the python2
> compatibility should be maintained at least until the encoding problems
> have been solved for python3.
>
> I previously wrote some patches which attempt to move in what I think is
> the right direction, but unfortunately they never got upstreamed:
>
> https://lore.kernel.org/git/20210412085251.51475-1-andrew@adoakley.name/
>
> Your comments elsewhere that git-p4 could benifit from some clean-up
> seem accurate to me, and it would be good to see that kind of change.

This summary makes sense, i.e. if the original SCM doesn't have a
declared or consistent encoding then having no "encoding" header etc. in
git likewise makes sense, and we should be trying to handle it in our
output layer.

[Snipped from above]:

> It's not clear to me how "attempt to detect the encoding somehow" would
> work.  The first option therefore seems like the best choice.

This really isn't possible to do in the general case, but you can get
pretty far with heuristics.

The best way to do this that I'm aware of is Mozilla's character
detection library:

    https://www-archive.mozilla.org/projects/intl/chardetinterface

Here's an old (maybe/probably not up-to-date) copy of its sources that
I've worked with:

    https://metacpan.org/release/JGMYERS/Encode-Detect-1.01/source/src?sort=[[2,1]]

I.e. if you get arbitrary text the best you can do if you're going in
blind is to have various character/language frequency tables to try to
guess at what encoding is the most plausible, but even then you might
still be wrong.

I'd think for git-p4 (and git-svn, how do we handle this there?) a
sensible first approximation would be to use UTF-8, and if we encounter
data that doesn't conform die.

Then offer the user to manually configure a "fallback" encoding. I think
most real-world projects only have two of those, e.g. some old latin1
data before a UTF-8 migration.

And maybe start with a "don't even try" mode, which AFAICT is what
you're describing Python 2 doing.

If we change the Python 3 code to do what the Python 2 code does now,
will we pull the rug from under users who have only ever used the Python
3 code, and are relying on those semantics somehow?
