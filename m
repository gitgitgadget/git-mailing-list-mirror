Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA33C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 09:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLPJgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLPJgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 04:36:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A227169
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 01:35:58 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kw15so4745268ejc.10
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 01:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIDQO1O9SpTNV/C+z+frSGFE2GIfnrsf+e/TKKfQxdE=;
        b=SDVlrZ+8wQmTgE/ooyxfDoqQgfEDEh5lDzGC7npJOZdpv+CkOssNQQqVctKhG07ltp
         YMWoFoIKvemlnVNnYvPmATtL5lrKVtrmAUdo5TEQXuM1Lthy3URJMoes3czMIqTOsmRp
         O3Ltnuf2rPvFyXEFAiaG/XBFZgNBnY7s04zh7Pacgpw8lDDYHW/DnooiSgKI0M9mzHnT
         dAKUrUIqjxDKNOYBRvGbfgoNe8r9wJddmvuDY4akx8H4CDPvQI1I0vNoDwN97uhgPZG+
         kSRQzjuxMR4AVPGBzOQ356SiEP7h3gaVDBvygCbFRpXqzpfg8oVtqjwMIXmLkyT0Si31
         XOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIDQO1O9SpTNV/C+z+frSGFE2GIfnrsf+e/TKKfQxdE=;
        b=Fnrlbv8omB7f1E1M7NCojBLw4pohh13goSltoFBC9Z7FtOvD2ZDlyKJ+q96gbXZHJL
         /xWQrzAF8PxsfN8YzDsD6sQ0RxgDjkY948s/pmhUCy4aGuo1H1VXkp8MA8DtEeS+NprQ
         4XRcfPa7R82IrT4rjbfkCb8sTwcwO9Homao9w8z1rrrRUYN0/8PRFEokBJp1EV49aHr5
         bJS9ssBOsC4BeQvAH9w7+I+vuDEl2dt+Ui9Ctv3sQQwOxgc8RXvA4jGp2rX0qiG6q7go
         WtRTRStofqkCa2taT8BkW8/wEvRLxRUaxa5wcfNYrzM008tkSXp3HZGvP5piOhhbOQ+f
         QUzg==
X-Gm-Message-State: ANoB5pkrnpjdZLD4NROon5MfhsvkzkKXK1939oZE8phLVhXO+dw8UpC4
        VzQ6jEznRCtj2VvIxaoK6wTtuSW57FsKyg==
X-Google-Smtp-Source: AA0mqf6fuLFkAQTk0nbhZcEy+VRdI7scHeDx5OnDQ2YP+90A1gz+2CamZOz4wm9/4hE3/8E4QYn9GQ==
X-Received: by 2002:a17:906:f2d5:b0:7c0:ff76:dc12 with SMTP id gz21-20020a170906f2d500b007c0ff76dc12mr26047032ejb.2.1671183356831;
        Fri, 16 Dec 2022 01:35:56 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id x12-20020a05640225cc00b00459f4974128sm655538edb.50.2022.12.16.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 01:35:56 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] check-attr: add support to work with revisions
Date:   Fri, 16 Dec 2022 10:35:50 +0100
Message-Id: <20221216093552.3171319-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a revision to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
allows us to read gitattributes from the specified revision.

Changes since version 2:
- Changes to the commit message [1/2] to use more specific terms and to
  be more descriptive.
- Moved the flag's position in the documentation to be before the unbound
  list of non-options.

Range-diff against v2:

