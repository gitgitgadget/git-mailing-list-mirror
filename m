Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979D920209
	for <e@80x24.org>; Thu, 25 May 2017 05:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941906AbdEYFPw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:15:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35484 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941893AbdEYFPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:15:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so36787356pfd.2
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AUgy3BpmVwnnujYMnH9QSbcnRhjsvLZNyUOlu/4SyxI=;
        b=SG/IU5fgvO0c0gU9yZQZy+g+IncVVeAFg54BrdDh0y/SbFe8TY3WlvTpfivcBpsZqz
         raBBZEt7g5N9Rewa3sLf0c+vOjIrWS469JxVCuq26KaaXqkT7zoQ39vB+BjRlbEAmyQh
         2u6wW4ra+ST95nF7PDQM+wgI6nYNzipNir81HVB97ZLpLxFr+uyXqT/TbQ6SR4hSVvY8
         hphxaKExhb62SMAm13yIs5UuT+K4FgcMAPwZ9052marZLyps9XZO0IOZ5xUR/sma7A8k
         bOsbF/ebVczRJr2WJggz+kkQxMoyrY9068O7EqowKiZyenzWMmZCDFIL6kGVEeUqo40m
         lygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AUgy3BpmVwnnujYMnH9QSbcnRhjsvLZNyUOlu/4SyxI=;
        b=MtMZhAUZYHsNPb4FAGdBA1GFdYJQum9jbUa4Ki3SvwCEH774mhWucFgzM3nk7r7f2J
         ute2Vy96TSMNaMMHYxou1XMEwoW2J37dRMX9Uu+myXhq8ltC1X/MrtBMtU3VWV8ne5Ex
         uRs/s4Ag13zRz1UF1AzaZOXgnq1ypTg87u92/Li3++8bHevx5bTXwA8g2MiMKSdcxkMp
         aA+ucUnKXOCW+L+A+KUvBEFqyrVuuv+GzeUrD3DsLLH9wc8Y0WRfifiW9vVzhY3FrCrb
         wGApOrifMc5URWYX63ax9wTPVbU0WoDze4t7A8ZbdKom2l/mQ0uip29nL8Ig0FaADOHT
         wu8A==
X-Gm-Message-State: AODbwcBqzvVVTReAyE0dj6ngK0Zddkx9SHt6uMwiq5zLN/ojplULl01x
        EE8e5P0oAl+wuw==
X-Received: by 10.98.17.86 with SMTP id z83mr34744701pfi.212.1495689350258;
        Wed, 24 May 2017 22:15:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id i4sm10912645pgd.7.2017.05.24.22.15.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 22:15:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 22/29] blame: create scoreboard setup function
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-23-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 14:15:48 +0900
In-Reply-To: <20170524051537.29978-23-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:30 -0500")
Message-ID: <xmqqshjtecu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Create function that completes setting up blame_scoreboard structure.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---
>  builtin/blame.c | 190 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 101 insertions(+), 89 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index f839571..fd41551 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> ...
> @@ -2759,92 +2855,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> ...
> -	sb.num_read_blob++;
> -	lno = prepare_lines(&sb);
> +	setup_scoreboard(&sb, path, &o);
> +	lno = sb.num_lines;
>  
>  	if (lno && !range_list.nr)
>  		string_list_append(&range_list, "1");

After this change, nobody uses the value returned from
prepare_ilnes(), but the function is still returning an "int".
Perhaps change it to return nothing?
