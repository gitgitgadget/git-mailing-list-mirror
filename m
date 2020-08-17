Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D702EC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B230120760
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpRMQxtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHQWuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQWuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:50:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1EEC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:50:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so13717267edy.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMah3NHPhPkhZZmOzNtKN1ngRbjp04MmVFkTBfmluKk=;
        b=SpRMQxtqtpx9Tsa7zgpt9ys5khhvy+zgtG83yvwlqam9zfUdS6HjHAsGKK7CxMv4jD
         gQKBvv0VxB1KdjqBCxesrm00MVUpjieiqqz+Wi2gJ1hke6pMrLwkkaSou7Z4zpe0ASPv
         f6BySC/1GO0gJEN+y4IbBmqiQZcqo9afFlDTR0/gqaWomAfI5Gd1nPsRsoiWzg1I26RX
         BgZ90BJUhSgmxsFibP1LqW8Hsu3EFBf/uVV3btg2NIK6h27+lpwhOnVTOYGcEqyO1hZc
         wX0kbMnBTDLw5QJtNZqn9GEy9BXa0JxZaHNhx6GSTVDC022UdS5WpMdXjV7kGI4vFnqC
         wQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMah3NHPhPkhZZmOzNtKN1ngRbjp04MmVFkTBfmluKk=;
        b=DLAa3qag0bPXKbowWJyzWAvDuNgLXnXteoKDxsaUU6sh4lLvHWLECLgISw6o6RigR4
         dx+RN6x+NIcHSORKgCUPL6J34SYtF7JIUKSXkx1gehaD1+g2YSr1OmKP4JOmLGCLO838
         Vt+l9XOBWfZs2jjBEzcAHArsLb2RPc0B7Mh1R+Sbuqj4PuMK/TCWadzRdcc4iDQgog+5
         uSfu4J618o/8Vq4iXNQMjoypJrl+VVkqvqm+qLzECwo4O9G8hs12ZkaqhvCNv2adVEQN
         j/HpGs6GONFiASp5jkyy1bGOLMXlFRkfR88Sq0NywVN4bZ0YIAxn6qzpfjBPlZN8orlz
         nQoQ==
X-Gm-Message-State: AOAM531wuu+0AHIr+D3/s5kk4lunLsEF9k+zILf6vn5qCYMhial8czDH
        ghL8FIxWbEo9OoTwbV8kWHNDH07ET9g=
X-Google-Smtp-Source: ABdhPJz+koGixAB5BTI8Up+Bw05EzX232E5713Gf2wXAoNA9olwGsc3Bx7uHZxSQYXCfIJrtrW23aQ==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr17521502edx.161.1597704607676;
        Mon, 17 Aug 2020 15:50:07 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id zg6sm14821768ejb.106.2020.08.17.15.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 15:50:06 -0700 (PDT)
Date:   Tue, 18 Aug 2020 00:50:04 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200817225004.GB29528@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200812114929.GA19082@szeder.dev>
 <20200814202021.GE30103@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814202021.GE30103@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 04:20:21PM -0400, Taylor Blau wrote:
> > > @@ -1486,10 +1499,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> > >  		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
> > >  		&ctx->commits);
> > >
> > > +	max_new_filters = ctx->opts->max_new_filters >= 0 ?
> > > +		ctx->opts->max_new_filters : ctx->commits.nr;
> >
> > git_test_write_commit_graph_or_die() invokes
> > write_commit_graph_reachable() with opts=0x0, so 'ctx->opts' is NULL,
> > and we get segfault.  This breaks a lot of tests when run with
> > GIT_TEST_COMMIT_GRAPH=1 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.
> 
> Great catch, thanks. Fixing this is as simple as adding 'ctx->opts &&'
> right before we dereference 'ctx->opts', since setting this variable
> equal to 'ctx->commits.nr' is the right thing to do in that case.

That would avoid the segfault, sure, but I would rather see all
callers of write_commit_graph{_reachable}() passing a valid opts
instance.  Just like we don't call the diff machinery with a NULL
diff_options, or the revision walking machinery with a NULL rev_info.

> Unrelated to this comment, I am hoping to send out a final version of
> this series sometime next week so that we can keep moving forward with
> Bloom filter improvements.
> 
> Have you had a chance to review the rest of the patches? I'll happily
> wait until you have had a chance to do so before sending v5 so that we

v5?  This is v3, and I'm unable to a find a v4.

> can avoid a v6.
> 
> Thanks,
> Taylor
