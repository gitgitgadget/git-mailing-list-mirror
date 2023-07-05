Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD232EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjGETuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjGETuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A1121
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:50:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fe70f21bso831344866b.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586605; x=1691178605;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEsKDKvF3BrBf4y5KFQ6uXmwaQVIg6NOMzug5R5c5SU=;
        b=sw61rqInVn6O12pbtwqSl2NcTjk7JIhajnO0nWouY4fJiacm3QU3X5jntEQgltKefQ
         m7/hn8UMA5B2VTpjwypcYAp8aPa846vSRtDeL94jat5fNqB6b17M8TjYfwZFI23R+B7s
         0RfuzEx+suSCpbDU83f1zpya5tBU5IaI/WA4FYmbZ2p4xhdmkENOGyYJ/G2sr3bT9Afl
         RYmoe7PsaKgEzML6ynyf2fubzFFrCJIwwfVIcEJkXETU96xtuCRvGw8m5O7NveYPLppB
         0Ft+B1a8/TSqWZ9s6/NWCtNre8mTiNrmAKqMieGfJEpDDPgHOBUlebz0NQ/nsG3dt3Oj
         0SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586605; x=1691178605;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEsKDKvF3BrBf4y5KFQ6uXmwaQVIg6NOMzug5R5c5SU=;
        b=HJWdto8M2dCUKnqGze1RYnjlHllsHwy/twV0WFu8toAzwezbFzHQHE3e5Ok6T8VqBe
         BmY6G1HfdCatL/Bltnb3lQha4FtN0y5zst9GCgbfSLfcX4Q/iThVyeNr9kVgknDxjBmq
         wEoBfaDoKVRTzyZgYfO3snyL2xnMpMc3iKAS+fCT4jHurqksJQuv9RPHknChLdaIsoXq
         ofTNH/C8HREft59c3oehuP4+bZ+3fd/julzS1SsSXddRFvMp3u45L+BwVdjSnofD39Ds
         SGpU6qSNwS9/LLLP3D9Fxd9K5juex0QphNeaIcfvRF9c4vdyCvIvBA3BDwqNb/F6vdux
         6eHA==
X-Gm-Message-State: ABy/qLZCx25ZkY5v2xGDLfgUTClvM5gNJG3JlZTrzi4FE8rLYgTQsRnb
        ZORmwHS9pntUeixZ9ZASMO9NHiOsww4=
X-Google-Smtp-Source: ACHHUZ7kNm2NIdxvEUSR06tg7ZM/kFvTkfeWDUUJ4erCCD3UZyC47vdS2zl0ucGaophTia/hIjBBAA==
X-Received: by 2002:a17:907:100c:b0:96f:678:d2fc with SMTP id ox12-20020a170907100c00b0096f0678d2fcmr12115667ejb.22.1688586605406;
        Wed, 05 Jul 2023 12:50:05 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm10078341ejb.107.2023.07.05.12.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:04 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] diff --no-index: support reading from named pipes
Date:   Wed,  5 Jul 2023 20:49:26 +0100
Message-ID: <cover.1688586536.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g0a1e0755a6
In-Reply-To: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In some shells, such as bash and zsh, it's possible to use a command
substitution to provide the output of a command as a file argument to
another process, like so:

  diff -u <(printf "a\nb\n") <(printf "a\nc\n")

However, this syntax does not produce useful results with git diff
--no-index. On macOS, the arguments to the command are named pipes
under /dev/fd, and git diff doesn't know how to handle a named
pipe. On Linux, the arguments are symlinks to pipes, so git diff
"helpfully" diffs these symlinks, comparing their targets like
"pipe:[1234]" and "pipe:[5678]".

There have been at least three previous attempts [1-3] to address this
issue. They all seem to have received broad support for the aim of
supporting process substitutions but have foundered on details of the
implementation. In an effort to avoid the same fate this series is
narrowly focussed on making command substitutions work with "diff
--no-index" and does not attempt to add a general facility for
de-referencing symbolic links or reading from pipes to the diff
machinery.

The only functional change is that if a path given on the commandline
is a named pipe or a symbolic link that resolves to a named pipe then
we read the data to diff from that pipe. The first two patches improve
the error handling when reading from stdin and add a test. The third
patch implements support for reading from pipes.

This cover letter and the commit message for the third patch are
largely copied from brian’s patch[2] - do we have a standard commit
trailer for "I stole the commit message from someone else's patch"?

I've cc’d the participants of the discussion of the last attempt[1] to
fix this.

Thanks to Junio for his comments, the changes since v1 are:

* Patch 1: - This is new and changes the code to error out if the user
	     tries to compare stdin to a directory.

* Patch 4: - Changed the implementation of get_mode() to treat stdin and
	     named pipes as special. (suggested by Junio)
	   - Added separate functions to populate a diff_filespec from
	     a stdin or a named pipe. (suggested by Junio)
	   - It now dies if the user tries to compare a named pipe to a
	     directory and added a test for this. (suggested by Junio)
	   - The test for comparing named pipes now cleans up the
	     background processes if it fails.

[1] https://lore.kernel.org/git/20200918113256.8699-3-tguyot@gmail.com/
[2] https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
[3] https://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/


base-commit: 94486b6763c29144c60932829a65fec0597e17b3
Published-As: https://github.com/phillipwood/git/releases/tag/diff-no-index-pipes%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/94486b676...4e05a0be5
Fetch-It-Via: git fetch https://github.com/phillipwood/git diff-no-index-pipes/v2

Phillip Wood (4):
  diff --no-index: refuse to compare stdin to a directory
  diff --no-index: die on error reading stdin
  t4054: test diff --no-index with stdin
  diff --no-index: support reading from named pipes

 diff-no-index.c          | 126 ++++++++++++++++++++++++++++-----------
 t/t4053-diff-no-index.sh |  64 ++++++++++++++++++++
 2 files changed, 156 insertions(+), 34 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  5e65a15223 diff --no-index: refuse to compare stdin to a directory
1:  5dad728f3b = 2:  be1d666769 diff --no-index: die on error reading stdin
2:  b94d59034f ! 3:  1c7db4dbe2 t4054: test diff --no-index with stdin
    @@ t/t4053-diff-no-index.sh: test_expect_success POSIXPERM,SYMLINKS 'diff --no-inde
     +	test_write_lines 1 | git diff --no-index -- a/1 - >actual &&
     +	test_must_be_empty actual
     +'
    - test_done
    ++
    + test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
    + 	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
    + 	grep "fatal: cannot compare stdin to a directory" err
3:  990e71882b < -:  ---------- diff --no-index: support reading from named pipes
-:  ---------- > 4:  4e05a0be54 diff --no-index: support reading from named pipes

base-commit: 94486b6763c29144c60932829a65fec0597e17b3
-- 
2.40.1.852.g0a1e0755a6

