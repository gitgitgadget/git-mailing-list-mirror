Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77183C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245402083B
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCP/0W/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgJFUUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:20:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1AC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 13:20:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id az3so2102238pjb.4
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PLdNjutVZlNXAONG+vpCaeXEMlAuneJL6oU16zrgW7I=;
        b=pCP/0W/wB1ZZV1w1/LyYmrmPTlVS8zdDIsOTl4fo78uUJobJt6MR7viLmJ1HCVOtq3
         vwQREdFC0QpOqM+Eh8OJYk85OK3AgS3qASkAPzIBzmBVoFIbJPZLSSVr02Q9p8ZRctYZ
         NweJehkGv6fZ5uPWy720dHP1Gl7Nmf/Qpkl2r7bS7fjT+hHfCgglUOCxfGw0/AYzKklO
         zx2prxwoaAbbmTxLRf2pzTkfP4j8NQhtL3xDs+5cLCZnMsyzuMlXGjNiIn2Q4+ahTjAq
         Ilj/gJzA7MaxiXCVvOc17YZZclXyindtfoU2IAFHVXrtxMSyEpeFmuPdpGyh5vWaxOuN
         6rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PLdNjutVZlNXAONG+vpCaeXEMlAuneJL6oU16zrgW7I=;
        b=X6rb70rF510nzN4X6M/Gk3jlRAVHUXgYtdKOk2ZRgX+eaimmlf/5J1t/0SegSXNYlr
         021BxbgetcISEapKj9WD66Cba9RbfjIc8Gi9ihUbjEgFnSoKtS4CqdO+vlxto0BFrDGB
         7Ju7w3lwesSay58enMGHsq/Cx+aoY2xgb96IbcteP0O6K1+Ba8YakVzOt9k3gjoWnxTj
         GzcPMD7DUb95onUgOKHnLj8nVfPWJSKDeOCKZRmZ+HR/GvzlhG9GZlULW5kMXagdvpx0
         Dx810789OOprJsOzSSE0FCQ2As5Zuq5vJWrLGDrbynC/77RTmYwuTl/LrBKmhno8yYK7
         fdUQ==
X-Gm-Message-State: AOAM531kZM4DJhSUInl8D11S1cV/eCC4V6BVG+uv8wCUhHIt26v6Mf0G
        6VyJyl1T+QfM7J+yK+oqjz65yA==
X-Google-Smtp-Source: ABdhPJzxFCEItiT8uAuKtQOAujuw1udkDpwNdJ5V4akaRD1EoRMpt/IAvi028hlYWrtvu0vJlu7GKg==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr6216435pjb.208.1602015650070;
        Tue, 06 Oct 2020 13:20:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id t7sm3547989pjy.33.2020.10.06.13.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:20:49 -0700 (PDT)
Date:   Tue, 6 Oct 2020 13:20:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/9] hook: add list command
Message-ID: <20201006201957.GK331156@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-4-emilyshaffer@google.com>
 <CAN0heSq1iVtJycjgh-iv2O6vNr6CLn69N3286hzkfu5sXLjf5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSq1iVtJycjgh-iv2O6vNr6CLn69N3286hzkfu5sXLjf5w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 09:23:35PM +0200, Martin Ågren wrote:
> 
> Hi Emily,

Firstly, thanks for the doc review - this is great stuff.

> 
> On Wed, 9 Sep 2020 at 02:54, Emily Shaffer <emilyshaffer@google.com> wrote:
> 
> >  DESCRIPTION
> >  -----------
> >  You can list, add, and modify hooks with this command.
> 
> (BTW, I think this patch could teach this to say "You can list hooks
> with this command." If/when we add the other commands, we can expand
> on this.)

Done. I sort of glued this together with Jonathan Nieder's suggestion in
the setup patch, and ended up saying "later you will be able to blah".

> 
> > +This command parses the default configuration files for sections "hook" and
> > +"hookcmd". "hook" is used to describe the commands which will be run during a
> 
> I propose s/"hook"/`hook`/ and similar to set this as monospace since we
> are discussing configuration sections. If we want to avoid starting
> sentences with "hook" (or `hookcmd`; do we?), maybe something like "The
> section `hook` ..." would work fine.

Nice - done. I don't see much problem with starting a sentence with
monospaced lower-cased section name... someone can disagree with me :)

> 
> > +particular hook event; commands are run in config order. "hookcmd" is used to
> 
> "config order" feels a bit too colloquial/vague. You use the same phrase
> in the commit message and I think it works well there for the indented
> audience. But for this document, I'm not so sure. How about
> 
>   Commands are run in the order they are encountered as the Git
>   configuration files are processed (see linkgit:git-config[1]).

I don't mind colloquial - I think that improves the readability of user
documentation - but you're right that it's vague. "...commands are run
in the order Git encounters them during the configuration parse (see
linkgitblah)" seemed like an okay balance to me.

> 
> ? It's also quite possible that "config order" hits the exact right tone
> -- please trust your judgment.

Nah, I think you're right that "config order" is easily understood by
Git devs, but probably not by Git users. I like that linking out to the
config doc invites users to also learn a little more about how config
files work :)

> 
> > +describe attributes of a specific command. If additional attributes don't need
> > +to be specified, a command to run can be specified directly in the "hook"
> > +section; if a "hookcmd" by that name isn't found, Git will attempt to run the
> > +provided value directly. For example:
> 
> > +  [hook "post-commit"]
> > +    command = "linter"
> > +    command = "~/typocheck.sh"
> > +
> > +  [hookcmd "linter"]
> > +    command = "/bin/linter --c"
> 
> Hmm. "hook", "command" and "hookcmd". Should that be "cmd", or
> "hookcommand"? I'd favour the latter, but the current proposal somehow
> feels asymmetric. (If code uses, and is consistent about using,
> "hookcmd" that's another thing entirely, I think. It's just that for the
> configuration, it looks a bit odd.)

I'm not entirely in love with the name "hookcmd" but somehow I like
"hookcommand" even less - especially since you end up with
"hook.command" referencing a "hookcommand" which also has a
"hookcommand.command" - blech.

Some possible alternatives to "hookcmd":
- hookmodule/hook-module
- reusable-hook
- hook-with-options/hook-options (nah, this sounds like it means
  "options for hook execution")
- hook-details/detailed-hook
- named-hook

I'll think on this more. I like "named-hook" quite a lot. Very
interested in hearing other ideas - "the two hardest problems in
computer science are naming, cache invalidation, and off-by-one errors"
;)

> 
> > +List the hooks which have been configured for <hook-name>. Hooks appear
> 
> `<hook-name>` with backticks.
> 
> > +in the order they should be run, and note the config scope where the relevant
> > +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
> 
> I had to read and re-read this a few times. The "and note the" does not
> mean "and please observe that", but rather "and they make note of". Not
> sure how that can be done clearer. The second thing that tripped me up
> was that last part. Maybe end the sentence after "specified", then add
> something like "The scope is not affected by if and where
> `hookcmd.<hook-name>.command` appears.".

Occam's Razor suggests "Hooks appear in the order they should be run,
and print the config scope blah". Thanks for pointing out "and note
that" collision - I never use that phrase so it didn't occur to me!

> 
> I think you could add
> 
>   CONFIGURATION
>   -------------
>   include::config/hook.txt[]
> 
> here and add such a file
> 
>   hook.<hook-name>.command::
>          ...
> 
>   hookcmd.<hook-name>.command::
>          ...
> 
> where you define/describe those items. And you can include it from
> config.txt as well.

Yes, totally. Thanks.

 - Emily
