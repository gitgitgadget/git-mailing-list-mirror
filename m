Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E6C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247166109F
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhJNPwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNPwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 11:52:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEAC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:50:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t2so20926354wrb.8
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zjIpMX8t5PC6ikTTlHe9H2qGMUAtxJ1q/ravSh5CnpQ=;
        b=qvAs4eSqsa3bnNovd3ENUYWvBdcrG4NvF092InccDARh4y1BqWA7/+OVOFUYJfzxdH
         Y52ytj0TXnByS8nFFIMBB+2GwSmasYt4yfzu7hbai5cykJJ1nwzG9GlmopbuEpNSUEYm
         dYYxu78A1Abl2TjyFI0qf95qsjFRB4D4pYaybtE5gi422SI5I9Q6niMUR/31OQT3/st8
         8WmIhPl1b0BJmNXCXlJoqEeqKl2V436Q05dBgtL9Z3E5nNovveaoyoXsPdOz2hSsuJZ/
         1gvrN7aRxJyc6nZ6GDtbT+Oh1bPFmyGoETbSJZre0YjRF5y0XXTxWvdG1U3qOwCIBTPk
         a4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zjIpMX8t5PC6ikTTlHe9H2qGMUAtxJ1q/ravSh5CnpQ=;
        b=JTsGaIyeAMGxnsc7szeSM8M9ignmyZbYg9fgIavowI6y7dOWTceuQ0H3g/p+w6HAJ2
         8tCwP00rsYB0HBmcacbg+8gXcY0YsYF/a9neEph/dW4OpoTZp5kdUh9E23R75jsUquDv
         RfTSQ7gSnjyidA9Icb8uYDd1g2mzmzO5odO3IfqLKLGNFdzWwNQtuBGiUuKGeGltwJhn
         ULnn7Cjv43qk4kzH7KqW6B4QFV5knvOoRajtGoyjHlb1CqZKZ4ZR86blC7eG6kBfbc7j
         4RnnetmSrjf7jeLcMMHeqGLKPkI/RDCaP+1ZhvxxAaPzYVj14uX5+W5OganOCngkVzKK
         qRxA==
X-Gm-Message-State: AOAM532MRPVztpPFMlYe4xfqTf2EMgk5XNnNG4PkWPhUW/OAq5+V6SQT
        rcwFfIpoGylTa2Oc/pT8FVUFCjvD3QR30A==
X-Google-Smtp-Source: ABdhPJzKIx/U3+11hga0Fke38K5/CFO/Ub/SQkOk+YU6emTMvcmL4K2FqYU68ujwDn8x8vM+J5lyGQ==
X-Received: by 2002:adf:aa88:: with SMTP id h8mr7760831wrc.112.1634226610921;
        Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r4sm3737485wrz.58.2021.10.14.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org
Subject: Re: Suggestion: "verify/repair" option for 'git gc'
Date:   Thu, 14 Oct 2021 17:17:23 +0200
References: <e288dbe1-b7c7-5a2e-5271-404a14de836a@syntevo.com>
 <87h7dkh04o.fsf@evledraar.gmail.com>
 <96bf2eff-f4c8-cae8-76cb-6eeb233cd1d3@syntevo.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <96bf2eff-f4c8-cae8-76cb-6eeb233cd1d3@syntevo.com>
Message-ID: <87czo7haha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Alexandr Miloslavskiy wrote:

> On 14.10.2021 4:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I'd be interested in a copy of it, I've been slowly trying to improve
>> these sorts of corruption cases.
>
> Sent.

Thanks, I can't promise I'll take a look at it in detail time soon, but
I was going to loop back to checking out these corruption cases at some
point.

>> I wonder if this and other issues you encountered wouldn't need a full
>> "fsck", but merely gc triggering a complete repack.
>
> That sounds slow :( For example, it's going to be a lot of disk write
> bandwidth. Just doing the verification along with regular gc sounds
> faster.

Having looked at your repo the immedite issue is that you've got a tree
in it that has a (manually crafted?) entry that points to a commit
object, without the relevant mode being correct:

    $ git cat-file -p 1d571d7354f99b726bbcc0cb232b3f47846c71a1
    100644 blob 0189425cc210555c36383293c468df5da73acc48    common.mak
    040000 tree 6a2c4a5ef0b0ee7aa85d88c3147b7558a6a7c29f    include

Was this created with git itself, or some tool that's manually crafting
trees? I.e. that the object on-disk has the exact expected content but
is just bad in this particular way points to corruption in git or
another tool writing the data, not e.g. FS corruption or a bit-flip.

Anyway, getting back on track the "gc" command actually does do exactly
what you're suggesting:

    $ git gc; echo $?
    error: object 0189425cc210555c36383293c468df5da73acc48 is a commit, not=
 a blob
    fatal: entry 'common.mak' in tree 1d571d7354f99b726bbcc0cb232b3f47846c7=
1a1 has blob mode, but is not a blob
    fatal: failed to run repack
    128

The problem is that as a user you won't have seen that because we won't
get that far without running into the gc.auto limit, then it would have
run into that, and you'd have had the contents of gc.log spewed at you
by other commands.

So maybe we should be more aggressive there, e.g. as a function of repo
size or whatever (this repo is 18MB).

You really don't need "git fsck" to verify FS corruption or basic object
graph issues like these, and I think it's rather unfortunate that we
expose it like that.

What it does over and beyond a full repack of the repo is to
exhaustively verify object contents, which is most useful e.g. if you're
running a git service and want to prevent users from pushing crafted
corrupt objects, either intentionally or unintentionally.

I've also been meaning to look at that aspect of it for a while, i.e. it
should be able to have some --fast, it has --connectivity-only, but that
one goes a bit too far, although in this case it would have helped you.

>> Yes, we still definitely have cases where dealing with this sort of
>> thing can be very painful.
>
> With the new remote promisor code, I think that auto-fixing corrupted
> blobs is easy enough (provided they can be found on any remote) ?

Hypothetically, but these blobs aren't corrupted, and no amount of
fetching something from other places is going to fix a bad DAG. If that
thing didn't really point at the wrong object type the hash would be
different. The problem is that it was wrong when it was written.

I say "hypothetically" because even in the case of a bitflip or whatever
coercing git into some sort of auto-repair mode is pretty far off. I've
been able to do it manually in some cases, but e.g. promisors not having
a blob *and knowing that* is very different from the more general cases
of object(s) XYZ being corrupt.

We have well-intentioned features like the collision detection that
actively gets in the way of some repairs like that (I had a patch[1] to
disable it, which as a side-effect made recovering from some forms of
corruption easier).

But even without that you'll find that e.g. if a recent object is bad,
and we'd like to fetch it from upstream, that we're just going to die
pretty early, as none of the code involved in say incremental fetching
is prepared to run across a bad/corrupt object.

Those aren't inherent problems, and it would be very nice to have more
such auto-repair in git, just limitations of the current implementation.

1. https://lore.kernel.org/git/20181028225023.26427-5-avarab@gmail.com/=20
