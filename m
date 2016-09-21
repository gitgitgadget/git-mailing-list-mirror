Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E3A1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934207AbcIUOU2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 21 Sep 2016 10:20:28 -0400
Received: from sdaoden.eu ([217.144.132.164]:39284 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934202AbcIUOU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 10:20:27 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 16B591604A; Wed, 21 Sep 2016 16:20:24 +0200 (CEST)
Date:   Wed, 21 Sep 2016 16:21:18 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch
 name
Message-ID: <20160921142118.zintMuTEK%steffen@sdaoden.eu>
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
 <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
 <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com>
In-Reply-To: <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
 Git Users <git@vger.kernel.org>, Bryan Turner <bturner@atlassian.com>
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Jakub Narębski <jnareb@gmail.com> wrote:
 |W dniu 20.09.2016 o 20:54, Bryan Turner pisze:
 |> On Tue, Sep 20, 2016 at 9:23 AM, Steffen Nurpmeso <steffen@sdaoden.eu> \
 |> wrote:
 |>> Hello again,
 |>>
 |>> yah, sorry, i'm back again..
 |>> I try to find a way to find the name of the current branch in an
 |>> automated way, because i need to ensure that a commit happens on
 |>> it and no other branch.  Now the problem arises that the commit
 |>> ref at the time of that commit maybe shared in between several
 |>> different branches, but no more thereafter, of course:
 |>>
 |>>   ?0[steffen@wales ]$ git branch|grep '^*'
 |>>   * stable/v14.9
 |
 |Not good, 'git branch' is a porcelain (user facing) command, so it
 |output may change; e.g. '*' could be replaced with '•'. For example
 |output for detached HEAD had changed!

Ok.  I went the road Bryan suggested, i had only forgotten this.
Yes, it caused mysterious bugs once rev-parse reversed the output,
but i didn't understand the order at first, anyway.  With todays'
ever-rotating distributions i don't even try to keep up; currently
unthinkable to use the same release of an OS for five years, like
FreeBSD 5.3.  Well.

  ...
 |>> Is there another way except looking into .git/HEAD or using sed(1)
 |>> on the output of `branch' to find the right name?
 |> 
 |> Have you tried "git symbolic-ref HEAD"?
  ...
 |This does not work for detached HEAD, but perhaps you don't need
 |to worry about this.

No, not for me: it will only switch in between two different
stable/ which exist.  But thanks, just give it to me!

 |  $ git rev-parse --symbolic-full-name HEAD
 |  refs/heads/master

This is a really good suggestion, which i will remember.  I didn't
know this at all yet:

  $ git rev-parse --symbolic-full-name --abbrev-ref=strict HEAD

Seems to do exactly what i want, non-fragile, then.

 ...
 |But
 ...
 |  You are in 'detached HEAD' state. [...]
 | 
 |  $ git rev-parse --symbolic-full-name HEAD
 |  HEAD
 |
 |  $ git symbolic-ref HEAD
 |  fatal: ref HEAD is not a symbolic ref
 |
 |  $ git branch
 |  * (HEAD detached at 3e2ebf9)
 |    master

And name-rev gives "HEAD master~2" in a test of mine, or only
"master~2", or "undefined" if i use --tags, for completeness sake.

Thanks, Jakub.  I'm using the plumbing.

--steffen
