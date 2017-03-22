Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA142095D
	for <e@80x24.org>; Wed, 22 Mar 2017 21:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdCVVrA (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:47:00 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34090 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdCVVq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:46:58 -0400
Received: by mail-pf0-f171.google.com with SMTP id p189so73730591pfp.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5t0LR/+W3nsZy1YEUxxwikrYOlFYjjvmZRSxZVo4cLw=;
        b=Vb9vbR9tpQF/spA9TXfCMxyGop/iE8CgTN9PanGryAAYmtuWcwdO1Tf3ArfZ5IHp5m
         Ts5avukbeNuwxlCYqNX0GRa48QtQuFGI6vykMs87l/cwWRDktbTdQDlQfZbVZoSXaju2
         z8MrLJsSY5gF9awyxetjd+n3mJSiNZZQ340jTPHm1ryHjFvS3ucbwKcYDNz/MtcZ5uQ7
         UemB75p0vtMI9Vmf9AAXAWhKsUy6k2l4NCT/hWTWHbm+LLv69siLGBA+SD442J5HF9mn
         nGMsD2vsnMjNCibyEHQ+oUQlXTGfDxyhMpQHM3+7sgVy3vwCgh8S1VZ5a0v6Bzy9kIxR
         2orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5t0LR/+W3nsZy1YEUxxwikrYOlFYjjvmZRSxZVo4cLw=;
        b=WSAIFgERu3MXzEcZ975eyCMo7MnfRBGTqgOymkx1OBmeb1nqEAZoO995yK4N8ObzH2
         t9lWtVfQYE2OncaOzLF/7u0Qvj3UWJtHCGUNMWGFZkC2Gf/f2c5GabIGlVFsoO63Z9uX
         kr8p9GACyB60W7dm9PElPXIEeE6W8koOPrdyHKVQtGlJXBKOl32Z+GTTH2upaTnlRA8J
         Y1wBz4BQq1KO4kIKTZmP26VPGVlRT2TqM0tiadSOfIwoNOrGhnaGSZjpjDNaJlVYz5VD
         I9ee356v3vOtGctvToPDAxl7onYBsLBSRWSGhyDVxLI3VSy66xWKdoTq56Az4cFOAbaR
         1hwQ==
X-Gm-Message-State: AFeK/H1GXyb66JEK3giExZCfK+qYC+654FnKSOGiVl4TLge8i526vw9V+l8nmQeXqGgoejzR
X-Received: by 10.98.16.137 with SMTP id 9mr48781609pfq.104.1490219216683;
        Wed, 22 Mar 2017 14:46:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:4506:c5a2:cf62:91cb])
        by smtp.gmail.com with ESMTPSA id s3sm5781612pgn.55.2017.03.22.14.46.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 14:46:55 -0700 (PDT)
Date:   Wed, 22 Mar 2017 14:46:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] grep: fix bug when recursing with relative
 pathspec
Message-ID: <20170322214654.GC11254@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-4-bmwill@google.com>
 <CACsJy8Cu8cgtJzDDM09GoJr5Ny+G+nP17GjZjXng6ZPQv9eXXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Cu8cgtJzDDM09GoJr5Ny+G+nP17GjZjXng6ZPQv9eXXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Duy Nguyen wrote:
> On Sat, Mar 18, 2017 at 12:22 AM, Brandon Williams <bmwill@google.com> wrote:
> > With these two pieces of information a child process can correctly
> > interpret the pathspecs provided by the user as well as being able to
> > properly format its output relative to the directory the user invoked
> > the original command from.
> 
> This part can stand alone as a separate patch right? It would help
> focus on the pathspec thingy first.

I guess it could probably be factored out, though it is necessary for it
to work.  The issue I was running into was that when no pathspecs were
given it would create a 'prefix' pathspec.  So if we were in directory
'dir/' the pathspec that would get created would be:

ps.match = "dir/"
ps.original = "dir/"

Since it also set the original field it messed up when the child tried
to interpret the pathspecs again.  I solved this by just passing the raw
pathspec through to the child.

> 
> > @@ -399,13 +405,12 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
> >  }
> >
> >  static void compile_submodule_options(const struct grep_opt *opt,
> > -                                     const struct pathspec *pathspec,
> > +                                     const char **argv,
> >                                       int cached, int untracked,
> >                                       int opt_exclude, int use_index,
> >                                       int pattern_type_arg)
> >  {
> >         struct grep_pat *pattern;
> > -       int i;
> >
> >         if (recurse_submodules)
> >                 argv_array_push(&submodule_options, "--recurse-submodules");
> 
> Side note. It would be awesome if you could make parse_options() (or a
> new function) do the reverse process: given a 'struct option' with
> valid data, spit out argv_array. Less worrying about git-grep having
> new option but not passed to subgrep by accident. You can have a new
> flag to tell it to ignore certain options if you don't want to pass
> all.

I thought about this for a second but didn't pursue it very far.  Mostly
because of how you would handle options with callback routines.  Maybe
if you want the option to be reversible you need to have an additional
callback routine to do the conversion?  I agree that having this sort of
functionality would be nice as it does save you from forgetting about
passing on options to a child process.

-- 
Brandon Williams
