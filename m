Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDBBC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 18:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA490206C3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 18:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os/AjTC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgETSwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 14:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgETSwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 14:52:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55182C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 11:52:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so1993794pfw.13
        for <git@vger.kernel.org>; Wed, 20 May 2020 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pFj1izBOpy2lNNeFdz/gqcwm+QSMTxlb6phuEGxsA4Y=;
        b=os/AjTC4O9OFd6KQoAyqgFHneBcsJo6EjzOAD1fIxPWezLFOQ27BIcjmbiAmF2T/g5
         uKQSOdRJfsb8rfPtPuEnXu1MuiZTFbGxXQlEaXF5QcDRVLK3zYGKCNiYBvnhK2QLrSBF
         noOlE4W5gwM6ZWzj6uYxXpnH1cGmYmLgYQHr0OdgeRtkxfE6gKB/I808XdcAnoEzA+on
         7mjLyUWNs1PDr0vf/Mh62h7J43aywDkAcADw1Q7rTPU3B0ToNTWbUoHfoLU0H72nfIMw
         CEKQj7mme1eqis7+pNoTRaC5pGykMaxsjso1evjhjXa+2uNNLqW6A1Ywju8JZ6T/izL6
         k2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pFj1izBOpy2lNNeFdz/gqcwm+QSMTxlb6phuEGxsA4Y=;
        b=AaVOA6Ec4gFkoHQrx64xWWV3T6rtKm/AW6/cmP0DTqSWc7KogmcXP4D4SmfjTijEgK
         8VCK3C1qFlf5RmUtPdVutUh9EcbzpgmsLBPdfDc1O85nn1/KQUr8Qur4aN3QMqK9KPJY
         zJ5gDjNRWTKyJKmt4dIkt2rRS8QZaU5MkqOjPdLBDxWupclBH9tw6GvqMwiqXhCRM0oV
         YFC9yR2TDABQzWof0S+crhwMDH4kbwZKXdjujdE8aEqToHiwEuffYissRPWZE8mMOFfv
         lJL5f8jl92GXgYa/9W5/p34KbVYpRIX7YTXfdbdWzAEkIWJEZoTL8rsjn/HkMijF2pwL
         AZ+Q==
X-Gm-Message-State: AOAM530Tieqz6cFZ7fLX9NvbyzExzH10SWt4wzhRQSfCd9O7W16JxyX6
        T+olEtxF81oJk1TY7EhBuyA=
X-Google-Smtp-Source: ABdhPJyNOWNdCP5jO8LmDjcauNczKQOXLqa0+6T2w274YKSRQfxIVKXXgWhUMfgerVnPuFK42ry0aw==
X-Received: by 2002:a65:498f:: with SMTP id r15mr5331532pgs.345.1590000725580;
        Wed, 20 May 2020 11:52:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a85sm2685580pfd.181.2020.05.20.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:52:04 -0700 (PDT)
Date:   Wed, 20 May 2020 11:52:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
Message-ID: <20200520185202.GA3648@google.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
 <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
 <xmqqeerfzitt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqeerfzitt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Han-wen wrote:

>> From: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Shawn Pearce explains:
>>
>> Some repositories contain a lot of references (e.g. android at 866k,
>> rails at 31k). The reftable format provides:
>>
>> - Near constant time lookup for any single reference, even when the
>>   repository is cold and not in process or kernel cache.
>> - Near constant time verification a SHA-1 is referred to by at least
>>   one reference (for allow-tip-sha1-in-want).
>
> Not quite grammatical sentence?  Perhaps "if" after "verification?

Good catch, thanks.

[...]
>> using pandoc 2.2.1.  The result required the following additional
>> minor changes:
>>
>> - removed the [TOC] directive to add a table of contents, since
>>   asciidoc does not support it
>> - replaced git-scm.com/docs links with linkgit: directives that link
>>   to other pages within Git's documentation
>
> There are many
>
> 	’
>
> funny-quotes where we would prefer to place vanilla single quotes,
> which may also need to be corrected in the conversion toolchain.

Looks like Han-Wen is taking care of this (thanks!).

> Typoes pointed out below may probably be from the original where
> they should be corrected.

I'm happy to do one final update the doc in JGit to match what we end
up with and then replace it with a pointer to Git's copy once that
lands.

[...]
>> +Repositories with many loose references occupy a large number of disk
>> +blocks from the local file system, as each reference is its own file
>> +storing 41 bytes (and another file for the corresponding reflog). This
>> +negatively affects the number of inodes available when a large number of
>> +repositories are stored on the same filesystem. Readers can be penalized
>> +due to the larger number of syscalls required to traverse and read the
>> +`$GIT_DIR/refs` directory.
>
> Another downside is that we cannot arrange atomic updates to
> multiple refs over loose refs, even though the "lookup of a single
> reference does not require linear scan" unlike packed-refs, (as long
> as the filesystem does its job).  Worth mentioning?

