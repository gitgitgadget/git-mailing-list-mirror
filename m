Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7902B1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 02:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfJZCnb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 22:43:31 -0400
Received: from zinan.dashjr.org ([192.3.11.21]:51862 "EHLO zinan.dashjr.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfJZCnb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 22:43:31 -0400
Received: from [2001:470:5:265:a45d:823b:2d27:961c] (unknown [IPv6:2001:470:5:265:a45d:823b:2d27:961c])
        (Authenticated sender: luke-jr)
        by zinan.dashjr.org (Postfix) with ESMTPSA id E4E2A38A0CDF;
        Sat, 26 Oct 2019 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dashjr.org; s=zinan;
        t=1572057810; bh=ASp1LPgNwcj3kcOZ7QWMOu/w1MDklT0hX8y6A7gBvNs=;
        h=From:To:Subject:Date:Cc:References:In-Reply-To;
        b=y0tQla/blKqoPSjNi0vmvN3F9Kr3OrBmwIHI6Z28cEP2zN9K7J3E7hN2eebGjAM7K
         cIy82fE3qTKaIE6/VCeqRR/duS19NBznHGBCGViX7z1hcgqZfBdYjkZyBosHiWwjLg
         V82ojH0xHrOFMn6/ysdKbYld3u3aaCBTe+FX5FfI=
X-Hashcash: 1:25:191026:jrnieder@gmail.com::dcStJ7ko6Ktq+OAh:DoA3
X-Hashcash: 1:25:191026:git@vger.kernel.org::cPaEAcc51v3tfmGQ:erM8
From:   Luke Dashjr <luke@dashjr.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GIT_COMMITTER_* and reflog
Date:   Sat, 26 Oct 2019 02:43:22 +0000
User-Agent: KMail/1.9.10
Cc:     git@vger.kernel.org
References: <201910252149.23787.luke@dashjr.org> <20191026022039.GE39574@google.com>
In-Reply-To: <20191026022039.GE39574@google.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201910260243.23627.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 26 October 2019 02:20:39 Jonathan Nieder wrote:
> Luke Dashjr wrote:
> > It appears the reflog currently allows its log data (name and date) to be
> > overridden by the GIT_COMMITTER_* environment variables. At least for my
> > workflow, this kinda breaks the reflog (as I regularly set
> > GIT_COMMITTER_DATE to produce deterministic commit objects).
>
> Can you say more about this?  What is the workflow this is part of?  Can
> you describe a sequence of steps and how you are affected during those
> steps?

I maintain a bleeding-edge variant of a more stable project, which is 
constantly being rebased on the latest stable version. To make this easier, I 
use a Perl script to generate the bleeding-edge version's git branches:
    https://github.com/bitcoinknots/assemble-deriv
It uses GIT_COMMITTER_DATE to ensure that I can repeatedly generate the branch 
until everything merges successfully, without polluting the repository with 
hundreds of merge commits each attempt. (Which would be annoying, since I 
literally never prune.)

Because git's reflog also uses GIT_COMMITTER_DATE, my reflogs (HEAD in 
particular) get polluted with incorrect timestamps during this process.

> > Is there a need to support this override for the reflog?
>
> Yes.
>
> > Is there any reason it can't be changed to use GIT_REFLOG_* instead?
>
> Would a new GIT_REFLOG_* set of envvars that overrides GIT_COMMITTER_*
> work for you?  If I understand correctly, you could set
> GIT_REFLOG_NAME and GIT_REFLOG_EMAIL to an appropriate identity, but
> you wouldn't have a good value to put in GIT_REFLOG_DATE.
>
> If GIT_COMMITTER_{NAME,EMAIL} were used when writing reflogs but
> GIT_COMMITTER_DATE weren't, would that help with your workflow?

Yes, it's really only GIT_COMMITTER_DATE that's messing me up personally.
I never use GIT_COMMITTER_{NAME,EMAIL}.

Luke
