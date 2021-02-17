Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50528C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069D664E6B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBQCLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 21:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBQCK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 21:10:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECAC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 18:10:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id do6so9312228ejc.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 18:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rVJfAuxvEOHFqpFc4lY/ZfZOk+TyairDi/2QVSi6NRI=;
        b=O15kKeNd57T9FWAmMALYbrfN1KV80AXbBHGXb37/iTUS/mAUAR6LrccV0dZrINRYDK
         Dmqz4LnK6Sfs1wrkHnXdJpR7VgznRYJO7aiP8ZM92pp+3KjdFBe6ES4bu5XeS4HZslpQ
         X2clkHk6ttknG1mAeSmPx+6bL9IAP4Z1zL79yVX3fOmO9KOS/Cf5YgsNuk4ncc0HX/d7
         aL2ttbL+EiR6ENPMPSixFtCEFCLvYwFM/G3uZ3vglBMnAhDzt1ODiXJYtVkWBYIjAhk4
         OyPtZPxmkTWU28eX+glz5+DHiUvlXiT2R+5mtP/EAaSDVTExN6VHcMfsCKehq0ag2LQP
         A6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rVJfAuxvEOHFqpFc4lY/ZfZOk+TyairDi/2QVSi6NRI=;
        b=phGXqn7h/nHL4dA6jtyEjibMhFQjEdgc6Ro15a40D3IhUaD++aSdYUT3d4y45bNBp1
         yQFM2v9MG0FKGiouD2/mCU9buNztBjwdxH/+Cw/HRLgvXS8AMayqGdAybvQzjcd1pHBP
         wyVUrixaoEQp8M7ZDE/c8aMYTCLwDaVl6A0USd+jGyWpm8pNUVfac/DMRv0s1FUSeM65
         DhWSdu/s2FOsD7BoRgsK3ClfP+xFhL6Tk/aZocSozxmT6a82hAXWHD2jBmYxcFT8DVLG
         vvRblaLaCoKHbIK9XoXjVR7Sh0Ux1jUShbq/YyBZu0rxVlYVJWKKpq4U1QbIrTQxW5YR
         wwqQ==
X-Gm-Message-State: AOAM532cfsu0nMYjLC0+BeQObLTZchg76msTQrRAlyvh2zCFrusbt5k4
        2YK0S8boPjRcS3zDFtOBIegS4MfrqIO0tg==
X-Google-Smtp-Source: ABdhPJwbuCBBAoW9T6iKg6XBG+mNqRLPEQJrkWYlR1rDhCEC72J9aamMQlGt+UuWj3BsYHEpkFj1pg==
X-Received: by 2002:a17:906:dbd0:: with SMTP id yc16mr23573357ejb.524.1613527814688;
        Tue, 16 Feb 2021 18:10:14 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id fu7sm325099ejc.11.2021.02.16.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 18:10:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <87czxu7c15.fsf@evledraar.gmail.com>
 <20210128011525.3886106-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210128011525.3886106-1-jonathantanmy@google.com>
Date:   Wed, 17 Feb 2021 03:10:13 +0100
Message-ID: <878s7na1h6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 28 2021, Jonathan Tan wrote:

