Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82768C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6D208CA
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdjMtt3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCXJY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:24:58 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36540 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCXJY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 05:24:58 -0400
Received: by mail-lj1-f182.google.com with SMTP id g12so17789786ljj.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pnGdav7+8ZhwGOtnWx2nU5uiqZgQEg04XnKeWtJ746A=;
        b=pdjMtt3vuQ0vCjiklankGoEbM4REdtGsYeQzn4WOOOrjD8sa2twmU1a364wcBsXVlB
         ePMbuNQYzcBwQeCSmP5puq4ycnE05V8uJJVSc8EeoxLO0ZdDiCWL4GRvASzvKFlnxlXQ
         HZPeoJV26VfrYiFCSHUJQ4xLD6P3Oy59llpPDVMzy4O7TxUyED4Y8kuQ66J8MufAAXSV
         EdS9c1IMBOAzmmVhNqfKXZ/9HORc6uAKxZ71ggqWjsljrSfOh7f9cM/eGhYzBjvaOxcl
         doCUHXKE6+ojxlNvN9pKLrp/Gi7lJyrC53kSvUdABpmuXtDBUyjEqvOfm9YfQEJqdXn+
         zCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=pnGdav7+8ZhwGOtnWx2nU5uiqZgQEg04XnKeWtJ746A=;
        b=IeaLmpXvc1nnK+rlcZD9VRrmiwATiW0xIfNvzKPxqS9oSUqDcr9kq+yDYjHBVcGQhK
         mUPgGxWlLKx8Kkxs+eGwVqzkH0zsZWHbitkVczgO/Bthl/b4GHWZyXY7pyQ2ZaC6NeIo
         Knay1cXcgiBi24SFCFS43JOOh/7O8HdCxfz2FhDIcHk+EkWVyVOtHpx/YevGwTfuDfOz
         D31woz5MQc4sWp4SLQjfj+d+Cs/kxZPphIeu6+g3BKTQnxDl1S2vAYBD9ENePLiMihU9
         Qb6NIkQy2AbZ+E4mKml4MpTnbZPNqrq6HR6EkhK4lumvcOmNN1nAEC3tMKOEleMCql71
         ktRw==
X-Gm-Message-State: ANhLgQ0GOJTOQOkKfO+ciPqqeZ3MqcOMXxusY27ZeBG/YfVpHL651oYK
        gQeLGYmxyundsdMl9AfD0X0=
X-Google-Smtp-Source: ADFU+vtJAtHz/GL1wZWb/uBuaRohcZQA2fT2JkQZsJAKdJpUcZTWuL/J8m0JZurYtRtD4subsmkJEQ==
X-Received: by 2002:a2e:8652:: with SMTP id i18mr1584921ljj.265.1585041895126;
        Tue, 24 Mar 2020 02:24:55 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id b28sm6324773ljp.90.2020.03.24.02.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 02:24:54 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
        <xmqq369z7i1b.fsf@gitster.c.googlers.com> <86mu87qj92.fsf@gmail.com>
        <13995fbd-d645-56aa-b647-e9a51d00554e@gmail.com>
