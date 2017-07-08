Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFADE202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbdGHLIi (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 07:08:38 -0400
Received: from avasout05.plus.net ([84.93.230.250]:33068 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbdGHLIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 07:08:37 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id iB8b1v00118PUFB01B8c3p; Sat, 08 Jul 2017 12:08:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=0jZBXOGl-rx64QDzl0wA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in
 gitdiff_verify_name()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d83d2395-e667-9e52-cc94-af5fbec6054c@ramsayjones.plus.com>
Date:   Sat, 8 Jul 2017 12:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/07/17 09:58, René Scharfe wrote:
> Avoid running over the end of another -- a C string whose length we
> don't know -- by using strcmp(3) instead of memcmp(3) for comparing it
> with another C string.

I had to read this twice, along with the patch text, before this
made any sense. ;-) The missing information being that 'another'
was the name of the string variable that we were potentially
'running over the end of'.

ATB,
Ramsay Jones

> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  apply.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 946be4d2f5..9b3df8a3aa 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -962,13 +962,12 @@ static int gitdiff_verify_name(struct apply_state *state,
>  	}
>  
>  	if (*name) {
> -		int len = strlen(*name);
>  		char *another;
>  		if (isnull)
>  			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
>  				     *name, state->linenr);
>  		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
> -		if (!another || memcmp(another, *name, len + 1)) {
> +		if (!another || strcmp(another, *name)) {
>  			free(another);
>  			return error((side == DIFF_NEW_NAME) ?
>  			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
> 
