Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B8C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiCKJnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiCKJnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:43:02 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178EB1BE132
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:41:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so17857187ejc.7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PkyJCxPEGORypT5B3e+yNyPNJDypl88iF5acYfUpMlM=;
        b=aPr1++6jIQF8FLXkZTp79VrQbEk7g8ctVXqiZIB/fSzffLyKrdxAtSXdbw5x3tp3/3
         cD8HaX1RNW/zF28ubDGSJWBvQj+A+TehncPZ6gMzG5E6qJXYTRVpsFdc5buvwPlcZK3c
         7N1x7p1m3X71Nbzl90sqHBCeLq80wSBvUNrKokW0K9BhSnSYgU/3r/5IMSI1zOc0v7F9
         Mjp+XCHYyjAmvNUY2Ge6Sf7Yb22todSw5mkfB5VitYGmBqQrMZuDHzkanWivZzBbPUZF
         nhBUXf+wiwA3/G01I6+E9qfnmH+V1lwp8/l+Of0oxb2iimImmaifABoTyShkgCSb5Gpj
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PkyJCxPEGORypT5B3e+yNyPNJDypl88iF5acYfUpMlM=;
        b=APghKbZ5bIPmZZEcFsbTzoYWC8GN9rU4PiSIRqCzX3SOvLX56PT0D274KFw+HnzPa6
         w4LqKesZHsWyGn2ToMisjoiTBlFyC/jJcCokbRBS6Nvo+VJBFMUSjAKBBWwNmpgdrbtM
         KhFSSUPqm3B0SLWLUOWXHoQXcxrn1Wdr86mzArWJ0hEGGac1qP5HF+PsnKdkfu2xD+m4
         SBmJVtlSC6aYKOWLFDpmeoYC1aGqNQYhj81tYbgCC9OwFc+J2pC4GanP2oHBS4tIjhZe
         Du6CE6LU7V+8sCfQOlj7qEllKv4wew/+sCivTQSO13yQLnxXkeCo5XMgQGgTu6SLf6w6
         k5cg==
X-Gm-Message-State: AOAM5314wDbRPNHhl965gSI4yjTWEMnrU609lktxLRzEmTpJwagc7uC4
        tWoL2tG+vsdppAy02D/BBrM=
X-Google-Smtp-Source: ABdhPJwnrNAro0kbyx7d6R/QPaJPYlQELI1qqwjXtYJs1LAtQXQhHMGzGXlQ02ydMNDvCDMFADrvog==
X-Received: by 2002:a17:907:948b:b0:6d8:27f8:ab4a with SMTP id dm11-20020a170907948b00b006d827f8ab4amr7679367ejc.39.1646991717508;
        Fri, 11 Mar 2022 01:41:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cc21-20020a0564021b9500b00403bc1dfd5csm3131609edb.85.2022.03.11.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:41:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSbmW-000xJb-FZ;
        Fri, 11 Mar 2022 10:41:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        nksingh85@gmail.com, sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 7/8] core.fsync: new option to harden loose references
Date:   Fri, 11 Mar 2022 10:36:26 +0100
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
 <xmqqzglx9em0.fsf@gitster.g> <YisTPSOqKkQQ1RbQ@ncase>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YisTPSOqKkQQ1RbQ@ncase>
Message-ID: <220311.86y21ghlln.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Thu, Mar 10, 2022 at 10:40:07PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > @@ -1504,6 +1513,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
>> >  	oidcpy(&lock->old_oid, &orig_oid);
>> >  
>> >  	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
>> > +	    files_sync_loose_ref(lock, &err) ||
>> >  	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
>> >  		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
>> >  		strbuf_release(&err);
>> 
>> Given that write_ref_to_lockfile() on the success code path does this:
>> 
>> 	fd = get_lock_file_fd(&lock->lk);
>> 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>> 	    write_in_full(fd, &term, 1) < 0 ||
>> 	    close_ref_gently(lock) < 0) {
>> 		strbuf_addf(err,
>> 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
>> 		unlock_ref(lock);
>> 		return -1;
>> 	}
>> 	return 0;
>> 
>> the above unfortunately does not work.  By the time the new call to
>> files_sync_loose_ref() is made, lock->fd is closed by the call to
>> close_lock_file_gently() made in close_ref_gently(), and because of
>> that, you'll get an error like this:
>> 
>>     Writing objects: 100% (3/3), 279 bytes | 279.00 KiB/s, done.
>>     Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>>     remote: error: could not sync loose ref 'refs/heads/client_branch':
>>     Bad file descriptor     
>> 
>> when running "make test" (the above is from t5702 but I wouldn't be
>> surprised if this broke ALL ref updates).
>> 
>> Just before write_ref_to_lockfile() calls close_ref_gently() would
>> be a good place to make the fsync_loose_ref() call, perhaps?
>> 
>> 
>> Thanks.
>
> Yeah, that thought indeed occurred to me this night, too. I was hoping
> that I could fix this before anybody noticed ;)
>
> It's a bit unfortunate that we can't just defer this to a later place to
> hopefully implement this more efficiently, but so be it. The alternative
> would be to re-open all locked loose refs and then sync them to disk,
> but this would likely be a lot more painful than just syncing them to
> disk before closing it.

Aside: is open/write/close followed by open/fsync/close on the same file
portably guaranteed to yield the same end result as a single
open/write/fsync/close?

I think in practice nobody would be insane enough to implement a system
to do otherwise, but on the other hand I've seen some really insane
behavior :)

I could see it being different e.g. in some NFS cases/configurations
where the fsync() for an open FD syncs to the remote storage, and the
second open() might therefore get the old version and noop-sync that.

Most implementations would guard against that in the common case by
having a local cache of outstanding data to flush, but if you're talking
to some sharded storage array for each request...

Anyway, I *think* it should be OK, just an aside to check the assumption
for any future work... :)
