Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9471F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfBLW1b (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:27:31 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34099 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfBLW1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:27:30 -0500
Received: by mail-qt1-f202.google.com with SMTP id u32so381425qte.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dsx5Hrw4vl46EgQrn1YCbGvX7V3hKyAgx31fwwebJmE=;
        b=QpwyLXsuQpdBLi7xR+GUYtGoDYrIZW9miV5HWQJwQVs0Cjz1119AMlf2YBodrWP0qm
         f+/dkishPMxXc0IblVkY7dewY7xw3cQJq231IOvb+1EawB8q5c74VucYWX/JHIDwveRW
         MXsiQYCAcEvEgKGT1PQ8FxbDmOYjXkF447USjfGNvkdiy5FRt/mMKrVmkdQI3KpWyI9r
         iqSUQ6U9Qu+1GYnNKf1jy1TRBgOM4migO3EmPA8CbqxDi27Cy8Zo49rZL9+vG/sYCo1W
         T+obXontAkq1rlapTMIs16tJMAIX9GR4wKWynJUuIdeWuDWBURiYNOOPPflm955QCF9u
         5cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dsx5Hrw4vl46EgQrn1YCbGvX7V3hKyAgx31fwwebJmE=;
        b=leO3OA2q2Vv0/c9RcYwmoMQ2Gfpgvt8H5+DDravvSYiLqYyfPOzZud3PxcpK6HfJKh
         eckbnpL3jwf8ggiSJIzGCM7MRXDvkAmeqip63v/3frv5h+GHVTecZeFsdrstaWCdqrKt
         LZ1yVFtsdxLymC6eoFJ5UchYqCyZpLnqgLx5aRr4MdRyhxmYcpvZe0dGwJehT2AuGjRe
         Ul4pLIuKQpriD5aheyu0Rpunw0P4ruMV5UU9PDKV1X1j+SGXQbsd+iYtcO5xlqk9bQUA
         NsPaS1gKYzz5tAkyzH9UpIPL1R51yo6xwlTW5Wiv8+Njdc42w4oZk+bmesQnMUWP5DZI
         Znog==
X-Gm-Message-State: AHQUAuZ86JD+hUftViBduOs/ZOuzOqocDbqw5lI3cT67Jg78Kx8DU+hJ
        7n5iffG2CD2CNq+IpSFL5pnJoxC0c21iSeJSY7KbATy3Ft1x7TY0WjRoWcuA1acsMRDEIjUhTwv
        1+kU0ly6e89Z6LE45k8ugo5Jiz1nTAnQXdoWQ/UlkrBs9mwvNH/QA
X-Google-Smtp-Source: AHgI3Ib8PAAl9sdNSTwSmIoN7gxtPWGBh8/oGlVlj2K8jdKZb+PQcqqHTgsCLhPuqN4B9Feg5yrH8nfd
X-Received: by 2002:a0c:d1cd:: with SMTP id k13mr3324728qvh.40.1550010449600;
 Tue, 12 Feb 2019 14:27:29 -0800 (PST)
Date:   Tue, 12 Feb 2019 17:27:17 -0500
Message-Id: <20190212222722.240676-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v3 0/5] blame: add the ability to ignore commits
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

Barret Rhoden (5):
  Move init_skiplist() outside of fsck
  blame: use a helper function in blame_chunk()
  blame: add the ability to ignore commits and their changes
  blame: add a config option to mark ignored lines
  blame: add tests for ignoring revisions

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
2.21.0.rc0.258.g878e2cd30e-goog

