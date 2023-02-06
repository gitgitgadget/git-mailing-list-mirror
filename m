Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB12C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBFVJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFVJD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:09:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778D883DC
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:09:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 5so5157813pgd.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTYRwpc9+mtdM/rr4qnUM/rPBzbu24SHWz6G4M6RmYw=;
        b=WltHWNMK/Tn3A0iE1IaNTyQn/6TDGCVYF+3XjPgnOOw9d2gbsAgGs2fx4kX9+MPKNq
         pyawxFwnxhY1km8d28ExrWJsfK2XpB2aHu2aAeMGRo/DBkOVm5jVUv/bizUqpZ8YLs/3
         1Ezd8mVnJ0HNW76NI5XDYXVOlPDeoqMdqvYJNdlWWZ+z5qmv6LxASasEzAt0L9uPx9Lg
         toddM/sS43LSgBedDETcf+U0sSLt913+0MvdgFe2PPu7gAmWy7Q72AQTBr+OAGuhibPh
         D0mldxbFKu2zZsMRBtU3Vx4yPPd0Iow5c5gaT5RtI2uzes2/dq7lL+ZZ3hpQSl9gtbtk
         OHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rTYRwpc9+mtdM/rr4qnUM/rPBzbu24SHWz6G4M6RmYw=;
        b=L1wh4A6Jih12NX5rgSTMWXjW18W2NWNeJ7k7qftroK+5S0E4Dac6Agwoyp0JFemgsO
         kGo0niVJIiC/S+k5yVy4Y6SaTPdMnzxg2W7XZbmtJlKrwcd/XPExgCT0+BBkMku2QREc
         oCpoY7BYpHP+2DZVhdbXlhYBuSWZ9rq6poiP7A1+gC+xmGhMC2HjoCwRW+BWjmNStvOO
         XsJfqSiR0JSS1GoCOoOsrfRguuzo3NgAxRJ84/w+0D8q/E70SV8395B4bjHHjcDEMqw5
         AaRo0RJeNfzWlduhOosiIVzInHtOzOZR+I/snLg+pHw7NUwOkMWZdjh+m9QJbBPSzSRi
         Edhw==
X-Gm-Message-State: AO0yUKVRA/jbWlxg5Ewzzf1f8gX+DbxEOEx7eFbWaQWwOMp5AHFv5F7t
        +qrbW7tZSI9DSCcIpi/Gxgw=
X-Google-Smtp-Source: AK7set/tLzkuVKhI7jfBxStbqjdPK1I4txIZ/c3csNenNZyvvefkwN8ohqP97aFLPEtaptC4gY7jwg==
X-Received: by 2002:a62:520b:0:b0:593:c9b6:dc5d with SMTP id g11-20020a62520b000000b00593c9b6dc5dmr788332pfb.0.1675717740678;
        Mon, 06 Feb 2023 13:09:00 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 131-20020a621489000000b00593cad8566fsm7498257pfu.132.2023.02.06.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:09:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
        <20230205221728.4179674-2-sandals@crustytoothpaste.net>
Date:   Mon, 06 Feb 2023 13:08:59 -0800
In-Reply-To: <20230205221728.4179674-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 5 Feb 2023 22:17:28 +0000")
Message-ID: <xmqq8rha5wno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +Overview
> +--------
> +
> +Many people find it convenient to have tar archives that are bit-for-bit
> +identical between versions.  This can be valuable to validate that an archive
> +has not changed using a cryptographic hash without needing to store the archive
> +itself.
> +
> +However, up to now, Git has not guaranteed a consistent format, although people
> +often make the assumption that Git's archives will always be bit-for-bit
> +identical.  This has led to several notable problems with various forges.
> +
> +This document proposes a canonical tar format based on the POSIX pax format that
> +is bit-for-bit identical.  It is referred to as ctar-v1 (canonical tar version 1).

"is identical to what"?  Ditto for the one in the previous
paragraph.  The first paragraph is better in that there is "between
versions", even though it would be easier to grok if we made it more
clear that we are talking about versions of the software that is
used to create the archive, not the version of contents being
archived.

Our goal is that serializing the same tree object or the same commit
object result in bit-for-bit identical result, no matter which
version of Git is used, and no matter what platform the Git used to
create the archive was built on.  Mentioning both what we take an
archive out of (i.e. tree or commit) and we can use different
versions of Git to create archives, in the description would make it
easier to grok.

> +Goals and Rationale
> +-------------------
> +
> +The goals for this format are that it is first and foremost reproducible, that
> +identical trees produce identical results, that it is simple and easy to
> +implement correctly, and that it is useful in general.  While we don't consider
> +functionality needs beyond Git's at the moment (such as hardlinks, xattrs, or
> +sparse files), there is intense interest in reproducible builds, and so it makes
> +sense to design something that can see general use for software interchange.

