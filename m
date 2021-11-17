Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E48DC4332F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EAB613A9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhKQPsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbhKQPs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:48:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B519C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:45:27 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t5so13372959edd.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+Z3OFLqSwrgGIXhGupQ352DiRvHq7RDOQ8+k/NA3MGg=;
        b=N4UTK+ES0YLU32AOsq4BHa6oOZ63VEM8vFMXmnyMZjBBHnGSN/Po4wuyMhIHx0ymNa
         7J06N27vBGmM+6mKhN4JdUk7RM/DOvqPqcFAs9YmsBhcpJQix3vcs19F8CMAqflW9sZy
         XryraPWcWFzSbnx7xvUxVY81oYHLRpJyLelYd2SaKD/RkiVW4KvplGqMx3BAqEccgsl1
         T47eug3/eAaBWFXtGEpXdnQ7rBPdmz1C9sy5Dq6obrIWb3Mp+/e6kWoxBjC173oypytr
         dGDim9b5s3jd+Lopq527rpvBwGIbWU67WBPH6sNWiD055ZIAYtufZN5/SLC1GAkmkOeG
         9aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+Z3OFLqSwrgGIXhGupQ352DiRvHq7RDOQ8+k/NA3MGg=;
        b=0gxzofglJAOqI3BEd3ZYmoxDQw89Q+wwycj2VYQLU7SJaiMxnztyRy6rbVw9g4QKwg
         6go6Lwp3pR/LFyD72//YbuRjT0vnR3XnG952sio6rKOPho81N76fnrIMEhVY+Dyp9YPc
         oMUD8Qy2eZDbEqDyMxlBL5XJ8vW4ZxkRDASZVRODyHSmaTXV/JtDVbYbPLkr9s3E2nc9
         jL/my8+k6oEoJqbOXAlpjPOCcB1JCO41mjyty0E8cF+/xAjMqVQ+CzZWF6AIPe/at1So
         8afwfauKnpALfa3jsFE9pzeCJ6U5fSpbTJrHLOboGE1AcO9CXnz+vwyooToCqbT8TSNK
         5dbg==
X-Gm-Message-State: AOAM532HZMXJ+UUcQW23qon7C4YJQboUOPANbRnsecz0CSjhpWVvzohs
        FnmKorP+BHuSSfrHXIbpjuQGq5U1deVrOA==
X-Google-Smtp-Source: ABdhPJxhF3mTXH47GJ6k7zxczPghDMozcX6F8vZH/0oHFnXu/bnz4ZgTA/LIlEOKmPzlM6i1yLLpFQ==
X-Received: by 2002:a17:906:6899:: with SMTP id n25mr22927977ejr.253.1637163925837;
        Wed, 17 Nov 2021 07:45:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q14sm72932edj.42.2021.11.17.07.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 07:45:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnN7k-000E4I-Ld;
        Wed, 17 Nov 2021 16:45:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Date:   Wed, 17 Nov 2021 16:41:47 +0100
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
Message-ID: <211117.8635nu7pm3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Derrick Stolee wrote:

> I recently had to pave my Linux machine, so I updated it to Ubuntu
> 21.10 and had the choice to start using the ZFS filesystem. I thought,
> "Why not?" but now I maybe see why.
>
> Running the Git test suite at the v2.34.0 tag on my machine results in
> these failures:
>
> t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
>   TODO passed:   9-10
> t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: 1)
>   Failed test:  31
>   Non-zero exit status: 1
> t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: 10)
>   Failed tests:  1, 4, 6, 8, 11-16
>   TODO passed:   23
>   Non-zero exit status: 1
>
> These are all related to the UTF8_NFD_TO_NFC prereq.
>
> Zooming in on t0050, these tests are marked as "test_expect_failure" due
> to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:
>
>
> $test_unicode 'rename (silent unicode normalization)' '
> 	git mv "$aumlcdiar" "$auml" &&
> 	git commit -m rename
> '
>
> $test_unicode 'merge (silent unicode normalization)' '
> 	git reset --hard initial &&
> 	git merge topic
> '
>
>
> The prereq creates two files using unicode characters that could
> collapse to equivalent meanings:
>
>
> test_lazy_prereq UTF8_NFD_TO_NFC '
> 	# check whether FS converts nfd unicode to nfc
> 	auml=$(printf "\303\244")
> 	aumlcdiar=$(printf "\141\314\210")
> 	>"$auml" &&
> 	test -f "$aumlcdiar"
> '
>
>
> What I see in that first test, the 'git mv' does change the
> index, but the filesystem thinks the files are the same. This
> may mean that our 'git add "$aumlcdiar"' from an earlier test
> is providing a non-equivalence in the index, and the 'git mv'
> changes the index without causing any issues in the filesystem.
>
> It reminds me as if we used 'git mv README readme' on a case-
> insensitive filesystem. Is this not a similar situation?
>
> What I'm trying to gather is that maybe this test is flawed?
> Or maybe something broke (or never worked?) in how we use
> 'git add' to not get the canonical unicode from the filesystem?
>
> The other tests all have similar interactions with 'git add'.
> I'm hoping that these are just test bugs, and not actually a
> functionality issue in Git. Yes, it is confusing that we can
> change the unicode of a file in the index without the filesystem
> understanding the difference, but that is very similar to how
> case-insensitive filesystems work and I don't know what else we
> would do here.
>
> These filesystem/unicode things are out of my expertise, so
> hopefully someone else has a clearer idea of what is going on.
> I'm happy to be a test bed, or even attempt producing patches
> to fix the issue once we have that clarity.

I haven't used ZFS, but this points to non-POSIX behavior on the FS
itself. It looks like tweaking the "normalization" property might change
it, see: https://manpages.ubuntu.com/manpages/eoan/man8/zfs.8.html

There's also "casesensitivity" and "utf8only".

We probably don't want to invoke some ZFS command on every test to
interrogate this, but if we can pass it down from GIT-BUILD-OPTIONS or
similar then we could have a test prereq check this.

Or perhaps it's as simple as changing the "UTF8_NFD_TO_NFC" prereq from
doing a "test -f" to e.g. "echo *" and seeing what it gets back. Perhaps
ZFS says "yes" to "it exists?" but when doing a readdir() it will
canonicalize?

