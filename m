Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF4A1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeDPQSo (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:18:44 -0400
Received: from ao2.it ([92.243.12.208]:40135 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDPQSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:18:44 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f86ov-0003lI-L3; Mon, 16 Apr 2018 18:17:33 +0200
Date:   Mon, 16 Apr 2018 18:18:41 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 02/10] submodule: fix getting custom gitmodule file in
 fetch command
Message-Id: <20180416181841.b486524b8b9b0e68e3a31bfa@ao2.it>
In-Reply-To: <CAGZ79kbnc17PZ9_=8QLkZgUZ0DHJKfWnxrekmgkLGFBU_0ieug@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180412222047.5716-3-ao2@ao2.it>
        <CAGZ79kbnc17PZ9_=8QLkZgUZ0DHJKfWnxrekmgkLGFBU_0ieug@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Apr 2018 16:55:15 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Antonio,
> 
> the subject line could also be
>   fetch: fix custom submodule location
> as I was not expecting this patch from the subject line.
>

OK.

> On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> > Import the default git configuration before accessing the gitmodules
> > file.
> >
> > This is important when a value different from the default one is set via
> > the 'core.submodulesfile' config.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >  builtin/fetch.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index dcdfc66f0..d56636f74 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1428,8 +1428,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >         for (i = 1; i < argc; i++)
> >                 strbuf_addf(&default_rla, " %s", argv[i]);
> >
> > -       config_from_gitmodules(gitmodules_fetch_config, NULL);
> >         git_config(git_fetch_config, NULL);
> > +       config_from_gitmodules(gitmodules_fetch_config, NULL);
> 
> Wouldn't this break the overwriting behavior?
> e.g. you configure a submodule URL in .gitmodules and then override it
> in .git/config,
> then we'd currently first load config from the modules file and then override it
> in git_config(git_fetch_config,..), whereas swapping them might have
> unintended consequences? Do the tests pass with this patch?

The patch changes the current behavior indeed, but it does not break
any of the existing tests.

Anyway, to be on the safe side, I could load only the
core.submodulesFile option from the global configuration, maybe even in
config_from_gitmodules() itself, before accessing the gitmodules file,
but I still don't know how to do that.

Is there an API to just load one config setting?

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
