Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF5C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 08:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbhLFI4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 03:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhLFI4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 03:56:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9984C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 00:53:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v23so7163754pjr.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 00:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vd22hPX/D8Q9hwM4AtE81X3mrFPzt0NLygjoQ/wRTgI=;
        b=MZzcwUQi7BjRz7OdURv4qOg735/xLnlyuEPjhDG16Xy0Wf7rg/MCTaPpcz8K67UFjq
         ZwyUxgB/S+NipNWgIZA8Mw/W1PRAw0PTaqxcYvhVq7QI5VtSr4td/RiYm+Vh/KWxtLQz
         qEDpZXFUjJGWIjSgPUTbAhpey1WW7B8Q//YqMxerNAjYPVueH5OndLucxUfe9fh8G9pr
         ihO2eUY/nculgVTbZ8WX02y/eDNOsGed7DT10EPi3ZobcLjkOI+6IPO8lFhT2Sy4zh7V
         SZDFK7Eb95wzdl9C+/xWTfi7d84ErjJtuJckkBCoJCYkzCWG5mvZX+lPVMfzNsuCn72P
         J3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vd22hPX/D8Q9hwM4AtE81X3mrFPzt0NLygjoQ/wRTgI=;
        b=EYwpFW3bZkojlBiMea3FNza+jgPb1NJDmJJFC0iUDfGaNTtadzMz65S+SRPCfhViQr
         6cXFJH2ChZizf0MvSXZeghuNWqGHtSQ6ZbottA7bUzRtVfhhnPC65KDFyBvsHXM6YiB2
         a8ddsRWIDuORr79qUenwUAekXoq0uBGuHEIvvX/ATBRBj+pTxaqujqsLc8yIfk4SN6R1
         Y/CNpELgVwB6EsMPqVBAZyqg0+x/D9RDldhn5uzfW4zp6qHMN9PWnR+nPCoXktQZTElG
         ExWMNSzXQ1Bi9h5VYxAOWq/KCYVtYKSNFjaRM/LMu03r2neYeQrkJTFT4HQ4zut1EiIj
         +gCA==
X-Gm-Message-State: AOAM530SJQPnAVrI1sL4m5sf+jysIyP4ivihNLsP5w0drImK+yW2eC0G
        E4s5a2OhO7QVm45T8NcGe2E=
X-Google-Smtp-Source: ABdhPJx+urZ7OBOIxH3J1Lw/SBaPKaxkzBZ1vz4VT5H6W2rfIqtTmjW4RsyTDFtOhVqkDZ8PqMYJCQ==
X-Received: by 2002:a17:90b:97:: with SMTP id bb23mr36160542pjb.201.1638780783355;
        Mon, 06 Dec 2021 00:53:03 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id l1sm12186216pjh.28.2021.12.06.00.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 00:53:02 -0800 (PST)
Date:   Mon, 6 Dec 2021 00:53:00 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/2] tmp-objdir: new API for creating temporary
 writable databases
Message-ID: <20211206085300.GA26699@neerajsi-x1.localdomain>
References: <pull.1091.git.1638585658.gitgitgadget@gmail.com>
 <pull.1091.v2.git.1638750965.gitgitgadget@gmail.com>
 <36c00613d9a6ad4fc768e15b9ec23f9af520338a.1638750965.git.gitgitgadget@gmail.com>
 <xmqq4k7mi3g4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4k7mi3g4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 05, 2021 at 11:43:07PM -0800, Junio C Hamano wrote:
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > @@ -331,10 +332,14 @@ static void update_relative_gitdir(const char *name,
> >  				   void *data)
> >  {
> >  	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
> > +	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
> >  	trace_printf_key(&trace_setup_key,
> >  			 "setup: move $GIT_DIR to '%s'",
> >  			 path);
> > +
> >  	set_git_dir_1(path);
> 
> If a blank line needs to be added, have it between the variable
> declarations and the first statement (i.e. before the above call to
> "trace_printf_key()").
> 

Will fix.

> > +	if (tmp_objdir)
> > +		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
> >  	free(path);
> >  }
> 
> This is called during set_git_dir(), which happens fairly early in
> the set-up sequence.  I wonder if there is a real use case that
> creates a tmp-objdir that early in the process to require this
> unapply-reapply sequence.
> 

The lack of this code was causing a failure, I believe in
t2107-update-index-basic.sh: "--refresh triggers late setup_work_tree".

This problem came up after applying: https://lore.kernel.org/git/4a40fd4a29a468b9ce320bc7b22f19e5a526fad6.1637020263.git.gitgitgadget@gmail.com/

I thought it would be best to fix this in the tmp-objdir code so that
callers could plug/unplug bulk checkin without any subtle surprises.

> > @@ -1809,8 +1846,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
> >  /* Finalize a file on disk, and close it. */
> >  static void close_loose_object(int fd)
> >  {
> > -	if (fsync_object_files)
> > -		fsync_or_die(fd, "loose object file");
> > +	if (!the_repository->objects->odb->will_destroy) {
> > +		if (fsync_object_files)
> > +			fsync_or_die(fd, "loose object file");
> 
> OK, so we omit fsync because these newly created loose objects may
> not survive and instead get discarded.  Presumably when we migrate
> them to the real object store, we'll make sure they hit the disk
> platter in some other way?
> 
> 	... goes and cheats by reading ahead ...
> 
> Ahh, ok, new objects created in a temporary object store that is
> marked with the will_destroy bit is not allowed to migrate to the
> real object store, so there is no point to fsync them.
> 
> set_temporary_primary_odb() and tmp_objdir_replace_primary_odb() can
> mark the temporary one to be throw-away, but unfortunately there is
> no caller in this step, so it is a bit hard to see when a throw-away
> object store is useful.  I guess remerge-diff wants to do tentative
> merges that create new objects in a throw-away object directory,
> because it is logically a read-only operation.
> 

Yes, this code is there exactly for remerge-diff and anyone doing something
similar in the future.

> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> > index b8d880e3626..3d38eeab66b 100644
> > --- a/tmp-objdir.c
> > +++ b/tmp-objdir.c
> > @@ -1,5 +1,6 @@
> >  #include "cache.h"
> >  #include "tmp-objdir.h"
> > +#include "chdir-notify.h"
> >  #include "dir.h"
> >  #include "sigchain.h"
> >  #include "string-list.h"
> > @@ -11,6 +12,8 @@
> >  struct tmp_objdir {
> >  	struct strbuf path;
> >  	struct strvec env;
> > +	struct object_directory *prev_odb;
> > +	int will_destroy;
> 
> The other one was a one-bit unsigned bitfield, but this is a full
> integer.  I somehow think that the other one can and should be a
> full integer, too---it's not like there are tons of bits need to be
> stored in the structure or we will have tons of instances of the
> structure that storing many bits compactly matters.
> 

The principle I was trying to follow here is that the only flag in a
structure might as well be a full integer, but when we have two or more
it might be worth combining them into a single machine word.  Given that
these are not highly replicated structures, you're right that's it's not
a big benefit.

I'll switch everything to an int and call it good.

Given that this patch series introduces functions with no users, are you
going to hold off on putting this into 'next' until another next-worthy
patch series is ready?  I've already reworked the batch mode stuff on Github,
but I'll need to do a lot more testing before sending it to the list.

Thanks,
Neeraj
