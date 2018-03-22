Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF43D1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 13:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbeCVNke (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 09:40:34 -0400
Received: from mail.progesoft.com ([104.236.42.59]:33918 "EHLO
        mail.progesoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeCVNkd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 09:40:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.progesoft.com (Postfix) with ESMTP id 935121A0CDC
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 14:40:31 +0100 (CET)
Received: from [192.168.1.11] (151-0-155-178.ip281.fastwebnet.it [151.0.155.178])
        by mail.progesoft.com (Postfix) with ESMTPSA id 2E0E31A0297;
        Thu, 22 Mar 2018 14:40:21 +0100 (CET)
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] filter-branch: use printf instead of echo -e
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180319144905.11564-1-michele@locati.it>
 <20180319155259.13200-1-michele@locati.it>
 <nycvar.QRO.7.76.6.1803212249170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Michele Locati <michele@locati.it>
Message-ID: <081ccfce-7a89-503e-465e-3befe6f33f17@locati.it>
Date:   Thu, 22 Mar 2018 14:40:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803212249170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il 21/03/2018 22:50, Johannes Schindelin ha scritto:
> Hi Michele,
> 
> On Mon, 19 Mar 2018, Michele Locati wrote:
> 
>> [...]
>> -- 
>> 2.16.2.windows.1
> 
> Yaaaaay!
> 
> Out of curiosity: did the CONTRIBUTING.md file help that was recently
> turned into a guide how to contribute to Git (for Windows) by Derrick
> Stolee?

Well, no. Here's what led me here...

The people behind the concrete5 CMS asked support for improving the 
following procedure:

concrete5 is stored in
https://github.com/concrete5/concrete5
In order to make it installable with Composer (a PHP package manager), 
we need to extract its "/concrete" directory, and push the results to 
https://github.com/concrete5/concrete5-core
We previously used "git filter-branch --all" with this script:
https://github.com/concrete5/core_splitter/blob/70879e676b95160f7fc5d0ffc22b8f7420b0580b/bin/splitcore

That script is executed every time someone pushes concrete5/concrete5, 
and it took very long time (3~5 minutes).

I noticed on the git-filter-branch manual page that there's a 
"--state-branch", and it seemed quite interesting.
So, I asked in git@vger.kernel.org how to use it, and the author of that 
feature (Ian Campbell) told me to look at some code he wrote.
So, I wrote
https://github.com/concrete5/incremental-filter-branch
which wraps "git filter-branch --filter-state", and it's used in
https://github.com/concrete5/core_splitter/blob/99bbbcea1ab90572a04864ccb92327532ab6a42c/bin/splitcore
(it not yet in production: Korvin wants to be sure everything works well 
before adopting it)
The time required for the operation dropped from 3~5 minutes to ~10 
seconds ;)

While writing that script, I noticed a couple of things that could be 
improved in "git-filter-branch", so I submitted
https://marc.info/?l=git&m=152111905428554&w=2
(so that the script could run without problems if there's nothing to do)
and
https://marc.info/?l=git&m=152147095416175&w=2
(so that  --filter-state could be used on Mac and other non-Linux systems).
How did I learn how to submit to git? I searched for "git src", landed 
on https://github.com/git/git, read Documentation/SubmittingPatches and 
used git send-email.

And yes, all that on Windows (and WSL).


> 
> Ciao,
> Johannes

Ciao!

--
Michele

