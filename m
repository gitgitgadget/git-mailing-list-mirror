Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83791C433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbiDKS0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbiDKS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:26:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AA2AD0
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 11:23:55 -0700 (PDT)
Received: from penguin.thunk.org ([65.199.217.170])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23BINR13001314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 14:23:28 -0400
Received: by penguin.thunk.org (Postfix, from userid 1000)
        id 030401C724; Mon, 11 Apr 2022 14:23:25 -0400 (EDT)
Date:   Mon, 11 Apr 2022 14:23:25 -0400
From:   tytso <tytso@mit.edu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <YlRyHR5rvG5P/Acr@mit.edu>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 12:19:51PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > and the main argument *against* is "for most
> > people (non-advanced users), what you do initially is what you end up
> > pushing, or at least trying to push, and fixing things later is *hard*
> > - it requires a much deeper understanding of git than most people
> > otherwise necessarily need to develop".
> 
> Yes, maybe it won't be viable to go in that direction, but re this in my
> [1]:
> 	
> 	But I'm also pretty sure that those people are engaged in a proxy war,
> 	and we should just attack the "problem" directly instead. I.e. it's not
> 	a problem that some commit somewhere has an empty message, rather it's
> 	that such a commit gets "propagated". A better place to check for it is
> 	then at the point of point of propagation.

So possible options we could consider:

1) Do nothing.  If users want to override the current behavior they
can just put in their .git/config or ~/.gitconfig file:

[alias]
   commit = commit --allow-empty-message

2) Add some kind of explicit git-config option which could then be
added to their .git/config or ~/.gitconfig:

[commit]
   allow-empty-description = true

3) Change the default, so that --allow-empty-message is always
implied, and hope that novices can figure out git rebase -i without
shooting themselves in the foot.

4) Enforce git push doesn't push commits with empty commits,
implemented on the client side.  This could be implemented via a
pre-push hook script.

5)  Enforce git push doesn't push commits with empty commits,
implemented on the server side.This could be implemented via a
pre-receive hook script.

I will note that only options 2 and 3 require source code changes to
git.  The rest can effectively be done via config file changes; for
the hook files, we could provide example scripts to make it easier for
people to choose that particular option.

And of these options, only one option, #3, requires imposing someone's
preference (which does appear to be in the minority) on everyone
else.

						- Ted
