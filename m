Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A006C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353297AbiCUUZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353114AbiCUUZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:25:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD52B249
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:23:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k21so9958419lfe.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PqolmzjR2xj8eEcPBUja57xCmJ1qkcqko7UJR0XcFI=;
        b=htpEfF5SMifg7t/ZdpHHhzi/eTihthKbk2A7NR9ypAML0Grg1SBDEMocWta5Y8IuRn
         LxHRpxnJIMTUkH2w8LfT/ncO9FrQogygl69+zFKxroox3krcxgtVZTjWEgFwMVMAh67x
         jFX0XA2RpmB1ODlhxaSNnSnfrvXfk6M1bLORPyu6F6U5Soln7b4mBbM22uMyDp/nLG3O
         5UHPwc+JZNQJu6MUYSrHcWyaeFhq69dfefLkSCIpj8zSqLaxMBLXl0X6al/bS4PqCm/o
         fqiIzqvBzjICx8yp6jhq7OxR4lDM9iIs2OqaeNd/1butFhc5ajwSR6V0CYwJ8PYe0h92
         g8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PqolmzjR2xj8eEcPBUja57xCmJ1qkcqko7UJR0XcFI=;
        b=BDlC5sNcVPJGZzDVKoAteYrm13RijZmRutRrSp+8H7l10f+f2T30jfJFuYRluC73V9
         z1ox/5Hokt2VhFPnwGY1AhO4AeOs/9hJpXDydYhQ/RDeaZGX8jIlZHizSoCARkqPH4Ov
         n6jjmb73QMJSxeClxl+QMGk2KIhVEfQgKBOPA2aRdA5ePCvRTTTEpJBIoYG1X6G0C40B
         1Y+BUwIgZ58EiibGVJdwJwD8Kf/MsrcQtmQsGAPyjk8PvSDe8cToMVdqILzFEmiVcg6J
         hz0+V/JbA5It4mxhHw1W+wyJeGfMxsMGW7O6pCzIT4m8HYtSlwsAz/3Jiz4/e4WWhk7p
         MxoQ==
X-Gm-Message-State: AOAM532SasRkdsx7EtvJ/cNrXCSJDQqlkNkJeWLA3WerhJb/6WKnu0pW
        X5LuZP1/Dv67q+OgCE0YvYDuo6RU9jOwo8eKUcE=
X-Google-Smtp-Source: ABdhPJwc7egweVYROY1mEmEJq26Celtyyy+kErOO0XjbwAZnYA/NQtDA40deY/Dk+1qCuBsmfr0gsPlCgWaneHW8Cog=
X-Received: by 2002:a05:6512:3909:b0:44a:2428:3ecb with SMTP id
 a9-20020a056512390900b0044a24283ecbmr6740070lfu.522.1647894219123; Mon, 21
 Mar 2022 13:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <xmqqee2v1adc.fsf@gitster.g>
In-Reply-To: <xmqqee2v1adc.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 13:23:27 -0700
Message-ID: <CANQDOdckKac7wfrKhskBV7YCVhX6qG0P44Ej552U+LBsE6Mg-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 10:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +* `batch` enables a mode that uses writeout-only flushes to stage multiple
> > +  updates in the disk writeback cache and then does a single full fsync of
> > +  a dummy file to trigger the disk cache flush at the end of the operation.
>
> It is unfortunate that we have a rather independent "unplug" that is
> not tied to the "this is the last operation in the batch"---if there
> were we didn't have to invent a dummy but a single full sync on the
> real file who happened to be the last one in the batch would be
> sufficient.  It would not matter, if the batch is any meaningful
> size, hopefully.
>

I'm banking on  a large batch size or the fact that the additional
cost of creating
and syncing an empty file to be so small that it wouldn't be
noticeable event for
small batches. The current unfortunate scheme at least has a very simple API
that's easy to apply to any other operation going forward. For instance
builtin/hash-object.c might be another good operation, but it wasn't clear to me
if it's used for any mainline scenario.

