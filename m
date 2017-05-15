Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD8D201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965160AbdEOTJn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:09:43 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36019 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965059AbdEOTJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:09:43 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so67643381pfg.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0Le1VOslsAXk2XpZ5hHjzFPWAQ0/BHG7+wbu9oj7Ubg=;
        b=e2SRrvgTWzFgHgtnAs4idk7r+cs7r7LKhC/3D/RpbnkEv3rH9BJIR31E2j6yGf5qbT
         IMV64+G8+wrxA9vnBZgRUVCXKEyYJrtw6/4k8VhQrwMasNP4EFE1PZMrDnyFUExGkT1q
         vegkxtb/et9m1CLR+vzBTONKe04RJuHBAfZbGlE9/gL8UvfO2Ek3s2hVP+A8OxcmN8ph
         aUH2MFPP1FHfmdeYJ1Kaxv5UwohilbYqg4o3KxN0/6xbFtlJENADTWWeHaY3G/lXKhIF
         XWzNGncBCY+tMElibjUy/jsXd9TK+dEsel72ayrwYI6XMtelO4oK7aQV+cvdi9+sSolG
         Ws/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0Le1VOslsAXk2XpZ5hHjzFPWAQ0/BHG7+wbu9oj7Ubg=;
        b=rBH4BV0O2+PWifW9hagaTadVkA52VlAqS4AXASyG99CP4vccKuol9InURI9iHaKB97
         GCiweU+I9FVRgEiu0ZcUI5gE+GwWA7zqTsjDS2jrtO6LxQjXIlj6zsOYPQL3SwGhZB92
         m6w24maZrIXUc4p47aOZfMASYRcjrbFsFVV5HdeYL3f0pmeXKHZc8zhWxmCpAwIKNZ4x
         JiR1nWpomm4uFQXGK+gVsIJg0Gdz+8DgF9sGeMlelfJGumzhbC7vZBAxnAyCL1MTyV9x
         WxIcuarSbEzovrXLikgkD5+pPzvnpIyEwqf/wQp2T6ouit1/luGAGjk9SNku+eHBk1Hi
         qLlQ==
X-Gm-Message-State: AODbwcDoPJdFt8I3oje7m7hyti4qUG1X4990kc48CZE2TV7Yqg19pk/I
        HZBpJzYWn7zJg3wU
X-Received: by 10.98.194.66 with SMTP id l63mr7957935pfg.234.1494875382184;
        Mon, 15 May 2017 12:09:42 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id p62sm18207799pfp.48.2017.05.15.12.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 12:09:40 -0700 (PDT)
Subject: Re: [PATCH 10/19] diff.c: convert emit_rewrite_lines to use
 emit_line_*
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-11-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <d67fa7ed-fbde-7bce-a691-01dafaa93732@google.com>
Date:   Mon, 15 May 2017 12:09:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-11-sbeller@google.com>
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
> This covers emit_rewrite_lines.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index e4b46fee4f..369c804f03 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -748,7 +748,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
>  	if (!endp) {
>  		const char *context = diff_get_color(ecb->color_diff,
>  						     DIFF_CONTEXT);
> -		putc('\n', ecb->opt->file);
> +		emit_line(ecb->opt, NULL, NULL, "\n", 1);

This outputs diff_line_prefix(ecb->opt) - is that OK?

>  		emit_line_0(ecb->opt, context, reset, '\\',
>  			    nneof, strlen(nneof));
>  	}
>
