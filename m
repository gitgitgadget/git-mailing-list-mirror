Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47381F403
	for <e@80x24.org>; Sun, 10 Jun 2018 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeFJT0v (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 15:26:51 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:24451 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbeFJT0v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 15:26:51 -0400
Received: from [192.168.2.240] ([92.22.21.50])
        by smtp.talktalk.net with SMTP
        id S5zEf7eawbZX5S5zEfWdqw; Sun, 10 Jun 2018 20:26:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528658809;
        bh=7DOqA5Hg9oGji5Wb1SM7/xkY1oa/h3S9seeVkLAeO5w=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=ThfO5vS1QvW8pdP3axgVSuLparRuNVdxohOUetQ5XC5rYufGUFuSXgWYTr0gTWw+s
         OK7Kcp7QuIhHSyOKOmpOD0BhoUwh2ktTtwFpYIzafyryZr/ROsM1gXI0Q2/+C9uhhZ
         gQBTr2MoaPTe/dU2Td387n+wvwf5nf9ZWupq2bFI=
X-Originating-IP: [92.22.21.50]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=WogICo9TToZCqFjIzRluTQ==:117
 a=WogICo9TToZCqFjIzRluTQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=gd-c90epqYwOYwZxZcwA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-rebase.sh: handle keep-empty like all other options
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050747.19726-1-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <8f19c8c2-d050-2d51-756d-d78b9f2bd335@talktalk.net>
Date:   Sun, 10 Jun 2018 20:26:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607050747.19726-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBj+DMQ//rqOGT6pm6euqCQobbe6GFP2zUkEWCPhtVs3zoFdvv4oW1LgghCVfT6wF0pPeREObHFPk2EsgTi8w66IHEX8ynTeOtx41CLxJ8EwMhQsJkbL
 yLb4Y2YwhWtmjl3/9Ql50jHlrOri+9SQxzcAgg2MLojbNWBoqH8uObqrK8ztel7vO9FXvoo9ECh5ud3uE7MIeYZhPeWz95UGpu0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah
On 07/06/18 06:07, Elijah Newren wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   git-rebase.sh | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 40be59ecc4..a56b286372 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -276,6 +276,7 @@ do
>   		;;
>   	--keep-empty)
>   		keep_empty=yes
> +		test -z "$interactive_rebase" && interactive_rebase=implied

I think you need to wait until all the options have been parsed before 
setting the implied interactive rebase in case the user specifies has 
'--keep-empty' in an alias and specifies '--no-keep-empty' with some am 
options on the command line.

Best Wishes

Phillip
>   		;;
>   	--allow-empty-message)
>   		allow_empty_message=--allow-empty-message
> @@ -480,11 +481,6 @@ then
>   	test -z "$interactive_rebase" && interactive_rebase=implied
>   fi
>   
> -if test -n "$keep_empty"
> -then
> -	test -z "$interactive_rebase" && interactive_rebase=implied
> -fi
> -
>   if test -n "$interactive_rebase"
>   then
>   	type=interactive
> 

