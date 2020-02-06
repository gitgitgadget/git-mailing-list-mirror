Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E6C352A3
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335B520838
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1GkJqZWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBFRsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:48:41 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:37272 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBFRsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 12:48:40 -0500
Received: by mail-pf1-f179.google.com with SMTP id p14so3486673pfn.4
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NiQf4Eblr/ZMXa+o2Mtmvd78jJd+ukMQUzB6Sa7ZnXw=;
        b=1GkJqZWae3PcIR6epB+VqmdfJAXfM8agBJvuTY7g5ohOXkxmkri6hXAmM6wtgtMUtA
         gRrsO7Z8F+XPvQXpQyl7WtzySE24s3GOWrgbv/Piwf+XBNPw7GUJqpxQA7ZoghmFEotb
         TTKl0kqKjwL9RJWRxGh3RA1Zze2Jen+S5ZJZqthye5BCgFc5wVIqaLkiMJYwi+qGVjBY
         Z38NbghRHxlz8kMVA2645TEgjJEIk+x7UTEExhrMIADQowWWWMx+JkaMmMo9Wa73mfmd
         IAkvHEh4D5mCaHlbaV38sRFZoFWdcIxkb0+rNouPQNt1MbISzo02zlP+ULw2yeyES7ly
         uVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NiQf4Eblr/ZMXa+o2Mtmvd78jJd+ukMQUzB6Sa7ZnXw=;
        b=UaCygRQai4DBBLPJZt8+FbR01A1rZn6MbQ1VPT2Jkd3rB4VDCXDKAxKpNwmiRYsziV
         rKz2uIYKa7E4rGmJD65WOSd2pRy/P3AxBHgBWH+J5ThsbhepHwIqmnZK8K94FTmt578z
         D/DH/8Ne015Mvo3tl1LBfv7Y7IzoaOMHSzpgPguQgbc07MRhTd9ROEoNc/qUNJd5rmdE
         XNdEz44a/M/4c3gKSO7uKSzu4cx39PRkba9fTk4ngk1o2SZhEb9o7h+LXZo3+xcX0nsx
         UhsqH20s1wiB/g9peqgTUYzUAN1YXjLMWJ97Xkc/qTkiB429xf0KUjnpPH8BgyzT6iqb
         ohAA==
X-Gm-Message-State: APjAAAUlH6ejkfXgcAE/rZxsOneA2F+Qd/OBCkPs/JJ8gf74hI/Ef1la
        VKIEreA2KxAGG5nLZkya8LDc/Q==
X-Google-Smtp-Source: APXvYqyoMH44UyYtBPjvPpFIgliPuYiSQ/RkwsqYw/X5RWtAU82YY0klX/6/4CADcaihL4L4qA+7Hg==
X-Received: by 2002:a62:6409:: with SMTP id y9mr5183522pfb.30.1581011319814;
        Thu, 06 Feb 2020 09:48:39 -0800 (PST)
Received: from localhost ([205.175.106.196])
        by smtp.gmail.com with ESMTPSA id w3sm62013pgj.48.2020.02.06.09.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 09:48:38 -0800 (PST)
Date:   Thu, 6 Feb 2020 09:48:37 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
Message-ID: <20200206174837.GA55561@syl.local>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
 <20200206025130.GA22748@syl.local>
 <20200206085747.GA17654@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206085747.GA17654@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 09:57:48AM +0100, SZEDER Gábor wrote:
> On Wed, Feb 05, 2020 at 06:51:30PM -0800, Taylor Blau wrote:
> > > * tb/commit-graph-split-merge (2020-02-05) 3 commits
> > >  - builtin/commit-graph.c: support '--input=none'
> > >  - builtin/commit-graph.c: introduce '--input=<source>'
> > >  - builtin/commit-graph.c: support '--split[=<strategy>]'
> > >  (this branch uses tb/commit-graph-object-dir.)
> > >
> > >  The code to write out the commit-graph has been taught a few
> > >  options to control if the resulting graph chains should be merged
> > >  or a single new incremental graph is created.
> > >
> > >  Will merge to 'next'?
> >
> > I think that this is ready. Martin Ågren and I discussed a little bit
> > about the rationale behind why the new options were chosen over
> > alternatives, but I think we reached consensus (at least, the thread has
> > been quiet for a few days after sending 'v2').
> >
> > So, if you're asking whether or not this is ready to merge to 'next',
> > I'd say that it is, but I'd like to hear from Martin's thoughts, too.
> > (For what it's worth, we're *also* running this at GitHub, and without
> > issue).
>
> Please don't rush it, those '--input=<source>' options need more
> consideration.

Of course, and I'm happy to discuss more, if that's what others discuss.
I thought that things had settled since the thread quieted down after
sending 'v2'. But, if there's more to discuss, certainly we should do
that before queuing this up.

Let's wait a little while longer and see what happens there before
queuing this topic.

Thanks,
Taylor
