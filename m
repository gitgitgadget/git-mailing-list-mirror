Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBCC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B8610E8
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhIVCQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhIVCQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:16:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F2EC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:14:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id co2so3794242edb.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 19:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UNNAq9vxG/ki9MkbHrm+c/BvWpkKlE29yZW7J6YO4EU=;
        b=kcm3EsQZqDroGoaiQMsh2OY9g4O6Lj/IEnCSs3ZhO0OGMSmQIqlSXYj+mFBPOAfSjw
         o5zLYPZ4urXWBwMG/7F7xKv7AYWVIrjURbNrTztlPH88mBd+tNNw/cpDKNWGiWgE2OKZ
         9FW0v6pO0ZnRVnNPcLFeo62mx5YqF2MrGsDY7W5gbnxYKVyNXmfqKx/epXTaLA4ysqu5
         PnPpnGaJL58RKA3NdKqIx+ZuZPgVFp5Y+hHTyime8ERWcYZ8AIlswtJPt8Oi7RGUneRp
         jGY+AsOq5mErTD+6bwkI19XdATdhkT4L8jIAs4jpKNLg5DVxyMnxiTaky0y6PpEnAf+f
         W0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UNNAq9vxG/ki9MkbHrm+c/BvWpkKlE29yZW7J6YO4EU=;
        b=Nw3wjqrhuGer1o3K1GQrQqVlaQUpMnPhwbhiL7poyjdr796TdbjLsungsOJfkQ18Qo
         3AqFWollFQVUr9AKytRXlDOCrdRN9sR9mgIww2ctQcv/JrNgNJ88UXoSP5RqgjilkoRV
         X9GBRYHp8BJQ3BKtQpeqo6XpiyH9D5QQT8520TeUf64LBTdvFz6GyZzhGb/JbzWjf8BJ
         OAy+vGiGr5uy/cQ7+qdL4FdQ75b3gBIPqtivN2iqejI5bth5wldCIGAQBa4nWC5UotV1
         gp4f1X5IS3jIjZQt2BGAHqtUuOtsJPWkjZSGJgJykeAqJMjC9msEwAgTd5AKfaomgW2b
         03yg==
X-Gm-Message-State: AOAM533aNtCTyNNBo/KvdMWil++aMl5DKlPd1K0Zb5dwWMhp8MwbSnUf
        NmI4MnO8xmd9xDTxwiJzfCCqQyps4Nm5tQ==
X-Google-Smtp-Source: ABdhPJwlOG7xzHZ5pLiTZNSG8oxJTmj/50pwTFQiMvyUhM0EpE7AWafa8ZYKVABVZL2cbTVprKAZnQ==
X-Received: by 2002:a17:906:850a:: with SMTP id i10mr38454838ejx.256.1632276894319;
        Tue, 21 Sep 2021 19:14:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a7sm313119eda.70.2021.09.21.19.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 19:14:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/6] core.fsyncobjectfiles: batched disk flushes
Date:   Wed, 22 Sep 2021 04:02:29 +0200
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <12cad737635663ed596e52f89f0f4f22f58bfe38.1632176111.git.gitgitgadget@gmail.com>
        <87mto58pkc.fsf@evledraar.gmail.com>
        <CANQDOdc1bNwDYhJ8ck2cwUfKmr3064uBHFDACphW+cGZRd-6EQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CANQDOdc1bNwDYhJ8ck2cwUfKmr3064uBHFDACphW+cGZRd-6EQ@mail.gmail.com>
Message-ID: <87sfxx73vm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Neeraj Singh wrote:

