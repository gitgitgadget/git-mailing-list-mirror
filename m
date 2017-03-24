Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7811FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966797AbdCXVRH (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 17:17:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51363 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966793AbdCXVRF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 17:17:05 -0400
Received: (qmail 3105 invoked by uid 109); 24 Mar 2017 21:17:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 21:17:03 +0000
Received: (qmail 26362 invoked by uid 111); 24 Mar 2017 21:17:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:17:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 17:17:01 -0400
Date:   Fri, 24 Mar 2017 17:17:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: How do I copy a branch & its config to a new name?
Message-ID: <20170324211701.vvmp6n4c77o2dvbz@sigill.intra.peff.net>
References: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
 <20170324005249.GF20794@aiede.mtv.corp.google.com>
 <CACBZZX6U0PAAK8vJxBW2VSzbtfttFUNTZhDGk=BzLxkaTn64gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6U0PAAK8vJxBW2VSzbtfttFUNTZhDGk=BzLxkaTn64gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 12:10:49PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Actually this is a bit confusing, but I think reversing the arguments
> makes sense, i.e.:
> 
>     git branch -c dest [src]
> 
> And similarly:
> 
>     git checkout -c dest [<src>]
> 
> This is confusing in that it reverses the arguments, but more useful
> in that it allows you to omit src like the other invocations of these
> commands, and you can e.g. do:
> 
>     git branch -c avar/topic-2
> 
> While on avar/topic to start working on avar/topic-2, which would copy
> avar/topic's state & config.
> 
> I'll put this on my TODO list, but unless someone comes up with a
> compelling argument against the above I plan to make the interface
> look like that.

I think it probably should match "git branch -m", which uses:

  git branch -c [<oldbranch>] <newbranch>

That's the closest operation we currently have, and it still allows
omitting the src. It _is_ different than:

  git branch <branchname> [<start-point>]

I wondered if you could advertise "-c" not as a new "copy mode", but
rather as an option for normal branch creation. Sort of a "by the way,
copy the config". But I don't think that's a great mental model.
<start-point> doesn't have to be a branch at all.

-Peff
