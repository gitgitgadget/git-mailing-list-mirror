Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A115DC33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D7207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="gfD8OsTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAEN4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34274 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id x17so20814259pln.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tN0sQOzrJbyygXh3q6WP8MAUv/vYM4p65e0NsrBnv08=;
        b=gfD8OsTI2aYB75uESLIpYFS8MAEYKEeBcKtxxBjvyqlntW9iqM8SqktlE21Yw0JJa0
         TVqi8ILSc57WyEMONAZ/lQGW5FoWsc63nqm7uE+1RiRUCu0CHmDmKp47IHsgeJ/SXdvp
         ZPXWmGj3/+u0NbBuKyRaAwKXXFvh0X7PJrUzAS8bJmzD4rT6535RVsXDgHCAevlyDCWP
         PgNZrj+Ngs7ByD/tfsrfbZGTn1oC7/ivvtzYiQv46i/ilnxGEZGWXnLzgrb5ZOBSblCP
         5triKBqyV0WkdkcnAci0eDdXGFv5BGDAxFCPi0scc9eLVqo8wMuxyZ6se1P+YEibiGfW
         /trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tN0sQOzrJbyygXh3q6WP8MAUv/vYM4p65e0NsrBnv08=;
        b=hNTxewqUYbtklRespVIrycJLS2NSsuCxCb5kH3znRTjqA3HUu06J0f1oe3Q8mwVsVU
         WB9F3E4RY1LqU/JcGI8ZiAesPiutSzZ5azRmJrSCmbi0NJMYKX3xLLS/uCFqm8Um/HdA
         8C/NiiQKff/yXEDF5cUXohJAgmH9OIn6iucS3oFnrZIXGpdSk73BRFTQQV3AlFJCVlGz
         iD03oITeSt6SqxZ0IvEhQBRubmw6ugoKUbqBWreaoSwqHi/TxXMjUs2ECW1x+n0i3MpO
         d5h1U1U/W/FT0a2dWS7Cv1can4yKM7dIDSpKF/Bmnbf+UF6URDbrc80KAb7b2llZV5sw
         slTA==
X-Gm-Message-State: APjAAAU+CO1ABiM++fp2yG6SsdA1eEmT324NdXrx6OTklh2kCGxwUxaX
        VkNV3IrP+EAGjU56bOUPpC8lhkt0GFc=
X-Google-Smtp-Source: APXvYqwUEfXAl93PpaBYf1luIyei/GjMMeEWQ8hSQMd76NdSaGdZ10nwk7s00uWcKdXmaqCi6IBQYw==
X-Received: by 2002:a17:90a:330c:: with SMTP id m12mr37498244pjb.18.1578232580992;
        Sun, 05 Jan 2020 05:56:20 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id a17sm21852892pjv.6.2020.01.05.05.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:20 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 0/5] refactor gpg-interface and add gpg verification for clones
Date:   Sun,  5 Jan 2020 13:56:11 +0000
Message-Id: <20200105135616.19102-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series starts off with refactor of print_signature_buffer() to make
all output conditional based on the 'flags' parameter.  The print
function is also extended to optionally show one-line summaries of
signature verifications (previously that functionality existed in
verify_merge_signature()).

The helper functions for signature verification of commits are then
refactored.  The new gpg_verify_commit() function is modelled after
gpg_verify_tag().  This allows us to remove verify_merge_signature() and
the file-local run_gpg_verify() (from the verify-commit builtin).  It
also allows us to change check_commit_signature() into a local function
in commit.c.

A new configuration option is also introduced, gpg.verifySignatures.
This allows users to enable signature verification for all operations
that support it.  Individual operations can then use
<operation>.verifySignatures for finer-grained control.

And finally, signature verification is added to the clone builtin.  It
obeys --(no-)verify-signatures, clone.verifySignatures and
gpg.verifySignatures (in decreasing order of significance).

A notable quirk with signature verification for clones is
--recurse-submodules.  As mentioned in the commit message, the current
workaround is to disable signature verification for submodules by
passing --no-verify-signatures in submodule--helper.c

I'm very much open to suggestions for a better approach of dealing with
recursive clones.  However, I don't think --verify-signatures from the
clone builtin should propagate to submodules, because that would break a
workflow where a user:

1. trust the hash function
2. has audited an unsigned repository at a given point
3. has added the repository at that point as a submodule
4. has signed an object in the super repository where the audited
   submodule is referenced

So, I think it'd make more sense to introduce a
submodule.verifySignatures config knob to be used by both
--recurse-submodules and when the 'submodule' command is used directly.

I hope this patch series isn't too confusing/all over the place. I
wasn't sure whether the preparatory patches would have made sense in
isolation, so I opted to send it all in one go.

Hans Jerry Illikainen (5):
  gpg-interface: conditionally show the result in
    print_signature_buffer()
  gpg-interface: support one-line summaries in print_signature_buffer()
  commit: refactor signature verification helpers
  merge: verify signatures if gpg.verifySignatures is true
  clone: support signature verification

 Documentation/config.txt           |   2 +
 Documentation/config/clone.txt     |   3 +
 Documentation/config/gpg.txt       |   6 +
 Documentation/config/merge.txt     |   4 +-
 Documentation/git-clone.txt        |   4 +
 builtin/clone.c                    |  46 ++++
 builtin/merge.c                    |  22 +-
 builtin/pull.c                     |  18 +-
 builtin/submodule--helper.c        |   6 +
 builtin/tag.c                      |   4 +-
 builtin/verify-commit.c            |  26 +-
 builtin/verify-tag.c               |   4 +-
 commit.c                           |  58 ++--
 commit.h                           |  31 +--
 gpg-interface.c                    |  43 ++-
 gpg-interface.h                    |  11 +-
 pretty.c                           |   3 +-
 t/t5619-clone-verify-signatures.sh | 411 +++++++++++++++++++++++++++++
 t/t7612-merge-verify-signatures.sh |  27 ++
 tag.c                              |  19 +-
 20 files changed, 633 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/config/clone.txt
 create mode 100755 t/t5619-clone-verify-signatures.sh

--
2.25.0.rc1.302.gc71d20beed