> On Tue, Sep 21, 2021 at 4:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Sep 20 2021, Neeraj Singh via GitGitGadget wrote:
>>
>> > When the new mode is enabled we do the following for new objects:
>> >
>> > 1. Create a tmp_obj_XXXX file and write the object data to it.
>> > 2. Issue a pagecache writeback request and wait for it to complete.
>> > 3. Record the tmp name and the final name in the bulk-checkin state for
>> >    later rename.
>> >
>> > At the end of the entire transaction we:
>> > 1. Issue a fsync against the lock file to flush the hardware writeback
>> >    cache, which should by now have processed the tmp file writes.
>> > 2. Rename all of the temp files to their final names.
>> > 3. When updating the index and/or refs, we assume that Git will issue
>> >    another fsync internal to that operation.
>>
>> Perhaps note too that:
>>
>> 4. For loose objects, refs etc. we may or may not create directories,
>>    and most certainly will be updating metadata on the immediate
>>    directory containing the file, but none of that's fsync()'d.
>>
>> > On a filesystem with a singular journal that is updated during name
>> > operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
>> > would expect the fsync to trigger a journal writeout so that this
>> > sequence is enough to ensure that the user's data is durable by the ti=
me
>> > the git command returns.
>> >
>> > This change also updates the macOS code to trigger a real hardware flu=
sh
>> > via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
>> > macOS there was no guarantee of durability since a simple fsync(2) call
>> > does not flush any hardware caches.
>>
>> There's no discussion of whether this is or isn't known to also work
>> some Linux FS's, and for these OS's where this does work is this only
>> for the object files themselves, or does metadata also "ride along"?
>>
>
> I unfortunately can't examine Linux kernel source code and the details
> of metadata
> consistency behavior across files is not something that anyone in that
> group wants
> to pin down. As far as I can tell, the only thing that's really
> guaranteed is fsyncing
> every single file you write down and its parent directory if you're
> creating a new file
> (which we always are).  As came up in conversation with Christoph
> Hellwig elsewhere
> on thread, Linux doesn't have any set of syscalls to make batch mode
> safe.  It does look
> like XFS would be safe if sync_file_ranges actually promised to wait
> for all pagecache
> writeback definitively, since it would do a "log force" to push all
> the dirty metadata to
> disk when we do our final fsync.
>
> I really didn't want to say something definitive about what Linux can
> or will do, since I'm
> not in a position to really know or influence them.  Christoph did say
> that he would be
> interested in contributing a variant to this patch that would be
> definitively safe on filesystems
> that honor syncfs.

*nod*, it's fine if it's omitted. Just wondering if we knew but weren't
 saying etc.

>> > _Performance numbers_:
>> >
>> > Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
>> > Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
>> > Windows - Same host as Linux, a preview version of Windows 11.
>> >         This number is from a patch later in the series.
>> >
>> > Adding 500 files to the repo with 'git add' Times reported in seconds.
>> >
>> > core.fsyncObjectFiles | Linux | Mac   | Windows
>> > ----------------------|-------|-------|--------
>> >                 false | 0.06  |  0.35 | 0.61
>> >                 true  | 1.88  | 11.18 | 2.47
>> >                 batch | 0.15  |  0.41 | 1.53
>>
>> Per my https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com
>> and 6/6 in this series we've got perf tests for add/stash, but it would
>> be really interesting to see how this is impacted by
>> transfer.unpackLimit in cases where we may be writing packs or loose
>> objects.
>
> I'm having trouble understanding how unpackLimit is related to 'git stash'
> or 'git add'. From code inspection, it doesn't look like we're using
> those settings
> for adding objects except from across a transport.
>
> Are you proposing that we have a similar setting for adding objects
> via 'add' using
> a packfile?  I think that would be a good goal, but it might be a bit
> tricky since we've
> likely done a lot of the work to buffer the input objects in order to
> compute their OIDs,
> before we know how many objects there are to add. If the policy were
> to "always add to
> a packfile", it would be easier.

No, just that in the documentation that we should be explaining to the
reader that this mode that optimizes for loose object writing benefits
particular commands, but e.g. on the server-side that we'll probably
never write 500 objects, but stream them to one pack.

Which might also inform next steps for the commands this does help with,
i.e. can we make more things stream to packs? I think having this mode
is at worst a good transitory thing to have, but perhaps longer term
we'll want to simply write fewer individual loose objects.

In any case, pushing to a server with this configured and scaling that
by transfer.unpackLimit should nicely demonstrate the pack v.s. loose
object scenario at different fsck-settings.