Perfect.

> +Because the goal is strict reproducibility, this format doesn't honor
> +`tar.umask` or other options that can produce different output.  It serializes
> +all timestamps as the Epoch, which produces identical results whether the tree
> +is serialized as a tree, commit, or tag.  This is consistent with the behaviour
> +of some other tar serializers, including the default for modern Rust crates, and
> +is not believed to pose any interoperability problems.

> +Object IDs are not included in this version of the format because this produces
> +non-identical data when identical data is serialized with different hash
> +algorithms.

Declaring that we'll always peel a tag or a commit down to a tree is
one sure way to avoid having to worry about object name hashes, but
aren't we discarding too much utility by doing so?

This is probably debatable.  The commit object name embedded in the
extended header of an archive makes it trivial to identify what
version the archive _claims_ to have been taken from (you could also
embed it in the filename that stores archive, but the use of the
embedded metainfo makes it more robust against file names).  And
running "git archive" twice, with different versions of Git on
different architectures, should be reproducible as long as both
invokers expressed their desire to see the commit object name in the
archive by passing the commit, not its tree, to the command, and
they are using the same hash algorithm.

In the world where multiple hash functions are in use, a commit that
is being archived may have one or two "object names", but it should
not be hard to use one extended header item per each to store one or
both, I would imagine.

Having said all that, I think stripping the commit object name (or
tags) is a better design.  Imagine that I see I created a tarball
earlier and published its hash, but later lost the tarball.  By not
allowing any commit object name in the archive, it would force me to
somehow name the tarball in such a way that I can tell which commit
I used to create it, e.g. "git-e83c516331.tar".  Other people can
notice the filename and without having seen the bytes in it, they
can try running "git archive e83c516331" in their repository and see
the output matches the hash I published earlier.  Having commit or
tag embedded in the archive would make it harder to do this kind of
things.

By the way, other potentially interesting points are:

 - Do we want to ignore "export-subst" for stability?

 - "git archive" can be invoked with pathspec to archive only a
   subset of paths.

 - "git archive" could be extended to include submoudule trees
   recursively in the same output.

The latter two are trivial to support, but we need to make sure that
we do not screw up the ordering of paths in the output, especially
for the last one, when we add it.

> +Introduction to the Underlying Format
> +-------------------------------------
> ...
> +A global extended header sets metadata for the entire file, and a per-file
> +extended header applies to only the to which it corresponds.  A per-file

"only the to which" -> "only the file to which"

> +extended header overrides any data specified in the global extended header, and
> +all extended headers override any data stored in a normal ustar per-file header
> +block.

> +While pax extensions are widely supported by most modern versions of tar
> +(including versions on Windows and all major open-source OSes), some older
> +archivers and non-tar implementations which do not understand them typically
> +extract the extended headers as regular files.  Thus, it's helpful to have these
> +entries have reasonable permissions and unique names.

Surely, and to make things reproducible, they shouldn't just be
reasonable and unique.  They should be exactly as we define in the
specification.

> +General Architecture
> +--------------------
> +
> +All canonical tar archives are valid POSIX pax archives as that format is
> +defined in POSIX.1-2017.  Every archive will have a global header indicating the
> +version and format and what types of data are valid in the archive.
> +
> +Every file serialized in the archive is serialized in lexicographical order by
> +its bytes.  A directory is always serialized before its contents, and a

"by its bytes" -> "by the bytes in its filename" or something?
Surely we do not sort by contents ;-)

> +directory is never serialized with a trailing slash.  If a system uses a Unicode
> +encoding other than UTF-8, it encodes filenames as UTF-8.

This is a bit hard to grok.  Do you mean there may be UTF-16 system
where the data in our tree objects, whose paths are recorded in UTF-8,
but "git checkout" of the tree may result in files in the native
filename on that system, i.e. UTF-16 not UTF-8?  And even on such a
system, running "git archive" would record paths in the archive in
UTF-8 (i.e. the same as what was in the tree object)?  Or do you
mean something stronger, like on a Latin-1 system with Latin-1
project that used Latin-1 as pathnames even in the tree objects,
when "git archive" produces an archive, the paths in it shall be
transcoded from the original Latin-1 pathnames to UTF-8?

> +Each file shall contain a pax extended header record.
> +
> +It is possible to encode some extended headers in multiple ways because the
> +length in the header encodes its own length.  For example, in cases where the
> +length value can be encoded as either 99 or 100, both can lead to identical
> +header data.  The shortest possible encoding must always be used.

;-)

> +In any event where multiple encodings are possible, the shortest and, if there
> +is still confusion, lexicographically first (by byte value) must always be used.

;-)

> +All unspecified padding is filled with NUL bytes.

Perhaps we should change the casual mention "zero"s we saw earlier
about with "NUL bytes", too.