1:  2e71cbbddd < -:  ---------- Git 2.39-rc2
-:  ---------- > 1:  57e2c6ebbe Start the 2.40 cycle
2:  898041f243 = 2:  c386de2d42 t0003: move setup for `--all` into new block
3:  12a72e09e0 ! 3:  b93a68b0c9 attr: add flag `-r|--revisions` to work with revisions
    @@ Metadata
      ## Commit message ##
         attr: add flag `-r|--revisions` to work with revisions
     
    -    Git check-attr currently doesn't check the git worktree, it either
    -    checks the index or the files directly. This means we cannot check the
    -    attributes for a file against a certain revision.
    +    The contents of the .gitattributes files may evolve over time, but "git
    +    check-attr" always checks attributes against them in the working tree
    +    and/or in the index. It may be beneficial to optionally allow the users
    +    to check attributes against paths from older commits.
     
    -    Add a new flag `--revision`/`-r` which will allow it work with
    -    revisions. This command will now, instead of checking the files/index,
    -    try and receive the blob for the given attribute file against the
    -    provided revision. The flag overrides checking against the index and
    -    filesystem and also works with bare repositories.
    +    Add a new flag `--revision`/`-r` which will allow users to check the
    +    attributes against a tree-ish revision. When the user uses this flag, we
    +    go through the stack of .gitattributes files but instead of checking the
    +    current working tree and/or in the index, we check the blobs from the
    +    provided tree-ish object. This allows the command to also be used in
    +    bare repositories.
    +
    +    Since we use a tree-ish object, the user can pass "-r HEAD:subdirectory"
    +    and all the attributes will be looked up as if subdirectory was the root
    +    directory of the repository.
     
         We cannot use the `<rev>:<path>` syntax like the one used in `git show`
         because any non-flag parameter before `--` is treated as an attribute
         and any parameter after `--` is treated as a pathname.
     
    -    This involves creating a new function `read_attr_from_blob`, which given
    -    the path reads the blob for the path against the provided revision and
    +    The change involves creating a new function `read_attr_from_blob`, which
    +    given the path reads the blob for the path against the provided revision and
         parses the attributes line by line. This function is plugged into
    -    `read_attr()` function wherein we go through the different attributes.
    +    `read_attr()` function wherein we go through the stack of attributes
    +    files.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
         Co-authored-by: toon@iotcl.com
    @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
      [verse]
     -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
     -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
    -+'git check-attr' [-a | --all | <attr>...] [-r <revision>] [--] <pathname>...
    -+'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]
    ++'git check-attr' [-r <revision>] [-a | --all | <attr>...] [--] <pathname>...
    ++'git check-attr' --stdin [-z] [-r <revision>] [-a | --all | <attr>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-check-attr.txt: OPTIONS
      
     +--r <revision>::
     +--revision=<revision>::
    -+	Check attributes against the specified revision.
    ++	Check attributes against the specified tree-ish revision. All the
    ++	attributes will be checked against the provided revision. Paths provided
    ++	as part of the revision will be treated as the root directory.
     +
      \--::
      	Interpret all preceding arguments as attributes and all following
    @@ builtin/check-attr.c
      static const char * const check_attr_usage[] = {
     -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
     -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
    -+N_("git check-attr [-a | --all | <attr>...] [-r <revision>] [--] <pathname>..."),
    -+N_("git check-attr --stdin [-z] [-a | --all | <attr>...] [-r <revision>]"),
    ++N_("git check-attr [-r <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
    ++N_("git check-attr --stdin [-z] [-r <revision>] [-a | --all | <attr>...]"),
      NULL
      };
      


Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `-r|--revisions` to work with revisions

 Documentation/git-check-attr.txt |  10 +++-
 archive.c                        |   2 +-
 attr.c                           | 100 ++++++++++++++++++++++---------
 attr.h                           |   7 ++-
 builtin/check-attr.c             |  33 ++++++----
 builtin/pack-objects.c           |   2 +-
 convert.c                        |   2 +-
 ll-merge.c                       |   4 +-
 pathspec.c                       |   2 +-
 t/t0003-attributes.sh            |  71 +++++++++++++++++++++-
 userdiff.c                       |   2 +-
 ws.c                             |   2 +-
 12 files changed, 182 insertions(+), 55 deletions(-)

-- 
2.39.0

