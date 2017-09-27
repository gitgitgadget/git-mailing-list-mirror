Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBA920A26
	for <e@80x24.org>; Wed, 27 Sep 2017 07:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdI0HGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 03:06:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34261 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdI0HGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 03:06:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id u18so8211337pgo.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PoMrFHan8M7zksSQNxG6I2skcS7JWYDgRBQ45QgLYX8=;
        b=mKEwXUFWMXMa2g+dynRYbhm0qZ3GFEErgx50EPixMw8XEqA7oOYhe9KIWJYPO4atZq
         tnosBKOyp0xiW9pqbpzWc6ZazHJl7OEXL6T6kX0OuxmfuAJ7Wqy4kQeMJZSgV51LqdR7
         AHUw5mQwX9/rTgxmcfvRD2m85Czqw6bn+AL+qjUwQb74b/8N45jWAdJDtZivn48tqgnx
         wj3YK1QvxI0rIja00nG/zDyxdtzXuDv9uJ9H8ggwwvS5nD6ObMJX9HwYI+8r2iHwXuY7
         lbC5qlz8Qr3D1/n1cChvinDfisJuQZjYrA8cy+AWo51URiV1GqtA+NMhUHP4JzppS6+X
         ilLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PoMrFHan8M7zksSQNxG6I2skcS7JWYDgRBQ45QgLYX8=;
        b=cNJX/DIQa7sdSkCcoGptJaxyCIqkHIZQkZuFRNV//S1+Vu7DFxq+QzzxTzPOqRIeYY
         tGPru22v5KvksZYj3BKWzyGILlX4ljuPFeIsKb+N9EULR6SCLYIeT7nxuyE9AJXE0O7n
         OM1LesOybNH4tbALUzq4lFOqydmg61+YwuaRSXlXNa+lNFEXRrMqQhkVOXbuAaeHgy6L
         5Yt7QJeS9ffEJMnnbcug0I+Gnez0fMYjXZji7R0oYLT17YRUnS2C0YeNWcm99wuDocvd
         kxz0K/YEe/tgBZj4NoGufD6y4+aZ3cxzXxzgNheJDqEF9Me4ehOxeENvM0qCNK/r5PGy
         wFlg==
X-Gm-Message-State: AHPjjUgKSWCHeRlDIAj25+Ic0kV+PU0ywr0nUQzzp8X++IwcNIvpdASL
        t8tCFTqHmTtMkvhfn6H/j+A=
X-Google-Smtp-Source: AOwi7QAIO4glqJVrbE7IBco7UI2+h7R25jD8VT7wTYSty5dyyWBh+6HQ75U8wndhhZdSZL/bR1ri2A==
X-Received: by 10.84.129.193 with SMTP id b59mr441987plb.200.1506495983961;
        Wed, 27 Sep 2017 00:06:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id k12sm21092910pgt.3.2017.09.27.00.06.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 00:06:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] validate_headref: NUL-terminate HEAD buffer
References: <20170927061644.gwlhxaiairiy2njp@sigill.intra.peff.net>
        <20170927061722.7ubswfgykxiawzh3@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 16:06:22 +0900
In-Reply-To: <20170927061722.7ubswfgykxiawzh3@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 27 Sep 2017 02:17:23 -0400")
Message-ID: <xmqqefqs4o41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/path.c b/path.c
> index b533ec938d..3e4d7505ef 100644
> --- a/path.c
> +++ b/path.c
> @@ -662,6 +662,10 @@ int validate_headref(const char *path)
>  	len = read_in_full(fd, buffer, sizeof(buffer)-1);
>  	close(fd);
>  
> +	if (len < 0)
> +		return -1;
> +	buffer[len] = '\0';
> +
>  	/*
>  	 * Is it a symbolic ref?
>  	 */

A few tangents I noticed:

 - the result of readlink should be checked with starts_with() in
   the modern codebase (#leftoverbits).

 - buffer[256] would mean that we cannot have a branch whose name is
   more than a couple of hundred bytes long; as you said, we may be
   better off using strbuf_read to read the whole thing.

Neither should be touched by this patch, of course.

Thanks.
