Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816FBC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539762240C
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHODP633"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKSXzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40131 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSXzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so12862856plt.7
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ltP/P1LUYi8a65MyaRPZFmAqwIf6O4hH+TkJONT4LGs=;
        b=DHODP633jRyfYJd7ohD+bLdG1kv7SKtmzbGjKZP65Odxxhj/Ao59sylTnlv72iP/1H
         olBaYDfglD8ERrvbrO4qZgn05LygRsq2xwMFnhoh0AbUx2nE9aOMdEIh09JORUemefkt
         flNNXlvAAT1XT/+spGWrVGMM95mLya3nLUeHL7x36Zdvlgx6gbJlg9BYjwp3f/cJ6K3E
         kCw34yn8T6+gtUppJFVAVhtqnt6/0bpPYFskYBG82vFJDl7YXe0BiQjNuJh9WQJXvTGd
         H0uIL9IwmQueb9BncNInxq2wovGHSP4J/l+HRQB01RqCgFLCXUODccpA2K0UEhZsjFko
         JB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ltP/P1LUYi8a65MyaRPZFmAqwIf6O4hH+TkJONT4LGs=;
        b=V2+H4n8irfxm77FOOO28XhAa3+r9MZ+1zAcwRzpulCicl48UydDc/jddKdNC0zo6An
         nfx6CXvVHp4bvjpsa6HpUsZYlaVQzv/Ckf1DrLm36LPRZipTKyxFIJ7H+fsoxX4/hO6c
         Fw9V+HVH5mSxl3OQhVygVIefNsrpCTTAZcJKUm9CKI/Jbr2t8QNZjiX2AACFKeoQyU8N
         f58AibZ1mHetYms+rSjRGSRiStChN9fYOZ6xItO19mrdRGA5qEE9Ad3en1BU8pjN4pcg
         GP67cdfJaLGdt0piyNrSiZMZpdRBN0BzmceafGTClgb25ZndJr1sUVV9thVeE8aLNOm1
         3jzw==
X-Gm-Message-State: APjAAAXt4VM8tfSiZrXHE+d1GmO+2ps6em+D5CuCDHDfmcgIHkJtpaDF
        /+URjw9yNHdYCmIBVIOxwvP5F3aQ
X-Google-Smtp-Source: APXvYqyucaDhK2u0J2mN1hZOW5D9LofJImWkzxfEH08GTkWv8C9RhjvDthlDlfQalxhjEvHM+yClRQ==
X-Received: by 2002:a17:90a:1b0e:: with SMTP id q14mr273212pjq.132.1574207729720;
        Tue, 19 Nov 2019 15:55:29 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id w19sm25683265pga.83.2019.11.19.15.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:29 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:27 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] range-diff: learn `--notes`
Message-ID: <cover.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574125554.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset teaches range-diff and format-patch to pass `--notes`
options down to the `git log` machinery. This should make the behaviour
more configurable for users who either don't want notes to be displayed
or want multiple notes refs to be displayed.

Changes since v1:

* Complete overhaul of approach

Denton Liu (8):
  argv-array: add space after `while`
  rev-list-options.txt: remove reference to --show-notes
  t3206: remove spaces after redirect operators
  t3206: s/expected/expect/
  t3206: demonstrate current notes behavior
  range-diff: output `## Notes ##` header
  range-diff: passthrough --[no-]notes to `git log`
  format-patch: pass notes configuration to range-diff

 Documentation/git-range-diff.txt   |   6 +-
 Documentation/rev-list-options.txt |   2 +-
 argv-array.c                       |   2 +-
 builtin/log.c                      |  24 ++-
 builtin/range-diff.c               |   6 +-
 log-tree.c                         |   2 +-
 range-diff.c                       |  21 ++-
 range-diff.h                       |   4 +-
 t/t3206-range-diff.sh              | 264 +++++++++++++++++++++++++----
 9 files changed, 286 insertions(+), 45 deletions(-)

-- 
2.24.0.420.g9ac4901264

