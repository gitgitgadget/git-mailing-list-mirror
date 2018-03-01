Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551561F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161572AbeCAUaC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:30:02 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36702 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161563AbeCAUaA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:30:00 -0500
Received: by mail-wm0-f44.google.com with SMTP id 188so14577081wme.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A8y/di7Cax83/LXJHQQ3/goWs4UohXATxsYFXsOndds=;
        b=ZASGA8QuZ0A7QQFw73J/SjmOETRdJWq5Ax6O6q37K5wQ0S4TxDxRSDMTnlEpoJwkSb
         25IPxhBHcZMEV7ODRLtHsVA4GzFc/BKKe/jX20tU3F5Ctswb1R7Z4p1F0+L0i9L/tBtq
         CAY+Xg0uqt5yyuOhqgpL18ztBwVqZW7GNiWEVM3G/AUK987XaEzLT2AtbFgmbVBuHcnD
         PMDpa9Yzi+T6NwiCmD9VgQ8VtzG5cORBYDWcqDfRdv7tPafroYyP0qdOqMYmZGWE+lcu
         mzxuYCbO+NftEoHJO+T1t6nnHa+sDSXo882NEiip+tLRzlskeBdo9ZpOMWmceESy7sAn
         YkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A8y/di7Cax83/LXJHQQ3/goWs4UohXATxsYFXsOndds=;
        b=aUBkIi0KM9QB3R9cCnMGb+obzZ08g2U00ADgc82JsLwDtJ0ZcSOTsHNo4PLwb2xzPy
         LC2blQTeHbydaOHNE2aZRbGhIWUF1By/Tajg8P6hk4fXvnMUYEU1V+K7jgv4m3RBjzgM
         FZP64fc7KvI/g62LyZNuKLUYsJKByvugxQZx3d08ZY+91XMP3BZJyUBDVAVB96GBuAX3
         6AQNCFfXWGDNV0A+O4fvYCFl4QKkl7GZNWzxJIcVutN5r8oEeEDVKAwPPMDCF1yXrrq+
         lVdsptSTUjLiMJghQ8KJeDhhfk8Sfft1WluFOo6qgLfEPoSGeAy4aqhXpD9ET/rSkw2p
         6Hag==
X-Gm-Message-State: AElRT7Hn+PGqI4ACmyKRuejPTMiK49ZzgjINLjcZqMby/U0TYFNC7uJe
        x0iRTJzd2PR2FrVIoT7m7O8=
X-Google-Smtp-Source: AG47ELtAstcmwJCcWAK6dGVhXlLdNBKSJ5W99MmlxGb0KUHZ5e37fFdQ63ae14izWXL6YPLNF//YTQ==
X-Received: by 10.28.184.21 with SMTP id i21mr3002107wmf.94.1519936199013;
        Thu, 01 Mar 2018 12:29:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o204sm5050057wma.1.2018.03.01.12.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:29:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 8/9] add -p: fix counting when splitting and coalescing
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180301105103.24268-1-phillip.wood@talktalk.net>
        <20180301105103.24268-9-phillip.wood@talktalk.net>
Date:   Thu, 01 Mar 2018 12:29:58 -0800
In-Reply-To: <20180301105103.24268-9-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 1 Mar 2018 10:51:02 +0000")
Message-ID: <xmqqsh9jfsjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> @@ -887,8 +892,8 @@ sub merge_hunk {
>  	$o_cnt = $n_cnt = 0;
>  	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
>  		my $line = $prev->{TEXT}[$i];
> -		if ($line =~ /^\+/) {
> -			$n_cnt++;
> +		if ($line =~ /^[+\\]/) {
> +			$n_cnt++ if ($line =~ /^\+/);
>  			push @line, $line;
>  			next;
>  		}

Hmmmm, the logic may be correct, but this looks like a result of
attempting to minimize the number of changed lines and ending up
with a less-than-readble code.  "If the line begins with a plus or
backslash, do these things, the first of which is done only when
the line begins with a plus."  The same comment for the other hunk
that counts the $this side.
