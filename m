Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC812027C
	for <e@80x24.org>; Sun, 16 Jul 2017 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdGPToW (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 15:44:22 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33579 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdGPToU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 15:44:20 -0400
Received: by mail-ua0-f172.google.com with SMTP id b64so5429602uab.0
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 12:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IJCEjzKhdbZpHuWuzjVX7+0Ewv/pAriBkQfY/aowYVs=;
        b=CBQTZ8yNsn4LLoEXWb7lp+AiSBFhMKTV2WNWykMeH4soi2iFMO1fvrDZ6AHd8g8ApJ
         j6HvU8aSQD0FohToCQcQWj8EJiGJLT4igymt+4In4cRgX5onKljlUqz7BsrqM9wV3ZEm
         huLeWIbdGyvQgGMp1S25NlwNUWxVlo8zWiUyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IJCEjzKhdbZpHuWuzjVX7+0Ewv/pAriBkQfY/aowYVs=;
        b=sqfYaOtEpatPZY7XfnG/5u/0rEqw+D2Opu1wvOOEZ01lIx9Fz8UnfJrpqgHmErJ0Us
         1FSZ3GBRonic42A8dvtV1vqoLcR5WwyvJquNI1kXvgZDW6xaDtQRa0/lRnPbaa0rMYth
         anXYgXvWz3JSQQwi5cGCGAuXSt5mNuKS2wSPJWNwdB9E+xWJV5znMTujaGYN6rXGgpg9
         QRCHZSvWnJDMGQaykOut+XXGBg4/wnHSBkDhGFskvotchcLJNGP0A6L+nMHmMmc3yulv
         T/lYcO0c1V1rSDrts5wgH9sCRb+GPbPDZ9X3T83eP5QEsHwuV9iASxG+GmHWbYuxqUp8
         5oZQ==
X-Gm-Message-State: AIVw113f0EbTiRtFrWs21uIautANDmFPmmNZ2AANbt5btw1sronS4dWG
        UkqU7TdcoqJ6E62rt0jLAbhvSiG7uaQT
X-Received: by 10.176.18.71 with SMTP id s7mr5654883uac.127.1500234259690;
 Sun, 16 Jul 2017 12:44:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 16 Jul 2017 12:43:59 -0700 (PDT)
In-Reply-To: <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 16 Jul 2017 12:43:59 -0700
Message-ID: <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 10:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Thanks for your reftable proposal.

Thanks for your time reading the proposal. I really was looking
forward to your insights on this project.

> It would solve a lot of scalability
> problems that we currently have, and do it in a way that is
> implementable in both C and Java, which is very nice.
>
> There are two mostly orthogonal components to your proposal:
>
> 1. What does a single reftable file look like?
> 2. How can multiple reftable files be used together to avoid having to
> rewrite data more than necessary?
>
> For example (just for the sake of argument), many of the goals could
> be achieved by stacking traditional packed-refs files together (i.e.,
> component 2 of your proposal),

Agreed. I actually started from stacked packed-refs as the format
proposal and iterated on that several times before starting to draft
reftable. I like that packed-refs is already a format, and its human
readable. It unfortunately still didn't solve enough other objectives,
which led me towards reftable.


> * Do you propose to store *all* references (i.e., including the
> references that we call pseudorefs, like `HEAD`, `FETCH_HEAD`, etc) in
> reftables, or only the references under `refs/`? If the former, then
> you need to consider that some pseudorefs contain additional
> information besides the SHA-1 or linked-to reference. If the latter,
> then you could get some additional compression by making the `refs/`
> prefix implicit rather than storing it in the "restart" records
> explicitly.

Great question I didn't have an answer for. I was planning to store
HEAD, but not FETCH_HEAD/MERGE_HEAD/etc. Mostly because our storage
system at $DAY_JOB doesn't have a place to store HEAD itself, its
buried down in the reference system. So reftable has to do the job.

The file format for reftable describes a type 0x3 which is just a
length delimited byte string. Provided that the data fits into a
single block, reftable can store these larger files with their
auxiliary data.

I'm open to the idea of HEAD and friends being outside of reftable in
a git-core accessed repository, but the backend storage I want to run
reftable on would likely need to store HEAD inside reftable.


>   Personally, I don't think it makes sense to store pseudorefs in
> reftables. HEAD, though it doesn't include any supplemental
> information, is read so frequently that it seems like a bad idea to
> have to go through the lookup process rather than storing it in a
> separate flat file. Moreover, HEAD is written very *infrequently*, so
> (absent special treatment) it would tend to sink deep in the reftable
> stack, making reads even more expensive.

That is a very fair argument for keeping HEAD outside.

A counter argument is HEAD is written very frequently by following its
indirect pointer to the branch (e.g. refs/heads/master). HEAD is
consequently reflogged very frequently. reftable stores the logs
inside the table shards. HEAD could be floated onto the top on every
write to accompany its log record.


> * You have obviously designed your proposal to be friendly to whatever
> non-local storage system you are using at Google. It would probably
> help us understand your design tradeoffs better if you could tell us a
> little about that storage system.

Remote network attached disk. Random 64k seeks are O(40ms).
Smaller seeks cost about the same as 64k.
Larger seeks start to see the block size increase latency.

Caching is the responsibility of the application (e.g. JGit).

Tail-block packing is available for small files (ResierFS-ish, but its
not ResierFS). A 4k minimum file size occupies the entire 4k, and has
to transfer between the CPU and the disk. A 300 byte file occupies 300
bytes. To the extent the file scales down with its content, the better
(for this system).


> So let's examine the components one after the other...
>
> 1. The structure of a single reftable file
>
> * You use int32 and int24 values in a number of places. Couldn't these
> be uint32 and uint24?

Yes. I'll clarify that in the document.


> * You use int32 values in a number of places where a smaller size
> would suffice. For example, the block size is limited to 24 bits, so
> surely restart_offset, record_end_offset, and number_of_restarts
> needn't be larger than 24 bits?
>
>    OK, actually the *index* block size is not limited to 24 bits, so
> it's not a no-brainer.

Right, its the index block that really pushes the restart_offsets to
32 bits. And I wanted to leverage code between the multiple block
formats as much as possible, as the structure is similar.


> * I'm a little bit concerned that the structure is fixed to be a one-
> or two-level indexing scheme; i.e., the (optional) index block plus
> the restart index table within a block. This forces (as I understand
> it) the block size to be chosen based on the overall file size to
> prevent the index block from becoming too large, whereas for a
> low-latency local filesystem implementation like SSDs it would
> probably be preferable to set the block size to agree with the page
> size to minimize reads and memory usage.

True... but... in my "android" example repository we have 866,456 live
refs. A block size of 64k needs only 443 blocks, and a 12k index, to
get the file to compress to 28M (vs. 62M packed-refs).

Index records are averaging 28 bytes per block. That gives us room for
about 1955 blocks, or 4,574,700 refs before the index block exceeds
64k.

In other words, I'm happy with this. Given my storage is network
attached, by the time I bring in 4k I might as well bring in 64k.
Given that a 64k index lets refs grow 5.2x before I start to see
longer read times to load the index, I'm OK with that.

If you are assuming local attached SSD with a quality kernel (Linux),
I think you can mmap the reftable, and basically nearly about IO
costs. reftable is still more disk friendly for random seeks than pack
idx v2, or v2.


>   So I ask myself whether it might be worthwhile to allow deeper
> levels of indexing. The main index block could divide the namespace
> into as many segments as fit in one block, but if necessary point at a
> second-level index block that further divides the namespace before
> pointing at the ref block that ultimately contains the value. Those of
> us using local SSDs might tune the system to use 4k block sizes
> throughout, basically preferring to read three or even four disjoint
> 4k blocks rather than two disjoint 64k blocks.

I did consider this, and discarded it as unnecessary complexity. See
some of my discussion above. Nobody is complaining about pack idx
v1/v2 lookup speeds right now, and they are worse to disks.


> * The tuning parameter number_of_restarts currently trades off space
> (for the full refnames and the restart_offsets) against the need to
> read and parse more ref_records to get the full refnames. ISTM that
> this tradeoff could be made less painful by defining a blockwide
> prefix that is omitted from the refnames as used in the restarts. So
> the full refname would change from
>
>       this_name = prior_name[0..prefix_length] + suffix
>
>   to
>
>       this_name = block_prefix + prior_name[0..prefix_length] + suffix
>
>   I would expect this to allow more frequent restarts at lower space
> cost.

I've been on the fence about the value of this. It makes the search
with restarts more difficult to implement, but does allow shrinking a
handful of very popular prefixes like "refs/" and "refs/pulls/" in
some blocks.

An older format of reftable used only a block_prefix, and could not
get nearly as good compression as too many blocks contained references
with different prefixes.


>   If we are willing to force all reads to consider the indexes, the
> block_prefix could be taken from the index_record that points at it.

No, its important to be able to scan the file sequentially without
touching the index. Ref advertisement for the current wire protocol
demands all references. Being able to scan from the start of the file
to the end of the last ref block and more-or-less just dump those to
the client is a really nice gain.

Having to load the index first to walk the blocks in order and
assemble them with data from the index detracts from the simplicity of
just walking the ref blocks.


> * Does the format need to insist on fixed-size blocks?

Unfortunately, yes. For my network storage to perform efficient random
access to data, I need the block sizes fixed. I'm willing to trade off
inefficient torn block reads for the index and the log blocks/index,
but not the ref blocks.


> * What is the rationale for the footer? Is it important for the file
> to be written as a stream, as opposed to seeking back to the beginning
> of the file to add the index_size there?

Yes, my storage doesn't allow me to overwrite a prior section. Its
write-once. So I can't patch this data into the header.

> The CRC, I suppose, is meant
> to make it possible to detect a file that has been truncated
> accidentally?

Correct, or that the file footer is somehow otherwise damaged, or that
the file was accidentally appended to and now the footer location no
longer contains footer bits.


> 2. The stacking of multiple reftable files together
>
> * I like the ideas later in the thread to have a file of pointers to
> the files that make up the stack. (I think of it as a "table of
> contents"). I think without it there will be unavoidable races
> involving readdir().

I do too. Its a fantastic idea I am going to steal from Peff and work
into this document and implementation.


> * The spec should describe the protocol for reading references. The
> only interesting thing here is that
>
> * I think that geometric repacking of reftable files will be essential
> to performance for very active repositories with many references, and
> that the steady state of such a repository will involve O(lg N)
> retable files.
>
> * I would like to propose adding another design goal: that reference
> repacking can be done without blocking other *writers* (let alone
> readers, obviously). I think that something like this could work:
[...]
>   I think that this algorithm would allow reference updates to
> continue while the repack is happening, and would even allow reftables
> higher or lower in the stack than B and C to be repacked at the same
> time (though maybe that won't be necessary).

I agree, this is clever. I'll work that into the document. Thank you.


> * A very frequent operation will be to read a single reference. This
> could get expensive if a reftable stack grows deep, because every
> single reftable might have to be inspected. One way to reduce this
> cost might be to store a bloom filter in large reftable files. This
> could allow a quick determination that the file doesn't contain the
> reference being sought.

Yes, of course. But I'm torn on that premise. My gut theory says most
references that are read individually were/are recently modified. Thus
they should be higher in the reftable stack, and a reader will
terminate with its result. Its only the not-founds that will have a
penalty of reaching the base of the stack.

I'd also really like to see repositories holding stacks <4 deep, not
32 deep. If we can get the compaction working well, we should be able
to see most repositories with 1 large base file, 1 medium-ish
compaction, 2 recent updates.

At $DAY_JOB we can do this successfully with pack files, which are
larger and more costly to combine than reftable. I think we can get
reftable to do support a reasonable stack depth.


> I haven't reviewed your proposal for storing reflogs in reftables in
> any detail, though I must say that my first reaction is surprise that
> you want to store reflogs (which are mostly immutable, rarely read,
> and can be an order of magnitude bigger) in the same files as
> references.

reftable compressed 87,393 references into 3M, and a year's worth of
their log updates into another 4M. Keeping them together actually
simplifies a lot of nasty corner cases in Git.

D/F conflicts ("refs/heads/foo", "refs/heads/foo/bar") go away, but
assuming we continue to reject these to protect existing clients, we
can also still retain logs for deleted names that were cleared out.

Logs can be written in the same atomic filesystem operation as the
refs are mutated, avoiding any skew about the log being dropped or
logged early. Logs are now searchable in reverse time order, which
accelerates log queries.

I really think its worth storing the logs inside the reftable. I'm
pretty sold on that part of the design at this point. There are many
advantages, and I've been able to sufficiently push off the downsides
by storing the logs in a separate region of the reftable.
