Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081DC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 06:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiCaGbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 02:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiCaGbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 02:31:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A511C0F
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 23:29:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k21so39673374lfe.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xcDrEesoAggRi9/9JkK9PNiRSRLY7mUQbgGWpUEALfI=;
        b=nXyt6ELylMzYbWXoPeWg5+Het6vQo0Fo5c9XlhjIT9U4aVoUFv9dBRvDv0tcZzcV4H
         jJZ3u7fpNcDDCwTbh/IS0ZWat328ZfnvZ5IsZ+owLwLSzzz1im4NLm0EqmYW5yojK6q3
         s9HgwptruqF0Wxt570WYs1MmIaZqA0xLBfnEgAU9CCHyxVl619Wp9xsoD+izot8y7FZo
         +UvgNultj9XMNdAahJREwYgeYjuYt+dyQR+34m4iVQs+QhlNPYe3J2Q3IokO9fyPG/rb
         LlneplgHxrx5vbaQGXtwSx+vbxdmVzxD+UW4ZWwcgDnl8MfH+o4k6hk78781Ht744+Ph
         hGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xcDrEesoAggRi9/9JkK9PNiRSRLY7mUQbgGWpUEALfI=;
        b=KZEDGgTygsiZvU4nNb2bMih0CSIfcA+zYou0NgxunN7ZFm95OpVggkdwKYhPw12e8J
         b+VlV2YreOVkg3XfkjueqX+OSXxblcR3e/1HMei9tu69o24jM3M5V+xofyM0hsD/GYt0
         vTWwpoZpYV5X6OLy6ZVLqUtwOn/roNr1Skv73E6bS+mXF5EbE0rs2Cn2FIt4ueouu+/g
         ETXzbDYUIRUugjnCisA3LTa4jw2/1IGFiclu4O/h0IsxRs/XhZjm2TauzntpA2iw03Vu
         uzZh2kvIPUgEcsSCnyboqi6ntnw1aasHBRKshppmZqUKFUsbWe5PWjNWikODjrsIMq1C
         r8tw==
X-Gm-Message-State: AOAM533+kv+0nWg6PHo7cJjnXWWSdNpRL667GkNqa1uuriQxcqkzuNi8
        2JIzXpoRZ4ysCFGxT2h9lqpYh/nNHQR4ieb4ZLo=
X-Google-Smtp-Source: ABdhPJySuqhtcnB73iM7Rdve5jOAtl3ylAywf6aL07iukfWETM8bHr/2Y7Pm2/IR400B0UwtyqxTXyAODyfnYaWK4FU=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr9836777lfb.592.1648708149736; Wed, 30
 Mar 2022 23:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
 <xmqq4k3f9w9s.fsf@gitster.g>
In-Reply-To: <xmqq4k3f9w9s.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 23:28:56 -0700
Message-ID: <CANQDOdd-G0VHOKWjWQL75jAJ7Az4izB33HKzayqnk-F-nkHj_A@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] core.fsyncmethod: batched disk flushes for loose-objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 10:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core.=
txt
> > index 9da3e5d88f6..3c90ba0b395 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -596,6 +596,14 @@ core.fsyncMethod::
> >  * `writeout-only` issues pagecache writeback requests, but depending o=
n the
> >    filesystem and storage hardware, data added to the repository may no=
t be
> >    durable in the event of a system crash. This is the default mode on =
macOS.
> > +* `batch` enables a mode that uses writeout-only flushes to stage mult=
iple
> > +  updates in the disk writeback cache and then does a single full fsyn=
c of
> > +  a dummy file to trigger the disk cache flush at the end of the opera=
tion.
> > ++
> > +  Currently `batch` mode only applies to loose-object files. Other rep=
ository
> > +  data is made durable as if `fsync` was specified. This mode is expec=
ted to
> > +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS file=
systems
> > +  and on Windows for repos stored on NTFS or ReFS filesystems.
>
> Does this format correctly?  I had an impression that the second and
> subsequent paragraphs, connected with a line with a single "+" on
> it, has to be flushed left without indentation.
>

Here's the man format (Not sure how this will render going through gmail):
           =E2=80=A2   batch enables a mode that uses writeout-only flushes=
 to
stage multiple updates in the disk writeback cache and then does a
single full fsync of a dummy file to trigger the disk cache flush at
the end of the
               operation.

                   Currently `batch` mode only applies to loose-object
files. Other repository
                   data is made durable as if `fsync` was specified.
This mode is expected to
                   be as safe as `fsync` on macOS for repos stored on
HFS+ or APFS filesystems
                   and on Windows for repos stored on NTFS or ReFS filesyst=
ems.

To describe the above if it doesn't render correctly, we have a
bulleted list where the batch after the * is bolded.  Other instances
of single backtick quoted text just appears as plaintext. The
descriptive "Currently `batch` mode..." paragraph is under the bullet
point and well-indented.

In HTML the output looks good as well, except that the descriptive
paragraph is in monospace for some reason.

