Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911CAC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7518E611EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhKDNce (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhKDNce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:32:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B86C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 06:29:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m14so20941385edd.0
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gEnAntuD0IEZMmmizWH7sKgpu5Sw5VsyXd7zGNgLXhs=;
        b=Y5QrTVmCVigZwVusDvaFVc89wVI8aQkgJSuIk595NMsylSUvk67ONh6+zevwUpAeht
         nLbSrkrwQQSpSlQoAmoDpEwt8C14cdDxzkafZyKqKtrHdp2Hj47knYDJk0qW84jLebCo
         Qi/NE8Gg1cNiHK535vdhVv2Aiosb0TNKwiy0bSFlW/z9sQBGsqmY4S/PrJrusVY2qtar
         6fcSOvwRLfiRyn/CM9k1Eheg6WSIlgWLqNsXUtu+9xafHOxXKEoaXHHyOHSVG+rYnrM5
         OgXY+3hA2co8VYNrhtxItex/eh3k3cB0wzv/DShFxSw6ySUqgSjpEt1QSmojt2n1ZLqJ
         6D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gEnAntuD0IEZMmmizWH7sKgpu5Sw5VsyXd7zGNgLXhs=;
        b=ZDc9H7EHiqDM+S3g/kFsTUjd/GyAlyvkG7LkdRQM1Z2T3UBEW2T0pp1eb4InLvyQJL
         uHoCmeUd8rxT1f9lJLfBzH7qbWQIQ/13qhfvpYmXs30XMlEMMnIeoiY+KSjCPC7w1Icn
         EYs2RyohciO1gVxMy1KhZpOYfGAEhW43DLE7KLfo0NYUZe470/jZ3IH4aBspgspDDiTB
         deX4B6HLHRin1MAd1eIrGYsHGiWBRz+d1yv9RZKsaSWq5f9LGrpExulRpR3VZ8gyJif/
         MQnOn4sqPmZumTqbkAP57eKgTXGhZRdRjdNWAz2EUVpK5NrQcgF6vsbKgjsG2UiH+JD/
         ieuw==
X-Gm-Message-State: AOAM532/4TCM92qFWEAf/DKZ2h+5yydTNzo0TWGqMCukExIG0u0In9ix
        BSyPMVAw3gN/ziIKHnS44vQ=
X-Google-Smtp-Source: ABdhPJxQMgiaOVsP06XWRZBGUkNtaJD014rU0FhtA5Mc5VKNB0IOT9MJTo906Y8xva4ZhalQ4bE71g==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr37426199ejc.58.1636032594082;
        Thu, 04 Nov 2021 06:29:54 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z6sm1199324edc.53.2021.11.04.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:29:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1micoT-000B6U-2e;
        Thu, 04 Nov 2021 14:29:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Date:   Thu, 04 Nov 2021 14:14:54 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
Message-ID: <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Patrick Steinhardt wrote:

> When writing loose refs, we first create a lockfile, write the new ref
> into that lockfile, close it and then rename the lockfile into place
> such that the actual update is atomic for that single ref. While this
> works as intended under normal circumstences, at GitLab we infrequently
> encounter corrupt loose refs in repositories after a machine encountered
> a hard reset. The corruption is always of the same type: the ref has
> been committed into place, but it is completely empty.
>
> The root cause of this is likely that we don't sync contents of the
> lockfile to disk before renaming it into place. As a result, it's not
> guaranteed that the contents are properly persisted and one may observe
> weird in-between states on hard resets. Quoting ext4 documentation [1]:
>
>     Many broken applications don't use fsync() when replacing existing
>     files via patterns such as fd =
>     open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo"), or
>     worse yet, fd = open("foo", O_TRUNC)/write(fd,..)/close(fd). If
>     auto_da_alloc is enabled, ext4 will detect the replace-via-rename
>     and replace-via-truncate patterns and force that any delayed
>     allocation blocks are allocated such that at the next journal
>     commit, in the default data=ordered mode, the data blocks of the new
>     file are forced to disk before the rename() operation is committed.
>     This provides roughly the same level of guarantees as ext3, and
>     avoids the "zero-length" problem that can happen when a system
>     crashes before the delayed allocation blocks are forced to disk.
>
> This explicitly points out that one must call fsync(3P) before doing the
> rename(3P) call, or otherwise data may not be correctly persisted to
> disk.
>
> Fix this by always flushing refs to disk before committing them into
> place to avoid this class of corruption.
>
> [1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 151b0056fe..06a3f0bdea 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1749,6 +1749,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>  	fd = get_lock_file_fd(&lock->lk);
>  	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  	    write_in_full(fd, &term, 1) < 0 ||
> +	    fsync(fd) < 0 ||
>  	    close_ref_gently(lock) < 0) {
>  		strbuf_addf(err,
>  			    "couldn't write '%s'", get_lock_file_path(&lock->lk));

Yeah, that really does seem like it's the cause of such zeroing out
issues.

This has a semantic conflict with some other changes in flight, see:

    git log -p origin/master..origin/seen -- write-or-die.c

I.e. here you do want to not die, so fsync_or_die() doesn't make sense
per-se, but in those changes that function has grown to mean
fsync_with_configured_strategy_or_die().

Also we need the loop around fsync, see cccdfd22436 (fsync(): be
prepared to see EINTR, 2021-06-04).

I think it would probably be best to create a git_fsync_fd() function
which is non-fatal and has that config/while loop, and have
fsync_or_die() be a "..or die()" wrapper around that, then you could
call that git_fsync_fd() here.

On the change more generally there's some performance numbers quoted at,
so re the recent discussions about fsync() performance I wonder how this
changes things.

I've also noted in those threads recently that our overall use of fsync
is quite, bad, and especially when it comes to assuming that we don't
need to fsync dir entries, which we still don't do here.

The ext4 docs seem to suggest that this will be the right thing to do in
either case, but I wonder if this won't increase the odds of corruption
on some other fs's.

I.e. before we'd write() && rename() without the fsync(), so on systems
that deferred fsync() until some global sync point we might have been
able to rely on those happening atomically (although clearly not on
others, e.g. ext4).

But now we'll fsync() the data explicitly, then do a rename(), but we
don't fsync the dir entry, so per POSIX an external application can't
rely on seeing that rename yet. Will that bite us still, but just in
another way on some other systems?

1. https://stackoverflow.com/questions/7433057/is-rename-without-fsync-safe
