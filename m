Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB61C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8AF2076A
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQXhaZGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgCWNno (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:43:44 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45293 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgCWNnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:43:43 -0400
Received: by mail-lj1-f176.google.com with SMTP id t17so3903697ljc.12
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3pgFjgKxVLQ9e3WkZDdTDzWn67y8vp3OjA4l4l64yrQ=;
        b=pQXhaZGL62f2Utv1KSFoBUic0/u8JW0OwoCLLQN9I5UNjYVwLFQUHeUDi/4s3EKPw5
         kwB4qU/jQCRqcdm/2Xi1WxsNcm+q7IxlvauP+CCI4271Lk/r2e0LGh6MhQiJO4/uCSXU
         2X5xJX9snvdUP4ZMKl4xfuvokX/cuXu3cEqT5LavfFw6rLtsnLqK80IjWtSi5Ac6YaCF
         PcEuuUmZNV5OrKvKtDEuYAXdGzBuNcE6hFDZulAaFN6VRUD//2HL3DE3gRuURV6b/fva
         US1Q6JBRXfbcBnQQiOPqyoi6xiYLQy3Tu7O2XeOjjShu0bcxQURuPZoy83rAD4xIFXlL
         5RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=3pgFjgKxVLQ9e3WkZDdTDzWn67y8vp3OjA4l4l64yrQ=;
        b=H4K4QuqEeBZsU6BKJovm136yWbPAMI7u8zvIw4yt6elK7U/MOr0jlyxxjzrwC3lLRT
         ccGR65X//6+VA/mZv9vjq41vO9UeljHgY14hB41x+u12SiInppnhm60EbxglJTe5SoVk
         dTaGHcB1btSn2ufKaD1Nqjuhs/pvopB4oC4DVV9BJQPei9kkQra4A9WpY+3ymeh6ItQs
         Ygt+OFlLrnZFb77hHirN9ukxKWy3bWATXlh2tx/MZ0om2z0yVf1PtlG6paj55Ox5ciiu
         MVUf94yJL6KkU6ibPYw84VEDAG9Lgf70K0+cqeeLudbAsFQuFv29z5AlSd79J7/FDtu2
         hf1w==
X-Gm-Message-State: ANhLgQ3T3m4qDGEFkCXPGvS5TPHGuwwZMTO+NsS7+z+Hem1M2sYrHbNe
        tWmVMfX3Dr++mjrGGCd3A5s=
X-Google-Smtp-Source: ADFU+vvhLFKvHP+7R4F+U6mNEVUB4yzsIlPSJTYTNDoFn9VNsBYWThCDdV1JQJQUWTBC7M+IkVSJAA==
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr7024422ljj.218.1584971020124;
        Mon, 23 Mar 2020 06:43:40 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 15sm8244507lfr.17.2020.03.23.06.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:43:39 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
In-Reply-To: <xmqq369z7i1b.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 22 Mar 2020 22:32:32 -0700")
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
        <xmqq369z7i1b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
Date:   Mon, 23 Mar 2020 14:43:37 +0100
Message-ID: <86mu87qj92.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
[...]
>>> Unfortunately for the time being we cannot use commit-graph format
>>> version; the idea that was proposed on the mailing list (when we found
>>> about the bug in handling commit-graph versioning, during incremental
>>> commit-graph implementation), was to create and use metadata chunk or
>>> versioning chunk (the final version of incremental format do not use
>>> this mechanism).  This could be used by gen2 compatibile Git to
>>> distinguish between situation where old commit-graph file to be updated
>>> uses generation number v1, and when it uses v2.
>>>=20
>>> If you have a better idea, please say so.
>>
>> We could also use a flag file. Here's how it works:
>>
>> If the file `.git/info/generation-number-v2` exists, use gen2.
>> Otherwise use gen1.
>
> If the file is lost then we will try to read the other file that has
> the commit-graph data as if it were in old format?  And if such a
> file was created (say, with "touch .git/info/generation-number-v2"),
> a file in the original format will be read as if it is in new
> format?  If that is the case, it is likely that we'd see a segfault;
> sounds too brittle to me.
>
> It appears that the format of "CDAT", and the fact that generation
> is represented as higher 30-bit of a be32 integer, is very much
> hardcoded in the design and is hard to change, but your new version
> of graph file can be designed not to use "CDAT" chunk at all, and
> instead have the commit data with new version of generation numbers
> stored in a different chunk (say "CDA2") to force older version of
> Git not to use the new graph file---would that work?

It looks like there are a few possible ways of handling introduction of
generation numbers v2.  Let's consider them one by one.

The problem we need to solve is co-existence of old Git (that does not
understand v2, and that hard fails on commit-graph format version bump),
and new Git (that understands and writes v2, and that I assume soft
fails that is it simply doesn't use commit-graph if it of unknown
version).


If the commit-graph file was written by new Git, and includes generation
numbers v2, we want old Git to at least do not crash, possibly do not
use commit-graph, best if it can use commit-graph in suboptimal way.  We
also need to handle old Git trying to update (in incremental or
non-incremental way) the commit-graph file.

If the commit-graph file was written by old Git, and includes generation
nmbers v1 (topological levels), we want new Git to recognize this and at
best use those old generation numbers in a correct way.  We want new Git
to be able to update commit-graph file (in incremental or
non-incremental way).

Did I miss anything?


Proposed solutions are:
 - metadata / versioning chunk,
 - flag file: `.git/info/generation-number-v2`,
 - new chunk for commit data: "CDA2".

I would like to propose yet another solution: putting generation number
v2 data in a separate chunk (and possibly keeping generation number v1
in CDAT commit data chunk).  In this case we could even use ordinary
corrected commit date as generation number v2 (storing offsets as 32-bit
unsigned values), instead of backward-compatibile corrected commit date
with monotonic offsets.

Each solution has its advantages and disadvantages.


With the flag file, the problem is (as Junio noticed) that if file gets
accidentally deleted, new Git would think incorrectly that commit-graph
uses generation number v1... which while suboptimal should not be bad
thanks to backward compatibility.  But I think the flag file should have
some kind of checksum as its contents (perhaps simply a copy of
commit-graph file checksum, or one checksum per file in chain with
incremental commit-graph), so that it old Git rewrites commit-graph file
leaving flag file present, new Git would notice this.

Metadata or versioning chunk cannot be deleted by mistake; if old Git
copies unknown chunks to new updated commit-graph file instead of
skipping them we would need to add some kind of checksum (similarly to
the case for flag file).  The problem to be solved is what to do if some
files in the chain of commit-graph files have v2 (and this chunk), and
some have v1 generation number (and do not have this chunk).

About moving commit data with generation number v2 to "CDA2" chunk: if
"CDAT" chunk is missing then (I think) old Git would simply not use
commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
chunk has zero length... I don't know what would happen then, possibly
also old Git would simply not use commit-graph data at all.

Putting generation number v2 into separate chunk (which might be called
"GEN2" or "OFFS"/"DOFF") has the disadvantage of increasing the on disk
size of the commit graph, and possibly also increasing memory
consumption (the latter depends on how it would be handled), but has the
advantage of being fullly backward compatibile.  Old Git would simply
use generation numbers v1 in "CDAT", new Git would use generation
numbers v2 in "OFFS" -- combining commit creation date from "CDAT" and
offset from "OFFS"), and there should be no problems with updating
commit-graph file (either rewriting, or adding new commit-graph to the
chain).

I think that's all.

Best,
--=20
Jakub Nar=C4=99bski