> > diff --git a/bulk-checkin.c b/bulk-checkin.c
> > index 8b0fd5c7723..9799d247cad 100644
> > --- a/bulk-checkin.c
> > +++ b/bulk-checkin.c
> > @@ -3,15 +3,20 @@
> >   */
> >  #include "cache.h"
> >  #include "bulk-checkin.h"
> > +#include "lockfile.h"
> >  #include "repository.h"
> >  #include "csum-file.h"
> >  #include "pack.h"
> >  #include "strbuf.h"
> > +#include "string-list.h"
> > +#include "tmp-objdir.h"
> >  #include "packfile.h"
> >  #include "object-store.h"
> >
> >  static int odb_transaction_nesting;
> >
> > +static struct tmp_objdir *bulk_fsync_objdir;
>
> I wonder if this should be added to the bulk_checkin_state structure
> as a new member, especially if we fix the erroneous call to
> finish_bulk_checkin() as a preliminary fix-up of a bug that existed
> even before this series.
>

It seems like the only thing tying this to the bulk_checkin_state
(which I've renamed in my local changes to bulk_checkin_packfile) is
that they're both generally written when a transaction is active.
Keeping fsync separate from packfile should help the reader see that
the two sets of functions access only their respective global state.
If we add another optimization strategy (e.g. appendable pack files),
it would get its own separate state and functions that are independent
of the large-blob packfile and loose-object fsync optimizations.

> > +/*
> > + * Cleanup after batch-mode fsync_object_files.
> > + */
> > +static void do_batch_fsync(void)
> > +{
> > +     struct strbuf temp_path =3D STRBUF_INIT;
> > +     struct tempfile *temp;
> > +
> > +     if (!bulk_fsync_objdir)
> > +             return;
> > +
> > +     /*
> > +      * Issue a full hardware flush against a temporary file to ensure
> > +      * that all objects are durable before any renames occur. The cod=
e in
> > +      * fsync_loose_object_bulk_checkin has already issued a writeout
> > +      * request, but it has not flushed any writeback cache in the sto=
rage
> > +      * hardware or any filesystem logs. This fsync call acts as a bar=
rier
> > +      * to ensure that the data in each new object file is durable bef=
ore
> > +      * the final name is visible.
> > +      */
> > +     strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_direct=
ory());
> > +     temp =3D xmks_tempfile(temp_path.buf);
> > +     fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> > +     delete_tempfile(&temp);
> > +     strbuf_release(&temp_path);
> > +
> > +     /*
> > +      * Make the object files visible in the primary ODB after their d=
ata is
> > +      * fully durable.
> > +      */
> > +     tmp_objdir_migrate(bulk_fsync_objdir);
> > +     bulk_fsync_objdir =3D NULL;
> > +}
>
> OK.
>
> > +void prepare_loose_object_bulk_checkin(void)
> > +{
> > +     /*
> > +      * We lazily create the temporary object directory
> > +      * the first time an object might be added, since
> > +      * callers may not know whether any objects will be
> > +      * added at the time they call begin_odb_transaction.
> > +      */
> > +     if (!odb_transaction_nesting || bulk_fsync_objdir)
> > +             return;
> > +
> > +     bulk_fsync_objdir =3D tmp_objdir_create("bulk-fsync");
> > +     if (bulk_fsync_objdir)
> > +             tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
> > +}
>
> OK.  If we got a failure from tmp_objdir_create(), then we don't
> swap and end up creating a new loose object file in the primary
> object store.  I wonder if we at least want to note that fact for
> later use at "unplug" time.  We may create a few loose objects in
> the primary object store without any fsync, then a later call may
> successfully create a temporary object directory and we'd create
> more loose objects in the temporary one, which are flushed with the
> "create a dummy and fsync" trick and migrated, but do we need to do
> something to the ones we created in the primary object store before
> all that happens?
>
> > +void fsync_loose_object_bulk_checkin(int fd, const char *filename)
> > +{
> > +     /*
> > +      * If we have an active ODB transaction, we issue a call that
> > +      * cleans the filesystem page cache but avoids a hardware flush
> > +      * command. Later on we will issue a single hardware flush
> > +      * before as part of do_batch_fsync.
> > +      */
> > +     if (!bulk_fsync_objdir ||
> > +         git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
> > +             fsync_or_die(fd, filename);
> > +     }
> > +}
>
> Ah, if we have successfully created the temporary directory, we
> don't do full fsync but just writeout-only one, so there is no need
> for the worry I mentioned in the previous paragraph.  OK.
>

There is the possibility that we might create the objdir when calling
prepare_loose_object_bulk_checkin but somehow fail to write the object
and yet still make it to end_odb_transaction.  In that case, we'd
issue an extra dummy fsync.  I don't think this case is worth extra
code to track, since it's a single fsync in a weird failure case.

> > @@ -301,4 +370,6 @@ void end_odb_transaction(void)
> >
> >       if (bulk_checkin_state.f)
> >               finish_bulk_checkin(&bulk_checkin_state);
> > +
> > +     do_batch_fsync();
> >  }
>
> OK.
>
> > @@ -1961,6 +1963,9 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
> >       static struct strbuf tmp_file =3D STRBUF_INIT;
> >       static struct strbuf filename =3D STRBUF_INIT;
> >
> > +     if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> > +             prepare_loose_object_bulk_checkin();
> > +
> >       loose_object_path(the_repository, &filename, oid);
> >
> >       fd =3D create_tmpfile(&tmp_file, filename.buf);
>
> The necessary change to the "workhorse" code path is surprisingly
> small, which is pleasing to see.
>
> Thanks.

Thanks for looking at this.