> +Version Number
> +--------------
> +
> +The version number for this version is `ctar-v1`.
> +
> +Extended Headers
> +----------------
> +
> +Global Extended Header
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +The global extended header (record `g`) shall contain one header:
> +`CTAR.version`, which contains the version number specified above.
> +
> +The contents of the ustar header for the global extended header are as below,
> +except that the `name` field contains `pax_global_header`.

"as below" meaning...?  The same as what is listed in "Per-File
Extended Header"?  There is no `name` field listed there, though.

> +Per-File Extended Header
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Each file has a per-file extended header.
> +
> +The following per-file extended header fields are included:
> +
> +|===
> +| Field Name   | When Present  | Value
> +
> +| `atime`      | always        | `0`
> +| `mtime`      | always        | `0`
> +| `size`       | always        | size of the data in bytes
> +| `path`       | always        | full path name of the file

These are length-prefixed data, so we do not have to worry about
overly long pathnames or symlinks?

> +| `uid`        | always        | `0`
> +| `gid`        | always        | `0`
> +| `uname`      | always        | `root`
> +| `gname`      | always        | `root`
> +| `linkpath`   | symbolic link | full path name of the link destination
> +| `hdrcharset` | binary path   | `BINARY`
> +
> +Note that the `hdrcharset` entry appears if and only if the `path` or, if
> +present, the `linkpath`, header contains a non-UTF-8 encoded string.  Because
> +Git does not store the encoding of file names, it has no way of knowing whether
> +a file name which could be valid UTF-8 actually is, but for the purposes of
> +compatibility, such file names are assumed to be UTF-8 and are not declared as
> +binary.  This improves portability to systems which always use Unicode.
> +However, we because we do not know for certain whether these values are UTF-8,

"we because" -> "because"

> +we avoid explicitly declaring them as such and rely on the default archiver
> +behavior, which may be more sensible.

So, do we or do we not store hdrcharset?  Producing Git does not know
if the pathnames stored in the tree it is asked to produce archive
for are not in UTF-8, so it assumes everything is in UTF-8 hence
does not see the need to add hdrcharset?

> +The `path` field contains the full path name without a leading slash or leading
> +`.` or `..` component.  The path never contains a directory component which is
> +`.` or `..`.
> +
> +The `linkpath` field contains the full symbolic link destination.  `.` and `..`
> +components are permitted if the destination contains those values.

In other words, we just store the contents of the blob that
represents the symbolic link there?  I wonder if we do anything
special if a blob, that is pointed at in an entry in a tree whose
mode bits are 120000, has NUL in it (should we teach fsck to flag
it, for example)?

> +In all cases, path names use `/` as the directory separator.
> +
> +The reason for always including most of the entries in the archive is to aid in
> +implementing and testing correct serialization.  If these entries are always
> +present, then this process becomes much simpler, whereas if they are only
> +included as needed, then errors are more likely.

The order of entries need to be specified when we aim for
bit-for-bit reproduceability, no?

> +The `name` field of the ustar header of this extended header is `paxheader.%d`,
> +where `%d` represents the shortest-form decimal integer encoding the index of
> +this file in the archive, starting with 0.  All files, directories, and links of
> +whatever kind are counted, but extended headers are not.

> +Serialization of Extended Headers
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When serializing the header block for an extended header, the following values

"the header block" -> "the ustar header block" to match the next
section, probably.

> +should be used.  Note that all text fields are be NUL-padded on the right when
> +they do not fill the field, and all octal fields are left-padded with zeros such
> +that they fill the field with a single trailing NUL.  An empty field contains
> +only NULs.
> +
> +|===
> +| Field Name | Value
> +
> +| `name`     | `pax_global_header` (global) or `paxheader.%d` (per-file) (see above)
> +| `mode`     | `0640`
> +| `uid`      | `0`
> +| `gid`      | `0`
> +| `size`     | the size of the extended header in bytes
> +| `mtime`    | `0` (the Epoch)
> +| `chksum`   | as specified in the standard
> +| `typeflag` | `g` (global) or `x` (per-file)
> +| `linkname` | empty
> +| `magic`    | as specified in the standard
> +| `version`  | as specified in the standard
> +| `uname`    | `root`
> +| `gname`    | `root`
> +| `devmajor` | `0`
> +| `devminor` | `0`
> +| `prefix`   | empty
> +|===

These are barebone header fields, not extended headers.  Do we want
to refer to some canonical sources so that readers understand that
unlike the extended headres we are talking about fixed-length fields? 
The description above talks about "padding", but that of course
applies to fixed width columns.

> +When encoding the data for an extended header, all entries are sorted in order
> +by the byte values of their keys as encoded in UTF-8.  Duplicate keys are not
> +permitted.
> +
> +Because the format allows multiple length encodings of some values, the shortest
> +possible encoding must always be used.