Date:   Tue, 24 Mar 2020 10:24:52 +0100
In-Reply-To: <13995fbd-d645-56aa-b647-e9a51d00554e@gmail.com> (Derrick
        Stolee's message of "Mon, 23 Mar 2020 11:54:07 -0400")
Message-ID: <86eetiqf4r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 3/23/2020 9:43 AM, Jakub Narebski wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>> [...]
>> Proposed solutions are:
>>  - metadata / versioning chunk,
>>  - flag file: `.git/info/generation-number-v2`,
>>  - new chunk for commit data: "CDA2".
>>=20
>> I would like to propose yet another solution: putting generation number
>> v2 data in a separate chunk (and possibly keeping generation number v1
>> in CDAT commit data chunk).  In this case we could even use ordinary
>> corrected commit date as generation number v2 (storing offsets as 32-bit
>> unsigned values), instead of backward-compatibile corrected commit date
>> with monotonic offsets.
>
> I agree that if we are creating a new (optional) chunk, then that gets
> around our versioning issues and could store just the offsets to get
> the "corrected commit date" option instead of the backwards-compatible on=
e.
> By including yet another version number at the beginning of that chunk,
> we could present a way to update this "second reachability index chunk"
> with things like your interval mechanism with very little cost.

All this may be just a transitory phase, waiting until Git versions that
fail hard on commit-graph format version change die out... then we will
be able to use version number as intended (though it has the
disadvantage of turning off commit-graph wholly for older Git versions).

>> Each solution has its advantages and disadvantages.
>>=20
>>=20
>> With the flag file, the problem is (as Junio noticed) that if file gets
>> accidentally deleted, new Git would think incorrectly that commit-graph
>> uses generation number v1... which while suboptimal should not be bad
>> thanks to backward compatibility.  But I think the flag file should have
>> some kind of checksum as its contents (perhaps simply a copy of
>> commit-graph file checksum, or one checksum per file in chain with
>> incremental commit-graph), so that it old Git rewrites commit-graph file
>> leaving flag file present, new Git would notice this.
>
> I'm not a fan of the flag file idea. Optional chunks are a good way forwa=
rd.
> That _could_ mean the metadata chunk, whose length can grow in the future
> if/when we add more fixed-width metadata values.

So it looks like metadata / versioning chunk would be the best solution,
isn't it?

>> Metadata or versioning chunk cannot be deleted by mistake; if old Git
>> copies unknown chunks to new updated commit-graph file instead of
>> skipping them we would need to add some kind of checksum (similarly to
>> the case for flag file).  The problem to be solved is what to do if some
>> files in the chain of commit-graph files have v2 (and this chunk),
>> and> some have v1 generation number (and do not have this chunk).
>
> The incremental commit-graph format is newer than our previous tests
> for generation number v2, which will be a big reason why that old code
> cannot be immediately adapted here.
>
> The simplest thing to do is usually right: if we try to write a
> generation number version that doesn't match the current commit-graph,
> then we need to flatten the entire chain into one layer and recompute
> the values from scratch. While it is _technically_ possible to mix
> the backwards-compatible corrected commit date with generation number
> v1, it requires taking the "lowest version" when doing comparisons and
> that may behave very strangely. Better to avoid that complication.

Right.

>> About moving commit data with generation number v2 to "CDA2" chunk: if
>> "CDAT" chunk is missing then (I think) old Git would simply not use
>> commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
>> chunk has zero length... I don't know what would happen then, possibly
>> also old Git would simply not use commit-graph data at all.
>
> CDAT is required as it contains more than just generation numbers. It
> has the commit date, parent int-ids, and root tree oid. The generation
> numbers _could_ be left as all zeroes, which is a special case for the
> format before generation numbers were introduced, but it would be better
> to have values there.

I think (but I might be wrong) that the most expensive part of
calculating generation numbers is actually walking the commits.  Because
both generation number v1 (topological level) and generation number v2
(corrected committerdate, with or without monotonic restriction on
offsets) can be computed at the same time, during the same walk,
possibly with negligible cost compared to computing single geneation
number.

But this should be perhaps benchmarked.

>> Putting generation number v2 into separate chunk (which might be called
>> "GEN2" or "OFFS"/"DOFF") has the disadvantage of increasing the on disk
>> size of the commit graph, and possibly also increasing memory
>> consumption (the latter depends on how it would be handled), but has the
>> advantage of being fullly backward compatibile.  Old Git would simply
>> use generation numbers v1 in "CDAT", new Git would use generation
>> numbers v2 in "OFFS" -- combining commit creation date from "CDAT" and
>> offset from "OFFS"), and there should be no problems with updating
>> commit-graph file (either rewriting, or adding new commit-graph to the
>> chain).
>
> I share these concerns but also the locality of the data within the file.
> As we parse commits, we need the parent and commit date information out
> of the CDAT chunk anyway, so it is not difficult to grab the nearby
> generation number. If we put that data further away in a separate chunk,
> then it can be more expensive to flip between the CDAT chunk and the
> GEN2 chunk.

Right, I forgot about this issue, that Git is lazily parsing
commit-graph data, so keeping all [possible] commit data close is a good
idea from the performance point of view.

So it looks like metadata / versioning chunk would be the best solution
to the backward-compatibility interoperability problem.

> In terms of your prototyping for performance checks, it may be good to
> have a number of "GEN<X>" chunks so you can compute one commit-graph
> that stores all of the candidate reachability indexes, then use one
> of the chunks based on a config value or environment variable. I think
> that would only be appropriate for testing if you are evaluating which
> to build, so if you are focusing entirely on backwards-compatible
> corrected commit date, this is not worth spending time on.

Right, but it looks like there is nobody taking new labelings for GSoC
2020.

Good idea for prototyping, true.

Best,
--=20
Jakub Nar=C4=99bski
