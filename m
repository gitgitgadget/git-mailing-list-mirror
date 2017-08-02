Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3375120899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbdHBRlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:41:09 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36655 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdHBRlH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:41:07 -0400
Received: by mail-pg0-f53.google.com with SMTP id v77so18210062pgb.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O3vY6o371VRJS812+x19C1kB1vKR31vQUFE7Jf63V8Y=;
        b=DabE1uf+5ci8nltjwXOg8AVqHKHWfgJ3sfUUZ/x3xgtsvsklzsLJBQZuB5xlDnkuxK
         YFFceDUFHCMmGjqKDmqsgQLwVeqCZefXiaiTek35BOcMl7dllPx8HpysywqFB0ADI86w
         6ImWPh40J34FMfiWVjvXpMuc6ZppeQrTmLSuV8ULnX3MU57Fi1QjQKAm8qbrMsRle3Ae
         /dlqltM9RxDYP4kBvJnxm53VHg76LhKaKz47lwmBJYpgQIKNWiNFeSuipxha49Z4i25U
         8QpSYetiigOGQSFxswffUq/vwagiyXpsc5f3lEQSVQJgUSuYtjlQtcY6nO/W8ArTmPKZ
         ewBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O3vY6o371VRJS812+x19C1kB1vKR31vQUFE7Jf63V8Y=;
        b=pZKnmoSk4hovqxqcjJiUT0eRirSprX3Vp7EdpTgx/CWNdCR7eamuVj3xTZH5ufEZtA
         z/KSz66onx6oisqfOFF4LWpg+OzzOsoAwr9h3kpjclvFjT4NK/8aHVP62aXN58zRNHyS
         vicYz9/yqkmVp1cfXatkWGFdw9rAEPVuDzbUnXcvyU6mu7UhFyE5Eq8kY3drRd9+HizB
         TV1P9x9p+gRQ+dBKg9QgJ4faBK37eNcfnD/0OxYrEFOCfYhGVrNWYGU7FKf8n8mAMWbI
         ZIxkKmZYp4RJUyTNHxgWhukhvT73BLtLpi3zoVMRgQqVshRW8C1KYGsfNAEHdUwHOfH9
         mkYw==
X-Gm-Message-State: AIVw111auPsERmF4t+14h2q2uJ94yYlNdkxkjizcnQ0OnTg0xnBNCV2Q
        veMe7/Q9gDLMCar4
X-Received: by 10.98.202.214 with SMTP id y83mr23870036pfk.2.1501695667121;
        Wed, 02 Aug 2017 10:41:07 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:5415:3cb1:21dc:39fd])
        by smtp.gmail.com with ESMTPSA id i17sm44412601pfj.176.2017.08.02.10.41.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 10:41:06 -0700 (PDT)
Date:   Wed, 2 Aug 2017 10:41:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] submodule: check for unstaged .gitmodules
 outside of config parsing
Message-ID: <20170802174104.GB36159@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
 <20170718190527.78049-8-bmwill@google.com>
 <CAGZ79kYWd5WdwkC74+AdRt0anTUtngD7jt=aJv7iLCLf-TAfbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYWd5WdwkC74+AdRt0anTUtngD7jt=aJv7iLCLf-TAfbA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/31, Stefan Beller wrote:
> On Tue, Jul 18, 2017 at 12:05 PM, Brandon Williams <bmwill@google.com> wrote:
> > Teach 'is_staging_gitmodules_ok()' to be able to determine in the
> > '.gitmodules' file has unstaged changes based on the passed in index
> > instead of relying on a global varible which is set during the
> 
> variable
> 

Will change.