>>
>> > [...]
>> >  core.fsyncObjectFiles::
>> > -     This boolean will enable 'fsync()' when writing object files.
>> > -+
>> > -This is a total waste of time and effort on a filesystem that orders
>> > -data writes properly, but can be useful for filesystems that do not u=
se
>> > -journalling (traditional UNIX filesystems) or that only journal metad=
ata
>> > -and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteb=
ack").
>> > +     A value indicating the level of effort Git will expend in
>> > +     trying to make objects added to the repo durable in the event
>> > +     of an unclean system shutdown. This setting currently only
>> > +     controls the object store, so updates to any refs or the
>> > +     index may not be equally durable.
>>
>> All these mentions of "object" should really clarify that it's "loose
>> objects", i.e. we always fsync pack files.
>>
>> > +* `false` allows data to remain in file system caches according to
>> > +  operating system policy, whence it may be lost if the system loses =
power
>> > +  or crashes.
>>
>> As noted in point #4 of
>> https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com/ while
>> this direction is overall an improvement over the previously flippant
>> docs, they at least alluded to the context that the assumption behind
>> "false" is that you don't really care about loose objects, you care
>> about loose objects *and* the ref update or whatever.
>>
>> As I think (this is from memory) we've covered already this may have
>> been all based on some old ext3 assumption, but it's probably worth
>> summarizing that here, i.e. if you've got an FS with global ordered
>> operations you can probably skip this, but probably not etc.
>>
>> > +* `true` triggers a data integrity flush for each object added to the
>> > +  object store. This is the safest setting that is likely to ensure d=
urability
>> > +  across all operating systems and file systems that honor the 'fsync=
' system
>> > +  call. However, this setting comes with a significant performance co=
st on
>> > +  common hardware.
>>
>> This is really overpromising things by omitting the fact that eve if
>> we're getting this feature you've hacked up right, we're still not
>> fsyncing dir entries etc (also noted above).
>>
>> So something that describes the narrow scope here, along with "loose
>> objects" etc....
>>
>> > +* `batch` enables an experimental mode that uses interfaces available=
 in some
>> > +  operating systems to write object data with a minimal set of FLUSH =
CACHE
>> > +  (or equivalent) commands sent to the storage controller. If the ope=
rating
>> > +  system interfaces are not available, this mode behaves the same as =
`true`.
>> > +  This mode is expected to be safe on macOS for repos stored on HFS+ =
or APFS
>> > +  filesystems and on Windows for repos stored on NTFS or ReFS.
>>
>> Again, even if it's called "core.fsyncObjectFiles" if we're going to say
>> "safe" we really need to say safe in what sense. Having written and
>> fsync()'d the file is helping nobody if the metadata never arrives....
>>
>
> My concern with your feedback here is that this is user-facing documentat=
ion.
> I'd assume that people who are not intimately familiar with both their
> filesystem
> and Git's internals would just be completely mystified by a long commenta=
ry on
> the specifics in the Config documentation. I think over time Git should f=
ocus on
> making this setting really guarantee durability in a meaningful way
> across the entire
> repository.

Yeah, this setting though is probably going to be tweaked only by fairly
expert-level users of git.

I think it's fine if it just explicitly punts and says something like
'this is what it does, this may or may not work on your FS' etc., my
main issue with the current docs is that they give off this vibe of
knowing a lot more than they're telling you.

>> > +static void do_sync_and_rename(struct string_list *fsync_state, struc=
t lock_file *lock_file)
>> > +{
>> > +     if (fsync_state->nr) {
>>
>> I think less indentation here would be nice:
>>
>>     if (!fsync_state->nr)
>>         return;
>>     /* rest of unindented body */
>>
>
> Will fix.
>
>> Or better yet do this check in unplug_bulk_checkin(), then here:
>>
>>     fsync_or_die();
>>     for_each_string_list_item() { ...}
>>     string_list_clear(....);
>>
>>
>
> I'd prefer to put it in the callee for reasons of
> separation-of-concerns.  I don't want
> to have the caller and callee partially implement the contract. The
> compiler should
> do a good enough job, since it's only one caller and will probably get
> totally inilined.

*nod*

For what it's worth I meant the "inlined" just in terms of avoiding the
indirection for human readers, it won't matter to the machine,
especially since this is all I/O bound...
