Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565092035A
	for <e@80x24.org>; Tue, 11 Jul 2017 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbdGKTsl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 15:48:41 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34090 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdGKTsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 15:48:40 -0400
Received: by mail-pg0-f45.google.com with SMTP id t186so1126296pgb.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jn9OBHicY1K8awiyTSb89VtGV1mZn41H/AjQhdVUZA8=;
        b=hukj5C+yKnhJtC3eszOlos5RG24h6aG1xTxon8W8wYcOrf5c32B+UqFk1KB4rOj2uB
         5M5DI3l+zm5hhjB2ZF+ZgbjTEtBZh9GFDUMmESkYVIMcBcpL0M8jODVo0GedlMcmmRis
         CngnHGrUXIhenYHoYm7XEDvprM95Imi6XI5VmYhKcShQ0TazRxAqHxEjQy4K2n5E57Wf
         4f5J1EVrMKZDplmJVnEFqkj1b9Crf4u0Zov+h1ymy/iqP/s6gACt0rpibhcj/2w6w/Ds
         7JynXU4JxYY+bBADPzQpK0zzJtuTX7Bt3cOBWOifgDDdUcQFQgtpiru6DkMSHbTpFfCK
         Yhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jn9OBHicY1K8awiyTSb89VtGV1mZn41H/AjQhdVUZA8=;
        b=lXbm3xonpo4fWcAXPBlrr884KyFYiOyKxQ39Zkc7hN638L2p9t3OR+0qwJi308l/Rj
         J2ZtNB9lsjfX0foRL2hyY66uwSkyt0ViiHuaq7LKMWcjO6muOg1Hv+zo8NIF7q0iXXbI
         TA0fsBORX9KI7QJlEkaSk4DWgRALDrJmL62ogyyNbs0L7FrltY6lAU7WUO/8kt3rRSwa
         H+0qyyHucl5UPTiK960mbIjKB4VVTP8y32MIVY0q0CN9rHP7pn+hJy9sdoGWyBYyhqRO
         woDWXmz0/F7KpgKGDGgNFcGlYuxyQU2W/cebiX8145Q/i/Ya+brIxekqZOwdPR3WK6x9
         UIjw==
X-Gm-Message-State: AIVw111kIMS0Fl3kGVg/Vtn6yRMctPlMVinTo/1u4LgtjYWryMS/OZvg
        fqhsmUlG0KMX+IKBTSyAQQ==
X-Received: by 10.84.208.236 with SMTP id c41mr67137plj.152.1499802519354;
        Tue, 11 Jul 2017 12:48:39 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id 85sm227557pfr.90.2017.07.11.12.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 12:48:38 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
Date:   Tue, 11 Jul 2017 12:48:29 -0700
Message-Id: <cover.1499800530.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are part of a set of patches implementing partial clone,
as you can see here:

https://github.com/jonathantanmy/git/tree/partialclone

In that branch, clone with batch checkout works, as you can see in the
README. The code and tests are generally done, but some patches are
still missing documentation and commit messages.

These 3 patches implement the foundational concept - formerly known as
"missing blobs" in the "missing blob manifest", I decided to call them
"promised blobs". The repo knows their object names and sizes. It also
does not have the blobs themselves, but can be configured to know how to
fetch them.

An older version of these patches was sent as a single demonstration
patch in versions 1 to 3 of [1]. In there, Junio suggested that I have
only one file containing missing blob information. I have made that
suggested change in this version.

One thing remaining is to add a repository extension [2] so that older
versions of Git fail immediately instead of trying to read missing
blobs, but I thought I'd send these first in order to get some initial
feedback.

[1] https://public-inbox.org/git/cover.1497035376.git.jonathantanmy@google.com/
[2] Documentation/technical/repository-version.txt

Jonathan Tan (3):
  promised-blob, fsck: introduce promised blobs
  sha1-array: support appending unsigned char hash
  sha1_file: add promised blob hook support

 Documentation/config.txt               |   8 ++
 Documentation/gitrepository-layout.txt |   8 ++
 Makefile                               |   1 +
 builtin/cat-file.c                     |   9 ++
 builtin/fsck.c                         |  13 +++
 promised-blob.c                        | 170 +++++++++++++++++++++++++++++++++
 promised-blob.h                        |  27 ++++++
 sha1-array.c                           |   7 ++
 sha1-array.h                           |   1 +
 sha1_file.c                            |  44 ++++++---
 t/t3907-promised-blob.sh               |  65 +++++++++++++
 t/test-lib-functions.sh                |   6 ++
 12 files changed, 345 insertions(+), 14 deletions(-)
 create mode 100644 promised-blob.c
 create mode 100644 promised-blob.h
 create mode 100755 t/t3907-promised-blob.sh

-- 
2.13.2.932.g7449e964c-goog

