Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F0C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3B206B2
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZSs5xSsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHLNsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLNst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:48:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F94C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:48:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so1498530qtp.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jhnNuz1l3HNkM9jJooDe/jHb6yMOtqdys9/vf4m389U=;
        b=ZSs5xSsdpBUXT7NNqNfhxHR4ex7sC+rcW2i9iiKP6i+3Z50/xalHLUNrQhIUXdclnZ
         RhQ/jNgVu/nXsLBqcFvGenaY9O/+D21vjTtdDPiOMpjdEg78WfuJNEbY+LLIuGJb0Uz7
         REmttAsWoAPpvVMw4F5XC80BJkPQ9+3RjNfrXMi7fs//9yXiBDGCrgT3I6aWUABY0Kaq
         Cs74jl47OE27fWkyte5hTrYnk1i2hcT01WvHJBMAyV5DUhF2RVK3vwfPavA8JJxbo4u5
         nINWFrgo6yf6OyiO1MY5ZKYHMc5yQPeJolf5NWuCbzBI1JkdiUcZnQ77OvL/2o1P09Jg
         CoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jhnNuz1l3HNkM9jJooDe/jHb6yMOtqdys9/vf4m389U=;
        b=Rc7m7VKQ6Qgl6CgDHe+GHoOywwzTkrmAEqkv53tmL2s5DZiiXYjvHjJxiF0iKHHX/z
         eA/N5k+Ad5s5sY4wwxtUtnCDqGXfPWKissPEqpmQU6PZdYlF4F8hEW2Gs+Swinqv3NEj
         7eoZDkasvxrPCySi+IWcz3Vdw/8MVObY8qF9nMCg9ju2ClTJOYX24ArekbfIbNZcxAqY
         dih7DYSduGOs4/aH2gA6UEEebZFkJdO1SbasosNftyZZdJHdQXAdYweMxvX2LVvEwKPy
         A9tN7CaM8Wbp7SnGKTjlJo7Tla2Q9p1L5z2x2qLqCNZaoVJ+lNNcohzLejz5EQfC6btX
         9IMA==
X-Gm-Message-State: AOAM530mEQSj5GwE8/ovLjgDEvv/jtdFy8u0f7QyY4YM4Gbk0g9fCjq1
        cP6Yr5+3QVHML9a4tOfoFhthJQ==
X-Google-Smtp-Source: ABdhPJwgT2IzWTp2pWKkOHxHp0dIw4jWJAI4zWdArEzTlzVWdvmocbpRQUCsyeEmAwA6fiynz0qCVA==
X-Received: by 2002:aed:21a6:: with SMTP id l35mr6566568qtc.178.1597240109084;
        Wed, 12 Aug 2020 06:48:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id p33sm2747380qtp.49.2020.08.12.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 06:48:28 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:48:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] rebase: remove unused function reschedule_last_action
Message-ID: <20200812134827.GB74542@syl.lan>
References: <80744078-c0a9-5b55-0578-d6b62af6673b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80744078-c0a9-5b55-0578-d6b62af6673b@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 03:45:47PM +0200, René Scharfe wrote:
> The only caller of reschedule_last_action was removed by ef64bb328df
> (rebase: strip unused code in git-rebase--preserve-merges.sh,
> 2018-05-28); remove this unused shell function as well.

Easy peasy ;-). Obviously correct, and thanks for cleaning this up.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  git-rebase--preserve-merges.sh | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
> index dec90e9af67..b9c71d2a71b 100644
> --- a/git-rebase--preserve-merges.sh
> +++ b/git-rebase--preserve-merges.sh
> @@ -193,16 +193,6 @@ mark_action_done () {
>  	fi
>  }
>
> -# Put the last action marked done at the beginning of the todo list
> -# again. If there has not been an action marked done yet, leave the list of
> -# items on the todo list unchanged.
> -reschedule_last_action () {
> -	tail -n 1 "$done" | cat - "$todo" >"$todo".new
> -	sed -e \$d <"$done" >"$done".new
> -	mv -f "$todo".new "$todo"
> -	mv -f "$done".new "$done"
> -}
> -
>  append_todo_help () {
>  	gettext "
>  Commands:
> --
> 2.28.0

Thanks,
Taylor
