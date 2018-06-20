Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1695B1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 18:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbeFTS1W (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 14:27:22 -0400
Received: from ao2.it ([92.243.12.208]:50617 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeFTS1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 14:27:21 -0400
X-Greylist: delayed 1366 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 14:27:21 EDT
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fVhUZ-0003I6-B4; Wed, 20 Jun 2018 20:06:03 +0200
Date:   Wed, 20 Jun 2018 20:06:34 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally
 useful
Message-Id: <20180620200634.13b47725cfd1e2dfb1cd482e@ao2.it>
In-Reply-To: <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-2-ao2@ao2.it>
        <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com>
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

On Mon, 14 May 2018 18:05:19 -0700
Stefan Beller <sbeller@google.com> wrote:

Hi again Stefan,

> On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > The config_from_gitmodules() function is a good candidate for
> > a centralized point where to read the gitmodules configuration file.
> 
> It is very tempting to use that function. However it was introduced
> specifically to not do that. ;)
> 
> See the series that was merged at 5aa0b6c506c (Merge branch
> 'bw/grep-recurse-submodules', 2017-08-22), specifically
> f20e7c1ea24 (submodule: remove submodule.fetchjobs from
> submodule-config parsing, 2017-08-02), where both
> builtin/fetch as well as the submodule helper use the pattern to
> read from the .gitmodules file va this function and then overlay it
> with the read from config.
>

I get that the _content_ of .gitmodules is not meant to be generic
config, but I still see some value in having a single point when its
_location_ is decided.

> > Add a repo argument to it to make the function more general, and adjust
> > the current callers in cmd_fetch and update-clone.
> 
> This could be a preparatory patch, but including it here is fine, too.
>

I agree, having this as a preparatory change will help focusing the
review, thanks.

> > As a proof of the utility of the change, start using the function also
> > in repo_read_gitmodules which was basically doing the same operations.
> 
> I think they were separated for the reason outlined above, or what Brandon
> said in his reply.
>
> I think extending 'repo_read_gitmodules' makes sense, as that is
> used everywhere for the loading of submodule configuration.

I would follow Brandon's suggestion here and still use
'config_from_gitmodules' from 'repo_read_gitmodules' to avoid code
duplication.

I will try to be clear in the comments and in commit message when
motivating the decision.

Thanks for the review Stefan.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
