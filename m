Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76AC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbiCUUQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353264AbiCUUQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:16:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820813F36
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:14:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q14so8129800ljc.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcRJqz3+dYDVXId/kB36nwbcY+AdgMVoiuZ1nbM9QUs=;
        b=YI232bpgyrPVhtkUgsOMNH+2lACGIb2RbdnvDbhAy/rZ1ps9mlCPCo4gX323Amp1gk
         Xb8a8RXtuoDGQytp4k+VeJGhYebnk6y3BQX+YjG+LqlYVhJ3a/Vei3q9UPhuYIKU00za
         VarqvswNaaimTB9kgOsvzNr6Npg42WkwSaHy8QKj5ekhTWPx7Wry/qx3mmEkEDzZiMM+
         /JBK7Mx+HMmhVxUlWCI2/yvs5WGx/pjeo/T6jreLvfaFMmE2WwRGjPQN9mCWI+x7DYjo
         ldVLGOkym40LPdSEFc1VBU8e0aN1pWyGuRE/sYBEFnp5vejuk9tHDVJ4+N58bPqpbYR5
         nJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcRJqz3+dYDVXId/kB36nwbcY+AdgMVoiuZ1nbM9QUs=;
        b=1wcEGwGVC5B/pbcwOgZM/o1CiaaX/sR9p2yxfoXl5WnQQjKbOeZf5e6RFxy+WfTL3W
         NqrCoPG0rbLf0L1dA4flidtiNRALpjHepiGDY1VWAAXBjPRrVfqt+vblUvRptcQUKi7i
         b0NbmtLY4V/2c35x1wFapYgAwoCjr+WgSRLQW+uPosM+8W/oBU0ivtDgAZsAGJ9UBorL
         tVjBvytM35LOCe7nun3YncQsqiwKbUl3uYzAan9aJxd1yJ94djUbfGKJlhvkI5JXekfo
         6UChNgnT+jhplNjVLYbIgalYRJuNPvnvDjM11rtw3TmdF7SbK6cyaKhKMWVQiqvMifeT
         4mRA==
X-Gm-Message-State: AOAM530PFpJPRD9cleUBTuRHclbB8HAk1gHUInSmgINirBv/ZQq639mf
        v3Bzq4P8ZJ4+e9boBdFWMQ64ZTSQEBFPBFinuN4=
X-Google-Smtp-Source: ABdhPJx56gMKMjToJhTJ00h6RlQKrYbObGbr4GUFO9UWYNP+Co6H4egBDr9rM9Z8nuEuGQ2by06h/fqJwH67WqZrtdo=
X-Received: by 2002:a2e:bc1e:0:b0:249:896f:6dbf with SMTP id
 b30-20020a2ebc1e000000b00249896f6dbfmr3143755ljf.180.1647893671365; Mon, 21
 Mar 2022 13:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220321.861qyv9rjr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.861qyv9rjr.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 13:14:19 -0700
Message-ID: <CANQDOdez2u4oTNeETM0zLQr7Xb6XXbEuoxXPhSqGuurwQWbkHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 9:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > One major source of the cost of fsync is the implied flush of the
> > hardware writeback cache within the disk drive. This commit introduces
> > a new `core.fsyncMethod=3Dbatch` option that batches up hardware flushe=
s.
> > It hooks into the bulk-checkin plugging and unplugging functionality,
> > takes advantage of tmp-objdir, and uses the writeout-only support code.
> >
> > When the new mode is enabled, we do the following for each new object:
> > 1. Create the object in a tmp-objdir.
> > 2. Issue a pagecache writeback request and wait for it to complete.
> >
> > At the end of the entire transaction when unplugging bulk checkin:
> > 1. Issue an fsync against a dummy file to flush the hardware writeback
> >    cache, which should by now have seen the tmp-objdir writes.
> > 2. Rename all of the tmp-objdir files to their final names.
> > 3. When updating the index and/or refs, we assume that Git will issue
> >    another fsync internal to that operation. This is not the default
> >    today, but the user now has the option of syncing the index and ther=
e
> >    is a separate patch series to implement syncing of refs.
>
> Re my question in
> https://lore.kernel.org/git/220310.86r179ki38.gmgdl@evledraar.gmail.com/
> (which you *partially* replied to per my reading, i.e. not the
> fsync_nth() question) I still don't get why the tmp-objdir part of this
> is needed.
>

Sorry for not fully answering your question. I think part of the issue migh=
t be
background, where it's not clear to me what's different between your
understanding
and mine, so may not have included something that's questionable to
you but not to me.

