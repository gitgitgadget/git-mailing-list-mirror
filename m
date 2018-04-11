Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC2161F404
	for <e@80x24.org>; Wed, 11 Apr 2018 03:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeDKDCw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 23:02:52 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42978 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeDKDCv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 23:02:51 -0400
Received: by mail-wr0-f169.google.com with SMTP id s18so250060wrg.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sxb1cmOpxz9iwKrleuWi1kQIAy+1PyGso2ybAJqYNWc=;
        b=WIcK5eT+ogQ5NcGEccHRrr8AY6npfVC969PtmE3X+QNoq+fMe7HiyRQHuyIo1qOCUr
         z7tdrpQjPUWbJkabrx20vCcIH8JVD1yVLWSSjS2ni+T8jc/XESMHs3hKhiS18pRs8jwc
         Ogfd9d7mBDaTMqKZg2J+z4tY3WxwfuSm9izyGzxA/qtRfe9MwAAuYFQPo/0MgP0S/2Ca
         OJttcp8AfqRpsagZP6wj8YNy7dK9JKwzjishfALWxOwZNValOhuMJyF1E5S453M0GtIq
         U/88jzVSoYcr6vhdMQZJUfuuiQInvqUfDQMRabfxtdEq9T+gtkppD4MN7TXQZqUqkigi
         2wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sxb1cmOpxz9iwKrleuWi1kQIAy+1PyGso2ybAJqYNWc=;
        b=LlQVNlIg0hV3JwYRu7oRxpHU4VEvalN+lfGxqvzvVz4oDUlx2lpnKV2346PpIaCAV7
         b92OHHGl/FMntfysU/p6FtGEukZivuV4JiRXwB6x0F7utPhM9ygExeRIxwjaCgM3fbEg
         kguh5wwjtyVXVgLKZfRjaRWkUJE+/xc1yAh7ahXyeYT95EOiIjy22KQq2e636p8lbcn7
         SyoI+JSf2Mj0cC4vqp7gst9P9S/ipP9imFP1hF+dMcbYzI4NtkfMvA4l9lrmcv6jC7e8
         aebikY0hYyW8UsCUzSBDNZGiJm5UcKyToOF4ZFUNWn1LyEPWI+dpIdn00QrdriE/jcqq
         FJRQ==
X-Gm-Message-State: ALQs6tDiF77LUOiLvVMaVRQYWi2gxHIHCgRRv6+EbkZ5jbPcybD+AupS
        Cni1gUB05K6O47EivWgN930=
X-Google-Smtp-Source: AIpwx4/KHEybic238wDlXEZdJjQ+rARRMUyy09HWgiDhK/0bRftJHQGWqqO6S2tXUGDm4itH7b2JNA==
X-Received: by 10.223.168.4 with SMTP id l4mr1835097wrc.170.1523415770251;
        Tue, 10 Apr 2018 20:02:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e13sm330839wrg.79.2018.04.10.20.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 20:02:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 06/10] commit.c: use generation to halt paint walk
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-7-dstolee@microsoft.com>
Date:   Wed, 11 Apr 2018 12:02:49 +0900
In-Reply-To: <20180409164131.37312-7-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 9 Apr 2018 16:42:05 +0000")
Message-ID: <xmqq604yzbqe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> @@ -800,17 +810,26 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>  		return result;
>  	}
>  	prio_queue_put(&queue, one);
> +	if (one->generation < min_nonstale_gen)
> +		min_nonstale_gen = one->generation;
>  
>  	for (i = 0; i < n; i++) {
>  		twos[i]->object.flags |= PARENT2;
>  		prio_queue_put(&queue, twos[i]);
> +		if (twos[i]->generation < min_nonstale_gen)
> +			min_nonstale_gen = twos[i]->generation;
>  	}
>  
> -	while (queue_has_nonstale(&queue)) {
> +	while (queue_has_nonstale(&queue, min_nonstale_gen)) {
>  		struct commit *commit = prio_queue_get(&queue);
>  		struct commit_list *parents;
>  		int flags;
>  
> +		if (commit->generation > last_gen)
> +			BUG("bad generation skip");
> +
> +		last_gen = commit->generation;
> +
>  		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>  		if (flags == (PARENT1 | PARENT2)) {
>  			if (!(commit->object.flags & RESULT)) {
> @@ -830,6 +849,10 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>  				return NULL;
>  			p->object.flags |= flags;

Hmph.  Can a commit that used to be not stale (and contributed to
the current value of min_nonstale_gen) become stale here by getting
visited twice, invalidating the value in min_nonstale_gen?

>  			prio_queue_put(&queue, p);
> +
> +			if (!(flags & STALE) &&
> +			    p->generation < min_nonstale_gen)
> +				min_nonstale_gen = p->generation;
>  		}
>  	}
