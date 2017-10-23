Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53379202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 14:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbdJWONF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 10:13:05 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.104]:54678 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbdJWONF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 10:13:05 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e6dTQ-0005kP-Ej; Mon, 23 Oct 2017 16:13:00 +0200
Date:   Mon, 23 Oct 2017 16:12:59 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, Jens.Lehmann@web.de, bmwill@google.com,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 2/2] fetch, push: keep separate lists of submodules and
 gitlinks
Message-ID: <20171023141259.GB85043@book.hvoigt.net>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
 <20171019181109.27792-1-sbeller@google.com>
 <20171019181109.27792-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171019181109.27792-2-sbeller@google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 11:11:09AM -0700, Stefan Beller wrote:
> Currently when fetching we collect the names of submodules to be fetched
> in a list. As we also want to support fetching 'gitlinks, that happen to
> have a repo checked out at the right place', we'll just pretend that these
> are submodules. We do that by assuming their path is their name. This in
> turn can yield collisions between the name-namespace and the
> path-namespace. (See the previous test for a demonstration.)
> 
> This patch rewrites the code such that we treat the 'real submodule' case
> differently from the 'gitlink, but ok' case. This introduces a bit
> of code duplication, but gets rid of the confusing mapping between names
> and paths.
> 
> The test is incomplete as the long term vision is not achieved yet.
> (which would be fetching both the renamed submodule as well as
> the gitlink thing, putting them in place via e.g. git-pull)
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Heiko,
>  Junio,
> 
>  I assumed the code would ease up a lot more, but now I am undecided if
>  I want to keep arguing as the code is not stopping to be ugly. :)

So we are basically coming to the same conclusion? :) My previous
fallback approach basically did the same but with the old architecture
(without parallel fetch, ...) and was already ugly.

With the fallback on submodule default names approach we can keep most
of the old functionality and keep the code that handles that minimal.

Since there is only a small (IMO quite unlikely) cornercase that could
break peoples expectations I would like to have a look whether anyone
even notices the behavioral change on next or master. If there are
complaints we can still extend and add the two lists.

>  The idea is to treat submodule and gitlinks separately, with submodules
>  supporting renames, and gitlinks as a historic artefact.
>  
>  Sorry for the noise about code ugliness.

Why sorry? For me it is actually interesting to see you basically coming
to the same conclusions.

Cheers Heiko
