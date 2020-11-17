Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF7C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242A324679
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="anPBX4FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgKQAZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKQAZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:25:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB3C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 16:25:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 7so14523053qtp.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 16:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t94BXq9O6WXNulBhpfmN+DOq8Aq3TQI+RDhMm405Xt4=;
        b=anPBX4FUttxEZ8NjV7vuxiEwT98Z8YIJVzDl91WwNlpg0SChZa0TU/tvCShmjcHeK0
         Z1kTpBowoHVWx14nF9RGj/+ezPcYIPMkB6Atjlw/VrvC1DCPYyKyAHIL+jPbhFs+ScRh
         QDGZxilmM+UJe3wCB8tPx7BNbZRsL5XutcT8V2huXRHp6fUwblkLqhytT7d3cNCnYNRS
         aYohJKlOQu2uQKYHMVD+a0B8DRB+DrxzakN6jENuPqGUAhn3UMNtQ5nDm2yoRlR+Mz2t
         Gy72S1HUXXxipdvAxZjDDSBFkNY0G2jZjT5DQpBKSItHYzICgP7vnVjIB9UU/tH1fIzs
         l+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t94BXq9O6WXNulBhpfmN+DOq8Aq3TQI+RDhMm405Xt4=;
        b=SHrXT6ky8HEuiQ8fx+Svyfe7flGoWa8ghuV8FpAbfigdA3w7Q9yo4WfWg/wMT6TMf1
         JYYBvrURwRDqFI2H5Ob0/FdiFjOMUP4jEYbDOp31jgkDRYaDIc3as6XDE6wQgwJ1rJ9V
         kRXZnQ51snLg+i6E3O64MviE71r9LRvAIkwMKJGdgyMdL8K2/eYfTTd+aKJBuUZFoqZT
         kK02qke1quhN6ZojInUZ+lW+tHhLhCZHCClWnNBIfi3e/fqaGQ4nVX5bEYELywq6M/lS
         hnjebd96lKTCJ3DBlIRpNRpymbVC2wTpf0kkjsTB1jzxgRJnmbYrzjhFscA3YQTJFWJ8
         Zfvg==
X-Gm-Message-State: AOAM53336uLY48MIksV8AKvrIn8AlmwQzMLBywdsRR0Vby40/mvlUnLW
        9bDcNvXu6GdlrInJdxk/EQnaZw==
X-Google-Smtp-Source: ABdhPJysrKz6ydxkyNYmxnr5+amkZfRcabR1ZeqAarREPkHtc6fkXWSd5NC68dSsjnliLdnAPYnv9w==
X-Received: by 2002:ac8:4917:: with SMTP id e23mr16979814qtq.262.1605572748743;
        Mon, 16 Nov 2020 16:25:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2e3a:4a72:e851:164d])
        by smtp.gmail.com with ESMTPSA id p27sm5016081qkp.70.2020.11.16.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 16:25:47 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:25:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/3] builtin/repack.c: don't move existing packs out of
 the way
Message-ID: <X7MYifflg7SaTRXm@nand.local>
References: <cover.1605552016.git.me@ttaylorr.com>
 <d4e73aad14189a00621da9e000d2c6a5fe776d84.1605552016.git.me@ttaylorr.com>
 <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn4c7uf2.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 03:29:05PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This behavior dates all the way back to 2ad47d6 (git-repack: Be
> > careful when updating the same pack as an existing one., 2006-06-25).
> > 2ad47d6 is mainly concerned about a case where a newly written pack
> > would have a different structure than its index. This used to be
> > possible when the pack name was a hash of the set of objects. Under this
> > naming scheme, two packs that store the same set of objects could differ
> > in delta selection, object positioning, or both. If this happened, then
> > any such packs would be unreadable in the instant between copying the
> > new pack and new index (i.e., either the index or pack will be stale
> > depending on the order that they were copied).
>
> True.  So the idea is that we can now pretend that we never wrote
> the new packfile and leave the existing one as-is?

True for packs, which are guaranteed to be unchanged by having the same
checksum in their filename. For other files that use their pack's
checksum in their filename, we want to overwrite the existing copy with
the one we just wrote.

> > This patch is mostly limited to removing code paths that deal with the
> > 'old' prefixing, with the exception of pack metadata.
>
> ... "pack metadata" meaning?  We do not remove and replace the file,
> but we update their mtime to keep these packfiles more fresh than
> other packfiles, or something?

Meaning: .idx, .bitmap, .promisor files. I probably ought to be more
clear in what "metadata" means, since it could easily be confused with
mtime and others.

> > @@ -463,109 +463,34 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >
> >  	/*
> >  	 * Ok we have prepared all new packfiles.
> >  	 */
> >  	for_each_string_list_item(item, &names) {
> >  		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
> >  			char *fname, *fname_old;
> >
> >  			fname = mkpathdup("%s/pack-%s%s",
> >  					packdir, item->string, exts[ext].name);
> >  			fname_old = mkpathdup("%s-%s%s",
> >  					packtmp, item->string, exts[ext].name);
> > +
> > +			if (((uintptr_t)item->util) & (1 << ext)) {
> > +				struct stat statbuffer;
> > +				if (!stat(fname_old, &statbuffer)) {
> > +					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
> > +					chmod(fname_old, statbuffer.st_mode);
> > +				}
> > +
> >  				if (rename(fname_old, fname))
> >  					die_errno(_("renaming '%s' failed"), fname_old);
>
> OK, so this is where the previous step matters.  We do the same as
> before (i.e. stat+chmod and rename) only for paths we have created.
>
> We don't reuse the old one because we have already written a new
> file so we won't save anything by doing so, and checking if the
> target of rename exists already before deciding not to rename cannot
> be made atomic, so just relying on rename() to do the right thing is
> a good idea anyway.
>
> > +			} else if (!exts[ext].optional)
> > +				die(_("missing required file: %s"), fname_old);
>
> If one branch of if/else if.../else requires multi-statement block,
> use {} on all of them, for consistency.

Thanks.

> So, if we wrote a few .$ext for a packfile but not some .$ext, if
> the one we didn't write is among the necessary one, we are in
> trouble?  OK.

Yes, exactly.

> > +			else if (unlink(fname) < 0 && errno != ENOENT)
> > +				die_errno(_("could not unlink: %s"), fname);
>
> And if we wrote .pack and .idx but not .bitmap, the old .bitmpa that
> has the same pack hash may be stale and we discard it for safety?
> That sounds "prudent" but it is not immdiately clear from what
> danger we are protecting ourselves.
>
> In any case, much of what I speculated while reading the proposed
> log message turned out to be false, which may be a sign that the log
> message did not explain the approach clearly enough.  I thought that
> a newly created file that happened to be identical to existing ones
> would be discarded without getting renamed to their final location,
> but the code does not do such special casing.  I thought the
> 'metadata' it talks about were to compensate for side effects of
> reusing the old files, but that was not what the 'metadata' was even
> about.

It's more about: we trust what pack-objects wrote to be the current
state of things. So, if a bitmap already exists, but the caller did a
back-to-back repack and this time generates their bitmap with the
hash cache extension, we prefer the newer bitmap to the one that already
existed.

That goes both ways: if pack-objects _didn't_ write a file that already
exists, we want to drop the existing file. Peff seems to talk more about
this in his email, which I'll respond to now...

> Other than that, the change in [2/3] and [3/3] look quite sensible
> (I am not saying [1/3] is bad---I haven't looked at it yet).
>
> Thanks.

Thanks,
Taylor
