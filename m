Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3FEC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B15924658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEFvsh4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANU7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:59:33 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:36005 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANU7c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 15:59:32 -0500
Received: by mail-pj1-f53.google.com with SMTP id n59so6438131pjb.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 12:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=znEgbMkxrUvjsNBeo8bnKPQdD3+YTS/W6H2e6z/inyE=;
        b=TEFvsh4UVDewsmlOtVzs9HB9MngI0lwDF36h1zYwxMzCQ9bUsb1VYAh8EudYyQn+by
         JbckqWT5579qOHL1J6wT88GN8wfuuYRPykhfKBntaW8ak3KUHeqwTWM3RbaVJmoIliVH
         wGOCoaS5REz6mh48ApUyJxFyaVVxZD8/peWIvRSkamENnif/gN+GwAPkdlRNShe240Y5
         Cw6bDWS9ABynuA5qg7Dd+ejnJrq2ig7wPTCZF/IhlbC1zzuJo4+0RLy3HQpLXyuY28tx
         WEykq1L06u87WrIDBbpRMwpO4uJBEFme2f9lQR989edvieYlTb2Ngx6upsUPd9CJv56M
         cO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=znEgbMkxrUvjsNBeo8bnKPQdD3+YTS/W6H2e6z/inyE=;
        b=QWyWH+EGTkwTRwcO83tV3e0Da/Blzfbwl7OwWHsoOGL2FnDlnA5hs/aeWqGs7aStS2
         E31lrnX4qRnL7UTZYblavGaIY8nNKvPXwX9j6qRPQAVWPmOCno50UAWgJ3vp3JzNy6wF
         uM4lR7q8XR9MpYEVZkZv7dCvtu8NIMWeDinEMZbfjHjK3TsTNQjS3WsiHiQ5gchauBxv
         NhCimE26HpWYYOxiP0lS9TNn8yl2TW+YzIpnvL/xaUCT2cObsB31ETZXtXjC0RCRzsF2
         OYcE+SP6ceiT26e5WGIUkibvKTfizlgPSAcU0W5q8xO+xuLGXhPLMnOKm10BCpHJUOvG
         pp7A==
X-Gm-Message-State: APjAAAV6zYw+EDqn9O6QvikIknqf/hSEUX2m/0noPHQiK0nVneUfi+iF
        yw6/h4CaRFaKHiKGjZrPR0yiQQ==
X-Google-Smtp-Source: APXvYqy9n756kIyOwAJ2u8P5P6J7ER6mefol9mAyDaAnAIfHt7ERuYrln5Bgg1pEC+hO5uQp/CxffQ==
X-Received: by 2002:a17:902:7b89:: with SMTP id w9mr10498285pll.46.1579035571763;
        Tue, 14 Jan 2020 12:59:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k1sm17867817pgq.70.2020.01.14.12.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:59:31 -0800 (PST)
Date:   Tue, 14 Jan 2020 12:59:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: en/rebase-backend (was Re: "rebase -ri" (was Re: Problems with
 ra/rebase-i-more-options - should we revert it?))
Message-ID: <20200114205651.GA74460@google.com>
References: <CABPp-BG9eqbhnzU8gzJ_h+=XH4mSOj-Wb5SU7OjXz5ik6c+NnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BG9eqbhnzU8gzJ_h+=XH4mSOj-Wb5SU7OjXz5ik6c+NnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 08:52:57AM -0800, Elijah Newren wrote:
> Hi Junio,
> 
> On Mon, Jan 13, 2020 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > >> I will push out what I wish to be able to tag as the final [*1*]
> > >> shortly but without actually tagging, so that it can get a bit wider
> > >> exposure than just the usual "Gitster tested locally and then did
> > >> let Travis try them" testing.
> > >
> > > I haven't heard from any failure report so (taking no news as good
> > > news) I'll cut the final today based on what is already on the
> > > public repositories everywhere.
> >
> > By the way, as one of the methods to double check that my result of
> > reverting the merge made sense, I ran "git rebase -ri v2.24.0 pu"
> > and excised the merge and the problematic topic out of the todo
> > list.  With the rerere database populated beforehand, it was more or
> > less a painless exercise (except for one topic, en/rebase-backend,
> > which is one of the topics that was queued forking 'master' after
> > the topic got merged *and* actually depended on what the topic did)
> > and after about 1700+ steps (which did not take more than 20
> > minutes, including the time spent for the manual rebasing of
> > en/rebase-backend topic) I got the same tree for 'pu' I pushed out
> > last night.
> 
> I wonder if I should have been the one fixing up the en/rebase-backend topic...
> 
> Also, with the new release and the review comments Phillip posted on
> the en/rebase-backend series, would you rather see me address those as
> additional patches on top of en/rebase-backend, or should we kick that
> topic out of next and have me send a full re-roll?  I'm not sure
> what'd be better and I don't mind going either direction...


For what it's worth, I had started to look into one of the bugs Jonathan
Nieder reported[1] as a patch on top of en/rebase-backend topic. I'll
keep an eye on this thread; if you're interested in rerolling the whole
topic then it might be less time for you to identify the right place to
call "post-commit" than it would be for me, plus less conflict
resolution time.

[1]: https://lore.kernel.org/git/20200110231436.GA24315@google.com/
(bullet point 1)

 - Emily
