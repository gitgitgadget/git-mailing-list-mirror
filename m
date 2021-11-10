Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC3C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD7661205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhKJPL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbhKJPL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 10:11:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F9C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 07:09:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f8so11899084edy.4
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 07:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xSRshixzi1AzTrTavLqw1Vb1x7hdEYXt0BZDFyWj7o4=;
        b=oZOvYttCMiN80lmoKnnXH2DBejZiYc8wtrAUAwJWjaqBJ5/zefuKZ1gKamZ5iuThu5
         OENM+xi3RhVTsaZm39jpMxEPK1nXm5NTeTqYMH3tgr1tBoYvxA6yUozcNlQvh72KERTB
         fecn95LI3LuAVIBDLToEjHHdp0UjBzC5wtSgAs030sNeUugZbGl1gGMIEldEgjXPSolP
         mL3r35PB7FtwLVxzAulw5MXTLpUZa5Dfagza7iV7DKYHPIBePKAiX0ksM18FUPbE/T24
         COGD6lTAYwx7dOtPgCbyugYxxx/lAyIHjB2fC3gqgAbt3V4iQ0P3uZcjg7uSIcGROw4R
         JkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xSRshixzi1AzTrTavLqw1Vb1x7hdEYXt0BZDFyWj7o4=;
        b=Qa991JVOJtY9kQtLVCAOOgDJKdeqUiloLEivFW2nKjIHJ8RYuyV95uhom7CGoCtPH3
         gDvgcKabtuPpd8gOaNhf4cPp6uNT3UG/S7fSHSln33YB9xhMrP3P+T60uRjSzTlyQSBY
         Ry5R96Ti49hAq1Ly61hVuoNmtiECSW76IqclV1PZLO7ZAiovKlsS37hIRiCvZRyaAJer
         5UCB7O55UhKaLC+2jLjeQu6Js+r/ZH9ZFNbSVf/SXpIGQrfwH84tLK/PDjsItM02TPVA
         wYDyay5XiKcJ+URKa4+BoJumM6u7d3d7c6k3HNSn7Axj0sQtI6befhcp7tHFAeB7cCFP
         t9NQ==
X-Gm-Message-State: AOAM531tRbI59bruWAizab73uKxXds8kKSBNAz7A+psDXHGfLK7yGccR
        3eaQ4sDcKc2X/67zjxH7eLMNA2RtvMTpsw==
X-Google-Smtp-Source: ABdhPJwsqbCoufSclADQ/1otuOJ4o9nj3tEgOkhgz8W6P7ELLIWkB2sFfSalzbAqeSuSLiYrqzZ0tQ==
X-Received: by 2002:a05:6402:128a:: with SMTP id w10mr346522edv.272.1636556946651;
        Wed, 10 Nov 2021 07:09:06 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g21sm16005edw.86.2021.11.10.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 07:09:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkpDl-0012yj-5z;
        Wed, 10 Nov 2021 16:09:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Date:   Wed, 10 Nov 2021 15:49:02 +0100
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
Message-ID: <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Patrick Steinhardt wrote:

