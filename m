Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36299EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjF0OLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF0OLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:11:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3364B296C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso13838155e9.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687875069; x=1690467069;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z81ROu9diBYpnrjP42S4ac+RDmv+rS+ZsarhBK6KogA=;
        b=IJ9sMq2VofDSDQb0UKPSLSnyG6A9cKPpUAhzIo5pvnRWBgwBvTZDzr2HXIjMlmMB7+
         /ukb20sQlldq3sGWx0gGxVUTe7nDX0tTZiertivVdZyfoEMze7IqHuAsSOSWAforIxmv
         kdUqgOFS50RgaylpsT76fYR4C461kK2IDl6wZeRr1lp7N0Sg/QClHp9tMHU0W4DdQbaz
         mecZWOX9UNbCVQ432gWAywMC4J5jdbxlXaUJGJMoW2YBCh/hYNlvoetxgcatMQ2+bMzq
         yV8Vbii3uahj+1N06iHjoZqa1VVQrD75dLY2aTQMl0cX9v/9x/kl2+ndFb7rech/j7fa
         7DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875069; x=1690467069;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z81ROu9diBYpnrjP42S4ac+RDmv+rS+ZsarhBK6KogA=;
        b=ei8lQAHa/qvofWN0IlCAqGa+zwa8A3iVy+9qcC8GWuL31Nv+7Li7Ld0+GRiNMlsQvO
         s4qtdPj+NT4fVQOAy6oWhzHUvK0IgrzM5RsHhDVSM5hNekvUMs1n0tEeoYjp8Y3YzOjD
         IchczbaOY827bWmXsS5S74z2lNY38NNUaOVHyMBWfltiOLHNZ7jTCni1HcB/QfC+XELR
         sJzgzD/2J/1n/CGIxkkGxest+AUSC3/+DsLh6emdwBEXRz0t1rVh2i7lgOEBc2h6h9R/
         dC44se1d77OWWMqKSls5UcZeUa11wZcRIOgIEn9Gmq4bJ1wwNe9jyUMUGELcp80fNRvE
         MgUQ==
X-Gm-Message-State: AC+VfDyJZpkq5X1NYf0SbgyD0OMdaHHJ6TeiJ1mtuo0tSwShtntY/S0U
        gshOrdF0p3AVCK1itBT9B0s6VFzyM/o=
X-Google-Smtp-Source: ACHHUZ7QPYB91Q9fBhrMvcxcqxzlOP1T4xYOqwIXC2cUjFwt3C6fFz6kpUVhSgNZxK9iNJTOJVPGZA==
X-Received: by 2002:a05:600c:3d91:b0:3f9:b867:4bb with SMTP id bi17-20020a05600c3d9100b003f9b86704bbmr20342030wmb.2.1687875069377;
        Tue, 27 Jun 2023 07:11:09 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm2581935wmj.39.2023.06.27.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:11:08 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] diff --no-index: support reading from named pipes
Date:   Tue, 27 Jun 2023 15:10:13 +0100
Message-ID: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g22d29fd9ba
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

[1] https://lore.kernel.org/git/20200918113256.8699-3-tguyot@gmail.com/
[2] https://lore.kernel.org/git/20181220002610.43832-1-sandals@crustytoothpaste.net/
[3] https://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/


Base-Commit: 94486b6763c29144c60932829a65fec0597e17b3
Published-As: https://github.com/phillipwood/git/releases/tag/diff-no-index-pipes%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/94486b676...990e71882
Fetch-It-Via: git fetch https://github.com/phillipwood/git diff-no-index-pipes/v1

Phillip Wood (3):
  diff --no-index: die on error reading stdin
  t4054: test diff --no-index with stdin
  diff --no-index: support reading from named pipes

 diff-no-index.c          | 83 ++++++++++++++++++++++++----------------
 t/t4053-diff-no-index.sh | 43 +++++++++++++++++++++
 2 files changed, 92 insertions(+), 34 deletions(-)

-- 
2.40.1.852.g22d29fd9ba

