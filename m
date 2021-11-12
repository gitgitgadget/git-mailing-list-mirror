Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E45C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0719660F39
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKLWXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKLWXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFAC061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so17935122wra.12
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BmK8wtLfv9CQ4+VffD9oAfE2cQ3hVu0Bju/KxroC10=;
        b=IjraRxnWnj9+5J381iPTiAX0FYLOWhjq7kB1iy8X+FBL9WadklVbU57BetN1Qc/rh3
         ERIAdqwDleVM6wgu9B/gPzbclw2W9OHeLFbD9ixl09li30y39Ln0wk+s0G0oq2dLD7BO
         ADd+gPXaNbAqalQgQ8iAmxHanWuwhUojUscDt1O3dQbTc/m6uyHYIPtA0XagY/nt1G36
         +fYAuIgfP1LemIpsP2dbxn7/rNVEdqlhWIDvf0DZjRhQUuNGvgz36I/VcSo07QB7iEOT
         JFYO3l4ybcseaKpWzsxD+ZTffTexUC/uPHnScZWrd73OzH06TEXZ6jjR3Evqu28EfDCA
         /2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BmK8wtLfv9CQ4+VffD9oAfE2cQ3hVu0Bju/KxroC10=;
        b=AJXqH0ueiTTx4EoyZOlEsWQHf+A4uhuBlfGbPU/6r7G8yqiEC9JgqKqGLJb6ELGajA
         rPSVBjn3Y7UA9i+VI/InbugoA990CYKIOEAH5RG4QIDC77SnU1nSC0QVy53x85gYgxb0
         1fyi/fzEbdjyiwo/hifn2ydszmV0lwwNem8L254xmNId5IYpdcDt9bVDdS329gJxOlvu
         OjAHo5Axo1NxYwReu0F64WyV3DN3vwO4xKmaV3HXDgGb+ppaP/b2hGuSCL3tZtvp49ov
         SGwfBi3QzyfgBo9oJcOK6WrODPJOVxLctvD1NfDN46Ih4vZFlpK2CCmcFNdwo2b+uNQW
         HXGw==
X-Gm-Message-State: AOAM530i+wzQyjfIMQ+ioHEzPNu3y2zG6AxChhBGHLEC2Fuf3Gxv8T85
        OlVQp8UcJDOjOw3xzsyyAbZHKzj2ROE8lw==
X-Google-Smtp-Source: ABdhPJwnHQRaNVUBdXSdr0LVyQPitQX1jU+7n8h3P4fR9U0s3dLMNKbpvGEpbqDpjg90umDpI5appQ==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr22243258wrd.373.1636755651041;
        Fri, 12 Nov 2021 14:20:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] cat-file: better usage UX & error messages
Date:   Fri, 12 Nov 2021 23:19:58 +0100
Message-Id: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10. For the v1 see[1]

This update addresses comments Eric Sunshine had on test patterns &
typos. I've taken (or attemted to address) all his comments
here. There was a leftover unused $switch variable from development,
and some other minor test & typo nits.

Junio: John Cai expressed (off-list) interest in building on top of
this for the cat-file "new stdin mode"+fflush() batch command. You
seemed to think the direction of my WIP patch in that direction was
good, whic his much easier to implement, test & be sure about the
correctness off after this series.

So it would be great to have this tightening of the options behavior &
UX improvement picked up.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/
3. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test bad usage
  cat-file tests: test messaging on bad objects/paths
  parse-options API: add a usage_msg_optf()
  cat-file docs: fix SYNOPSIS and "-h" output
  cat-file: move "usage" variable to cmd_cat_file()
  cat-file: make --batch-all-objects a CMDMODE
  cat-file: fix remaining usage bugs
  cat-file: correct and improve usage information
  object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
  cat-file: improve --(textconv|filters) disambiguation

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 181 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |  11 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  92 +++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  26 +++++
 9 files changed, 267 insertions(+), 81 deletions(-)

