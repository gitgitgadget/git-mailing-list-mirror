Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40BDC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDF2205CB
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ucTEztZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgESWA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 18:00:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56617 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgESWA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 18:00:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 357CCCAB7F;
        Tue, 19 May 2020 18:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8HsjBDLExMkr
        MFobOeY6CXdgZQo=; b=ucTEztZWsMlvpkgKy+lcoEsEAZbgOp8vHk+u7u6ANtlG
        keLBGvzKkG4Ihyaw/qfexHknaGsDtlqVshRY+P8pkDIwgnnLN0Hv+DUOwuzlFGit
        79zA3+jsAe9LkQyrE69Z3T+YjXDY89GyJMiJZWSqA3YNqapIGR0FzgzJ3MnIExo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZHc4Wp
        aXjqyoMO+xQuNNlV6TD4rzDTpGZ/6DZJKS1r/wsv+yqMirWSI/8n8iaOhuRGI1a/
        ChnHILwDhLyS0huX2UMLFCajcHug7vsaZSvLjamM77nNKQVhHw3nTSaxK9kc/vlj
        l3HYqUTzDxRu2GQ5+UXDhsDlV7dzuWbxDS+2c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AE1CCAB7E;
        Tue, 19 May 2020 18:00:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 492EECAB7D;
        Tue, 19 May 2020 18:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jonathan Nieder via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
Date:   Tue, 19 May 2020 15:00:14 -0700
In-Reply-To: <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
        (Jonathan Nieder via GitGitGadget's message of "Mon, 11 May 2020
        19:46:19 +0000")
Message-ID: <xmqqeerfzitt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F4D83FE-9A1C-11EA-AAE8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jonathan Nieder via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jonathan Nieder <jrnieder@gmail.com>
>
> Shawn Pearce explains:
>
> Some repositories contain a lot of references (e.g. android at 866k,
> rails at 31k). The reftable format provides:
>
> - Near constant time lookup for any single reference, even when the
>   repository is cold and not in process or kernel cache.
> - Near constant time verification a SHA-1 is referred to by at least
>   one reference (for allow-tip-sha1-in-want).

Not quite grammatical sentence?  Perhaps "if" after "verification?

> - Efficient lookup of an entire namespace, such as `refs/tags/`.
> - Support atomic push `O(size_of_update)` operations.
> - Combine reflog storage with ref storage.
>
> This file format spec was originally written in July, 2017 by Shawn
> Pearce.  Some refinements since then were made by Shawn and by Han-Wen
> Nienhuys based on experiences implementing and experimenting with the
> format.  (All of this was in the context of our work at Google and
> Google is happy to contribute the result to the Git project.)
>
> Imported from JGit[1]'s current version (c217d33ff,
> "Documentation/technical/reftable: improve repo layout", 2020-02-04)
> of Documentation/technical/reftable.md and converted to asciidoc by
> running
>
>   pandoc -t asciidoc -f markdown reftable.md >reftable.txt
>
> using pandoc 2.2.1.  The result required the following additional
> minor changes:
>
> - removed the [TOC] directive to add a table of contents, since
>   asciidoc does not support it
> - replaced git-scm.com/docs links with linkgit: directives that link
>   to other pages within Git's documentation

There are many=20

	=E2=80=99

funny-quotes where we would prefer to place vanilla single quotes,
which may also need to be corrected in the conversion toolchain.

Typoes pointed out below may probably be from the original where
they should be corrected.

> diff --git a/Documentation/technical/reftable.txt b/Documentation/techn=
ical/reftable.txt
> new file mode 100644
> index 00000000000..8bad9ade256
> --- /dev/null
> +++ b/Documentation/technical/reftable.txt
> @@ -0,0 +1,1067 @@
> +reftable
> +--------
> +
> +Overview
> +~~~~~~~~
> +
> +Problem statement
> +^^^^^^^^^^^^^^^^^
> +
> +Some repositories contain a lot of references (e.g.=C2=A0android at 86=
6k,

Let's not use &nbsp; here after "e.g.".  I see a normal space after "e.g.=
"
a few lines below.

> +rails at 31k). The existing packed-refs format takes up a lot of space
> +(e.g. 62M), and does not scale with additional references. Lookup of a
> +single reference requires linearly scanning the file.
> +Atomic pushes modifying multiple references require copying the entire
> +packed-refs file, which can be a considerable amount of data moved
> +(e.g. 62M in, 62M out) for even small transactions (2 refs modified).
> +
> +Repositories with many loose references occupy a large number of disk
> +blocks from the local file system, as each reference is its own file
> +storing 41 bytes (and another file for the corresponding reflog). This
> +negatively affects the number of inodes available when a large number =
of
> +repositories are stored on the same filesystem. Readers can be penaliz=
ed
> +due to the larger number of syscalls required to traverse and read the
> +`$GIT_DIR/refs` directory.

