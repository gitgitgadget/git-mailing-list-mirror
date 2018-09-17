Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7271F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIRCMZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:12:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36677 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:12:25 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so16661608qtn.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MF8Sd8oZxDZzkw+IHMaY/w//jpFP9l20V9Vc+glAfC4=;
        b=muk8YFE4E0onyP7kK0K9odOb3mxNHMdXmPKp7RDyK13Y9Ox6KfdvH11hJudsRSfoRO
         GeKACewfgz3ImOO7qH5yRFn23wOhUy7rquhtmPzW65N1EqMp4mW7gmgN+htNBdX+tRQ1
         BmCTv4qQgMXqsxqH6VNqN1oH5UcorBfsaXjRIu+3H7hA9RgisWXi4gOhVP4LaM6C/mg9
         S8tTDU676UKmCi4JQO2F4UMKpTixedMNHaMemfXekasZO/xykNSh91Y/YOWjFVMhofqT
         XkItEHlMMY0UOLaSaxr7hr0IdzQYgIcSanw5o6E9sduAqCB0PFc7+J/WFfLhsFfOYaYL
         Vnyw==
X-Gm-Message-State: APzg51AaJGaLGN2JSg7W5c9GPU9R2FkIsUpaB3WfvFjYKQXYEHlfUtZY
        hhNhPAGFjBhRfimqIDarJLa+Jluev73IuWNMG9I=
X-Google-Smtp-Source: ANB0VdbQNeIzYeBrjYNgKHb+bMtNlxyf3y59l08TU2LXwZk6knHY4mR7u6nAf0/4kPVGCWEWM/dRmaVdejuIa9l9YPk=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr19055100qtc.50.1537217006287;
 Mon, 17 Sep 2018 13:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180830195546.GA22407@sigill.intra.peff.net> <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com> <20180917183258.GC140909@aiede.svl.corp.google.com>
 <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Sep 2018 16:43:13 -0400
Message-ID: <CAPig+cSrvvWn1rd6TcG8H6tGvGDvfNJZE3KnxYazwDTfxAkVeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 3:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> >> +    '$(SHELL_PATH_SQ)' ./doc-diff --clean
> >
> > This means I need a copy of git in order to run "make clean".  That
> > was never required before.  It makes bootstrapping difficult --- do we
> > really need it?
>
> Gahh, you are absolutely right.  Also "doc-diff --clean", if I am
> reading the code correctly, requires us to be in a Git repository,
> not a tarball extract.
>
> Having to have Git installed, or be in a repository, in order to be
> able to run an optional "doc-diff" tool is fine.  Requiring either
> in order to run "make clean" is a different story.
>
> Thanks for spotting.  We can just prefix the line with '-'?  Or does
> the script badly misbehave (due to lack of CEILING_DIRECTORY) when
> run in a tarball extract inside somebody else's repository?

I did consider this case and felt that it would be reasonable for it
to error out and ignore the error if git was missing or if the
directory was not a repository. And, I _thought_ I had prefixed the
line with "-" to handle just such a case, but apparently I botched it.
Oh well.
