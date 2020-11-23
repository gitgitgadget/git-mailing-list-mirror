Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EBC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78A220717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mcuTbZbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKWXhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:37:48 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:41598 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgKWXhr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606174666; x=1637710666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/1nKz8AO8edDkufMUMkOd2jUpQQHc97Xg1OoMZ8xQGw=;
  b=mcuTbZbriWkKzwlwFliyX1CRI78MGXDZbbY6fmYdtMzHrA9bqc7v90SR
   x/Dh66hnSf/JRRupWoK2i9PBmKZ+up7f4UmxSA8kBjq6MUnRSsuixT+7O
   C3JNwPJhcayUohMqe66kkxOTRS7X1HgxHoJdyoAubFgdnTX72p5EFkHxa
   0=;
X-IronPort-AV: E=Sophos;i="5.78,364,1599523200"; 
   d="scan'208";a="66871243"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Nov 2020 23:37:38 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 56E0D241B19;
        Mon, 23 Nov 2020 23:37:37 +0000 (UTC)
Received: from EX13D31UWC001.ant.amazon.com (10.43.162.152) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 23:37:36 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D31UWC001.ant.amazon.com (10.43.162.152) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Nov 2020 23:37:37 +0000
Received: from dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com
 (10.200.254.64) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 23:37:36 +0000
Received: by dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com (Postfix, from userid 5408343)
        id 3F45548DE; Mon, 23 Nov 2020 23:37:35 +0000 (UTC)
Date:   Mon, 23 Nov 2020 23:37:35 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
CC:     Matheus Tavares <matheus.bernardino@usp.br>, <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
Message-ID: <20201123233735.GB28189@dev-dsk-gerardu-1d-54592b62.us-east-1.amazon.com>
References: <20201115194359.67901-1-matheus.bernardino@usp.br>
 <87y2ixpvos.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2ixpvos.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Thu, Nov 19, 2020 at 10:01:07AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > The major downside is that detecting the file system type is quite
> > platform-dependent, so there is no simple and portable solution. (Also,
> > I'm not sure if the optimal number of workers would be the same on
> > different OSes). But we decided to give it a try, so this is a
> > rough prototype that would work for Linux:
> > https://github.com/matheustavares/git/commit/2e2c787e2a1742fed8c35dba185b7cd208603de9
> 
> I'm not intrinsically opposed to hardcoding some "nr_threads = is_nfs()
> ? x : y" as a stopgap.
> 
> I do think we should be thinking about a sustainable way of doing this
> sort of thing, this method of testing once and hardcoding something
> isn't a good approach.
> 
> It doesn't anticipate all sorts of different setups, e.g. in this case
> NFS is not a FS, but a protocol, there's probably going to be some
> implementations where parallel is much worse due to a quirk of the
> implementation.
> 
> I think integrating an optimization run with the relatively new
> git-maintenance is a better way forward.
> 
> You'd configure e.g.:
> 
>     maintenance.performanceTests.enabled=true
>     maintenance.performanceTests.writeConfig=true
> 
> Which would run e.g.:
> 
>     git config --type bool core.untrackedCache $(git update-index --test-untracked-cache && echo true || echo false)
>     git config checkout.workers $(git maintenance--helper auto-discover-config checkout.workers)
> 
> Such an implementation can be really basic at first, or even just punt
> on the test and use your current "is it NFS?" check.
> 
> But I think we should be moving to some helper that does the actual test
> locally when asked/configured by the user, so we're not making a bunch
> of guesses in advance about the size/shape of the repository, OS/nfs/fs
> etc.

I like this idea as something that will give the best configuration for a given
repository. I also know from working with customers for a long time that most
users will use the default settings for almost any application, and that
default configurations therefore matter a lot.

The ideal experience would be, in my view, that a clone or checkout would
automatically benefit from parallel checkout, even if this is the first
checkout into a new repository.

Maybe both ideas could be combined? We could have some reasonable heuristic
based on file system type (and maybe number of CPUs) that gives most of the
benefits of paralell checkout, while still being a reasonable compromise that
that works across different NFS servers and file systems. Power users that want
more aggressive tuning could run the maintenance command that measures file
system performance and comes up with an optimal value for checkout.workers.

Regards,
Geert
