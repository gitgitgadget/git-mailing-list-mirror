Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBEEC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7233E6120A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 16:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbhHYQcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhHYQcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 12:32:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8119C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 09:31:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a25so26091160ejv.6
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1hHEJeZvm+myc2+oEFjXv9qF+KvABbtQWlyIOXA88es=;
        b=MjGsFvyHADK0V4mo5sKETD2xLoSew7ZZO+5JUYMh401+6Azl77eWoJv4NDndf3o4Sv
         H17PXZAl77Dsv2x3Lxfng8n1Aqr+7MPrd73zl5cVaMpbnMDW3JY+Uff1CWbAN/73TRKp
         eazbt7Rcw5oAm6GYu9I0maCyedBHQXAGvLS2SyVLVJ9AlM1ROuStlC/yYeAWSyaO5caC
         n3E4hT2H4ifSChz/98AqHJ2ZEDHddOQfXTw2lRS19lE60Qlwu4tXqZOophx13LMtOiiD
         ges082mVIF2K//91jR6cBOufUlLusGrhrfgrpucJvXG6Sorr45K2YEKXESGfFdFn6TaE
         nGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1hHEJeZvm+myc2+oEFjXv9qF+KvABbtQWlyIOXA88es=;
        b=OGMnDQ5kNUrUQz8l3bM+oY50kCOXyt2QecX4BnC7BeVIsaYKddOjDbWzuhlpGsln1R
         2JHhW2YHG1Z5BgGEUkFeNhmdWoKqVgnolNK19vhOgp0anRDOU/97IIs3RTV5geNHvjB3
         GD2GwjuBAPk9pqfEB2+9wtcEBVDe2WAUiLNFlsPIkfptGrWhcnc3fE+DOHBGZVgmfvP8
         BrBWv/KQ5dCrRHZZdOjbe1c4QDKNvqyyaX136HkPAaHAWOUuTGIfxMoTcAR1IFG8C8nY
         hFdOpdA2RoSvB7YimInaoBfypmAK5EDE6Zo2XPF008dK9bn/LRtSMsf6o/uQ8DD2xZ2P
         E2jQ==
X-Gm-Message-State: AOAM532fKKP+uZLvoXu2zcM6DOaRrYlsBeSoZ1+5mNd1Pib7plkR6vmD
        fd04lS/f93kWyYKZxKR35VOtZ38l2vo=
X-Google-Smtp-Source: ABdhPJy/bX6eGiRsOVY5rtLwW+lzGZjuNqNFcflgE6gG0h+29pLfX2xCuFNMRjAR4xN9yGg/ixrang==
X-Received: by 2002:a17:906:374e:: with SMTP id e14mr25664204ejc.161.1629909093757;
        Wed, 25 Aug 2021 09:31:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q21sm81017ejs.43.2021.08.25.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:31:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
Date:   Wed, 25 Aug 2021 18:11:13 +0200
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
Message-ID: <87mtp5cwpn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Neeraj Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> When adding many objects to a repo with core.fsyncObjectFiles set to
> true, the cost of fsync'ing each object file can become prohibitive.
>
> One major source of the cost of fsync is the implied flush of the
> hardware writeback cache within the disk drive. Fortunately, Windows,
> MacOS, and Linux each offer mechanisms to write data from the filesystem
> page cache without initiating a hardware flush.
>
> This patch introduces a new 'core.fsyncObjectFiles = 2' option that
> takes advantage of the bulk-checkin infrastructure to batch up hardware
> flushes.
>
> When the new mode is enabled we do the following for new objects:
>
> 1. Create a tmp_obj_XXXX file and write the object data to it.
> 2. Issue a pagecache writeback request and wait for it to complete.
> 3. Record the tmp name and the final name in the bulk-checkin state for
>    later name.
>
> At the end of the entire transaction we:
> 1. Issue a fsync against the lock file to flush the hardware writeback
>    cache, which should by now have processed the tmp file writes.
> 2. Rename all of the temp files to their final names.
> 3. When updating the index and/or refs, we will issue another fsync
>    internal to that operation.
>
> On a filesystem with a singular journal that is updated during name
> operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
> would expect the fsync to trigger a journal writeout so that this
> sequence is enough to ensure that the user's data is durable by the time
> the git command returns.
>
> This change also updates the MacOS code to trigger a real hardware flush
> via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
> MacOS there was no guarantee of durability since a simple fsync(2) call
> does not flush any hardware caches.

Thanks for working on this, good to see fsck issues picked up after some
on-list pause.

> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index c04f62a54a1..3b672c2db67 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -548,12 +548,17 @@ core.whitespace::
>    errors. The default tab width is 8. Allowed values are 1 to 63.
>  
>  core.fsyncObjectFiles::
> -	This boolean will enable 'fsync()' when writing object files.
> -+
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadata
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> +	A boolean value or the number '2', indicating the level of durability
> +	applied to object files.
> ++
> +This setting controls how much effort Git makes to ensure that data added to
> +the object store are durable in the case of an unclean system shutdown. If
> +'false', Git allows data to remain in file system caches according to operating
> +system policy, whence they may be lost if the system loses power or crashes. A
> +value of 'true' instructs Git to force objects to stable storage immediately
> +when they are added to the object store. The number '2' is an experimental
> +value that also preserves durability but tries to perform hardware flushes in a
> +batch.

Some feedback/thoughts:

0) Let's not expose "2" to users, but give it some friendly config name
and just translate this to the enum internally.

1) Your commit message says "When updating the index and/or refs[...]"
but we're changing core.fsyncObjectFiles here, I assume that's
summarizing existing behavior then

2) You say "when adding many [loose] objects to a repo[...]", and the
test-case is "git stash push", but for e.g. accepting pushes we have
transfer.unpackLimit.

It would be interesting to see if/how this impacts performance there,
and also if not that should at least be called out in
documentation. I.e. users might want to set this differently on servers
v.s. checkouts.

But also, is this sort of thing something we could mitigate even more in
commands like "git stash push" by just writing a pack instead of N loose
objects?

I don't think such questions should preclude changing the fsync
approach, or offering more options, but they should inform our
longer-term goals.

3) Re some of the musings about fsync() recently in
https://lore.kernel.org/git/877dhs20x3.fsf@evledraar.gmail.com/; is this
method of doing not-quite-an-fsync guaranteed by some OS's / POSIX etc,
or is it more like the initial approach before core.fsyncObjectFiles,
i.e. the happy-go-lucky approach described in the "[...]that orders data
writes properly[...]" documentation you're removing.

4) While that documentation written by Linus long ago is rather
flippant, I think just removing it and not replacing it with some
discussion about how this is a trade-off v.s. real-world filesystem
semantics isn't a good change.

5) On a similar thought as transfer.unpackLimit in #2, I wonder if this
fsync() setting shouldn't really be something we should be splitting
up. I.e. maybe handle batch loose object writes one way, ref updates
another way etc. I think moving core.fsync* to a setting like what we
have for fsck.* and <cmd>.fsck.* is probably a better thing to do in the
longer term.

I.e. being able to do things like:

    fsync.objectFiles = none
    fsync.refFiles = cache # or "hardware"
    receive.fsync.objectFiles = hardware
    receive.fsync.refFiles = hardware

Or whatever, i.e. we're using one hammer for all of these now, but I
suspect most users who care about fsync care about /some/ fsync, not
everything.

6) Inline comments below.

> +struct object_rename {
> +	char *src;
> +	char *dst;
> +};
> +
> +static struct bulk_rename_state {
> +	struct object_rename *renames;
> +	uint32_t alloc_renames;
> +	uint32_t nr_renames;
> +} bulk_rename_state;

In a crash of git itself it seems we're going to leave some litter
behind in the object dir now, and "git gc" won't know how to clean it
up. I think this is going to want to just use the tmp-objdir.[ch] API,
which might or might not need to be extended for loose objects / some
oddities of this use-case.

Also, if you have a pair of things like this the string-list API is much
more pleasing to use than coming up with your own encapsulation.

>  static struct bulk_checkin_state {
>  	unsigned plugged:1;
>  
> @@ -21,13 +33,15 @@ static struct bulk_checkin_state {
>  	struct pack_idx_entry **written;
>  	uint32_t alloc_written;
>  	uint32_t nr_written;
> -} state;


> +
> +		free(state->renames);
> +		memset(state, 0, sizeof(*state));

So with this and other use of the "state" variable is this part of
bulk-checkin going to become thread-unsafe, was that already the case?

> +static void add_rename_bulk_checkin(struct bulk_rename_state *state,
> +				    const char *src, const char *dst)
> +{
> +	struct object_rename *rename;
> +
> +	ALLOC_GROW(state->renames, state->nr_renames + 1, state->alloc_renames);
> +
> +	rename = &state->renames[state->nr_renames++];
> +	rename->src = xstrdup(src);
> +	rename->dst = xstrdup(dst);
> +}

All boilerplate duplicating things you'd get with a string-list for free...

> +		/*
> +		 * If we have a plugged bulk checkin, we issue a call that
> +		 * cleans the filesystem page cache but avoids a hardware flush
> +		 * command. Later on we will issue a single hardware flush
> +		 * before renaming files as part of do_sync_and_rename.
> +		 */

So this is the sort of thing I meant by extending Linus's docs, I know
some FS's work this way, but not all do.

Also there's no guarantee in git that your .git is on one FS, so I think
even for the FS's you have in mind this might not be an absolute
guarantee...
