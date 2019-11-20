Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F833C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A62245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUdtq/a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKTAvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46921 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so12922414plt.13
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K35DLlbtm3xLQoaVV6XJrooDS2llATtVGE93x/7FiyA=;
        b=CUdtq/a31RVJuoiAoRkTYROqMdEn4etuFJhpuF0IJ4SwbMd2EgXvnDmhohG4rE3JMU
         QaV/CfwcnpFj0BCeDFqIIsaIKJot5Io2n65B4I261vjH500bd4nZftTVy7SpdOGKegjm
         5Zfptg1Zp6rvdZXtimbzHSbAQCMFn09tTEQHn+BAfIsLVflAmpO6GBd5bLwZwv6NQFAs
         CKJ0hVe+kWLKsgD2yAyYP3LMXn0sRQL3U8qzNGMlW5g6vb/Y5Jl55OVaYTfWzNjkujI/
         YX9a4SqvpDic1jEuPnUZSJxC24Rrg/YsEGMsEcnW9FjXlaBjyZpoRKZ1ZtJ+qcHFCYav
         JvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K35DLlbtm3xLQoaVV6XJrooDS2llATtVGE93x/7FiyA=;
        b=kTRqDBmJaIDedZvX0gSZZKT9wOexu55e06T+/eKdK4O0BPV+exjJYscIuSsZSHSzoK
         hhZnM81fKdepqCQPlr38HOFFrVem7FyvS6DJM8H8KkwwYJIYh9nu48iSMxFTEKeVGbhn
         MXAQhGS73WMY0JZqQ9V6ATAcx3lUxL0tFjCHtx13ZisklVuY9BM1xKHWwnYYFrQlpPbF
         S4gOm/tomkAIw1jbbpAQ0sKfgijlYz4yCXlWvVVnqROoJCrhPpFLFe003Z31ZB806amY
         qMTkYGCgdPtu2p5jPoY8GRynzKu2xBaZu2n1aqxlTlqQRrTnO5MWSPrq4qlysguEyFOk
         Poqw==
X-Gm-Message-State: APjAAAXTNpp68b6Ab+2mh02QWzs3UOG+Li79AltvE5DyJlbIgawuCwPJ
        GJi3nBmhwTdJL0dLCe+tG5GzXYb4
X-Google-Smtp-Source: APXvYqwqVofv+GdmqEp5C3kh/QznNw5oBQS1pkqC2tG7UeRdiUnliayiQY4Of+c2CPvPVzZ4OCeIaA==
X-Received: by 2002:a17:90a:8a90:: with SMTP id x16mr529741pjn.66.1574211063490;
        Tue, 19 Nov 2019 16:51:03 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j17sm26255904pfr.2.2019.11.19.16.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:02 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 00/11] learn the "reference" pretty format
Message-ID: <cover.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On this mailing list (and many others) the standard way to reference
other commits with the "reference" format, e.g. "f86a374 (pack-bitmap.c:
fix a memleak, 2015-03-30)". Since it's so commonly used, let's
standardise it as a pretty format.

Patches 5-7 were cleanup patches that were critical in earlier
iterations of the series but no longer are critical for the rest of the
patchset. Nonetheless, let's include them since they improve the quality
of the codebase.

Changes since v4:

* Add a column in `struct cmt_fmt_map` to handle the default short date
  of `--pretty=reference`

Changes since v3:

* Change one reference from "summary" to "reference"

* Clarify --pretty=reference documentation

* Add a squashable patch at the end to implement overridable --date

Changes since v2:

* Rename from "summary" to "reference"

* Implement the feature as a canned userformat

* Implement the %*s (short date) format string element

* Remove the enclosing dqs around the subject

Changes since v1:

* Replace more references to "sha1" with "hash"

* Clean up 8/10 by losing the allocation and making the subject less
  misleading

* Add tests in 7/10 to ensure 8/10 does not change any behaviour