Another downside is that we cannot arrange atomic updates to
multiple refs over loose refs, even though the "lookup of a single
reference does not require linear scan" unlike packed-refs, (as long
as the filesystem does its job).  Worth mentioning?

> +
> +Objectives
> +^^^^^^^^^^
> +
> +* Near constant time lookup for any single reference, even when the
> +repository is cold and not in process or kernel cache.
> +* Near constant time verification if a SHA-1 is referred to by at leas=
t
> +one reference (for allow-tip-sha1-in-want).
> +* Efficient lookup of an entire namespace, such as `refs/tags/`.

Does this "lookup" refer to "do we have anything in refs/tags/
hierarchy?" or "enumerate all refs under refs/tags/ hierarchy?"

If the latter, perhaps s/lookup of/iteration over/

> +* Support atomic push with `O(size_of_update)` operations.
> +* Combine reflog storage with ref storage for small transactions.
> +* Separate reflog storage for base refs and historical logs.

> +Details
> +~~~~~~~
> +
> +Peeling
> +^^^^^^^
> +
> +References stored in a reftable are peeled, a record for an annotated
> +(or signed) tag records both the tag object, and the object it refers
> +to.

OK.  Peeled results are recorded in packed-refs file because quite
often when we use a tag object, what we actually want to access is
the commit object it points at.  We do so here for the same reason?

Not a rhetorical question, but if it invites a question from a
reader, it may deserve to be described before readers ask it.

> +Reference name encoding
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Reference names are an uninterpreted sequence of bytes that must pass
> +linkgit:git-check-ref-format[1] as a valid reference name.

OK.  We want to be able to express any reference that we allow in
the current backends.

> +Key unicity
> +^^^^^^^^^^^
> +
> +Each entry must have a unique key; repeated keys are disallowed.
> +
> +Network byte order
> +^^^^^^^^^^^^^^^^^^
> +
> +All multi-byte, fixed width fields are in network byte order.
> +
> +Ordering
> +^^^^^^^^
> +
> +Blocks are lexicographically ordered by their first reference.

Key and Block are not explained until quite later, so these two
among the above three are "Huh?" to readers at this point during
their first read, but it probably cannot be helped.  Let's read on.

> +Directory/file conflicts
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The reftable format accepts both `refs/heads/foo` and
> +`refs/heads/foo/bar` as distinct references.
> +
> +This property is useful for retaining log records in reftable, but may
> +confuse versions of Git using `$GIT_DIR/refs` directory tree to mainta=
in
> +references. Users of reftable may choose to continue to reject `foo` a=
nd
> +`foo/bar` type conflicts to prevent problems for peers.

Here "users" refer to things like "git-core", "jgit", "libgit2", etc.?

Let's say we have these two "conflicting" branches and want to
interoperate with existing versions of Git (e.g. a "git ls-remote"
client requests us to show what we have).  We could either show
"refs/heads/foo" with its object name, or "refs/heads/foo/bar" with
its object name, but not both.

"users ... may choose" implies that it is up to the implementation
of reftable user which one to show, so given a single repository,
"jgit" may show "refs/heads/foo" while "libgit2" may choose to show
the other one.

I am not sure if that is desirable---I suspect that we want to
record which one needs to be chosen so that these "D/F conflicts
disallowing" users can make consistent choices, but I dunno.

> +Block size
> +^^^^^^^^^^
> +
> +The file=E2=80=99s block size is arbitrarily determined by the writer,=
 and does
> +not have to be a power of 2. The block size must be larger than the
> +longest reference name or log entry used in the repository, as
> +references cannot span blocks.
> +
> +Powers of two that are friendly to the virtual memory system or
> +filesystem (such as 4k or 8k) are recommended. Larger sizes (64k) can
> +yield better compression, with a possible increased cost incurred by
> +readers during access.
> +
> +The largest block size is `16777215` bytes (15.99 MiB).

