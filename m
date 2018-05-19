Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6F11F42D
	for <e@80x24.org>; Sat, 19 May 2018 07:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbeESHcI (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 03:32:08 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30191 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeESHcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 03:32:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40nxZF5Vpnz5tlJ;
        Sat, 19 May 2018 09:32:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 05019D7;
        Sat, 19 May 2018 09:32:05 +0200 (CEST)
Subject: Re: [PATCH 5/5] merge-recursive: simplify handle_change_delete
To:     Elijah Newren <newren@gmail.com>
References: <20180519020700.2241-1-newren@gmail.com>
 <20180519020700.2241-6-newren@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3b05f4b1-e236-989d-afe0-e85b28c2e278@kdbg.org>
Date:   Sat, 19 May 2018 09:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519020700.2241-6-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.2018 um 04:07 schrieb Elijah Newren:
> There is really no need for four branches of nearly identical messages
> when we can store the differences into small variables before printing.

Oh, there is a reason for the repeated message text: translations! 
Please do not play sentence Lego with translated strings. The original 
code is preferable.

> It does require a few allocations this way, but makes the code much
> easier to parse for human readers.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   merge-recursive.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 273ee79afa..3bd727995b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1290,31 +1290,17 @@ static int handle_change_delete(struct merge_options *o,
>   		if (!ret)
>   			ret = update_file(o, 0, o_oid, o_mode, update_path);
>   	} else {
> -		if (!alt_path) {
> -			if (!old_path) {
> -				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -				       "and %s in %s. Version %s of %s left in tree."),
> -				       change, path, delete_branch, change_past,
> -				       change_branch, change_branch, path);
> -			} else {
> -				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -				       "and %s to %s in %s. Version %s of %s left in tree."),
> -				       change, old_path, delete_branch, change_past, path,
> -				       change_branch, change_branch, path);
> -			}
> -		} else {
> -			if (!old_path) {
> -				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -				       "and %s in %s. Version %s of %s left in tree at %s."),
> -				       change, path, delete_branch, change_past,
> -				       change_branch, change_branch, path, alt_path);
> -			} else {
> -				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> -				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
> -				       change, old_path, delete_branch, change_past, path,
> -				       change_branch, change_branch, path, alt_path);
> -			}
> -		}
> +		const char *deleted_path = old_path ? old_path : path;
> +		char *supp1 = xstrfmt(old_path ? " to %s" : "", path);
> +		char *supp2 = xstrfmt(alt_path ? " at %s" : "", alt_path);
> +
> +		output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
> +		       "and %s%s in %s. Version %s of %s left in tree%s."),
> +		       change, deleted_path, delete_branch, change_past,
> +		       supp1, change_branch, change_branch, path, supp2);
> +		free(supp1);
> +		free(supp2);
> +
>   		/*
>   		 * No need to call update_file() on path when change_branch ==
>   		 * o->branch1 && !alt_path, since that would needlessly touch
> 