Your syscall description below makes the issues very concrete, so I
think we'll get it this round :).

> For "git stash" which is one thing sped up by this let's go over what
> commands/FS ops we do. I changed the test like this:
>
>         diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>         index 3fc16944e9e..479a495c68c 100755
>         --- a/t/t3903-stash.sh
>         +++ b/t/t3903-stash.sh
>         @@ -1383,7 +1383,7 @@ BATCH_CONFIGURATION=3D'-c core.fsync=3Dloos=
e-object -c core.fsyncmethod=3Dbatch'
>
>          test_expect_success 'stash with core.fsyncmethod=3Dbatch' "
>                 test_create_unique_files 2 4 fsync-files &&
>         -       git $BATCH_CONFIGURATION stash push -u -- ./fsync-files/ =
&&
>         +       strace -f git $BATCH_CONFIGURATION stash push -u -- ./fsy=
nc-files/ &&
>                 rm -f fsynced_files &&
>
>                 # The files were untracked, so use the third parent,
>
> Then we get this output, with my comments, and I snipped some output:
>
>         $ ./t3903-stash.sh --run=3D1-4,114 -vixd 2>&1|grep --color -e 897=
72c935031c228ed67890f9 -e .git/stash -e bulk_fsync -e .git/index
>         [pid 14703] access(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/=
89772c935031c228ed67890f953c0a2b5c8316", F_OK) =3D -1 ENOENT (No such file =
or directory)
>         [pid 14703] access(".git/objects/fb/89772c935031c228ed67890f953c0=
a2b5c8316", F_OK) =3D -1 ENOENT (No such file or directory)
>         [pid 14703] link(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/tm=
p_obj_bdUlzu", ".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89772c935031c2=
28ed67890f953c0a2b5c8316") =3D 0
>
> Here we're creating the tmp_objdir() files. We then sync_file_range()
> and close() this.
>
>         [pid 14703] openat(AT_FDCWD, "/home/avar/g/git/t/trash directory.=
t3903-stash/.git/objects/tmp_objdir-bulk-fsync-rR3AQI/bulk_fsync_HsDRl7", O=
_RDWR|O_CREAT|O_EXCL, 0600) =3D 9
>         [pid 14703] unlink("/home/avar/g/git/t/trash directory.t3903-stas=
h/.git/objects/tmp_objdir-bulk-fsync-rR3AQI/bulk_fsync_HsDRl7") =3D 0
>
> This is the flushing of the "cookie" in do_batch_fsync().
>
>         [pid 14703] newfstatat(AT_FDCWD, ".git/objects/tmp_objdir-bulk-fs=
ync-rR3AQI/fb/89772c935031c228ed67890f953c0a2b5c8316", {st_mode=3DS_IFREG|0=
444, st_size=3D29, ...}, 0) =3D 0
>         [pid 14703] link(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/89=
772c935031c228ed67890f953c0a2b5c8316", ".git/objects/fb/89772c935031c228ed6=
7890f953c0a2b5c8316") =3D 0
>
> Here we're going through the object dir migration with
> unplug_bulk_checkin().
>
>         [pid 14703] unlink(".git/objects/tmp_objdir-bulk-fsync-rR3AQI/fb/=
89772c935031c228ed67890f953c0a2b5c8316") =3D 0
>         newfstatat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f953=
c0a2b5c8316", {st_mode=3DS_IFREG|0444, st_size=3D29, ...}, AT_SYMLINK_NOFOL=
LOW) =3D 0
>         [pid 14705] access(".git/objects/tmp_objdir-bulk-fsync-0F7DGy/fb/=
89772c935031c228ed67890f953c0a2b5c8316", F_OK) =3D -1 ENOENT (No such file =
or directory)
>         [pid 14705] access(".git/objects/fb/89772c935031c228ed67890f953c0=
a2b5c8316", F_OK) =3D 0
>         [pid 14705] utimensat(AT_FDCWD, ".git/objects/fb/89772c935031c228=
ed67890f953c0a2b5c8316", NULL, 0) =3D 0
>         [pid 14707] openat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed6=
7890f953c0a2b5c8316", O_RDONLY|O_CLOEXEC) =3D 9
>
> We then update the index itself, first a temporary index.stash :
>
>     openat(AT_FDCWD, "/home/avar/g/git/t/trash directory.t3903-stash/.git=
/index.stash.19141.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =3D 8
>     openat(AT_FDCWD, ".git/index.stash.19141", O_RDONLY) =3D 9
>     newfstatat(AT_FDCWD, ".git/objects/fb/89772c935031c228ed67890f953c0a2=
b5c8316", {st_mode=3DS_IFREG|0444, st_size=3D29, ...}, AT_SYMLINK_NOFOLLOW)=
 =3D 0
>     newfstatat(AT_FDCWD, "/home/avar/g/git/t/trash directory.t3903-stash/=
.git/index.stash.19141.lock", {st_mode=3DS_IFREG|0644, st_size=3D927, ...},=
 0) =3D 0
>     rename("/home/avar/g/git/t/trash directory.t3903-stash/.git/index.sta=
sh.19141.lock", "/home/avar/g/git/t/trash directory.t3903-stash/.git/index.=
stash.19141") =3D 0
>     unlink(".git/index.stash.19141")        =3D 0
>
> Followed by the same and a later rename of the actual index:
>
>     [pid 19146] rename("/home/avar/g/git/t/trash directory.t3903-stash/.g=
it/index.lock", "/home/avar/g/git/t/trash directory.t3903-stash/.git/index"=
) =3D 0
>
> So, my question is still why the temporary object dir migration part of
> this is needed.
>
> We are writing N loose object files, and we write those to temporary
> names already.
>
> AFAIKT we could do all of this by doing the same
> tmp/rename/sync_file_range dance on the main object store.
>

Why not the main object store? We want to maintain the invariant that any
name in the main object store refers to a file that durably has the
correct contents.
If we do sync_file_range and then rename, and then crash, we now have a fil=
e
in the main object store with some SHA name, whose contents may or may not
match the SHA.  However, if we ensure an fsync happens before the rename,
a crash at any point will leave us either with no file in the main
object store or
with a file that is durable on the disk.

> Then instead of the "bulk_fsync" cookie file don't close() the last file
> object file we write until we issue the fsync on it.
>
> But maybe this is all needed, I just can't understand from the commit
> message why the "bulk checkin" part is being done.
>
> I think since we've been over this a few times without any success it
> would really help to have some example of the smallest set of syscalls
> to write a file like this safely. I.e. this is doing (pseudocode):
>
>     /* first the bulk path */
>     open("bulk/x.tmp");
>     write("bulk/x.tmp");
>     sync_file_range("bulk/x.tmp");
>     close("bulk/x.tmp");
>     rename("bulk/x.tmp", "bulk/x");
>     open("bulk/y.tmp");
>     write("bulk/y.tmp");
>     sync_file_range("bulk/y.tmp");
>     close("bulk/y.tmp");
>     rename("bulk/y.tmp", "bulk/y");
>     /* Rename to "real" */
>     rename("bulk/x", x");
>     rename("bulk/y", y");
>     /* sync a cookie */
>     fsync("cookie");
>

The '/* Rename to "real" */' and '/* sync a cookie */' steps are
reversed in your above sequence. It should be
1: (for each file)
    a) open
    b) write
    c) sync_file_range
    d) close
    e) rename in tmp_objdir  -- The rename step is not required for
bulk-fsync. An earlier version of this series didn't do it, but
Jeff King pointed out that it was required for concurrency:
https://lore.kernel.org/all/YVOrikAl%2Fu5%2FVi61@coredump.intra.peff.net/

2: fsync something on the same volume to flush the filesystem log and
disk cache. This functions as a "barrier".
3: Rename to final names.  At this point we know that the "contents"
are durable, so if the final name exists, we can read through it to
get the data.

> And I'm asking why it's not:
>
>     /* Rename to "real" as we go */
>     open("x.tmp");
>     write("x.tmp");
>     sync_file_range("x.tmp");
>     close("x.tmp");
>     rename("x.tmp", "x");
>     last_fd =3D open("y.tmp"); /* don't close() the last one yet */
>     write("y.tmp");
>     sync_file_range("y.tmp");
>     rename("y.tmp", "y");
>     /* sync a cookie */
>     fsync(last_fd);
>
> Which I guess is two questions:
>
>  A. do we need the cookie, or can we re-use the fd of the last thing we
>     write?

We can re-use the FD of the last thing we write, but that results in a
tricker API which
is more intrusive on callers. I was originally using a lockfile, but
found a usage where
there was no lockfile in unpack-objects.

>  B. Is the bulk indirection needed?
>

Hopefully the explanation above makes it clear why we need the
indirection. To state it again,
we need a real fsync before creating the final name in the objdir,
otherwise on a crash a name
could exist that points at contents which could have been lost, since
they weren't durable. I
updated the comment in do_batch_fsync to make this a little clearer.

> > +             fsync_or_die(fd, "loose object file");
>
> Unrelated nit: this API is producing sentence lego unfriendly to
> translators.
>
> Should be made to take an enum or something, so we can emit the relevant
> translated message in fsync_or_die(). Imagine getting:
>
>         fsync error on '=E6=97=A5=E6=9C=AC=E8=AA=9E=E3=81=AF=E8=A9=B1=E3=
=81=9B=E3=81=BE=E3=81=9B=E3=82=93'
>
> Which this will do, just the other way around for non-English speakers
> using the translation.
>
> (The solution is also not to add _() here, since translators will want
> to control the word order.)

This line is copied from the preexisting version of the same code in
close_loose_object.
If I'm understanding it correctly, the entire chain of messages is
untranslated and would
remain as english.  fsync_or_die doesn't have a _().  Can we just
leave it that way, since
this is not a situation that should actually happen to many users?
Alternatively, I think it
would be pretty trivial to just pass through the file name, so I'll
just do that.

> > diff --git a/cache.h b/cache.h
> > index 3160bc1e489..d1ae51388c9 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1040,7 +1040,8 @@ extern int use_fsync;
> >
> >  enum fsync_method {
> >       FSYNC_METHOD_FSYNC,
> > -     FSYNC_METHOD_WRITEOUT_ONLY
> > +     FSYNC_METHOD_WRITEOUT_ONLY,
> > +     FSYNC_METHOD_BATCH
> >  };
> >
> >  extern enum fsync_method fsync_method;
> > @@ -1767,6 +1768,11 @@ void fsync_or_die(int fd, const char *);
> >  int fsync_component(enum fsync_component component, int fd);
> >  void fsync_component_or_die(enum fsync_component component, int fd, co=
nst char *msg);
> >
> > +static inline int batch_fsync_enabled(enum fsync_component component)
> > +{
> > +     return (fsync_components & component) && (fsync_method =3D=3D FSY=
NC_METHOD_BATCH);
> > +}
> > +
> >  ssize_t read_in_full(int fd, void *buf, size_t count);
> >  ssize_t write_in_full(int fd, const void *buf, size_t count);
> >  ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
> > diff --git a/config.c b/config.c
> > index 261ee7436e0..0b28f90de8b 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1688,6 +1688,8 @@ static int git_default_core_config(const char *va=
r, const char *value, void *cb)
> >                       fsync_method =3D FSYNC_METHOD_FSYNC;
> >               else if (!strcmp(value, "writeout-only"))
> >                       fsync_method =3D FSYNC_METHOD_WRITEOUT_ONLY;
> > +             else if (!strcmp(value, "batch"))
> > +                     fsync_method =3D FSYNC_METHOD_BATCH;
> >               else
> >                       warning(_("ignoring unknown core.fsyncMethod valu=
e '%s'"), value);
> >
> > diff --git a/object-file.c b/object-file.c
> > index 5258d9ed827..bdb0a38328f 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1895,6 +1895,8 @@ static void close_loose_object(int fd)
> >
> >       if (fsync_object_files > 0)
> >               fsync_or_die(fd, "loose object file");
> > +     else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> > +             fsync_loose_object_bulk_checkin(fd);
> >       else
> >               fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
> >                                      "loose object file");
>
> This is related to the above comments about what minimum set of syscalls
> are needed to trigger this "bulk" behavior, but it seems to me that this
> whole API is avoiding just passing some new flags down to object-file.c
> and friends.
>
> For e.g. update-index that results in e.g. the "plug bulk" not being
> aware of HASH_WRITE_OBJECT, so with dry-run writes and the like we'll do
> the whole setup/teardown for nothing.
>
> Which is another reason I wondered why this couldn't be a flagged passed
> down to the object writing...

In the original implementation [1], I did some custom thing for
renaming the files
rather than tmp_objdir. But you suggested at the time that I use
tmp_objdir, which
was a good decision, since it made access to the objects possible in-proces=
s and
for descendents in the middle of the transaction.

It sounds to me like I just shouldn't plug the bulk checkin for cases
where we're not
going to add to the ODB.  Plugging the bulk checkin is always
optional.  But when
I wrote the code, I didn't love the result, since it makes arbitrary
callers harder. So
I changed the code to lazily create the tmp objdir the first time an object
shows up, which has the same effect of avoiding the cost when we
aren't adding any
objects.  This also avoids the need to write an error message, since
failing to create
the tmp objdir will just result in a fsync.  The main downside here is
that it's another thing
that will have to change if we want to make adding to the ODB multithreaded=
.

Thanks,
Neeraj

[1] https://lore.kernel.org/all/12cad737635663ed596e52f89f0f4f22f58bfe38.16=
32176111.git.gitgitgadget@gmail.com/