The number being "(2**24) - 1" might be as significant as "15.99
MiB" to readers.  As we recommend, and the users would find it
natural, to use powers of two, the largest block size in practice
would be 8 MiB?

> +Ref block format
> +^^^^^^^^^^^^^^^^
> +
> +A ref block is written as:
> +
> +....
> +'r'
> +uint24( block_len )
> +ref_record+
> +uint24( restart_offset )+
> +uint16( restart_count )
> +
> +padding?
> +....
> +
> +Blocks begin with `block_type =3D 'r'` and a 3-byte `block_len` which
> +encodes the number of bytes in the block up to, but not including the
> +optional `padding`. This is always less than or equal to the file=E2=80=
=99s
> +block size. In the first ref block, `block_len` includes 24 bytes for
> +the file header.
> +
> +The 2-byte `restart_count` stores the number of entries in the
> +`restart_offset` list, which must not be empty. Readers can use
> +`restart_count` to binary search between restarts before starting a
> +linear scan.
> +
> +Exactly `restart_count` 3-byte `restart_offset` values precedes the
> +`restart_count`. Offsets are relative to the start of the block and
> +refer to the first byte of any `ref_record` whose name has not been
> +prefix compressed. Entries in the `restart_offset` list must be sorted=
,
> +ascending. Readers can start linear scans from any of these records.

So the algorithm to find a record in a single block would be

 - see how big the block_len is by reading the first four bytes;

 - look at the last 16-bit word to see how many restart_offset
   entries there are;

 - bisect using restart_offset array to see where to start a linear
   scan in the ref_record array

 - linear scan the range between two adjacent offsets in
   restart_offset array.

(this is a mental exercise to make sure the information given here
is sufficient, which I think it is).

> +A variable number of `ref_record` fill the middle of the block,
> +describing reference names and values. The format is described below.
> +
> +As the first ref block shares the first file block with the file heade=
r,
> +all `restart_offset` in the first block are relative to the start of t=
he
> +file (position 0), and include the file header. This forces the first
> +`restart_offset` to be `28`.

OK.

> +ref record
> +++++++++++
> +
> +A `ref_record` describes a single reference, storing both the name and
> +its value(s). Records are formatted as:
> +
> +....
> +varint( prefix_length )
> +varint( (suffix_length << 3) | value_type )
> +suffix
> +varint( update_index_delta )
> +value?
> +....
> +
> +The `prefix_length` field specifies how many leading bytes of the prio=
r
> +reference record=E2=80=99s name should be copied to obtain this refere=
nce=E2=80=99s
> +name. This must be 0 for the first reference in any block, and also mu=
st
> +be 0 for any `ref_record` whose offset is listed in the `restart_offse=
t`
> +table at the end of the block.

OK.  That's quite similar to how v4 index format shortens pathnames.
We have encode_varint() helper (in varint.c), that is used from the
index v4 code (in read-cache.c) and also untracked cache code (in
dir.c).

The OFS_DELTA codepaths, both for encoding (in packfile.c) and for
decoding (in builtin/pack-objects.c), uses the same algorithm but
open codes it without using helper functions from varint.c (could
this become leftoverbit?  I dunno).

The document clarifies that the chosen variant of varint
representation much later, but it may want to be moved up close to
where "we use network byte order" etc. are declared.

> +Recovering a reference name from any `ref_record` is a simple concat:
> +
> +....
> +this_name =3D prior_name[0..prefix_length] + suffix
> +....
> +
> +The `suffix_length` value provides the number of bytes available in
> +`suffix` to copy from `suffix` to complete the reference name.

It is interesting that suffix is *not* a simple NUL terminated
string.  This DOES allow a NUL byte in a refname, but because we
upfront declared that only the refnames allowed are the ones that
pass check-ref-format, that would not be an advantage the use of
varint to encode the suffix seeks.  Then what is it? =20

I guess the answer is that a lot of time, the suffix length is
shorter than 16 bytes (=3D 128/8), so we can store 3-bit value_type
for free in such a case.  Is that worth a mention?

> +The `update_index` that last modified the reference can be obtained by
> +adding `update_index_delta` to the `min_update_index` from the file
> +header: `min_update_index + update_index_delta`.

