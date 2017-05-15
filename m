Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E81201A7
	for <e@80x24.org>; Mon, 15 May 2017 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934613AbdEOUVx (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 16:21:53 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34644 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934544AbdEOUVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 16:21:52 -0400
Received: by mail-pg0-f50.google.com with SMTP id u28so65310406pgn.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jGZ2eOmNuzCsTgjZJc9Q+mAcP1IiHTLuEfmpTxhE6qI=;
        b=oR0V9/Sjy7vsxHZrMh+16te2652QtWgPxac5zzomxfztBghPK892YhjGbsXf0gup94
         gdQAivxbGvNZ/ncP+WfTt44C2C1XtK9a2X2UdjwqNHp0rDAUyL/yPxK8sDmetpBuk/B6
         1qjtYTm1FdelnfH17gS6P22oOzTY/12/jCEYjM2RlC4Fkt1JBE+RHlfZM8kvtfahwULR
         I6VUhi9SpWglJNYgb6tTy6Xu8lWCsDVQUG6fKvIXbSHJO4PYDhpFvWpvHHMDlIgEAvhi
         o0YUdYkX2dMAm0tDrzuyF4LeiR+uv+UiROGOCwc1P+QMsgjD9BrHOi09lo0MxT6ZgHSp
         Tp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jGZ2eOmNuzCsTgjZJc9Q+mAcP1IiHTLuEfmpTxhE6qI=;
        b=czall/XoRRR+DCyZJNHxwB4HqMdGugSOfeCUKNk+XB3cg+TnOyG3HLDaR3/Vmrdo8x
         HJLLa7QulpU+aeSbYWqs1u9mj6vkwLHDKDJjKgykmIRWkPcCXQtr3hm/sa84noe3oe0I
         4GTd0WMOJ4nQ7dpYZttca5vpLHMxvlfaUCci7EUQNibf3OiR8mj/wsN0He9UCzNYwGjT
         HfYhwby3PTGgDSk1ANmmhYtmU9V4w8Ic72QijR7SFPExvM/zdm5etskEDCAUFgr4AChb
         3vBKNheSXNuu8q5FxF+aGUcMFUSjsLsADg/NB37jLL3rCZViYfMMPCig24yFATDOC728
         eYcw==
X-Gm-Message-State: AODbwcD0/IrvGwNHIcrAEhG1+Wyeu/3aUQEq4ET8aSWeKnsOwGt/ueZJ
        UMwzl4iRGC3b0w6a
X-Received: by 10.99.139.195 with SMTP id j186mr8196111pge.134.1494879711655;
        Mon, 15 May 2017 13:21:51 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id 15sm23867684pfj.59.2017.05.15.13.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 13:21:50 -0700 (PDT)
Subject: Re: [PATCH 15/19] diff.c: convert diff_flush to use emit_line_*
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-16-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <1b85a773-fb44-9a88-63d3-36c642d07c22@google.com>
Date:   Mon, 15 May 2017 13:21:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-16-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13/2017 09:01 PM, Stefan Beller wrote:
> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This covers diff_flush.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 07041a35ad..386b28cf47 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4873,7 +4873,9 @@ void diff_flush(struct diff_options *options)
>  				  term, 1);
>  			if (options->stat_sep) {
>  				/* attach patch instead of inline */
> -				fputs(options->stat_sep, options->file);
> +				emit_line(options, NULL, NULL,
> +					  options->stat_sep,
> +					  strlen(options->stat_sep));

Same comment as patch 10 - is it OK that we now output a prefix too?

>  			}
>  		}
>
>
