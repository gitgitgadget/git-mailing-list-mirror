Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA4C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5349D207C3
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxh+/hTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIMIb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgIMIb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 04:31:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90884C061573
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 01:31:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so3800711pji.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJjq1Dp/uCenGiPTzdL983oaBFZTDQFc/1EkqZFGHiY=;
        b=Oxh+/hTdHk5Fzbd/hrrGcB2kgsQRNnCMVumRLZ6dCVp6c6w4NfvLpzzsDsfDtyCxL9
         zfPT8qq5cZ6j8jg5el5MMD66Ek5MvowwqWkhwMKuw2K9nThouIoa8T0f3p3t6J/y9FWg
         aQOFscBnL3PRZwGWxNFHFs7uBHjcqdKXHa3Z+rdjUXavmnvYJCU0+Fbvo1NklwDUm4Cp
         B0WloXFELjriw0NUkDSLB07DM5ippCdIn4bNC0zijPQ7TxZXjZbp5w0lDOa7A4tP9D0V
         Qlrt4pdGp1B4RmCjBSrnTRMuAYSQ5PGCOYU9fJDn0AY4dVmSYtlFMp2beAwxq+duzIok
         +fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJjq1Dp/uCenGiPTzdL983oaBFZTDQFc/1EkqZFGHiY=;
        b=uNcad4X2rZVn0vmV8oKAVcJzPiJ6PAap/+3ziXUrNmuBeg4L4YVJdpdwIsLDORrk4f
         9KwxpsM4MOYLO/VAjWU0+cGYDxHIr9V9DXBAKJVu4ByZgDZpOz5TyASF7JsGBXp9qNty
         cteKgEe15dIZAr9nfMl29cvsKuWKRwwjlT7D7f7gswJyEPaEs3rLJ8J7zMidQYSHaYQ7
         JtlZYqwivO76JHeAAA5di2a2QNlDbl9MeqYbMTvzMBf2Q2UUJ8g+kMq9n+vK1zyTuJiv
         ePZ0UGUgdVkHUVFf39B1HhVWbSZbSm+oVtYxm8yOfhqnJY5koSz5Z1JhCjeuTmGf0i7r
         rwWQ==
X-Gm-Message-State: AOAM533ZcEcIe95sMWCBhgxbzioD9CTG6yqydRgWH8q5nXef6n5lkmDq
        3WxyMKU+zrrPDioMQhZfJ+5//qTDAYPmCQ==
X-Google-Smtp-Source: ABdhPJz0II/ECvn++R4/PQU/XQ6S+y03mq4Aq75H8VAhAmA1vaFGhbqQJWd4D4LyFF5Q2Rf1V+pspw==
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr8793291pju.166.1599985884995;
        Sun, 13 Sep 2020 01:31:24 -0700 (PDT)
Received: from generichostname ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id kt18sm5921085pjb.56.2020.09.13.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 01:31:24 -0700 (PDT)
Date:   Sun, 13 Sep 2020 01:31:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] builtin/diff: parse --no-index using
 parse_options()
Message-ID: <20200913083122.GA189023@generichostname>
References: <cover.1599332861.git.liu.denton@gmail.com>
 <cover.1599723087.git.liu.denton@gmail.com>
 <ea6717e7b3a8b89fc3750505678321803cde78dc.1599723087.git.liu.denton@gmail.com>
 <xmqqo8mdpji9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8mdpji9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Sep 10, 2020 at 11:35:42AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Instead of parsing the `--no-index` option with a plain strcmp, use
> > parse_options() to parse options. This allows us to easily add more
> > options in a future commit.
> >
> > As a result of this change, `--no-index` is removed from `argv` so, as a
> > result, we no longer need to handle it in diff_no_index().
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  builtin/diff.c  | 33 ++++++++++++++++++++++-----------
> >  diff-no-index.c | 15 +++------------
> >  2 files changed, 25 insertions(+), 23 deletions(-)
> >
> > diff --git a/builtin/diff.c b/builtin/diff.c
> > index cb98811c21..0e086ed7c4 100644
> > --- a/builtin/diff.c
> > +++ b/builtin/diff.c
> > @@ -373,6 +373,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
> >  	int nongit = 0, no_index = 0;
> >  	int result = 0;
> >  	struct symdiff sdiff;
> > +	struct option options[] = {
> > +		OPT_SET_INT_F(0, "no-index", &no_index,
> > +			   N_("compare the given paths on the filesystem"),
> > +			   DIFF_NO_INDEX_EXPLICIT,
> > +			   PARSE_OPT_NONEG),
> > +		OPT_END(),
> > +	};
> 
> What's the reasoning behind teaching the "--merge-base" option only
> to "diff" and not allowing "diff-index" and "diff-tree" to also
> benefit from the new support?

This is a good idea. Initially, I was hesitant because the manpages for
diff-index and diff-tree both list the argument as <treeish> but I think
it makes sense that these commands should accept --merge-base too.

> It should be taught to be handled by
> diff.c::diff_opt_parse() instead, like all other "diff" options.  I
> simply do not see what makes "--merge-base" so special compared to
> other options like "-R", "--color-words", etc.

Unfortunately, despite the above, I don't think we'll be able to handle
this in diff_opt_parse(). --merge-base won't be common to all diff
modes. It'll only work with diff-index and diff-tree, so it'll have to
be handled in those modes specifically.

Thanks,
Denton
