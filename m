Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE73B1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHDSrQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 14:47:16 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:46714 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 14:47:16 -0400
X-Greylist: delayed 1657 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 14:47:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M5toULKnJ54HGb1V6vZJNLfBEU8rYSaRKX9wSjjhoAI=; b=uYbixyQm2ENxqiCSro4RAxyvQ
        Iv0NE3gSCVTRL4lNREc4ueZFbo6dCrTGHezAEpXMDRpC9gbbSoy0vl6RmpHG+lc/BfUHHVOmoTCXR
        qGiGNQ2I/HoYGfmMSZsE7rowvurfT1LT6DJrt5lAHTcP9A5CbkmNw+w9eU9q9EmQ+/SQFFyoY3GvO
        DP5108kzXcL1UTouUtLpeN4b7nA6QYuqA2Cylb69NU+/RPLdp1Kos23WUgB1rGUCQI8zEnlG0Etol
        GLjoR1orrQTfPDedIdV7NsyLnAyuzhGZq8c0DyT1gRQEjGb4J4wy+9dIgRmu30XkkhxbX3udcDnJo
        k15NHlz7w==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:44100 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1flzG6-00H7Mj-Cp; Sat, 04 Aug 2018 12:18:27 -0400
Date:   Sat, 4 Aug 2018 12:17:03 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] recover: restoration of deleted worktree files
In-Reply-To: <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1808041214550.28242@localhost.localdomain>
References: <20180804142247.GA7@e3c0ce5ceb57>        <20180804142416.GA6@5f28dc333bbd> <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Aug 2018, Junio C Hamano wrote:

> Edward Thomson <ethomson@edwardthomson.com> writes:
>
> > Introduce git-recover, a simple script to aide in restoration of
> > deleted worktree files.  This will look for unreachable blobs in
> > the object database and prompt users to restore them to disk,
> > either interactively or on the command-line.

> >  git-recover.sh | 311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 311 insertions(+)
> >  create mode 100755 git-recover.sh
>
> My first reaction was to say that I am not going to take a new
> command written only for bash with full bashism, even if it came
> with docs, tests nor Makefile integration, for Git itself.  Then I
> reconsidered, as not everything related to Git is git-core, and all
> of the above traits are sign of this patch _not_ meant for git-core.
>
> In other words, I think this patch can be a fine addition to
> somebody else's project (i.e. random collection of scripts that may
> help Git users), so let's see how I can offer comments/inputs to
> help you improve it.  So I won't comment on lang, log message, or
> shell scripting style---these are project convention and the
> git-core convention won't be relevant to this patch.

  not sure how relevant this is, but fedora bundles a bunch of neat
utilities into two packages: git-tools and git-extras. i have no idea
what relationship those packages have to official git, or who decides
what goes into them.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
