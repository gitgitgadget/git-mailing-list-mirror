Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EAC20951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdCQXqZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:46:25 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33428 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCQXqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:46:24 -0400
Received: by mail-pg0-f42.google.com with SMTP id n190so50180490pga.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lhPPbxbg5pGIh4qxl+FF2qIzS7e2WAcq0/CjNZn1qc=;
        b=UQzMOvgbLyjp6u4YJfwa0ioil/Xzgsj2BYEDVAj642kvCGeyDRIUQ53g/XGsJ2TVZW
         JFlylsZ+C3jdcwO+DJyfqW14PcSb4qTQTjoFQOImAa3x16dtiA2QU1gRBsNaUdIJtG8c
         urdTE6cP6uwbLoN8pFfgLp19S+UdYMLf8+P8OOVpfDY8GRu4DHFciJQUwkfBPgtwaw32
         xPXqWbE/PpTAwhmYrAbOxZ5UzOAPi6hp3MfGKRDMks4+WUFY56W7tyEkiQ4q3/YNc10J
         T6sVmJypWEtR4OdygeEY95Fsh3QltxntXf1hnDKY6Gvl8Mwg+AAXBw73ZRFK21nBBJRx
         kyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lhPPbxbg5pGIh4qxl+FF2qIzS7e2WAcq0/CjNZn1qc=;
        b=Gxs1tXeXNxJPiOA70LIx9tvoL0Kj8W4cJAQQ1C4VG16+khtjyryQrDIPXKY39i7Uhi
         QBfT8lB/TZG3lVJcDQdJB7to1xo+AJvROhsf3NjR6mBDpgzrG6Lgnik2A71kbCa5WDXE
         +119ehmahki40I2zJycN5zC8eC6ujvFyMAS4HTnXE3//qtVYIWdGd7FfhN4qKaTg+RKH
         PosrsrYPIJE5N1B2PW4TxGOsQzLd/ys9lWHFakZKU0eApAnG18H2U4LfLUlNEFDMFzw/
         6ptz5ap5rQQIvcuHcqtuitARD/UYuVqpsajhBIQw1zZpKVUdYMkqKB3xa6RYoVOX/lVW
         DiSQ==
X-Gm-Message-State: AFeK/H1uTPV4EM5OIy+4+kNJUMkdQ+XGWNI9BvX+qxnK5527M24oMVLzeZxbZa2EypT9cz1R
X-Received: by 10.98.46.130 with SMTP id u124mr19696803pfu.204.1489793888730;
        Fri, 17 Mar 2017 16:38:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id n29sm16075538pfi.101.2017.03.17.16.38.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 16:38:07 -0700 (PDT)
Date:   Fri, 17 Mar 2017 16:38:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: fix segfault when cleaning forked async
 process
Message-ID: <20170317233806.GG63813@google.com>
References: <20170317232004.xqs5f2q2swa3b5bq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317232004.xqs5f2q2swa3b5bq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Jeff King wrote:
> Callers of the run-command API may mark a child as
> "clean_on_exit"; it gets added to a list and killed when the
> main process dies.  Since commit 46df6906f
> (execv_dashed_external: wait for child on signal death,
> 2017-01-06), we respect an extra "wait_after_clean" flag,
> which we expect to find in the child_process struct.
> 
> When Git is built with NO_PTHREADS, we start "struct
> async" processes by forking rather than spawning a thread.
> The resulting processes get added to the cleanup list but
> they don't have a child_process struct, and the cleanup
> function ends up dereferencing NULL.
> 
> We should notice this case and assume that the processes do
> not need to be waited for (i.e., the same behavior they had
> before 46df6906f).
> 
> Reported-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is a regression in v2.12.0, though there is no hurry to get it into
> v2.12.1 unless your grep patches go in, too. Without them you can't
> actually build with NO_PTHREADS anyway.
> 
> However, applied directly on top of 46df6906f (which predates the build
> breakage), you can easily see the test failures with NO_PTHREADS and
> that this fixes them.
> 
>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 5227f78ae..574b81d3e 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -48,7 +48,7 @@ static void cleanup_children(int sig, int in_signal)
>  
>  		kill(p->pid, sig);
>  
> -		if (p->process->wait_after_clean) {
> +		if (p->process && p->process->wait_after_clean) {
>  			p->next = children_to_wait_for;
>  			children_to_wait_for = p;
>  		} else {

Looks good to me! Thanks for tracking that down so quickly.  I'm glad it
was a quick fix.

-- 
Brandon Williams
