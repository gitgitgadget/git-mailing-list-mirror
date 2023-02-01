Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3EBC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjBANUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBANUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 08:20:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDAA4ED1
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 05:20:38 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lu11so14024464ejb.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 05:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTisRFjP5eUD66+VvQ14LTLgQh61bU5CHLBZR/Rq/HQ=;
        b=f70ZvIn3I49faITjDe3M/3kNMJBBLkcp7dAicPOMBWCG7lFZTKQ2dTS7JucHNCDF+e
         s6vCNRocLZHy9rd4qkIJ6L2tqgK58sHLU0N2ASpX81x8WV2JD+BDxa/C61BLCWNklrxn
         kr8mHoqqWfQ6qTJ5gtLwHVO5z/FjpPbCHY1bRs5KVQTVC9nKAHtf+nVKGugsnXKHrzRT
         vw2lqxPm0cEusStJeKtW8rYqmShBPQnW7IrYGJnaOKOQt0EOv89iSG4N1DATlPHwUdvz
         ZJjZtXgUcDKfn7PuEeCbI9IlMQ/q4TUWTmrHYqPKK0nVxtRFigTHcPlwnjcko0XZ9r1e
         wbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTisRFjP5eUD66+VvQ14LTLgQh61bU5CHLBZR/Rq/HQ=;
        b=Tunx9hGCA4nMSpgthjY/UaQV51QJsCshzMTxPWQc/cY9OkCvLZhvuVdE4I/KEROQTt
         7ctzomPGptIjs4cHUI2pXQS9Qes/FobRGcpIKLXHIHhs2Kn/PQXbFQoy/U5VCu167mRU
         eOW0ZGRGkDXJZ396+UcwD7sFARH52OYAaqthBq41cDnpQLrAOyAfTOqhInYelj+G+qX1
         fzWLl0RHPopanM63okj1Z13KUtgZmVLX4P6e2j0ROLkFf/itGZ6YLJ1egmV5vo5vgvBh
         NfOM15Z1ZHWKx9ZwyyBMUj6MmI+EzTwRkRAtCGXh/ysLdl7vSEsQTXdDHyBvZOFSoDyl
         Kx3Q==
X-Gm-Message-State: AO0yUKX9+6MYg8eQmqXWUDg/GfGRIFBHQbqCLQRYDLcDkVqsxMVG4Kq+
        4XcFitky8XukGgiKNUXg4co5pWwOnsaM4w==
X-Google-Smtp-Source: AK7set/4psIOJh8Q2CGcLwMIVWj+0AiWM0ib/z6ceAUxwAA+kbPFRiTiFRJHSSOZUbsHzFPzIGLy/g==
X-Received: by 2002:a17:906:5048:b0:878:4bc1:dd19 with SMTP id e8-20020a170906504800b008784bc1dd19mr2321632ejk.52.1675257636375;
        Wed, 01 Feb 2023 05:20:36 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id w20-20020a170906d21400b008897858bb06sm4281634ejz.119.2023.02.01.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:20:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pND2R-002F2O-0W;
        Wed, 01 Feb 2023 14:20:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 6/6] hash-object: use fsck for object checks
Date:   Wed, 01 Feb 2023 14:08:39 +0100
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haHL9xIWntSm0/@coredump.intra.peff.net>
 <Y9pgG10dAoQABGXG@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9pgG10dAoQABGXG@coredump.intra.peff.net>
Message-ID: <230201.86h6w5r07w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, Jeff King wrote:

