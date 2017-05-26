Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A638209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969428AbdEZDfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:13 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33324 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758076AbdEZDfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:12 -0400
Received: by mail-pf0-f177.google.com with SMTP id e193so185089499pfh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUPdGw6tr5TYPDWsNVkenAHCOoDWdYOZh5GFNul4KMo=;
        b=ONGhpPOb8onhbPDfsiGq+V4KtU/G9HDX0nnGPbqJBeukYZB5y1LuJffD0G6S8lEp88
         CHSa62n6L6njUoSgZubiHwKozp+5ZgyfALi/QpA6yiwClY7mBQj9gYQmRgw740xUDKo5
         pOQGIoxTe7IKLsxTcBgO8gm3zGUPxgjdDd2n9s+LBNFvhfsvHBGk3EW/OWWgbUxW2n5q
         9P3HYNaU5GTJmFPQ9dwW4jgGZM+QlKqZLnCloof9XMPV+j7vaCHtQ2TKyK6icErJFhh2
         0rhS16juMjCGRwWxi6AIOstCsAYIY9E2g3tVnf11o183TAHJejOQgocoMoa9qS+VMiha
         y/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZUPdGw6tr5TYPDWsNVkenAHCOoDWdYOZh5GFNul4KMo=;
        b=Bx7QqCxp4XTYi1Pog4JDgolZUSMroA9J18M+JsKlYj+hSDZTTlgZ1flabJoNd6PiIV
         d8bxVJeHp8J83Oieu4XtnUrVEh1k/v58i6JLF/XqjlLoicppgj7pQmjTZyFattU0JKyf
         k/jtPJNbAer7RDKGZPh36KJalOyJNLmb1FazqhGKiHtlBsTAMQ918sH/T/ohUA0zD9Xy
         ZQJUIEt6kMLP4el6nCWepH6rFVmdq3ScrLduvM8qx1OOx+SCbjiD4sSg/Mecjm8/fQW2
         6VPb0Qa7tR6yUCRD7g5uNlnJGrIw9ZktRCMLHo26A/Pc3KIlLQ6YJZc9j4T4dVkNeErO
         vtNg==
X-Gm-Message-State: AODbwcCoz9um7mkTwHMiwrpITeHrgTagU9h8HlLXobC+jB+2ICZEBVwv
        NkNUTeIdqv+uQg==
X-Received: by 10.98.64.143 with SMTP id f15mr49436942pfd.109.1495769711774;
        Thu, 25 May 2017 20:35:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id z14sm15689742pfg.109.2017.05.25.20.35.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 00/13] reporting unexpected errors after (f)open
Date:   Fri, 26 May 2017 12:34:57 +0900
Message-Id: <20170526033510.1793-1-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are taken from https://github.com/pclouds/git/commits/fopen-or-warn
cf. <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
with a few bits salvaged from its v2 version.


Ramsay Jones (1):
  git_fopen: fix a sparse 'not declared' warning

Nguyễn Thái Ngọc Duy (9):
  use xfopen() in more places
  clone: use xfopen() instead of fopen()
  config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
  wrapper.c: add and use warn_on_fopen_errors()
  wrapper.c: add and use fopen_or_warn()
  wrapper.c: make warn_on_inaccessible() static
  print errno when reporting a system call error
  rerere.c: move error_errno() closer to the source system call
  log: fix memory leak in open_next_file()

Junio C Hamano (3):
  config.mak.uname: set FREAD_READS_DIRECTORIES for Darwin, too
  wrapper: factor out is_missing_file_error()
  is_missing_file_error(): work around EINVAL on Windows

Patches 12 & 13 are my attempt to answer the issue the series had on
Windows.
cf. <xmqq37bseddy.fsf@gitster.mtv.corp.google.com>


 attr.c                |  7 ++-----
 bisect.c              |  7 ++-----
 builtin/am.c          |  8 ++------
 builtin/blame.c       |  2 +-
 builtin/clone.c       |  2 +-
 builtin/commit.c      |  5 +----
 builtin/fast-export.c |  4 +---
 builtin/fsck.c        |  3 +--
 builtin/log.c         | 11 ++++++++---
 builtin/merge.c       |  4 +---
 builtin/pull.c        |  3 +--
 commit.c              |  2 +-
 compat/fopen.c        |  4 ++--
 config.c              |  5 ++++-
 config.mak.uname      |  4 ++++
 diff.c                |  8 ++------
 dir.c                 |  6 +++---
 fast-import.c         |  4 +---
 git-compat-util.h     | 15 +++++++++------
 ident.c               |  8 +++-----
 remote-testsvn.c      |  8 ++------
 remote.c              |  4 ++--
 rerere.c              |  7 ++++---
 sequencer.c           |  8 ++++----
 server-info.c         |  2 +-
 t/t1308-config-set.sh | 13 ++++++++++++-
 t/t5512-ls-remote.sh  | 13 ++++++++++---
 wrapper.c             | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 wt-status.c           |  3 ++-
 xdiff-interface.c     |  4 ++--
 30 files changed, 133 insertions(+), 90 deletions(-)

-- 
2.13.0-491-g71cfeddc25

