Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C8EC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiCPSXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiCPSXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:23:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415552E65
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:22:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g17so5194918lfh.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nKsLq4LJl7BV8UJ+3wM9z8vV5vcZzoYzknWCeCDZu8=;
        b=UM42ZZgbGoTKMKv7xmpAJZVe/YVmKKQDrWGErpd7stSKAz/FMmY+sHyxHfm/cq9+1W
         x0Q51s7h3a1lvhR0seJyHua/DIPK/yMydcjBcLS3L/pvanKqhrZwEwJ2M48PEJ44MJeL
         y8+oyi3k6RSkV6dkMoMyo1lcUAstxk8d3TR9Z5hfuBxfSRRBRuzPQyy9ORr56cp5Ntx8
         PpvUWhmqbkLSm6dU/oLGAUOwyZkS46GD37mbm3jGBHBBXjFVn+GCmFPyTdMvlQcnnaYF
         BTA04+wLIYA2V23xJStWp4k0FG/7AFJyxQCx1PJ2l4+5VivHVC5Uvzqm5qm+zqEX5qr2
         UnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nKsLq4LJl7BV8UJ+3wM9z8vV5vcZzoYzknWCeCDZu8=;
        b=L1GzYkYpsKEWtJqH7CPAL4VPl7B4qPpyos0IAAph4dImRfLYsCOGjzmxhfLkV+XJEl
         zNZGbS18A4Ime+g13tbzR2WpocbIGsSAFUINnYA03L2r/LFhW2CNEr3gCpV+vb7gykvk
         fjYI4jdZiQ6ng3Fdwzl6et6oWtYrX1Wv6/OAsbhu3IUBPL1+D8a+jQ6A1eORuydt6xkR
         thHptzgUFyz/l5aEGqeCA/GKMDrlYU/35+onHkkS5OHAqzLQPNWpcJkIB6LxB9B96yVI
         aThvuh5QN2ciBlKC3q94CDeSFKrikVsNd9s7oe1h0ZQOgsCHlXoGh1x/MwPVu/hJEH9u
         bzGQ==
X-Gm-Message-State: AOAM5333kXYIBenurVl7IVpq9ZisVCkAWXhwgqUCu1iQV5wSNyr73Uio
        LT+6yzCl1pKp5CgIKHVxwQSNVDmhaVNlWL3a3a7YBqRaphKPsw==
X-Google-Smtp-Source: ABdhPJxhnm4za+wBB/fZLzweAptG1ENZpDuzxCrxQ/mohTpVGUNalR9FtRNwl0swGp6Adf+ij/D3qKy3WA4ACqYzytI=
X-Received: by 2002:a05:6512:1155:b0:448:bcee:3df0 with SMTP id
 m21-20020a056512115500b00448bcee3df0mr535375lfg.442.1647454927168; Wed, 16
 Mar 2022 11:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
 <YjGSOJlZnDSske3s@ncase>
In-Reply-To: <YjGSOJlZnDSske3s@ncase>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 16 Mar 2022 11:21:56 -0700
Message-ID: <CANQDOddkJ_iyUjYQAHs93nqCda1W6ss5JQzbz3uuh-XnoATg5g@mail.gmail.com>
Subject: Re: [PATCH 2/7] core.fsyncmethod: batched disk flushes for loose-objects
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 12:31 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Mar 15, 2022 at 09:30:54PM +0000, Neeraj Singh via GitGitGadget wrote:
> > From: Neeraj Singh <neerajsi@microsoft.com>
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> > index 062e5259905..c041ed33801 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -628,6 +628,11 @@ core.fsyncMethod::
> >  * `writeout-only` issues pagecache writeback requests, but depending on the
> >    filesystem and storage hardware, data added to the repository may not be
> >    durable in the event of a system crash. This is the default mode on macOS.
> > +* `batch` enables a mode that uses writeout-only flushes to stage multiple
> > +  updates in the disk writeback cache and then a single full fsync to trigger
> > +  the disk cache flush at the end of the operation. This mode is expected to
> > +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
> > +  and on Windows for repos stored on NTFS or ReFS filesystems.
>
> This mode will not be supported by all parts of our stack that use our
> new fsync infra. So I think we should both document that some parts of
> the stack don't support batching, and say what the fallback behaviour is
> for those that don't.
>

Can do. I'm hoping that you'll revive your batch-mode refs change too so that
we get batching across the ODB and Refs, which are the two data stores that
may receive many updates in a single Git command.  This documentation
comment will read:
```
* `batch` enables a mode that uses writeout-only flushes to stage multiple
  updates in the disk writeback cache and then does a single full fsync of
  a dummy file to trigger the disk cache flush at the end of the operation.
  Currently `batch` mode only applies to loose-object files. Other repository
  data is made durable as if `fsync` was specified. This mode is expected to
  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
  and on Windows for repos stored on NTFS or ReFS filesystems.
```


> >  core.fsyncObjectFiles::
> >       This boolean will enable 'fsync()' when writing object files.
> > diff --git a/bulk-checkin.c b/bulk-checkin.c
> > index 93b1dc5138a..5c13fe17802 100644
> > --- a/bulk-checkin.c
> > +++ b/bulk-checkin.c
> > @@ -3,14 +3,20 @@
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
> >  static int bulk_checkin_plugged;
> > +static int needs_batch_fsync;
> > +
> > +static struct tmp_objdir *bulk_fsync_objdir;
> >
> >  static struct bulk_checkin_state {
> >       char *pack_tmp_name;
> > @@ -80,6 +86,34 @@ clear_exit:
> >       reprepare_packed_git(the_repository);
> >  }
> >
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
> > +     }
> > +
> > +     if (bulk_fsync_objdir)
> > +             tmp_objdir_migrate(bulk_fsync_objdir);
> > +}
> > +
>
> We never unset `bulk_fsync_objdir` anywhere. Shouldn't we be doing that
> when we unplug this infrastructure?
>

Will Fix.

Thanks,
Neeraj