> > submodule-config parsing.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/mv.c |  2 +-
> >  builtin/rm.c |  2 +-
> >  submodule.c  | 32 +++++++++++++++++---------------
> >  submodule.h  |  2 +-
> >  4 files changed, 20 insertions(+), 18 deletions(-)
> >
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index dcf6736b5..94fbaaa5d 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -81,7 +81,7 @@ static void prepare_move_submodule(const char *src, int first,
> >         struct strbuf submodule_dotgit = STRBUF_INIT;
> >         if (!S_ISGITLINK(active_cache[first]->ce_mode))
> >                 die(_("Directory %s is in index and no submodule?"), src);
> > -       if (!is_staging_gitmodules_ok())
> > +       if (!is_staging_gitmodules_ok(&the_index))
> >                 die(_("Please stage your changes to .gitmodules or stash them to proceed"));
> >         strbuf_addf(&submodule_dotgit, "%s/.git", src);
> >         *submodule_gitfile = read_gitfile(submodule_dotgit.buf);
> > diff --git a/builtin/rm.c b/builtin/rm.c
> > index 52826d137..4057e73fa 100644
> > --- a/builtin/rm.c
> > +++ b/builtin/rm.c
> > @@ -286,7 +286,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> >                 list.entry[list.nr].name = xstrdup(ce->name);
> >                 list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
> >                 if (list.entry[list.nr++].is_submodule &&
> > -                   !is_staging_gitmodules_ok())
> > +                   !is_staging_gitmodules_ok(&the_index))
> >                         die (_("Please stage your changes to .gitmodules or stash them to proceed"));
> >         }
> >
> > diff --git a/submodule.c b/submodule.c
> > index b1965290f..46ec04d7c 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -37,18 +37,25 @@ static struct oid_array ref_tips_after_fetch;
> >  static int gitmodules_is_unmerged;
> >
> >  /*
> > - * This flag is set if the .gitmodules file had unstaged modifications on
> > - * startup. This must be checked before allowing modifications to the
> > - * .gitmodules file with the intention to stage them later, because when
> > - * continuing we would stage the modifications the user didn't stage herself
> > - * too. That might change in a future version when we learn to stage the
> > - * changes we do ourselves without staging any previous modifications.
> > + * Check if the .gitmodules file has unstaged modifications.  This must be
> > + * checked before allowing modifications to the .gitmodules file with the
> > + * intention to stage them later, because when continuing we would stage the
> > + * modifications the user didn't stage herself too. That might change in a
> > + * future version when we learn to stage the changes we do ourselves without
> > + * staging any previous modifications.
> >   */
> > -static int gitmodules_is_modified;
> > -
> > -int is_staging_gitmodules_ok(void)
> > +int is_staging_gitmodules_ok(const struct index_state *istate)
> >  {
> > -       return !gitmodules_is_modified;
> > +       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> > +
> > +       if ((pos >= 0) && (pos < istate->cache_nr)) {
> 
> Why do we need the second check (pos < istate->cache_nr) ?
> 
> I would have assumed the first one suffices,
> it might read better if turned around:
> 
> 
>     if (pos < 0)
>         return 1;
> 
>     return (lstat(GITMODULES_FILE, &st) == 0 &&
>         ce_match_stat(istate->cache[pos], &st, 0) & DATA_CHANGED);
>   }
> 
> > @@ -231,11 +238,6 @@ void gitmodules_config(void)
> >                                     !memcmp(ce->name, ".gitmodules", 11))
> >                                         gitmodules_is_unmerged = 1;
> >                         }
> > -               } else if (pos < active_nr) {
> > -                       struct stat st;
> > -                       if (lstat(".gitmodules", &st) == 0 &&
> > -                           ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
> > -                               gitmodules_is_modified = 1;
> >                 }
> 
> So this is where the check "pos < active_nr" is coming from,
> introduced in 5fee995244 (submodule.c: add .gitmodules staging
> helper functions, 2013-07-30) as well as d4e98b581b (Submodules:
> Don't parse .gitmodules when it contains, merge conflicts, 2011-05-14).
> 
> If I am reading the docs for cache_name_pos correctly, we would
> not need to check for the index exceeding active_cache,
> but checking for the index not being out of bounds seems
> to be wide spread.

I can drop the pos < active_nr requirement.

-- 
Brandon Williams