Range-diff against v1:
 1:  c8040da8e55 !  1:  3a0d2923cfa cat-file tests: test bad usage
    @@ Commit message
         when --batch-all-objects is combined with --textconv or --filters, but
         we don't.
     
    +    The cases of needing to assign to opt=2 in the "opt" loop are because
    +    on those we do the right thing already, in subsequent commits the
    +    "test_expect_failure" cases will be fixed, and the for-loops unified.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t1006-cat-file.sh ##
    @@ t/t1006-cat-file.sh: test_description='git cat-file'
      
      . ./test-lib.sh
      
    -+test_cmdmode_usage() {
    ++test_cmdmode_usage () {
     +	test_expect_code 129 "$@" 2>err &&
     +	grep "^error:.*is incompatible with" err
     +}
     +
    -+test_expect_success 'usage: cmdmode' '
    -+	test_cmdmode_usage git cat-file -e -p &&
    -+	test_cmdmode_usage git cat-file -p -t &&
    -+	test_cmdmode_usage git cat-file -t -s &&
    -+	test_cmdmode_usage git cat-file -s --textconv &&
    -+	test_cmdmode_usage git cat-file --textconv --filters
    -+'
    ++for switches in \
    ++    '-e -p' \
    ++    '-p -t' \
    ++    '-t -s' \
    ++    '-s --textconv' \
    ++    '--textconv --filters'
    ++do
    ++	test_expect_success "usage: cmdmode $switches" '
    ++		test_cmdmode_usage git cat-file $switches
    ++	'
    ++done
     +
    -+test_incompatible_usage() {
    ++test_incompatible_usage () {
     +	test_expect_code 129 "$@" 2>err &&
    -+	grep -E "^error:.*$switch.*needs" err
    ++	grep -E "^error:.**needs" err
     +}
     +
     +for opt in --batch --batch-check
 2:  a473185eb97 =  2:  fc8d5e60682 cat-file tests: test messaging on bad objects/paths
 3:  5d87897f49c =  3:  0e2e5ab9d2d parse-options API: add a usage_msg_optf()
 4:  29b67330a48 =  4:  b9c935b95b7 cat-file docs: fix SYNOPSIS and "-h" output
 5:  1974136d483 =  5:  664c5db634e cat-file: move "usage" variable to cmd_cat_file()
 6:  ee49e586483 !  6:  d945fc94774 cat-file: make --batch-all-objects a CMDMODE
    @@ Commit message
         instead. It doesn't combine with --filters, --textconv etc.
     
         By giving parse_options() information about what options are mutually
    -    exclusive with one another we can get the die9) message being removed
    +    exclusive with one another we can get the die() message being removed
         here for free, we didn't even use that removed message in some cases,
         e.g. for both of:
     
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
      		usage_with_options(usage, options);
     
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_expect_success 'usage: cmdmode' '
    - 	test_cmdmode_usage git cat-file -p -t &&
    - 	test_cmdmode_usage git cat-file -t -s &&
    - 	test_cmdmode_usage git cat-file -s --textconv &&
    --	test_cmdmode_usage git cat-file --textconv --filters
    -+	test_cmdmode_usage git cat-file --textconv --filters &&
    -+	test_cmdmode_usage git cat-file --batch-all-objects -e
    - '
    - 
    - test_incompatible_usage() {
    +@@ t/t1006-cat-file.sh: for switches in \
    +     '-p -t' \
    +     '-t -s' \
    +     '-s --textconv' \
    +-    '--textconv --filters'
    ++    '--textconv --filters' \
    ++    '--batch-all-objects -e'
    + do
    + 	test_expect_success "usage: cmdmode $switches" '
    + 		test_cmdmode_usage git cat-file $switches
     @@ t/t1006-cat-file.sh: do
      	test_expect_success "usage: $opt requires another option" '
      		test_expect_code 129 git cat-file $opt
 7:  9e1dcd6b824 !  7:  22f55e1fb6b cat-file: fix remaining usage bugs
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
      		die("git cat-file --allow-unknown-type: use with -s or -t");
     
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_expect_success 'usage: cmdmode' '
    +@@ t/t1006-cat-file.sh: done
      
    - test_incompatible_usage() {
    + test_incompatible_usage () {
      	test_expect_code 129 "$@" 2>err &&
    --	grep -E "^error:.*$switch.*needs" err
    -+	grep -E "^(fatal|error):.*$switch.*(requires|incompatible with|needs)" err
    +-	grep -E "^error:.**needs" err
    ++	grep -E "^(fatal|error):.*(requires|incompatible with|needs)" err
      }
      
      for opt in --batch --batch-check
 8:  951fea02b83 =  8:  0842df64695 cat-file: correct and improve usage information
 9:  49f9e30792b !  9:  6642b57c6fe object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
    @@ Commit message
         call get_oid_with_context_1() again via this
         maybe_die_on_misspelt_object_name() function.
     
    -    In the subsequent commit we'll add a new caller that excepts to call
    +    In the subsequent commit we'll add a new caller that expects to call
         this only once, but who would still like to have all the error
         messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
         regular errors.
10:  3d61399aa78 = 10:  177f16ba856 cat-file: improve --(textconv|filters) disambiguation
-- 
2.34.0.rc2.795.g926201d1cc8

