Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F6D1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 10:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbeHCMRU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 08:17:20 -0400
Received: from ao2.it ([92.243.12.208]:56214 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbeHCMRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 08:17:20 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flXBx-000845-FK; Fri, 03 Aug 2018 12:20:17 +0200
Date:   Fri, 3 Aug 2018 12:21:38 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH v2 04/12] submodule--helper: add a new 'config'
 subcommand
Message-Id: <20180803122138.ca4be250bf1ad3b3730866e3@ao2.it>
In-Reply-To: <20180802192032.GA28962@sigill.intra.peff.net>
References: <20180802134634.10300-1-ao2@ao2.it>
        <20180802134634.10300-5-ao2@ao2.it>
        <CAGZ79kY78rgb8VpRn-A2moucy16z1TsDGdz2cjJzVOxsiKiiYw@mail.gmail.com>
        <20180802192032.GA28962@sigill.intra.peff.net>
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

On Thu, 2 Aug 2018 15:20:33 -0400
Jeff King <peff@peff.net> wrote:

> On Thu, Aug 02, 2018 at 11:47:30AM -0700, Stefan Beller wrote:
> 
> > > +static int module_config(int argc, const char **argv, const char *prefix)
> > > +{
> > > +       if (argc < 2 || argc > 3)
> > > +               die("submodule--helper config takes 1 or 2 arguments: name [value]");
> > > +
> > > +       /* Equivalent to ACTION_GET in builtin/config.c */
> > > +       if (argc == 2)
> > > +               return print_config_from_gitmodules(argv[1]);
> > > +
> > > +       /* Equivalent to ACTION_SET in builtin/config.c */
> > > +       if (argc == 3)
> > > +               return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
> > > +
> > > +       return 0;
> > 
> > Technically we cannot reach this point here?
> > Maybe it would be more defensive to
> > 
> >     BUG("How did we get here?");
> > 
> > or at least return something !=0 ?
> 
> When I find myself reaching for a BUG(), it is often a good time to see
> if we can restructure the code so that the logic more naturally falls
> out.  Here the issue is that the first if conditional repeats the "else"
> for the other two. So I think we could just write:
> 
>   if (argc == 2)
> 	return ...
>   if (argc == 3)
> 	return ...
> 
>   die("need 1 or 2 arguments");
> 

Hi Jeff,

I like that, I'll see how this plays out after patch 06 which adds
another option, and decide whether to use this style; validating
arguments beforehand may still look a little cleaner.

Thanks for the comment.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
