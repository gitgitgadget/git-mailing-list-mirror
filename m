Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F993C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC1E21655
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpanmoKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIQLHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgIQLHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 07:07:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E227C061756;
        Thu, 17 Sep 2020 04:06:53 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so2088498edt.4;
        Thu, 17 Sep 2020 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=v0u7ygrgenEjZHhKX1lpXgtS3ObFogYyT8UMBJrndes=;
        b=jpanmoKPu9aTVh3AwDyhPH+TBrBhsrmal2yFj6onbmiOzXe9h+9S4xAsJk0NzoN3Tw
         1BL0iFq5zhVrG+sjhF2yhm1+vIiNpp8R0kfvjAokgHQDs/zkDoJUQf45TKh/7nHY4QUo
         3YEF7e1JMfZ80L/VmZ4MGIjAoG0KvDQvGTlPpbTsbsvDTHRL+kY0L4NymlJRx8v4DhX5
         dtM58BLxOYB7VG25gScAMxOA2Yer/H5b5k6u8KMid4jFV5OgBgQOkykriAUu0htGPYlU
         gz7dE3cR3Jtmkp7vtKDOC1bAHtBQf9o5y5FaU7aSaTOacNFsAIvuXR0mJ5GeHo+pHhfv
         3jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=v0u7ygrgenEjZHhKX1lpXgtS3ObFogYyT8UMBJrndes=;
        b=CHwpvJ6BDAhZH0LqgOgOGCWpNQduddJgXnrTSNMI5wQ0TaVBGP7ay15hLyahJ1KiBZ
         UlcY623B/PT2AmrvhA7AV1mwq/amtVVduuo/m2w2e1BtpghEOhRgDxomhnUghWTWZ4Se
         kJzkikP4bmUPjx50rKjvnXVNGqcARzto1Nr+GevYxCHACS2uw9+alCuQ3/iKKncuuOM8
         1StOvOMAcvCPlubIpsddrsu39KNLF+wvV29cHlFMaKt+9hQk4BjFFuzTmP9bktvbY034
         KW2mtBWZpxJMRWvuPZpkoSwd83XTSAjRTRtLPa3Tsk6z1fdhNHKXsTYFSBQ5/kvpxj0Q
         aKIQ==
X-Gm-Message-State: AOAM5310veboXfmohNaDzM1Q9AoDeguK100XRU2Udv3CNjqlPCA/huB/
        5Ro0peZGeYAzLtTf04t8igA=
X-Google-Smtp-Source: ABdhPJzeFMn/Iha6vazPITmi4y4AlPzANsJXKvJ/BnXRVZswgRxgdEvD3S/RL1DtHgtsntf+cyGk6A==
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr31418801edb.268.1600340811946;
        Thu, 17 Sep 2020 04:06:51 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id c22sm16235140edr.70.2020.09.17.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:06:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com> <20180117235220.GD6948@thunk.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20180117235220.GD6948@thunk.org>
Date:   Thu, 17 Sep 2020 13:06:50 +0200
Message-ID: <87sgbghdbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 18 2018, Theodore Ts'o wrote:

> On Wed, Jan 17, 2018 at 02:07:22PM -0800, Linus Torvalds wrote:
>> 
>> Now re-do the test while another process writes to a totally unrelated
>> a huge file (say, do a ISO file copy or something).
>> 
>> That was the thing that several filesystems get completely and
>> horribly wrong. Generally _particularly_ the logging filesystems that
>> don't even need the fsync, because they use a single log for
>> everything (so fsync serializes all the writes, not just the writes to
>> the one file it's fsync'ing).
>
> Well, let's be fair; this is something *ext3* got wrong, and it was
> the default file system back them.  All of the modern file systems now
> do delayed allocation, which means that an fsync of one file doesn't
> actually imply an fsync of another file.  Hence...
>
>> The original git design was very much to write each object file
>> without any syncing, because they don't matter since a new object file
>> - by definition - isn't really reachable. Then sync before writing the
>> index file or a new ref.
>
> This isn't really safe any more.  Yes, there's a single log.  But
> files which are subject to delayed allocation are in the page cache,
> and just because you fsync the index file doesn't mean that the object
> file is now written to disk.  It was true for ext3, but it's not true
> for ext4, xfs, btrfs, etc.
>
> The good news is that if you have another process downloading a huge
> ISO image, the fsync of the index file won't force the ISO file to be
> written out.  The bad news is that it won't force out the other git
> object files, either.
>
> Now, there is a potential downside of fsync'ing each object file, and
> that is the cost of doing a CACHE FLUSH on a HDD is non-trivial, and
> even on a SSD, it's not optimal to call CACHE FLUSH thousands of times
> in a second.  So if you are creating thousands of tiny files, and you
> fsync each one, each fsync(2) call is a serializing instruction, which
> means it won't return until that one file is written to disk.  If you
> are writing lots of small files, and you are using a HDD, you'll be
> bottlenecked to around 30 files per second on a 5400 RPM HDD, and this
> is true regardless of what file system you use, because the bottle
> neck is the CACHE FLUSH operation, and how you organize the metadata
> and how you do the block allocation, is largely lost in the noise
> compared to the CACHE FLUSH command, which serializes everything.
>
> There are solutions to this; you could simply not call fsync(2) a
> thousand times, and instead write a pack file, and call fsync once on
> the pack file.  That's probably the smartest approach.
>
> You could also create a thousand threads, and call fsync(2) on those
> thousand threads at roughly the same time.  Or you could use a
> bleeding edge kernel with the latest AIO patch, and use the newly
> added IOCB_CMD_FSYNC support.
>
> But I'd simply recommend writing a pack and fsync'ing the pack,
> instead of trying to write a gazillion object files.  (git-repack -A,
> I'm looking at you....)
>
> 					- Ted

[I didn't find an ideal message to reply to in this thread, but this
seemed to probably be the best]

Just an update on this since I went back and looked at this thread,
GitLab about ~1yr ago turned on core.fsyncObjectFiles=true by
default.

The reason is detailed in [1], tl;dr: empty loose object file issue on
ext4 allegedly caused by a lack of core.fsyncObjectFiles=true, but I
didn't do any root cause analysis. Just noting it here for for future
reference.

1. https://gitlab.com/gitlab-org/gitlab-foss/-/issues/51680#note_180508774
