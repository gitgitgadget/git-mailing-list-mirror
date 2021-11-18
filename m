Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED85C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847CA61B31
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhKRAz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhKRAz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:55:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CBC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:52:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b11so3695136pld.12
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2m8jmAhDOZ6GSzvFWj05JA8giTZKaPOdsy25sRR2Kk=;
        b=RNYVIq2LHWWTkRAZIhpkCnNPoTbaWe9huZQcOBblaJAqdSpn2NkU/DASo9oOn2P/p3
         cfywyI7t4xa0XP/peKPZktca6GmDuSgUpdDdofbRR+vja0ASJ3Qiad/Z8xMZouPbyE8r
         t84j32m5J2+8no3wGhAjP+zobIvqmxmyz3UDZVk2+ZP+7S9S+i3RULSpnIs6AjpGB4hH
         yz/WgCu7akIG3nHh+xif/Ge4mfxwZwPuMGJcDqYm59nBrh5nVjE+b2nsjTsS8YBiBkI+
         NQKsZ8FAAwA9sbx7BVZDowb2PVXNfNUJqvl1PTOg/3Yybg2ezkGTTDLrR6MgOh1mZBpv
         xcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2m8jmAhDOZ6GSzvFWj05JA8giTZKaPOdsy25sRR2Kk=;
        b=UqlWfuiDKZW1HJH69E6RzLgti/WkDE+mUvT+/r2K0ZDNbRaYiPCvRJn+RTiC6WLZr0
         mquLHAaPwZYuIWoQyGrBzNqxJtpAlXQfcG2Gasrf3u4kuEoZTt56eW5UpIm8ODYows0N
         HOngWYDWoH5Zgy5vef/8OaWjemGUj+9aB8oBoLjH9sWoXVoOEXQ3kRzx60Hhq6HWS9pM
         uNBRD3908GUgXJG0hupSoBosNAHBJWvb7DToJjCBZbr/A9WEihN8N1F5wPWaqZbkcj4y
         0h2I+aE5RoNu+dbuZD8ptGE4nY9U++u8zH9tXhJ1v4vgafNFp04TXT5hd5hQ6tikt/fL
         sRhA==
X-Gm-Message-State: AOAM530GuiEFnGV80HBG3Eduf8ukxH35G3HYSCZFJJK42ozsHGm61I5q
        WMjx9sSUm3enYeKF9vxITASZfwe1OPgfkOVtX85oFsAtEbs=
X-Google-Smtp-Source: ABdhPJz6waN7MJ+1AYUY/FdTecA0UfUInMTbcgABBlU87SyLtPjw9xeiVEpaN4FeBzC0hR+LCI7g50vAgnZwTzwJBXE=
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr4896223pjc.159.1637196777641;
 Wed, 17 Nov 2021 16:52:57 -0800 (PST)
MIME-Version: 1.0
References: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
In-Reply-To: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 17 Nov 2021 16:52:46 -0800
Message-ID: <CAGyf7-FoRyVtQHa2ETQtRA6fD7x0GDhKVPg+eAajhgPNrsw_OQ@mail.gmail.com>
Subject: Re: Bug report: Strange behavior with `git gc` and
 `reference-transaction` hook
To:     Waleed Khan <me@waleedkhan.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 4:42 PM Waleed Khan <me@waleedkhan.name> wrote:
>
> Hi all,
>
> I'm seeing unusual behavior on Git built from source at
> cd3e606211bb1cf8bc57f7d76bab98cc17a150bc, but which appears to extend
> back to Git v2.29.
>
> This is a repro script:
>
> ```
> #!/bin/sh
>
> temp_dir=$(mktemp -d)
> echo "git dir is: $temp_dir"
> mkdir -p "$temp_dir"
> trap "rm -rf $temp_dir" EXIT
>
> cd "$temp_dir" || exit 1
> git init -q
> date='Thu, 07 Apr 2005 22:13:13 +0200'
> GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -q
> --allow-empty -m 'Initial commit'
>
> mkdir -p '.git/hooks'
> cat >.git/hooks/reference-transaction <<'EOT'
> #!/bin/sh
>
> [[ "$1" != 'committed' ]] && exit 0
> echo 'New reference-transaction invocation'
>
> while read old new ref; do
>   echo "  old: $old, new: $new, ref: $ref"
> done
> EOT
> chmod +x .git/hooks/reference-transaction
>
> git gc --prune=now -q
> git show-ref refs/heads/master
> ```
>
> And this is the output it produces:
>
> ```
> git dir is: /var/folders/gn/gdp9z_g968b9nx7c9lvgy8y00000gp/T/tmp.b3Jc6qnb
> New reference-transaction invocation
>   old: 0000000000000000000000000000000000000000, new:
> e197d18c017d4038418be8b1cd38f4503e289165, ref: refs/heads/master
> New reference-transaction invocation
>   old: e197d18c017d4038418be8b1cd38f4503e289165, new:
> 0000000000000000000000000000000000000000, ref: refs/heads/master
> e197d18c017d4038418be8b1cd38f4503e289165 refs/heads/master
> ```
>
> These hooks are invoked a few milliseconds one after another.

There are two built-in "ref backends" that Git uses out of the box: A
packed backend, which manages the "packed-refs" file, and a loose
backend, which manages other files under "$GIT_DIR/refs". What you're
seeing is a reference transaction for the packed backend which is
adding the new value for "refs/heads/master" to "packed-refs" (packed
backend reference-transactions rarely, if ever, include an actual old
hash, as far as I can tell), and then a second reference transaction
for the loose backend to delete the loose "refs/heads/master" file,
now that it's packed.

>
> The expected behavior would be that the latest reference transaction
> hook refers to the state of the references on disk. That is, either
> `master` should point to 0 (be deleted), or it should have said that
> `master` pointed to `e197d1`.
>
> But if we actually examine `master`, it's set to `e197d1`, just as you
> would expect. The GC should have been a no-op overall.

One of the subtasks of "git gc" is "git pack-refs". If you inspect in
more detail, I suspect you'll find that "refs/heads/master" was loose
before "git gc" ran (as in, there was a file
"$GIT_DIR/refs/heads/master") and "packed-refs" either didn't have a
"refs/heads/master" entry or had a different hash. (Loose refs always
"win" over packed, since ref updates only write loose refs.)

Hope this helps,
Bryan Turner

>
> Best,
> Waleed