>> On Sun, Jan 24 2021, Jonathan Tan wrote:
>> >  --fsck-objects::
>> > -	Die if the pack contains broken objects. For internal use only.
>> > +	For internal use only.
>> > ++
>> > +Die if the pack contains broken objects. If the pack contains a tree
>> > +pointing to a .gitmodules blob that does not exist, prints the hash of
>> > +that blob (for the caller to check) after the hash that goes into the
>> > +name of the pack/idx file (see "Notes").
>> 
>> [I should have waited a bit and sent one E-Mail]
>> 
>> Is this really generally usable as an IPC mechanism, what if we need
>> another set of OIDs we care about? Shouldn't it at least be hidden
>> behind some option so you don't get a deluge of output from index-pack
>> if you're not in this packfile-uri mode?
>
> --fsck-objects is only for internal use, and it's only used by
> fetch-pack.c. So its only consumer does want the output.
>
> Junio also mentioned the possibility of another set of OIDs, and I
> replied [1].
>
> [1] https://lore.kernel.org/git/20210128003536.3874866-1-jonathantanmy@google.com/
>
>> But, along with my other E-Mail...
>> 
>> > [...]
>> > +static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
>> > +{
>> > +	int len = the_hash_algo->hexsz + 1; /* hash + NL */
>> > +
>> > +	do {
>> > +		char hex_hash[GIT_MAX_HEXSZ + 1];
>> > +		int read_len = read_in_full(fd, hex_hash, len);
>> > +		struct object_id oid;
>> > +		const char *end;
>> > +
>> > +		if (!read_len)
>> > +			return;
>> > +		if (read_len != len)
>> > +			die("invalid length read %d", read_len);
>> > +		if (parse_oid_hex(hex_hash, &oid, &end) || *end != '\n')
>> > +			die("invalid hash");
>> > +		oidset_insert(gitmodules_oids, &oid);
>> > +	} while (1);
>> > +}
>> > +
>> 
>> Doesn't this IPC mechanism already exist in the form of fsck.skipList?
>> See my 1f3299fda9 (fsck: make fsck_config() re-usable, 2021-01-05) on
>> "next". I.e. as noted in my just-sent-E-Mail you could probably just
>> re-use skiplist as-is.
>
> I'm not sure how fsck.skipList could be used here. Before running
> fsck_finish() for the first time, we don't know which .gitmodules are
> missing and which are not. And when running fsck_finish() for the second
> time, we definitely do not want to skip any blobs.
>
>> Or if not it seems to me that this whole IPC mechanism would be better
>> done with a tempfile and passing it along like we already pass the
>> fsck.skipList between these processes.
>> 
>> I doubt it's going to be large enough to matter, we could just put it in
>> .git/ somewhere, like we put gc.log etc (but created with a mktemp()
>> name...).
>> 
>> Or if we want to keep the "print <list> | process" model we can refactor
>> the existing fsck IPC noted in 1f3299fda9 a bit, so e.g. you pass some
>> version of "lines prefixed with "fsck-skiplist: " go into list xyz via a
>> command-line option. And then existing option(s) and your potential new
>> list (which as noted, I think is probably redundant to the skiplist) can
>> use it.
>
> I think using stdout is superior to using a tempfile - we don't have to
> worry about interrupted invocations, for example.
>
> What do you mean by "the existing fsck IPC noted in 1f3299fda9"? If you
> mean the ability to pass a list of OIDs, for example using "-c
> fsck.skipList=filename.txt", I'm not sure that it solves anything.
> Firstly, I don't think that the skipList is useful here (as I said
> earlier). And secondly, I don't think that OID input is the issue -
> right now, the design is a process (index-pack, calling fsck_finish())
> writing to its output which is then picked up by the calling process
> (fetch-pack). We are not sending the dangling .gitmodules through stdin
> anywhere.

Sorry for being unclear here. I don't think (honestly I don't remember,
it's been almost a month) that I meant to you should use the skipList.

Looking at that code again we use object_on_skiplist() to do an early
punt in report(), but also fsck_blob(), presumably you never want the
latter, and that early punting wouldn't be needed if your report()
function intercepted the modules blob id for stashing it away / later
reporting / whatever.

So yeah, I'm 99% sure now that's not what I meant :)

What I meant with:

    Or if we want to keep the "print <list> | process"[...]

Is that we have an existing ad-hoc IPC model for these commands in
passing along the skipList, which is made more complex because sometimes
the initial process reads the file, sometimes it passes it along as-is
to the child.

And then there's this patch that passes OIDs too, but through a
different mechanism.

I was suggesting that perhaps it made more sense to refactor both so
they could use the same mechanism, because we're potentially passing two
lists of OIDs between the two. Just one goes via line-at-a-time in the
output, the other via a config option on the command-line.
