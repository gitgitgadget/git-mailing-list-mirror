Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B6D320951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdCQQNE (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:13:04 -0400
Received: from avasout01.plus.net ([84.93.230.227]:41249 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCQQND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:13:03 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id x4CZ1u00322aPyA014CabJ; Fri, 17 Mar 2017 16:12:34 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=9Wbz0odb7UIUuQdXHHoA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][PATCH v5 2/3] credential-cache: use XDG_CACHE_HOME for
 socket
To:     Devin Lehmacher <lehmacdj@gmail.com>
References: <20170316051827.97198-5-lehmacdj@gmail.com>
 <20170317025315.84548-1-lehmacdj@gmail.com>
 <20170317025315.84548-2-lehmacdj@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2952fc80-a313-4193-64b6-072b7ccdef4f@ramsayjones.plus.com>
Date:   Fri, 17 Mar 2017 16:12:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170317025315.84548-2-lehmacdj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/03/17 02:53, Devin Lehmacher wrote:
> Make git-credential-cache follow the XDG base path specification by
> default. This increases consistency with other applications and helps
> keep clutter out of users' home directories.
> 
> Check the old socket location, ~/.git-credential-cache/, and use
> ~/.git-credential-cache/socket if that directory exists rather than
> forcing users who have used `git credential-cache` before to migrate to
> the new XDG compliant location.
> Otherwise use the socket $XDG_CACHE_HOME/git/credential/socket following
> XDG base path specification. Use the subdirectory credential/ in case
> other files are cached under $XDG_CACHE_HOME/git/ in the future and to
> make the socket's purpose clear.
> 
> Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
> ---
>  Documentation/git-credential-cache.txt | 11 +++++++----
>  credential-cache.c                     | 15 ++++++++++++++-
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
> index 96208f822..2b8582639 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -33,10 +33,13 @@ OPTIONS
>  --socket <path>::
>  
>  	Use `<path>` to contact a running cache daemon (or start a new
> -	cache daemon if one is not started). Defaults to
> -	`~/.git-credential-cache/socket`. If your home directory is on a
> -	network-mounted filesystem, you may need to change this to a
> -	local filesystem. You must specify an absolute path.
> +	cache daemon if one is not started).
> +	Defaults to `$XDG_CACHE_HOME/git/credential/socket` unless

or $HOME/.cache/git/credential/socket if $XDG_CACHE_HOME is not set.
I don't have a good suggestion to re-word this paragraph. (I just
spent ten minutes trying!).

Hmm, git-credential-store doesn't mention the $HOME/.config/git/credentials
outside of the files section. (In particular, not as part of the --file
option description).

> +	`~/.git-credential-cache/` exists in which case
> +	`~/.git-credential-cache/socket` is used instead.
> +	If your home directory is on a network-mounted filesystem, you
> +	may need to change this to a local filesystem. You must specify
> +	an absolute path.

ATB,
Ramsay Jones