> On Wed, Jan 18, 2023 at 03:44:12PM -0500, Jeff King wrote:
>
>> @@ -2350,12 +2340,13 @@ static int index_mem(struct index_state *istate,
>>  		}
>>  	}
>>  	if (flags & HASH_FORMAT_CHECK) {
>> -		if (type == OBJ_TREE)
>> -			check_tree(buf, size);
>> -		if (type == OBJ_COMMIT)
>> -			check_commit(buf, size);
>> -		if (type == OBJ_TAG)
>> -			check_tag(buf, size);
>> +		struct fsck_options opts = FSCK_OPTIONS_DEFAULT;
>> +
>> +		opts.strict = 1;
>> +		opts.error_func = hash_format_check_report;
>> +		if (fsck_buffer(null_oid(), type, buf, size, &opts))
>> +			die(_("refusing to create malformed object"));
>> +		fsck_finish(&opts);
>>  	}
>
> By the way, I wanted to call out one thing here that nobody mentioned
> during review: we are not checking the return value of fsck_finish().
>
> That is a bit of a weird function. We must call it because it cleans up
> any resources allocated during the fsck_buffer() call. But it also is
> the last chance to fsck any special blobs (like those that are found as
> .gitmodules, etc). We only find out the filenames while looking at the
> enclosing trees, so we queue them and then check the blobs later.
>
> So if we are hashing a blob, that is mostly fine. We will not have the
> blob's name queued as anything special, and so the fsck is a noop.
>
> But if we fsck a tree, and it has a .gitmodules entry pointing to blob
> X, then we would also pull X from the odb and fsck it during this
> "finish" phase.
>
> Which leads me to two diverging lines of thought:
>
>   1. One of my goals with this series is that one could add objects to
>      the repository via "git hash-object -w" and feel confident that no
>      fsck rules were violated, because fsck implements some security
>      checks. In the past when GitHub rolled out security checks this was
>      a major pain, because objects enter repositories not just from
>      pushes, but also from web-client activity (e.g., editing a blob on
>      the website). And since Git had no way to say "fsck just this
>      object", we ended up implementing the fsck checks multiple times,
>      in libgit2 and in some of its calling code.
>
>      So I was hoping that just passing the objects to "hash-object"
>      would be a viable solution. I'm not sure if it is or not. If you
>      just hash a blob, then we'll have no clue it's a .gitmodules file.
>      OTOH, you have to get the matching tree which binds the blob to the
>      .gitmodules path somehow. So if that tree is fsck'd, and then
>      checks the blob during fsck_finish(), that should be enough.
>      Assuming that fsck complains when the pointed-to blob cannot be
>      accessed, which I think it should (because really, incremental
>      pushes face the same problem).
>
>      In which case we really ought to be checking the result of
>      fsck_finish() here and complaining.
>
>   2. We're not checking fsck connectivity here, and that's intentional.
>      So you can "hash-object" a tree that points to blobs that we don't
>      actually have. But if you hash a tree that points a .gitmodules
>      entry at a blob that doesn't exist, then that will fail the fsck
>      (during the finish step). And respecting the fsck_finish() exit
>      code would break that.
>
>      As an addendum, in a regular fsck, many trees might mention the
>      same blob as .gitmodules, and we'll queue that blob to be checked
>      once. But here, we are potentially running a bunch of individual
>      fscks, one per object we hash. So if you had, say, 1000 trees that
>      all mentioned the same blob (because other entries were changing),
>      and you tried to hash them all with "hash-object --stdin-paths" or
>      similar, then we'd fsck that blob 1000 times.
>
>      Which isn't wrong, per se, but seems inefficient. Solving it would
>      require keeping track of what has been checked between calls to
>      index_mem(). Which is kind of awkward, seeing as how low-level it
>      is. It would be a lot more natural if all this checking happened in
>      hash-object itself.
>
> So I dunno. The code above is doing (2), albeit with the inefficiency of
> checking blobs that we might not care about. I kind of think (1) is the
> right thing, though, and anybody who really wants to make trees that
> point to bogus .gitmodules can use --literally.

Aside from the other things you bring up here, it seems wrong to me to
conflate --literally with some sort of "no fsck" or "don't fsck this
collection yet" mode.

Can't we have a "--no-fsck" or similar, which won't do any sort of full
fsck, but also won't accept bogus object types & the like?

Currently I believe (and I haven't had time to carefully review what you
have here) we only need --literally to produce objects that are truly
corrupt when viewed in isolation. E.g. a tag that refers to a bogus
object type etc.

But we have long supported a narrow view of what the fsck checks mean in
that context. E.g. now with "mktag" we'll use the fsck machinery, but
only skin-deep, so you can be referring to a tree which would in turn
fail our checks.

I tend to think that we should be keeping it like that, but documenting
that if you're creating such objects you either need to do it really
carefully, or follow it up with an operation that's guaranteed to fsck
the sum of the objects you've added recursively.

So, rather than teach e.g. "hash-object" to be smart about that we
should e.g. encourage a manual creation of trees/blobs/commits to be
followed-up with a "git push" to a new ref that refers to them, even if
that "git push" is to the repository located in the $PWD.

By doing that we offload the "what's new?" question to the
pack-over-the-wire machinery, which is well tested.

Anything else seems ultimately to be madness, after all if I feed a
newly crafted commit to "hash-object" how do we know where to stop,
other than essentially faking up a push negotiation with ourselves?

It's also worth noting that much of the complexity around .gitmodules in
particular is to support packfile-uri's odd notion of applying the
"last" part of the PACK before the "first" part, which nothing else
does.

Which, if we just blindly applied both, and then fsck'd the resulting
combination we'd get rid of that tricky special-case. But I haven't
benchmarked that. It should be a bit slower, particularly on a large
repository that won't fit in memory. But my hunch is that it won't be
too bad, and the resulting simplification may be worth it (particularly
now that we have bundle-uri, which doesn't share that edge-case).

