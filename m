Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9BFC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750C561263
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhKEImN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKEImM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 04:42:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0075C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 01:39:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so29765166edi.5
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 01:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9gF4Ua5Qj5w2GEZAwfUTf4kztOFU1/8CVXWmzcvZBGc=;
        b=oDyqUHTPVecgmM3WcN3dKarkE/S8oX7ikmxDspf/bT0To03AkHrMlhIjdwRsk0B5Kf
         zlY3KyNOGBtFcTtVEnfuFY2Rbds2WxEd2wIMEDxV/2BgEaQ+D2ZSAwJ3GC9aDAEaumoZ
         hdYJ9OSlnIhCiW+JTn4O34Fca7DLkxoKj9NiCKAUs/8dh3EjRPY3TwxWInqnKbcx1zRr
         17ob7PhdXkNTfq8vNQgTd9JIOYThsmnUCiOLKf3NUu6Ec5Vw+TRW+mW8p6WLTlfy6c58
         +5WkfJhazfmk3vn90S6Dn6Kv4pi7Q/Jz6amowOL676IEpSMWjXDVT81qtWQXNQgF1oWu
         haUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9gF4Ua5Qj5w2GEZAwfUTf4kztOFU1/8CVXWmzcvZBGc=;
        b=unDle29nlQtG8CBiaWzKL1ppsGMgNsGCfTtonq+09SerTLugDScZrXYfK4wJ/+FlbI
         X1FZLjYS+dqu0YdYcpHnJNC86+GtnNides8DLrje4/DB19I5f3qw5i8Ji1x0xx78iqEx
         a++sv6T40l5K8Hn3i+b1Q54aV5SYHdCt8B9kAETkPYRE/yxN3TZxZOHXoHa5065/csZw
         9t8DpA305fne6Xd+1jRGf44nNhJrb9zUn9fFvx6YHd7Kq79aDe2AOMuTMqOUzALYz84v
         et0ZvP33GJ9mM2Mk1944YJt8Ctg8BLOKuEYNf//kpoF08pxegUQoizlhlmVrHENN+W6Z
         UzJw==
X-Gm-Message-State: AOAM531AVltLJXEzKgoXlZ9bfh0ymWj7PB9tHf7RK0YFP2Bub82UKe0v
        JJLWDXZjY0RsgCfaYd6kex4=
X-Google-Smtp-Source: ABdhPJwgcKWKACOdd8CE6FdYV39WqpLCJPvC2H1yyn1Wds2dPS8ugVs/2X+v3dNpm1v2g7BkZ2Xcpw==
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr10621038ejc.12.1636101571241;
        Fri, 05 Nov 2021 01:39:31 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t25sm4094471edv.31.2021.11.05.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:39:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miul0-000GpD-3t;
        Fri, 05 Nov 2021 09:39:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Date:   Fri, 05 Nov 2021 09:35:24 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com> <xmqqk0hn1unp.fsf@gitster.g>
 <20211104223600.GA4069@neerajsi-x1.localdomain>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211104223600.GA4069@neerajsi-x1.localdomain>
Message-ID: <211105.865yt7hu7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Neeraj Singh wrote:

> On Thu, Nov 04, 2021 at 02:24:26PM -0700, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> > I think it would probably be best to create a git_fsync_fd() function
>> > which is non-fatal and has that config/while loop, and have
>> > fsync_or_die() be a "..or die()" wrapper around that, then you could
>> > call that git_fsync_fd() here.
>>=20
>> Adding git_fsync_fd() smells like a poor taste, as git_fsync() takes
>> an fd already.  How about making the current one into a static helper
>>=20
>> 	-int git_fsync(int fd, enum fsync_action action)
>> 	+static int git_fsync_once(int fd, enum fsync_action action)
>> 	 ...
>>=20
>> and then hide the looping behavior behind git_fsync() proper?
>>=20
>>         int git_fsync(int fd, enum fsync_action action)
>>         {
>>                 while (git_fsync_once(fd, action) < 0)
>>                         if (errno !=3D EINTR)
>>                                 return -1;
>>                 return 0;
>>         }
>>=20
>> fsync_or_die() can be simplified by getting rid of its loop.
>>=20
>> None of that needs to block Patrick's work, I think.  A version that
>> uses raw fsync() and punts on EINTR can graduate first, which makes
>> the situation better than the status quo, and all the ongoing work
>> that deal with fsync can be extended with an eye to make it also
>> usable to replace the fsync() call Patrick's fix adds.
>
> Is there some reason we shouldn't die if writing the ref fails? We are
> already accustomed to dying if fsyncing a packfile or the index fails.
>
> I assume the number of refs updated is not that high on any given git
> operation, so it's not worth having a batch mode for this eventually.

Others have mostly touched on this, but usually (always?) we're about to
die anyway, but by not calling die() here we'll die with a less crappy
message.

I.e. this bit:

    strbuf_addf(err, [...]

Is effectively a deferred die() in most (all?) cases, and be passed up
to the ref update code. because instead of a nondescript message like:

    fsync: failed somewhere

We want:

    couldn't update ref xyz to OID abc: fsync failed

Or similar.=20

Hrm, actually having written the above there's a really good reason not
to die, which is that fsync can return ENOSPC.

So if we're in the middle of a transaction and have created and written
the lockfile we might only notice that the disk has is full when we do
the fsync().

In that case we'll (or should, I didn't check just now) unroll the ref
transaction, and delete the *.lock files we created, which presumably
will succeed in that scenario.

So calling die() at this level is the difference between leaving the
repo in an inconsistent state due to a disk error, and something like
"git fetch --atomic" gracefully failing.
