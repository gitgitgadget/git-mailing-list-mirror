Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1111F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeFFTfp (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:35:45 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:35546 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbeFFTfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r7cTv2eA5yGcm8pypiQ5DC159+bmRYTNqa7VpGsScFE=; b=uwVioPN/vNm1W/6TPlEvDXoyW
        mA0lGcBZUCUXXkyN7OEsdEoix1ihygd5p9ptpl1IlwoLHslGeLnJT3eEpe+44Mclku1bWT0ya8fln
        N7pFVU5Nenbjp4BQlTGojLThLh2nf7OZu+77akOHlSzoRAntTXQ/tvxTj2B304aZ2K+KkhGhQ12Bo
        klZjtmZAbwsqzQVaFDHjfI2MTx7q4EIWzFnj3GJJAneOvliax/9h1yRJOstwlCdnqG5Tgyp2/WgfF
        NpxUOM0tUcTaahFaSpOkOtBYd7EeJR457jICT47ORjv8QDxneM2UK9730dKSw7QCmFPoi/amrh+sh
        YLVJIPJkA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:54386 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQeDe-009iJY-4R; Wed, 06 Jun 2018 15:35:43 -0400
Date:   Wed, 6 Jun 2018 15:33:27 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Fischer <thomasfischer@fastmail.com>
cc:     git@vger.kernel.org
Subject: Re: git rm bug
In-Reply-To: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
Message-ID: <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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

On Wed, 6 Jun 2018, Thomas Fischer wrote:

> OVERVIEW
>
> "git rm" will remove more files than specified. This is either a bug or undocumented behavior (not in the man pages).
>
> SETUP
>
> 1. In a git repository, create an empty directory OR a chain of empty directories
>
> $ mkdir -p path/to/some/
>
> 2. Create a file in the deepest directory and add it to tracking
>
> $ touch path/to/some/file
> $ git add path/to/some/file
> $ git commit -m 'add path/to/some/file'
>
> THE BUG
>
> Run 'git rm' on the tracked file.
>
> EXPECTED BEHAVIOR
>
> $ git rm path/to/some/file
> rm 'path/to/some/file'
> $ ls path
> to/
> $ ls path/to
> some/
>
> Note that path/, path/to/, and path/to/some/ still exist.
>
> ACTUAL BEHAVIOR
>
> $ git rm path/to/some/file
> rm 'path/to/some/file'
> $ ls path
> ls: cannot access 'path': No such file or directory
>
> The entire chain of empty directories is removed, despite the fact
> the git outputs only "rm 'path/to/some/file'".

  git cannot track empty directories. as that was the *only* content
in that whole hierarchy, the entire hierarchy had to be deleted.

rday
