Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A9C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA692072A
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwQPSejc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAFXr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:47:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgAFXr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:47:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so27575187pgl.11
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqsZyVlKGKu8d8cudu0sg4imrmeu5BoaTe1fDQsfmto=;
        b=qwQPSejcnsiVenBQvpl8Rl/3w+tfxWqeHoQ6A7sSIaQ9E5sPxuvQGOKigMxb2X8i9n
         UyTQrwj3jmTmX5HDw2IyJkjRtOOadrkfKNzb7A9yUpedZghn9R6o20q3wgdWKAut1Let
         fyOfSaJ3JAE4YEAc0e/fwhVfk5jiztkMCqLJPKPlYqm0azquOgJTaD0mcPz1/+M+YnJn
         BFn6ENbXnXoaXdVxlewjdceEkTuTRV4Vu7vdezSRvc4pjOly3uM3AC1ODgBWXJDEojZx
         sHhNdhy7r0QoqgHkcEmPCBVJk9KApTPEEUnsASyqzznBmSNh0lpIecS6U1ctNQww9Fe6
         mevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqsZyVlKGKu8d8cudu0sg4imrmeu5BoaTe1fDQsfmto=;
        b=ah8n7R1N4z+DEkBHAoO+3mROwRQS7Vki3sugFUFv8vpM02C/ZKK9pQVbkS3K/Q0fah
         AlF7kA3oT65sAV0uMAdu9Nr0F/9a4cAQWVDv8O9BJqBV/362wrw4y07F08IdSEsJuIds
         ZLAHf3MPMz6HfjTEhwHm5KHqQmRkcmJPYnEpGMFc5JIYpNdSvTJyWFMmONpVQgzoUhqz
         EIdYHqnN5IZ4ppKJMSUrhdADwEFNYnkpLuZNdIuhFjNAvFFNfEdDaooRn9cqnHyQn6a8
         RPFh8UltNgYtFPdbDsWos50K2YduJbO1RMtv8iZe3FigNZrjUe6PXjnpZcTq4Lx/RP+8
         To4w==
X-Gm-Message-State: APjAAAXx1z9nTRucgGfaFY8bR6SDYmK8dHl9br4KjlizDauiwU+dcsKj
        djpeW3YJhx9FdxPo3MfH4DM=
X-Google-Smtp-Source: APXvYqxmmhtdyI+39cTKz4DRWRU1afGusD40Ls7S8SO/MOdVNwF1qwmXqRlEa7tCmlfJARzDyy+ehA==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr114989053pfi.10.1578354476175;
        Mon, 06 Jan 2020 15:47:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b22sm25644484pjb.4.2020.01.06.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:47:55 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:47:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20200106234753.GB92456@google.com>
References: <20191230211027.37002-1-jonathantanmy@google.com>
 <20200102201630.180969-1-jonathantanmy@google.com>
 <20200104001331.GA130883@google.com>
 <20200106211730.GB980197@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106211730.GB980197@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Jan 03, 2020 at 04:13:31PM -0800, Jonathan Nieder wrote:

>> To follow up on Junio's hint in his review: callers can inject
>> additional cached objects by using pretend_object_file.  Junio
>> described how this would make sense as a mechanism for building
>> the virtual ancestor object, but we don't do that.  In fact, the
>> only caller is fake_working_tree_commit in "git blame", a read-only
>> code path. *phew*
>>
>> -- >8 --
>> Subject: sha1-file: document how to use pretend_object_file
>> [...]
>> +/*
>> + * Add an object file to the in-memory object store, without writing it
>> + * to disk.
>> + *
>> + * Callers are responsible for calling write_object_file to record the
>> + * object in persistent storage before writing any other new objects
>> + * that reference it.
>> + */
>>  int pretend_object_file(void *, unsigned long, enum object_type,
>>  			struct object_id *oid);
>
> I think this is an improvement over the status quo, but it's still a
> potential trap for code which happens to run in the same process (see my
> other email in the thread).
>
> Should the message perhaps be even more scary?

A pet peeve of mine is warning volume escalation: if it becomes common
for us to say

 * Warning: callers are reponsible for [...]

then new warnings trying to stand out might say

 * WARNING: callers are responsible for [...]

and then after we are desensitized to that, we may switch to

 * WARNING WARNING WARNING, not the usual blah-blah: callers are

and so on.  The main way I have found to counteract that is to make
the "dangerous curve" markers context-specific enough that people
don't learn to ignore them.  After all, sometimes a concurrency
warning is important to me, at other times warnings about clarity may
be what attract my interest, and so on.

I don't have a good suggestion here.  Perhaps "Callers are responsible
for" is too slow and something more terse would help?

 /*
  * Adds an object to the in-memory object store, without writing it
  * to disk.
  *
  * Use with caution!  Unless you call write_object_file to record the
  * in-memory object to persistent storage, any other new objects that
  * reference it will point to a missing (in memory only) object,
  * resulting in a corrupt repository.
  */

It would be even better if we have some automated way to catch this
kind of issue.  Should tests run "git fsck" after each test?  Should
write_object_file have a paranoid mode that checks integrity?

I don't know an efficient way to do that.  Ultimately I am comfortable
counting on reviewers to be aware of this kind of pitfall.  While
nonlocal invariants are always hard to maintain, this pitfall is
inherent in the semantics of the function, so I am not too worried
that reviewers will overlook it.

A less error-prone interface would tie the result of
pretend_object_file to a short-lived overlay on the_repository without
affecting global state.  We could even enforce read-only access in
that overlay.  I don't think the "struct repository" interface and
callers are ready for that yet, though.

Thanks,
Jonathan