> > +/*
> > + * Cleanup after batch-mode fsync_object_files.
> > + */
> > +static void do_batch_fsync(void)
> > +{
> > +     /*
> > +      * Issue a full hardware flush against a temporary file to ensure
> > +      * that all objects are durable before any renames occur.  The code in
> > +      * fsync_loose_object_bulk_checkin has already issued a writeout
> > +      * request, but it has not flushed any writeback cache in the storage
> > +      * hardware.
> > +      */
> > +
> > +     if (needs_batch_fsync) {
> > +             struct strbuf temp_path = STRBUF_INIT;
> > +             struct tempfile *temp;
> > +
> > +             strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
> > +             temp = xmks_tempfile(temp_path.buf);
> > +             fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> > +             delete_tempfile(&temp);
> > +             strbuf_release(&temp_path);
> > +             needs_batch_fsync = 0;
> > +     }
> > +
> > +     if (bulk_fsync_objdir) {
> > +             tmp_objdir_migrate(bulk_fsync_objdir);
> > +             bulk_fsync_objdir = NULL;
>
> The struct obtained from tmp_objdir_create() is consumed by
> tmp_objdir_migrate() so the only clean-up left for the caller to do
> is to clear it to NULL.  OK.
>
> > +     }
>
> This initially made me wonder why we need two independent flags.
> After applying this patch but not any later steps, upon plugging, we
> create the tentative object directory, and any loose object will be
> created there, but because nobody calls the writeout-only variant
> via fsync_loose_object_bulk_checkin() yet, needs_batch_fsync may not
> be turned on.  But even in that case, any new loose objects are in
> the tentative object directory and need to be migrated to the real
> place.
>
> And we may not cover all the existing code paths at the end of the
> series, or any new code paths right away after they get introduced,
> to be aware of the fsync_loose_object_bulk_checkin() when they
> create a loose object file, so it is most likely that these two if
> statements will be with us forever.
>
> OK.

After Avarb's last feedback, I've changed this to lazily create the objdir, so
the existence of an objdir is a suitable proxy for there being something worth
syncing. The potential downside is that the lazy-creation would need to be
synchronized if the ODB becomes multithreaded.

>
> > @@ -274,6 +311,24 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
> >       return 0;
> >  }
> >
> > +void fsync_loose_object_bulk_checkin(int fd)
> > +{
> > +     /*
> > +      * If we have a plugged bulk checkin, we issue a call that
> > +      * cleans the filesystem page cache but avoids a hardware flush
> > +      * command. Later on we will issue a single hardware flush
> > +      * before as part of do_batch_fsync.
> > +      */
> > +     if (bulk_checkin_plugged &&
> > +         git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
> > +             assert(bulk_fsync_objdir);
> > +             if (!needs_batch_fsync)
> > +                     needs_batch_fsync = 1;
>
> Except for when we unplug, do we ever flip needs_batch_fsync bit
> off, once it is set?  If the answer is no, wouldn't it be clearer to
> unconditionally set it, instead of "set it only for the first time"?
>

This code is now gone. I was stupidly optimizing for a future
multithreaded world
which might never come.

> > +     } else {
> > +             fsync_or_die(fd, "loose object file");
> > +     }
> > +}
> > +
> >  int index_bulk_checkin(struct object_id *oid,
> >                      int fd, size_t size, enum object_type type,
> >                      const char *path, unsigned flags)
> > @@ -288,6 +343,19 @@ int index_bulk_checkin(struct object_id *oid,
> >  void plug_bulk_checkin(void)
> >  {
> >       assert(!bulk_checkin_plugged);
> > +
> > +     /*
> > +      * A temporary object directory is used to hold the files
> > +      * while they are not fsynced.
> > +      */
> > +     if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
> > +             bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
> > +             if (!bulk_fsync_objdir)
> > +                     die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
> > +
> > +             tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
> > +     }
> > +
> >       bulk_checkin_plugged = 1;
> >  }
> >
> > @@ -297,4 +365,6 @@ void unplug_bulk_checkin(void)
> >       bulk_checkin_plugged = 0;
> >       if (bulk_checkin_state.f)
> >               finish_bulk_checkin(&bulk_checkin_state);
> > +
> > +     do_batch_fsync();
> >  }
> > diff --git a/bulk-checkin.h b/bulk-checkin.h
> > index b26f3dc3b74..08f292379b6 100644
> > --- a/bulk-checkin.h
> > +++ b/bulk-checkin.h
> > @@ -6,6 +6,8 @@
> >
> >  #include "cache.h"
> >
> > +void fsync_loose_object_bulk_checkin(int fd);
> > +
> >  int index_bulk_checkin(struct object_id *oid,
> >                      int fd, size_t size, enum object_type type,
> >                      const char *path, unsigned flags);
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
>
> Style.
>
> These days we allow trailing comma to enum definitions.  Perhaps
> give a trailing comma after _BATCH so that the next update patch
> will become less noisy?
>

Fixed.

> Thanks.

Thanks!
-Neeraj
