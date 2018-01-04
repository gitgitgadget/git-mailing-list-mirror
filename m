Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A181F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeADTyC (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:54:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeADTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:54:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 77B286032D; Thu,  4 Jan 2018 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515095641;
        bh=FHpydYszZZZ65ELZQO4JTqFTLI6BK2j/UoyN3vqv07s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKXIZhNkc2U14aHhgj1J2K8aYCQBsrN2i5vJhZilRKkmFzXJ6d1QRBqufMZwCpMNE
         fOIrbextuIVaAV18HRbWhzgd5z0HrfTzIePkedFrEYACMYte/qWJcjTDwf9bHOPcnf
         akTlNCc66koGLeiaLQEhgA+ntEH5K694dwN3E0lE=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1668A602B9;
        Thu,  4 Jan 2018 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515095641;
        bh=FHpydYszZZZ65ELZQO4JTqFTLI6BK2j/UoyN3vqv07s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKXIZhNkc2U14aHhgj1J2K8aYCQBsrN2i5vJhZilRKkmFzXJ6d1QRBqufMZwCpMNE
         fOIrbextuIVaAV18HRbWhzgd5z0HrfTzIePkedFrEYACMYte/qWJcjTDwf9bHOPcnf
         akTlNCc66koGLeiaLQEhgA+ntEH5K694dwN3E0lE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1668A602B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Date:   Thu, 04 Jan 2018 12:54 -0700
Message-ID: <3447055.jsE6nH3DQt@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <20171225035215.GC1257@thunk.org> <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, December 25, 2017 06:16:40 PM Carl Baldwin wrote:
> On Sun, Dec 24, 2017 at 10:52:15PM -0500, Theodore Ts'o 
wrote:
> Look at what happens in a rebase type workflow in any of
> the following scenarios. All of these came up regularly
> in my time with Gerrit.
> 
>     1. Make a quick edit through the web UI then later
> work on the change again in your local clone. It is easy
> to forget to pull down the change made through the UI
> before starting to work on it again. If that happens, the
> change made through the UI will almost certainly be
> clobbered.
> 
>     2. You or someone else creates a second change that is
> dependent on yours and works on it while yours is still
> evolving. If the second change gets rebased with an older
> copy of the base change and then posted back up for
> review, newer work in the base change has just been
> clobbered.
> 
>     3. As a reviewer, you decide the best way to explain
> how you'd like to see something done differently is to
> make the quick change yourself and push it up. If the
> author fails to fetch what you pushed before continuing
> onto something else, it gets clobbered.
> 
>     4. You want to collaborate on a single change with
> someone else in any way and for whatever reason. As soon
> as that change starts hitting multiple work spaces, there
> are synchronization issues that currently take careful
> manual intervention.

These scenarios seem to come up most for me at Gerrit hack-
a-thons where we collaborate a lot in short time spans on 
changes.  We (the Gerrit maintainers) too have wanted and 
sometimes discussed ways to track the relation of "amended" 
commits (which is generally what Gerrit patchsets are).  We 
also concluded that some sort of parent commit pointer was 
needed, although parent is somewhat the wrong term since 
that already means something in git.  Rather, maybe some 
"predecessor" type of term would be better, maybe 
"antecedent", but "amended-commit" pointer might be best?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