> [...]
> Fix this by introducing a new configuration "core.fsyncRefFiles". This
> config matches behaviour of "core.fsyncObjectFiles" in that it provides
> three different modes:
>
>     - "off" disables calling fsync on ref files. This is the default
>       behaviour previous to this change and remains the default after
>       this change.
>
>     - "on" enables calling fsync on ref files, where each reference is
>       flushed to disk before it is being committed. This is the safest
>       setting, but may incur significant performance overhead.
>
>     - "batch" will flush the page cache of each file as it is written to
>       ensure its data is persisted. After all refs have been written,
>       the directories which host refs are flushed.
>
> With this change in place and when "core.fsyncRefFiles" is set to either
> "on" or "batch", this kind of corruption shouldn't happen anymore.
>
> [1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt

With the understanding that my grokking of this approach is still
somewhere between "uh, that works?" and "wow, voodoo FS magic!". ....

I haven't looked at these changes in much daiter, or Neeraj's recent
related changes but...

> +core.fsyncRefFiles::
> +	A value indicating the level of effort Git will expend in trying to make
> +	refs added to the repo durable in the event of an unclean system
> +	shutdown. This setting currently only controls loose refs in the object
> +	store, so updates to packed refs may not be equally durable. Takes the
> +	same parameters as `core.fsyncObjectFiles`.
> +

...my understanding of it is basically a way of going back to what Linus
pointed out way back in aafe9fbaf4f (Add config option to enable
'fsync()' of object files, 2008-06-18).

I.e. we've got files x and y. POSIX sayeth we'd need to fsync them all
and the directory entry, but on some FS's it would be sufficient to
fsync() just y if they're created in that order. It'll imply an fsync of
both x and y, is that accurate?

If not you can probably discard the rest, but forging on:

Why do we then need to fsync() a "z" file in get_object_directory()
(i.e. .git/objects) then? That's a new "z", wasn't flushing "y" enough?

Or if you've written .git/objects/x and .git/refs/y I can imagine
wanting to create and sync a .git/z if the FS's semantics are to then
flush all remaining updates from that tree up, but here it's
.git/objects, not .git. That also seems to contract this above:

>       ensure its data is persisted. After all refs have been written,
>       the directories which host refs are flushed.

I.e. that would be .git/refs (let's ignore .git/HEAD and the like for
now), not .git/objects or .git?

And again, forging on but more generally [continued below]...

> +	if (!strcmp(var, "core.fsyncreffiles")) {

UX side: now we've got a core.fsyncRefFiles and
core.fsyncWhateverItWasCalled in Neeraj series. Let's make sure those
work together like say "fsck.*" and "fetch.fsck.*" do, i.e. you'd be
able to configure this once for objects and refs, or in two variables,
one for objects, one for refs...


> +static int sync_loose_ref(int fd)
> +{
> +	switch (fsync_ref_files) {
> +	case FSYNC_REF_FILES_OFF:
> +		return 0;
> +	case FSYNC_REF_FILES_ON:
> +		return git_fsync(fd, FSYNC_HARDWARE_FLUSH);
> +	case FSYNC_REF_FILES_BATCH:
> +		return git_fsync(fd, FSYNC_WRITEOUT_ONLY);
> +	default:
> +		BUG("invalid fsync mode %d", fsync_ref_files);
> +	}
> +}
> +
> +#define SYNC_LOOSE_REF_GITDIR    (1 << 0)
> +#define SYNC_LOOSE_REF_COMMONDIR (1 << 1)

nit: make this an enum and ...

> +static int sync_loose_refs_flags(const char *refname)
> +{
> +	switch (ref_type(refname)) {
> +	case REF_TYPE_PER_WORKTREE:
> +	case REF_TYPE_PSEUDOREF:
> +		return SYNC_LOOSE_REF_GITDIR;
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +	case REF_TYPE_NORMAL:
> +		return SYNC_LOOSE_REF_COMMONDIR;
> +	default:
> +		BUG("unknown ref type %d of ref %s",
> +		    ref_type(refname), refname);

... you won't need this default case...

> [...]
>  /*
>   * Emit a better error message than lockfile.c's
>   * unable_to_lock_message() would in case there is a D/F conflict with
> @@ -1502,6 +1553,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
>  	oidcpy(&lock->old_oid, &orig_oid);
>  
>  	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
> +	    sync_loose_refs(refs, sync_loose_refs_flags(newrefname), &err) ||
>  	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
>  		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
>  		strbuf_release(&err);
> @@ -1522,6 +1574,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
>  	flag = log_all_ref_updates;
>  	log_all_ref_updates = LOG_REFS_NONE;
>  	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
> +	    sync_loose_refs(refs, sync_loose_refs_flags(newrefname), &err) ||
>  	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
>  		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
>  		strbuf_release(&err);
> @@ -1781,6 +1834,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>  	fd = get_lock_file_fd(&lock->lk);
>  	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  	    write_in_full(fd, &term, 1) < 0 ||
> +	    sync_loose_ref(fd) < 0 ||
>  	    close_ref_gently(lock) < 0) {
>  		strbuf_addf(err,
>  			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
> @@ -2665,7 +2719,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		files_downcast(ref_store, REF_STORE_WRITE,
>  			       "ref_transaction_prepare");
>  	size_t i;
> -	int ret = 0;
> +	int ret = 0, sync_flags = 0;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
>  	char *head_ref = NULL;
>  	int head_type;
> @@ -2777,8 +2831,14 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  					&update->new_oid, NULL,
>  					NULL);
>  		}
> +
> +		sync_flags |= sync_loose_refs_flags(update->refname);
>  	}
>  
> +	ret = sync_loose_refs(refs, sync_flags, err);
> +	if (ret)
> +		goto cleanup;
> +
>  	if (packed_transaction) {
>  		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
>  			ret = TRANSACTION_GENERIC_ERROR;

...[continued from above]: Again, per my potentially wrong understanding
of syncing a "x" and "y" via an fsync of a subsequent "z" that's
adjacent on the FS to those two.

Isn't this setting us up for a really bad interaction between this
series and Neeraj's work? Well "bad" as in "bad for performance".

I.e. you'll turn on "use the batch thing for objects and refs" and we'll
do two fsyncs, one for the object update, and one for refs. The common
case is that we'll have both in play.

So shouldn't this go to a higher level for both so we only create a "z"
.git/sync-it-now-please.txt or whatever once we do all pending updates
on the .git/ directory?

I can also imagine that we'd want that at an even higher level, e.g. for
"git pull" surely we'd want it not for refs or objects, but in
builtin/pull.c somewhere because we'll be updating the .git/index after
we do both refs and objects, and you'd want to fsync at the very end,
no?

None of the above should mean we can't pursue a more narrow approach for
now. I'm just:

 1) Seeing if I understand what we're trying to do here, maybe not.

 2) Encouraging you two to think about a holistic way to configure some
    logical conclusion to this topic at large, so we won't end up with
    core.fsyncConfigFiles, core.fsyncObjectFiles, core.fsyncIndexFile,
    core.fsyncRefFiles, core.fsyncTheCrapRebaseWritesOutFiles etc. :)

I'll send another more generic follow-up E-Mail for #2.