Yes, this was another major part of the motivation (avoiding the
complication of the "atomic" multi-ref updates to packed-refs that Git
and JGit had to learn).

[...]
>> +References stored in a reftable are peeled, a record for an annotated
>> +(or signed) tag records both the tag object, and the object it refers
>> +to.
>
> OK.  Peeled results are recorded in packed-refs file because quite
> often when we use a tag object, what we actually want to access is
> the commit object it points at.  We do so here for the same reason?
>
> Not a rhetorical question, but if it invites a question from a
> reader, it may deserve to be described before readers ask it.

For a single tag ref, peeling to a commit is not very expensive.  But
for batch lookups e.g. when serving a response to an ls-remote
request, it adds up, and having the peeled results recorded helps.

[...]
>> +Directory/file conflicts
>> +^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The reftable format accepts both `refs/heads/foo` and
>> +`refs/heads/foo/bar` as distinct references.
>> +
>> +This property is useful for retaining log records in reftable, but may
>> +confuse versions of Git using `$GIT_DIR/refs` directory tree to maintain
>> +references. Users of reftable may choose to continue to reject `foo` and
>> +`foo/bar` type conflicts to prevent problems for peers.
[...]
> "users ... may choose" implies that it is up to the implementation
> of reftable user which one to show, so given a single repository,
> "jgit" may show "refs/heads/foo" while "libgit2" may choose to show
> the other one.
>
> I am not sure if that is desirable---I suspect that we want to
> record which one needs to be chosen so that these "D/F conflicts
> disallowing" users can make consistent choices, but I dunno.

Yes, I think it would be better to explicitly say that Git will continue
to reject D/F conflicts for refs (*not* reflogs) even though the format
can support them in principle.

If we choose to permit them some day in the future, I believe that would
be a separate repository format extension and protocol capability to
avoid confusing old versions of Git.

[...]
>> +Symbolic references use `0x3`, followed by the complete name of the
>> +reference target. No compression is applied to the target name.
>
> Is there a place in the file format where an incomplete name can be
> stored?  If not, I think it makes it easier to read if we drop
> "complete" from the sentence.

The sentence about "no compression" covers the lack of prefix encoding,
so I suppose I agree.

Might make sense to say "full name" to convey that we're talking about
rev-parse --symbolic-full-name, not a relative path like symlinks
support.

[...]
>> +Log block format
>> +^^^^^^^^^^^^^^^^
>> +
>> +Unlike ref and obj blocks, log blocks are always unaligned.
>> +
>> +Log blocks are variable in size, and do not match the `block_size`
>> +specified in the file header or footer. Writers should choose an
>> +appropriate buffer size to prepare a log block for deflation, such as
>> +`2 * block_size`.
>
> I can guess the reason behind this design decision, but the readers
> may not be able to.  Should we write it down here, or would it make
> too much irrelevant details?

I don't have a strong opinion.  It sounds like Han-Wen sees something to
explain there, so I suppose it would be nice to spell out.

(My take: reflog lookups are not on the critical path for most
operations; especially, random accesses do not need to be fast.  From a
performance perspective, the best we can do is to compress them well to
decrease I/O cost, hence there's not much value to alignment.)

[...]
> This is a tangent but in a repository at hosting provider, whose
> primary (and often the only) source of updates are by end-user
> pushing into it, if reflogs are enabled, whose name and email are
> recorded in the logs?  The committer or tagger of the object that
> sits at the tip of the ref after the update?  What happens when a
> blob is pushed to update a ref?  Or would it be just a single "user"
> that represents the "server operator"?

The latter, "server operator" (GIT_COMMITTER_IDENT at the server).

Committer in commit objects is forgeable, hence wouldn't be very
useful here.

> We know in a non-bare repository an individual contributor works on
> typically records only one <name, email> in the reflog: the user who
> works in it.
>
> What I am trying to get at is if it makes more sense to have a small
> table of unique <name, email> pairs used in the file and have
> log_data record a single varint that is the index into that
> "committer ident" table.  I would suspect that it would give us
> significantly more gain than mere <> two bytes per log_data entry.

That's true, and a good idea for the next rev of the format.

[...]
>> +A 68-byte footer appears at the end:
>> +
>> +....
>> +    'REFT'
>> +    uint8( version_number = 1 )
>> +    uint24( block_size )
>> +    uint64( min_update_index )
>> +    uint64( max_update_index )
>> +
>> +    uint64( ref_index_position )
>> +    uint64( (obj_position << 5) | obj_id_len )
[...]
>> +* `obj_id_len`: number of bytes used to abbreviate object identifiers in
>> +obj blocks.
>
> Should we write "this can be up to 31" somewhere?  It is more than
> enough for SHA-1 and not quite sufficient for SHA-256 (unless we say
> "we store obj_id_len-1 here")?

Oh!  I'll take a closer look and then follow up.

Thanks for looking it over,
Jonathan
