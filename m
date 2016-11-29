Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C381FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbcK2VOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:14:05 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:6124 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbcK2VOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:14:03 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tSxB12V9wz5tlF;
        Tue, 29 Nov 2016 22:14:01 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A6D661A28;
        Tue, 29 Nov 2016 22:14:00 +0100 (CET)
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Duy Nguyen <pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
 <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
 <20161129135646.GA19797@ash>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c73ec2ee-eed0-414c-63a1-a1bd5c864cef@kdbg.org>
Date:   Tue, 29 Nov 2016 22:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161129135646.GA19797@ash>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.2016 um 14:56 schrieb Duy Nguyen:
> If you drop all the "copy.c: " patches and squash this to "worktree
> move: new command", and if Windows rename() can move directories, then
> git should build and new tests pass.

Thanks! rename() can move directories on Windows, provided that 
*nothing* inside the directory is in any form of use by any process, 
particularly also not as the "current working directory" (as per getcwd()).

> diff --git a/copy.c b/copy.c
> index 4de6a11..b232aec 100644
> --- a/copy.c
> +++ b/copy.c
> @@ -65,3 +65,9 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
>  		return copy_times(dst, src);
>  	return status;
>  }
> +
> +int copy_dir_recursively(const char *dst, const char *src)
> +{
> +	errno = ENOSYS;
> +	return -1;
> +}

An error message "cannot move directories across devices" or something 
would be preferable over "Function not implemented", of course. Or did 
you mean to set errno = EXDEV?

-- Hannes

