Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D86B1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdCBTxS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:53:18 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32908 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdCBTxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:53:16 -0500
Received: by mail-pg0-f43.google.com with SMTP id 25so35509487pgy.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 11:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zWBSZ83G1GMOAAkiiYTIMe7bsCh5UuvjQ9+waBWCyBA=;
        b=A6VzUgW9wpXjbGUQsoqGpRdTIZAFDzZO8uVWhQXUze/PUd3PjqM0OXAgh0274p9qcj
         pVUkhh32C4fDP0Ghz1qlt1vh3gL2tRFChCuUPOJWK9LGe1xk7Zb15cx3L4KAzkGMHpTa
         /NRcm21xP+FpfuNaWiuOmkf5Kh32+p2jI9v6FphtN8CMZF5KcGUD03uHp5hfU1P+yelp
         H0Vzj7GBEfGrsk00Bbdap519PrPsZm5Cylc3p++iBDQhS7V8WahpUa6rWgimYNinTViP
         2aoxNieXTZWEqXu/6rhocaKGxNCSRKt21BiFmo2seZ51+cFSwyvFQIngcyBssstlmYUr
         cLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zWBSZ83G1GMOAAkiiYTIMe7bsCh5UuvjQ9+waBWCyBA=;
        b=anCzsggJmHlPtchtfOkdtR0kSoRoWTjVVEe6kGv+kqWTKm9poghHsIs4lWaJkW7AAb
         Bi9ivevXETXWBa57YnMNLTKqHQr9N7h8zPWfVWjP+1H2r2XcXIpuoQnidIfhedQ9Wutr
         pEhmXxsQGZe/n1lycYD7mEePPf7hLOt2kWLIVwWWR1Ou/16w4ihQw7Hacnnq00qLnNpm
         POvm1mX2LqQQWEYxs/cF5N96Z5hPnf2o9xjqh2/pDTt/UQGPbYUWIHiunOVlWHbYqIqS
         SsFeo7Wlw5ZV/IKXMmv9Jy886w2hOFM+rqbl2nEX5pEv908kNZ5Yzeft/7Q8Rb/UQpgy
         IjYQ==
X-Gm-Message-State: AMke39n6OmZWMTzRqc1zzw3S7VCOMi1hkd/rX/d/WUgKQhjH9CqeiKBGuV0vzmT/Y4vPDBYb
X-Received: by 10.99.202.73 with SMTP id o9mr17270392pgi.173.1488477705742;
        Thu, 02 Mar 2017 10:01:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d033:6603:834d:8912])
        by smtp.gmail.com with ESMTPSA id t6sm18543752pgt.8.2017.03.02.10.01.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 10:01:44 -0800 (PST)
Date:   Thu, 2 Mar 2017 10:01:43 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 5/5] ls-files: fix bug when recuring with relative
 pathspec
Message-ID: <20170302180143.GC30622@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170224235100.52627-6-bmwill@google.com>
 <xmqqa896ja7z.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa896ja7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Fix a bug which causes a child process for a submodule to error out when a
> > relative pathspec with a ".." is provided in the superproject.
> >
> > While at it, correctly construct the super-prefix to be used in a submodule
> > when not at the root of the repository.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/ls-files.c                     | 8 ++++++--
> >  t/t3007-ls-files-recurse-submodules.sh | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index 159229081..89533ab8e 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -194,12 +194,15 @@ static void compile_submodule_options(const struct dir_struct *dir, int show_tag
> >  static void show_gitlink(const struct cache_entry *ce)
> >  {
> >  	struct child_process cp = CHILD_PROCESS_INIT;
> > +	struct strbuf name = STRBUF_INIT;
> >  	int status;
> >  	int i;
> >  
> > +	quote_path_relative(ce->name, prefix, &name);
> >  	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
> 
> Same comment as 3/5.  quote_path is to produce c-quote and is not
> even meant for shell script quoting.  run_command() interface would
> do its own shell quoting when needed, so  I think you just want the
> exact string you want to pass here.
> 

Yeah I don't know what I was thinking when using that instead of
'relative_path()'.  Will change for this and 3/5.

-- 
Brandon Williams