At this point, we can infer the following from we have learned so
far by reading the document:

 - there is a quantity called "update index" attached to each ref
   record;

 - each file knows the range of update indices used in it; and

 - when files are chained together, the range of update indices do
   not overlap---all indices in one file are strictly larger or
   smaller than those in another file.

But we haven't learned at all what "update index" is and how it is
used, which makes it a frustrating read.  We probably should give a
mention of what it is here (a brief description at the same level of
detail as say "monotonically increasing counter that is used as a
transaction id when any ref update is made"), even though we will go
into much deeper details in a later section.

> +The `value` follows. Its format is determined by `value_type`, one of
> +the following:
> +
> +* `0x0`: deletion; no value data (see transactions, below)
> +* `0x1`: one 20-byte object id; value of the ref
> +* `0x2`: two 20-byte object ids; value of the ref, peeled target
> +* `0x3`: symbolic reference: `varint( target_len ) target`

We probably should write these as "one (binary) object name", and
"two (binary) object names", without hardwiring the number of bytes
needed to represent an object name.

> +Symbolic references use `0x3`, followed by the complete name of the
> +reference target. No compression is applied to the target name.

Is there a place in the file format where an incomplete name can be
stored?  If not, I think it makes it easier to read if we drop
"complete" from the sentence.

> +Types `0x4..0x7` are reserved for future use.
> +
> +Ref index
> +^^^^^^^^^
> +
> +The ref index stores the name of the last reference from every ref blo=
ck
> +in the file, enabling reduced disk seeks for lookups. Any reference ca=
n
> +be found by searching the index, identifying the containing block, and
> +searching within that block.
> +
> +The index may be organized into a multi-level index, where the 1st lev=
el
> +index block points to additional ref index blocks (2nd level), which m=
ay
> +in turn point to either additional index blocks (e.g. 3rd level) or re=
f
> +blocks (leaf level). Disk reads required to access a ref go up with
> +higher index levels. Multi-level indexes may be required to ensure no
> +single index block exceeds the file format=E2=80=99s max block size of
> +`16777215` bytes (15.99 MiB). To acheive constant O(1) disk seeks for

achieve

> +lookups the index must be a single level, which is permitted to exceed
> +the file=E2=80=99s configured block size, but not the format=E2=80=99s=
 max block size of
> +15.99 MiB.


> +Obj block format
> +^^^^^^^^^^^^^^^^
> +
> +Object blocks are optional. Writers may choose to omit object blocks,
> +especially if readers will not use the SHA-1 to ref mapping.

"the object name to ref mapping".

> +Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to

Likewise.  "unique prefix of object names no less than 2 bytes" or
somesuch to futureproof "2-20 byte SHA-1".

> +ref blocks containing references pointing to that object directly, or =
as
> +the peeled value of an annotated tag. Like ref blocks, object blocks u=
se
> +the file=E2=80=99s standard block size. The abbrevation length is avai=
lable in

abbreviation

> +the footer as `obj_id_len`.
> +
> +To save space in small files, object blocks may be omitted if the ref
> +index is not present, as brute force search will only need to read a f=
ew
> +ref blocks. When missing, readers should brute force a linear search o=
f
> +all references to lookup by SHA-1.
> +
> +An object block is written as:
> +
> +....
> +'o'
> +uint24( block_len )
> +obj_record+
> +uint24( restart_offset )+
> +uint16( restart_count )
> +
> +padding?
> +....
> +
> +Fields are identical to ref block. Binary search using the restart tab=
le
> +works the same as in reference blocks.
> +
> +Because object identifiers are abbreviated by writers to the shortest
> +unique abbreviation within the reftable, obj key lengths are variable
> +between 2 and 20 bytes. Readers must compare only for common prefix

Futureproof "2 and 20" similarly.

> +match within an obj block or obj index.

> +Log block format
> +^^^^^^^^^^^^^^^^
> +
> +Unlike ref and obj blocks, log blocks are always unaligned.
> +
> +Log blocks are variable in size, and do not match the `block_size`
> +specified in the file header or footer. Writers should choose an
> +appropriate buffer size to prepare a log block for deflation, such as
> +`2 * block_size`.

I can guess the reason behind this design decision, but the readers
may not be able to.  Should we write it down here, or would it make
too much irrelevant details?

> +A log block is written as:
> +
> +....
> +'g'
> +uint24( block_len )
> +zlib_deflate {
> +  log_record+
> +  uint24( restart_offset )+
> +  uint16( restart_count )
> +}
> +....
> +
> +Log blocks look similar to ref blocks, except `block_type =3D 'g'`.
> +
> +The 4-byte block header is followed by the deflated block contents usi=
ng
> +zlib deflate. The `block_len` in the header is the inflated size
> +(including 4-byte block header), and should be used by readers to
> +preallocate the inflation output buffer. A log block=E2=80=99s `block_=
len` may
> +exceed the file=E2=80=99s block size.
> +
> +Offsets within the log block (e.g. `restart_offset`) still include the
> +4-byte header. Readers may prefer prefixing the inflation output buffe=
r
> +with the 4-byte header.
> +
> +Within the deflate container, a variable number of `log_record` descri=
be
> +reference changes. The log record format is described below. See ref
> +block format (above) for a description of `restart_offset` and
> +`restart_count`.
> +
> +Because log blocks have no alignment or padding between blocks, reader=
s
> +must keep track of the bytes consumed by the inflater to know where th=
e
> +next log block begins.
> +
> +log record
> +++++++++++
> +
> +Log record keys are structured as:
> +
> +....
> +ref_name '\0' reverse_int64( update_index )
> +....
> +
> +where `update_index` is the unique transaction identifier. The
> +`update_index` field must be unique within the scope of a `ref_name`.
> +See the update transactions section below for further details.
> +
> +The `reverse_int64` function inverses the value so lexographical

lexicographical

> +ordering the network byte order encoding sorts the more recent records
> +with higher `update_index` values first:
> +
> +....
> +reverse_int64(int64 t) {
> +  return 0xffffffffffffffff - t;
> +}
> +....

Rationale?  It may be to ease the iteration over reflog i.e. "log
-g" that wants to go from the youngest to older---isn't it worth
mentioning?

> +Log records have a similar starting structure to ref and index records=
,
> +utilizing the same prefix compression scheme applied to the log record
> +key described above.
> +
> +....
> +    varint( prefix_length )
> +    varint( (suffix_length << 3) | log_type )
> +    suffix
> +    log_data {
> +      old_id
> +      new_id
> +      varint( name_length    )  name
> +      varint( email_length   )  email
> +      varint( time_seconds )
> +      sint16( tz_offset )
> +      varint( message_length )  message
> +    }?
> +....
> +
> +Log record entries use `log_type` to indicate what follows:
> +
> +* `0x0`: deletion; no log data.
> +* `0x1`: standard git reflog data using `log_data` above.
> +
> +The `log_type =3D 0x0` is mostly useful for `git stash drop`, removing=
 an
> +entry from the reflog of `refs/stash` in a transaction file (below),
> +without needing to rewrite larger files. Readers reading a stack of
> +reflogs must treat this as a deletion.
> +
> +For `log_type =3D 0x1`, the `log_data` section follows
> +linkgit:git-update-ref[1] logging and includes:
> +
> +* two 20-byte SHA-1s (old id, new id)

"two (binary) object names (old name, new name)" for futureproof out
of SHA-1 world.

> +* varint string of committer=E2=80=99s name
> +* varint string of committer=E2=80=99s email
> +* varint time in seconds since epoch (Jan 1, 1970)
> +* 2-byte timezone offset in minutes (signed)

We use minus eight hundred for "GMT-0800" internally, but this would
use -480, which makes more sense ;-)

