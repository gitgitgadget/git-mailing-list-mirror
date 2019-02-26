Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D374020248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfBZRHE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:07:04 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:38160 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZRHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:04 -0500
Received: by mail-yw1-f73.google.com with SMTP id c67so9294960ywe.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4VF6VQJOcckRXpJjMmLZpeyNYeZQQJT2UWbsnb579Bw=;
        b=YAGCTs5qbT9BMQBhHEeBWimy064thirjDBR/9rPOxDZepXqI8ar4dzZOlf3fipZWpV
         kqNfBF04wwlPxhlLVHPRcz/SmX9kd4Cmn9Bf6vxFuEAnq/84rfPDRLOjaqetRUKuaf5c
         6MXDdP0Ne27jp7sHgKjAcypPR1Xdjx7UK9jHcVt4CMIjorvVYZK0bCDMaV32W7GHE98v
         JCl3YxhvdXNh7h4noU95i08fxT5CA5CU2UeuoL2VYDx4uqoMuBAYg8hdFFsmgHvkOhDu
         xa1zJ0bRHjUQVala0/8yNUO0+Bh6eQTtm92EXiYx31gJ4AfT4pInm+JMUXJ8M6lgQWtk
         fHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4VF6VQJOcckRXpJjMmLZpeyNYeZQQJT2UWbsnb579Bw=;
        b=FteOshHpyDfevaKslrh0NjbyI7ZN2thXPY96+EGiWsPaWE/nwVoxWOHOlj8bh+WSSd
         Y6qkwjictDtUAhRf4RnFWSpP8AcP3i2BN8HR/flmaABuGro+z/7HanfJ9156IlikNn5Y
         vNpYPCzkhX6im5/7nJlFZ9BwI2BfqtHLigx8lR78hwUWy1sOinstWnCGUwj89+EbzhSZ
         ndXKOEsnZoAY0Qkf7xFhRjSUvtyQvbekL/iKQKwO27uRoCbBvxySkvPa9CZmFQk8YsbL
         uTHAVrn1zxn89jXCB/MNUDnpOqWJpfptqrIoPZSH9ocmufXmar0BGYJA36Rh60Qx+E0W
         YAAw==
X-Gm-Message-State: AHQUAuYe6+8NVHEsIgml2y1JMnoxE9ZUsaIgpobcfgYE7KassZ4tOMkh
        Cq+rDpodKx1hNnGL1GMz6t2VNtfwdSUfKOlH4Ww0wR0hHBEy8dFKnLJkAVmCrm0amv8tQjpq7+Y
        eb44M/2gHWJDkNaKJsGNaBzeL6KEtnqWNVVeEnAQPxVtcTZd2Se1k
X-Google-Smtp-Source: AHgI3IYEmc1mXXJup+jFypQs3IZy9VbEUEBPTzBNsb+wCEmxA2R56rO11o6KQXw+P2uJ414HzN2UOhLW
X-Received: by 2002:a0d:e887:: with SMTP id r129mr9408936ywe.19.1551200823203;
 Tue, 26 Feb 2019 09:07:03 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:06:44 -0500
Message-Id: <20190226170648.211847-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 0/4] blame: add the ability to ignore commits
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set adds the ability to ignore a set of commits and their
changes when blaming.  This can be used to ignore a commit deemed 'not
interesting,' such as reformatting.

v3 -> v4
v3: https://public-inbox.org/git/20190212222722.240676-1-brho@google.com/
- Cleaned up the tests, especially removing usage of sed -i.
- Squashed the 'tests' commit into the other blame commits.  Let me know
  if you'd like further squashing.

v2 -> v3
v2: https://public-inbox.org/git/20190117202919.157326-1-brho@google.com/
- SHA-1 -> "object name", and fixed other comments
- Changed error string for oidset_parse_file()
- Adjusted existing fsck tests to handle those string changes
- Return hash of all zeros for lines we know we cannot identify
- Allow repeated options for blame.ignoreRevsFile and
  --ignore-revs-file.  An empty file name resets the list.  Config
  options are parsed before the command line options.
- Rebased to master
- Added regression tests

v1 -> v2
v1: https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/
- extracted the skiplist from fsck to avoid duplicating code
- overhauled the interface and options
- split out markIgnoredFiles
- handled merges


Barret Rhoden (4):
  Move init_skiplist() outside of fsck
  blame: use a helper function in blame_chunk()
  blame: add the ability to ignore commits and their changes
  blame: add a config option to mark ignored lines

 Documentation/blame-options.txt |  16 +++
 Documentation/config/blame.txt  |  11 ++
 Documentation/git-blame.txt     |   1 +
 blame.c                         | 115 ++++++++++++++----
 blame.h                         |   4 +
 builtin/blame.c                 |  51 ++++++++
 fsck.c                          |  37 +-----
 oidset.c                        |  35 ++++++
 oidset.h                        |   8 ++
 t/t5504-fetch-receive-strict.sh |  14 +--
 t/t8013-blame-ignore-revs.sh    | 199 ++++++++++++++++++++++++++++++++
 11 files changed, 423 insertions(+), 68 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh

-- 
2.21.0.rc2.261.ga7da99ff1b-goog

