Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B47820951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdCQW2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:28:54 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36493 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdCQW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:28:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id o126so43067034pfb.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hgJl6z/yqsjWoFHrZ6uMZL4jCZo0qP1XyvZkDAu8qnA=;
        b=mCITZ8yKL4uHZQvvh0T2EasqELx+chHDxavXkS9b8wCrPSxy5oizsEkHt93eoF3I22
         6MP7XnEuwWRoy0w+7CgRUxGuZ1suttDZsWBq0asQyGaKPDajd9YLIrMYz9BviQxjV+wx
         +mLaHP1XAbBv5rHeBCofldsLJO9yI+stO0RGfb+PAdbASGRsK3X3h9bJEIR51SXg63Gj
         4T1T4n00BT53lmuukau3XJ55IQDTkhGAlRjbvDDqhrGX/ekkBs7sqMeIk5gVUSzb73YP
         ds0/CQA5ngL+yYbxD7dht0sR+YuEtenWziwctwKF9FPFg0fYiWiZAE7SMhbPltFXoQ/N
         yjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hgJl6z/yqsjWoFHrZ6uMZL4jCZo0qP1XyvZkDAu8qnA=;
        b=uXa2+gaUpXcglJ5JH4h/lmMKz9w4CpgWIpLUa+b1ZsS2ExgzHzPNRH5iytcAkYK/ZX
         2nwUWQ8DwbnxHc/dijlyYh8KQESy+91j12FbKZYjJjPrxZgVVtVjbWg2bLeMSE55iZw0
         nmeDvEzAJiyEj6Y9DYBFJmS0HSXY4jH/d0kMTvVsD6ZP4I5OKrOs5JN3i6djkvg9zJm5
         mXyQ1ssYLRyefaypN6ZURL125GUPHD1efp3iVwoVIiqmAyzjLyBC9XbfKeF80fLJbdg/
         cccVW4K+QntPuHTsNx3no40gTILUxHBWTcHtFjZdCI2P6pOzjPhwGKWOMFx/vn4GQx75
         LWZg==
X-Gm-Message-State: AFeK/H38aomPFfh9wxqoAKwO+I3Es7GgpTxYnh+onSsPItFOXrIPNoO7C6keItkn5mYIDp35
X-Received: by 10.99.173.69 with SMTP id y5mr18621837pgo.35.1489789731789;
        Fri, 17 Mar 2017 15:28:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id t70sm18470531pfe.64.2017.03.17.15.28.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:28:50 -0700 (PDT)
Date:   Fri, 17 Mar 2017 15:28:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 07/10] submodule init: initialize active submodules
Message-ID: <20170317222849.GD63813@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-8-bmwill@google.com>
 <CAGZ79ka-rQ3YtdduAMYf-XYitKMfX2iEVh4wfR1vD6RzqhHDzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka-rQ3YtdduAMYf-XYitKMfX2iEVh4wfR1vD6RzqhHDzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Stefan Beller wrote:
> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> > Teach `submodule init` to initialize submodules which have been
> > configured to be active by setting 'submodule.active' with a pathspec.
> >
> > Now if no path arguments are given and 'submodule.active' is configured,
> > `init` will initialize all submodules which have been configured to be
> > active.  If no path arguments are given and 'submodule.active' is not
> > configured, then `init` will retain the old behavior of initializing all
> > submodules.
> >
> > This allows users to record more complex patterns as it saves retyping
> > them whenever you invoke update.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> 
> > @@ -417,7 +445,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
> >         argc = parse_options(argc, argv, prefix, module_init_options,
> >                              git_submodule_helper_usage, 0);
> >
> > -       if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> > +       /*
> > +        * If there are no path args and submodule.active is set then,
> > +        * by default, only initialize 'active' modules.
> > +        */
> > +       if (!argc && git_config_get_value_multi("submodule.active"))
> > +               module_list_active(&list);
> > +       else if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> >                 return 1;
> 
> I would rather reuse module_list_compute and then post-process the list
> to filter out inactive submodules iff "submodule.active" is set as that seems
> cleaner and performance is not a pressing issue here?

Ok, Can do.  Shouldn't be very hard to do that.

> 
> >
> > +static void module_list_active(struct module_list *list)
> > +{
> > +       int i;
> > +
> > +       if (read_cache() < 0)
> > +               die(_("index file corrupt"));
> > +
> > +       gitmodules_config();
> 
> Here we also need to have
> 
>   git_config(submodule_config, NULL);
> 
> such that is_submodule_initialized works correctly,
> I would assume?

No I don't think so.  is_submodule_initialized doesn't need them to be
overlayed, it just needs the .gitmodules mappings.

> 
> > +
> > +       for (i = 0; i < active_nr; i++) {
> > +               const struct cache_entry *ce = active_cache[i];
> > +
> > +               if (!S_ISGITLINK(ce->ce_mode) ||
> > +                   !is_submodule_initialized(ce->name))
> > +                       continue;
> > +
> > +               ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> > +               list->entries[list->nr++] = ce;
> > +               while (i + 1 < active_nr &&
> > +                      !strcmp(ce->name, active_cache[i + 1]->name))
> > +                       /*
> > +                        * Skip entries with the same name in different stages
> > +                        * to make sure an entry is returned only once.
> > +                        */
> > +                       i++;
> > +       }
> > +}

-- 
Brandon Williams
