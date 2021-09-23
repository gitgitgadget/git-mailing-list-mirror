Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B7C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29749610C9
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhIWOyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbhIWOyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 10:54:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359EC061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 07:52:30 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HFdRv00tmzQkDy
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 16:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1632408743; bh=eUNkCtbS0iEUzGkfj7vZFjFPRVIifafpX
        cwfbZykRd8=; b=Gmy4XSijmTlGZQ7TPnJ7UlVk0+CcCSUARjcaLbB+Cq/pqrgjM
        KZF5ru1L4FlGDMhj6dc54woQHHTZ+g/O8Bj1XKR4oxOr4I/ZbRrW4VBEQ4BDL6h9
        GxmW13RFR9cpzGxVVabD9723YpN30g1ImpGHHh1wX3eqRl4Gv2zNw4HiIdolZWqY
        NiRVvHWVcuVcPi/B6Lvox7/y+QdTyEGDH3pvQMNGH94lIpyFt5qyRp1/ErFjt8CE
        EmRNfzIWsBFfOKuxhrgBYz8gTIUsba2etNnYIwY9tGMFOeWJuxIzrt86sl1WVE3u
        NiWOHmapZzrlvewXok42Lyg3/ecGJqJnDnqYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1632408745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n9lR2R/f5PpPL8MXjcsZobin6UGSQJV17o5J18sZkQU=;
        b=mu/HOQXXTl7VawggMHbcrFVKSd9VT741EXz4EJMuD3u4K2BpCDPZ/x7w5tcLq46cKObP/D
        ef3UituWq9L8wl9a/mciPm5qulk5AjSNV56J59oscwhhuYkfyfSk3lSJ+qqKmlhMG+i6Mu
        UlmnnD0TBUPgvcmeIYC0tViLIdH00GNzb9mpMcZSvQkAN/Apdkrd97iIL2M+b/HaaWRdLR
        UZcmiobFlIR+p8rZcRpAaH2CvuWDHAphEmdCmc3B2q4mxLqGsru/dmJjdP49Q7PYPxWNVs
        6XvIHWJffrWe1hcW3y1P9Pq7hHbcDwq7guwOQFQHFZusRaukkJDWi9SA7hg6Ew==
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   David Hurka <david.hurka@mailbox.org>
To:     git@vger.kernel.org
Subject: Bug: Documentation and behavior mismatch in and between git-archive and gitattributes/git-check-attr.
Date:   Thu, 23 Sep 2021 16:52:22 +0200
Message-ID: <22364178.6Emhk5qWAg@doro>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 00083270
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

in https://github.com/Kentzo/git-archive-all/issues/87 I reported a problem=
=20
which turns out to be more likely a problem in git.

The documentation of `gitattributes` says:

> The rules [mostly follow .gitignore], with a few exceptions:
> * [...]
> * patterns that match a directory do not recursively match paths
>   inside that directory (so using the trailing-slash path/ syntax
>   is pointless in an attributes file; use path/** instead)

This means to me, that patterns may match _directories_ instead of the file=
s=20
in them.

So, if I have a /.gitattributes file like this:

> LICENSES/ export-ignore

I expect the whole directory /LICENSES/ to be matched, so a tool like=20
`git-archive` skips it when creating an archive.

However, if I have a /.gitattributes file like this:

> LICENSES/** export-ignore

I expect the directory itself not to be matched, but all files inside it, s=
o a=20
tool like `git-archive` adds an empty /LICENSES/ directory to the archive.

`git-archive` actually behaves like this.

However, `git-check-attr` does not behave like this. In the second example,=
 it=20
will list `export-ignore` matching on every file inside /LICENSES/. But in =
the=20
first example, it will list `export-ignore` matching nowhere. This leads to=
=20
the problem where `git-archive-all` wrongly exports the whole /LICENSES/=20
directory.

The documentation for `gitattributes` says for `export-ignore`:

> `export-ignore`
>   Files and directories with the attribute `export-ignore`
>   won=E2=80=99t be added to archive files.

=46or most other attributes it does not include directories, because they d=
o not=20
make sense for directories.

=2D--

I think the solution is like this:

1. Change the documentation of `gitattributes` to:

> The rules [mostly follow .gitignore], with a few exceptions:
> * [...]
> * patterns that match a directory do not recursively match paths
>   inside that directory. (Since most attributes are only useful for
>   files, the path/ syntax is probably incorrect; use path/** instead.)

2. Change git-check-attr to make patterns like path/ match directories. At=
=20
least, for attributes like `export-ignore` this should be changed, but I th=
ink=20
the correct solution is to change it for all attributes.

=2D--

Below is a shell script to reproduce the problem.

```
mkdir test_attributes
cd test_attributes
git init -b master
mkdir include dont-include-1 dont-include-2 dont-include-3
touch include/a.txt dont-include-1/b.txt dont-include-2/c.txt dont-include-=
3/
d.txt
echo dont-include-1/ export-ignore >>.gitattributes
echo dont-include-2/** export-ignore >> .gitattributes
echo dont-include-3 export-ignore >>.gitattributes
git add -A
git commit -m "Test gitattributes"

git archive --output ../test_attributes.zip HEAD
zipinfo ../test_attributes.zip

git check-attr export-ignore * */*
```

This is the output which I get with git version 2.33.0.752.gd22421fcc6:

> $ git archive --output ../test_attributes.zip HEAD
> $ zipinfo ../test_attributes.zip
> Archive:  ../test_attributes.zip
> Zip file size: 584 bytes, number of entries: 4
> -rw----     0.0 fat       94 tx defN 21-Sep-23 16:37 .gitattributes
> drwx---     0.0 fat        0 bx stor 21-Sep-23 16:37 dont-include-2/
> drwx---     0.0 fat        0 bx stor 21-Sep-23 16:37 include/
> -rw----     0.0 fat        0 tx stor 21-Sep-23 16:37 include/a.txt
> 4 files, 94 bytes uncompressed, 46 bytes compressed:  51.1%
>=20
> $ git check-attr export-ignore * */*
> dont-include-1: export-ignore: unspecified
> dont-include-2: export-ignore: unspecified
> dont-include-3: export-ignore: set
> include: export-ignore: unspecified
> dont-include-1/b.txt: export-ignore: unspecified
> dont-include-2/c.txt: export-ignore: set
> dont-include-3/d.txt: export-ignore: unspecified
> include/a.txt: export-ignore: unspecified

Note how `dont-include-2/** export-ignore` caused an empty directory to be=
=20
created. This is problematic for my workflow.

`dont-include-3 export-ignore` yields the desired results here, but I think=
 it=20
is not always an alternative, since the missing trailing slash makes the ru=
le=20
apply to files too. For example in this repository structure:

> - a/
>   - dont-include-3/
>     - a.txt
> - b/
>   - dont-include-3/
>     - b.txt
> - dont-include-3

I could not use the glob syntax `**/dont-include-3 export-ignore` to skip o=
nly=20
the two _directories_ with a.txt and b.txt, because the _file_ dont-include=
=2D3=20
would also be skipped.

=2D--

I am generally available for submitting patches to fix this issue. Let me k=
now=20
what you think. :)

Cheers, David