> +* varint string of message
> +
> +`tz_offset` is the absolute number of minutes from GMT the committer w=
as
> +at the time of the update. For example `GMT-0800` is encoded in reftab=
le
> +as `sint16(-480)` and `GMT+0230` is `sint16(150)`.
> +
> +The committer email does not contain `<` or `>`, it=E2=80=99s the valu=
e normally
> +found between the `<>` in a git commit object header.

Saving two precious bytes?

This is a tangent but in a repository at hosting provider, whose
primary (and often the only) source of updates are by end-user
pushing into it, if reflogs are enabled, whose name and email are
recorded in the logs?  The committer or tagger of the object that
sits at the tip of the ref after the update?  What happens when a
blob is pushed to update a ref?  Or would it be just a single "user"
that represents the "server operator"?

We know in a non-bare repository an individual contributor works on
typically records only one <name, email> in the reflog: the user who
works in it.

What I am trying to get at is if it makes more sense to have a small
table of unique <name, email> pairs used in the file and have
log_data record a single varint that is the index into that
"committer ident" table.  I would suspect that it would give us
significantly more gain than mere <> two bytes per log_data entry.

> +The `message_length` may be 0, in which case there was no message
> +supplied for the update.
> +
> +Contrary to traditional reflog (which is a file), renames are encoded =
as
> +a combination of ref deletion and ref creation.

