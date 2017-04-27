Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8D7207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 17:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163665AbdD0ROJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 13:14:09 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:51006 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163654AbdD0ROH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 13:14:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wDNpN4hv8z5tlD;
        Thu, 27 Apr 2017 19:14:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A141E43E;
        Thu, 27 Apr 2017 19:14:02 +0200 (CEST)
Subject: Re: [PATCH 20/26] line-log: avoid memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <0051da81b5cffe53122c036122402418c7f8d55f.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4ae94881-305f-380b-e786-c7f4ea5735e3@kdbg.org>
Date:   Thu, 27 Apr 2017 19:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0051da81b5cffe53122c036122402418c7f8d55f.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> Discovered by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  line-log.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/line-log.c b/line-log.c
> index a23b910471b..19d46e9ea2c 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
>  	changed = process_all_files(&parent_range, rev, &queue, range);
>  	if (parent)
>  		add_line_range(rev, parent, parent_range);
> +	free(parent_range);
>  	return changed;
>  }
>
>

parent_range is of type struct line_log_data *, which needs more than a 
mere free(). I think it's free_line_log_data(parent_range).

-- Hannes