Denton Liu (10):
  SubmittingPatches: use generic terms for hash
  pretty-formats.txt: use generic terms for hash
  SubmittingPatches: remove dq from commit reference
  completion: complete `tformat:` pretty format
  revision: make get_revision_mark() return const pointer
  pretty.c: inline initalize format_context
  t4205: cover `git log --reflog -z` blindspot
  pretty: add struct cmt_fmt_map::default_date_mode_type
  pretty: implement 'reference' format
  SubmittingPatches: use `--pretty=reference`

René Scharfe (1):
  pretty: provide short date format

 Documentation/SubmittingPatches        | 16 ++++--
 Documentation/pretty-formats.txt       | 29 +++++++---
 Documentation/pretty-options.txt       |  2 +-
 Documentation/rev-list-options.txt     |  4 +-
 contrib/completion/git-completion.bash |  2 +-
 pretty.c                               | 20 +++++--
 revision.c                             |  4 +-
 revision.h                             |  4 +-
 t/t4205-log-pretty-formats.sh          | 79 ++++++++++++++++++++++++++
 9 files changed, 134 insertions(+), 26 deletions(-)

Range-diff against v4:
 1:  616cda0b4d =  1:  616cda0b4d SubmittingPatches: use generic terms for hash
 2:  badd3d4275 =  2:  badd3d4275 pretty-formats.txt: use generic terms for hash
 3:  ff818446ad =  3:  ff818446ad SubmittingPatches: remove dq from commit reference
 4:  2baa7f8d3d =  4:  2baa7f8d3d completion: complete `tformat:` pretty format
 5:  ac23c4ec45 =  5:  ac23c4ec45 revision: make get_revision_mark() return const pointer
 6:  fa375f8271 =  6:  fa375f8271 pretty.c: inline initalize format_context
 7:  1519677b30 =  7:  1519677b30 t4205: cover `git log --reflog -z` blindspot
 8:  6c41491c3e =  8:  6c41491c3e pretty: provide short date format
 -:  ---------- >  9:  ec05907b62 pretty: add struct cmt_fmt_map::default_date_mode_type
 9:  7b0cf7a39f ! 10:  5264c44fab pretty: implement 'reference' format
    @@ Documentation/pretty-formats.txt: This is designed to be as compact as possible.
     +	  <abbrev hash> (<title line>, <short author date>)
     ++
     +This format is used to refer to another commit in a commit message and
    -+is the same as `--pretty='format:%C(auto)%h (%s, %as)'`.  As with any
    -+`format:` with format placeholders, its output is not affected by other
    -+options like `--decorate` and `--walk-reflogs`.
    ++is the same as `--pretty='format:%C(auto)%h (%s, %ad)'`.  By default,
    ++the date is formatted with `--date=short` unless another `--date` option
    ++is explicitly specified.  As with any `format:` with format
    ++placeholders, its output is not affected by other options like
    ++`--decorate` and `--walk-reflogs`.
     +
      * 'email'
      
    @@ pretty.c: static void setup_commit_formats(void)
     -		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
     +		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
     +		{ "reference",	CMIT_FMT_USERFORMAT,	1,	0,
    -+			0, "%C(auto)%h (%s, %as)" },
    ++			0, DATE_SHORT, "%C(auto)%h (%s, %ad)" },
      		/*
      		 * Please update $__git_log_pretty_formats in
      		 * git-completion.bash when you add new formats.
    @@ t/t4205-log-pretty-formats.sh: test_expect_success '%S in git log --format works
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=reference always uses short date' '
    ++test_expect_success 'log --pretty=reference with log.date is overridden by short date' '
     +	git log --pretty="tformat:%h (%s, %as)" >expect &&
    ++	test_config log.date rfc &&
    ++	git log --pretty=reference >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'log --pretty=reference with explicit date overrides short date' '
    ++	git log --date=rfc --pretty="tformat:%h (%s, %ad)" >expect &&
     +	git log --date=rfc --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
10:  746481042a = 11:  1281927cb3 SubmittingPatches: use `--pretty=reference`
11:  9d50c069f7 <  -:  ---------- squash! pretty: implement 'reference' format
-- 
2.24.0.420.g9ac4901264