Yay?  How does the deletion record look like?  The new object name
being 0*hashlength?  I didn't see it defined in the description (and
I am guessing that log_type of 0x0 is *NOT* used for that purpose).

So, NEEDSWORK: describe how "creation of a ref" and "deletion of a ref"
appears in a log as a log record entry.

> +Footer
> +^^^^^^
> +
> +After the last block of the file, a file footer is written. It begins
> +like the file header, but is extended with additional data.
> +
> +A 68-byte footer appears at the end:
> +
> +....
> +    'REFT'
> +    uint8( version_number =3D 1 )
> +    uint24( block_size )
> +    uint64( min_update_index )
> +    uint64( max_update_index )
> +
> +    uint64( ref_index_position )
> +    uint64( (obj_position << 5) | obj_id_len )
> +    uint64( obj_index_position )
> +
> +    uint64( log_position )
> +    uint64( log_index_position )
> +
> +    uint32( CRC-32 of above )
> +....
> +
> +If a section is missing (e.g. ref index) the corresponding position
> +field (e.g. `ref_index_position`) will be 0.
> +
> +* `obj_position`: byte position for the first obj block.
> +* `obj_id_len`: number of bytes used to abbreviate object identifiers =
in
> +obj blocks.

Should we write "this can be up to 31" somewhere?  It is more than
enough for SHA-1 and not quite sufficient for SHA-256 (unless we say
"we store obj_id_len-1 here")?

> +* `log_position`: byte position for the first log block.
> +* `ref_index_position`: byte position for the start of the ref index.
> +* `obj_index_position`: byte position for the start of the obj index.
> +* `log_index_position`: byte position for the start of the log index.


> +Varint encoding
> +^^^^^^^^^^^^^^^
> +
> +Varint encoding is identical to the ofs-delta encoding method used
> +within pack files.
> +
> +Decoder works such as:
> +
> +....
> +val =3D buf[ptr] & 0x7f
> +while (buf[ptr] & 0x80) {
> +  ptr++
> +  val =3D ((val + 1) << 7) | (buf[ptr] & 0x7f)
> +}
> +....

As already said, I think this should be given upfront next to where
we declare that we use network byte order.

> +Restart point selection
> ++++++++++++++++++++++++
> +
> +Writers determine the restart points at file creation. The process is
> +arbitrary, but every 16 or 64 records is recommended. Every 16 may be
> +more suitable for smaller block sizes (4k or 8k), every 64 for larger
> +block sizes (64k).
> +
> +More frequent restart points reduces prefix compression and increases
> +space consumed by the restart table, both of which increase file size.
> +
> +Less frequent restart points makes prefix compression more effective,
> +decreasing overall file size, with increased penalities for readers

penalties

> +walking through more records after the binary search step.
> +
> +A maximum of `65535` restart points per block is supported.


> +LMDB
> +^^^^
> +
> +David Turner proposed
> +https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturne=
r@twopensource.com/[using
> +LMDB], as LMDB is lightweight (64k of runtime code) and GPL-compatible
> +license.
> +
> +A downside of LMDB is its reliance on a single C implementation. This
> +makes embedding inside JGit (a popular reimplemenation of Git)

reimplementation

> +difficult, and hoisting onto virtual storage (for JGit DFS) virtually
> +impossible.
> +
> +A common format that can be supported by all major Git implementations
> +(git-core, JGit, libgit2) is strongly preferred.
> +
> +Future
> +~~~~~~
> +
> +Longer hashes
> +^^^^^^^^^^^^^
> +
> +Version will bump (e.g. 2) to indicate `value` uses a different object
> +id length other than 20. The length could be stored in an expanded fil=
e
> +header, or hardcoded as part of the version.

