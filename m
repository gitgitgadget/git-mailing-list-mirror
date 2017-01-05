Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A301205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763661AbdAETa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 14:30:56 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35778 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754768AbdAET3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 14:29:11 -0500
Received: by mail-pg0-f43.google.com with SMTP id i5so178653993pgh.2
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+3B2v9/M9WT4Yl3grpZwbqOQqjUox/He6eusVIJq9w=;
        b=keSveuBOMQVeBPxpYnFIJ8gF0cxKE1IAP4SZ8k7JDwSIZiBaEbl3JlnS7Ixi3lwb5r
         lOXbaoerv7NDGsCBCKgCERNuJCcZg5v4neGqJjBxt+bP/NNId0TJH8JH+IHQsnDSaCuv
         LJPeQblQFxwtnWoflNZUpuCkqf/QxbSTCr0IuW39RW3ryGU/BdubY7ZPqqQWPxqp9Qby
         DEELqun8fammJz65u3KS9DN3yVFLYmbCEMAE/4uPe5jOi8bJgLJ0x2SA2CjPjxVbbauq
         YmT0yeLydQpz/GSjjxVaU9FvtsvUamjKMF+Q8dU0C/SdwPPk+WGsmLHEFNAgj/FEgU0J
         +T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+3B2v9/M9WT4Yl3grpZwbqOQqjUox/He6eusVIJq9w=;
        b=j/MFom6OQGT/0FuALxTeiUs8IGqTwDblyO2Ow8ELnxyKi3/ch1gLUZuUDWhC0REJL3
         9KLFis9ThvnkE5PfSEdol2u6Io5Mxq1Vjwe/B3hAvYRwgDXuXC3RY52ZlCkdeplzG22F
         rnwkXVoRC/GThih5fuTOe1UuQiK7OoTgvNCzHsHm9nYThYny7Euktm2VyWXpdK0nfc4/
         VYV4l1/HPDSpT+tYfP5FtU76POIk3n54sEvZi20KoKjsWQ4o0PwPPJfqcdh+reGEHJxn
         Ud5RloN5FjcBbjK0I89QY/orAJNNM0UGUQ5j4VPH7HbOz/G/aDhe+IGqwePYDFwmliwJ
         SCNA==
X-Gm-Message-State: AIkVDXJnR4XqxmVg8gylA8DnhiSyU1JkCRXksZZJkxPBqWpKY44K862eLM7rKV9nKPNM+nAf
X-Received: by 10.84.210.38 with SMTP id z35mr143851896plh.111.1483644550415;
        Thu, 05 Jan 2017 11:29:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:d8d4:45f:826c:3a9f])
        by smtp.gmail.com with ESMTPSA id d15sm155306963pfl.46.2017.01.05.11.29.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Jan 2017 11:29:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/2] pathspec: give better message for submodule related pathspec error
Date:   Thu,  5 Jan 2017 11:29:02 -0800
Message-Id: <20170105192904.1107-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6:
* rebased on top of origin/bw/pathspec-cleanup, resolving conflicts.
  (Additionally needs merging with origin/sb/submodule-embed-gitdir to have 
  6f94351b0, test-lib-functions.sh: teach test_commit -C <dir>)
* reworded comments and commit message
* do not reuse the strip_submodule_slash_expensive function, but have
  a dedicated die_inside_submodule_path function.

v5:
* was just resending the latest patch, which turns out to be in conflict with
  origin/bw/pathspec-cleanup

v4:
> It MIGHT be a handy hack when writing a test, but let's stop doing
> that insanity.  No sane project does that in real life, doesn't it?

> Create a subdirectory, make it a repository, have a commit there and
> bind that as our own submodule.  That would be a more normal way to
> start your own superproject and its submodule pair if they originate
> together at the same place.

This comes as an extra patch before the actual fix.
The actual fixing patch was reworded borrowing some words from Jeff.
As this makes use of "test_commit -C", it goes on top of sb/submodule-embed-gitdir

v3:
more defensive and with tests.


Stefan Beller (2):
  submodule tests: don't use itself as a submodule
  pathspec: give better message for submodule related pathspec error

 pathspec.c                       | 31 ++++++++++++++++++++++---------
 t/lib-submodule-update.sh        |  2 ++
 t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 t/t7001-mv.sh                    |  5 +++--
 t/t7507-commit-verbose.sh        |  4 +++-
 t/t7800-difftool.sh              |  4 +++-
 t/test-lib-functions.sh          | 16 ++++++++++++++++
 7 files changed, 82 insertions(+), 13 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

-- 
2.11.0.31.g919a8d0.dirty

