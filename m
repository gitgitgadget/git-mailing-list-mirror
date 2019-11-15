Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 839C71F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 03:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKODdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 22:33:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKODdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 22:33:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68CB79A7CC;
        Thu, 14 Nov 2019 22:33:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Cm70tVMx1uCDOkVyZFzSu7DQ8z8=; b=xzi5WdC
        RHSaj7FH1pynmkIv6xvD/n5RGfeH3BO9O3xDqYQTn71LUISBnx9m3Siv0tD2yKgJ
        Cu1lsA5DBh9RqEih6TDgyxGHIUPW3+1ANA1KdwEGr5ihKRiYMbqPcvfEkRUhTSx6
        9TUhmtgm8zH9NTNbwehlRnu11bMpEOu+wJHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=pmbYlQb298OsXxXy69slIqGvZ8tz6mE20
        9k+m7V7EcG3fJFisf3V4xqfVamL10XtplpLWmeWDB8g3s8R5pi8jxqTbrAU6vP/Y
        fSVg2IRsBLGbh2IhNTiCIeti/aEdJGgFkxinSuH69bKERb4b0RP81jVRThsZyiEH
        RY2VfwlAT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 610089A7CB;
        Thu, 14 Nov 2019 22:33:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E6459A7CA;
        Thu, 14 Nov 2019 22:33:27 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 14 Nov 2019 22:33:25 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
Message-ID: <20191115033325.GC3898@pobox.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
 <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B04FAEBA-0758-11EA-AB03-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu wrote:
> index 90ff9e2bea..91edeaf6d5 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -269,7 +269,7 @@ list.
>  	exclude (that is, '{caret}commit', 'commit1..commit2',
>  	and 'commit1\...commit2' notations cannot be used).
>  +
> -With `--pretty` format other than `oneline` (for obvious reasons),
> +With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
>  this causes the output to have two extra lines of information
>  taken from the reflog.  The reflog designator in the output may be shown
>  as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
> @@ -293,6 +293,8 @@ Under `--pretty=oneline`, the commit message is
>  prefixed with this information on the same line.
>  This option cannot be combined with `--reverse`.
>  See also linkgit:git-reflog[1].
> ++
> +Under `--pretty=summary`, this information will not be shown at all.

I think the line above wants s/summary/reference.

-- 
Todd
