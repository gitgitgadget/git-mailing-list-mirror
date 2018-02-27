Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3321F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeB0XRD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:17:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51657 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeB0XRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:17:00 -0500
Received: by mail-wm0-f68.google.com with SMTP id h21so1648058wmd.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8a5sdv8wi41ecOb1wORLSCkDDRocoAh5nOM7k67hH8U=;
        b=j0srMAo7ImyD7JcKdLhqZO0ZlLI0NzJ73aR03DhrrlGd0K7Ln78PRPOHYw2gnrt6tJ
         Qc3RPwA8xQAdcWHzvIs9WwsYCKN9gAe2rpZSQFXZlbAZc7AvirVaq3DHc19bzPqQlvNw
         M4TaFDByGgwaVF9W5u+P4Xb8EZssbmZdHWYD8OWbHA3lEovgtQ0rZfq6ycZm6jqVmmhN
         lCzWIspiONnlmUKWSKMR4EwZa3Zz6tfqWMofgsyVddj3YRKgXpIfvRFm9alqzbSCXO6d
         HBaSV+CphPsfS1JZ66JjDYT8utWaEOL8ieCxvyF0txuy6kQoH+Ak90RWNeNFZkPnS5xv
         tiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8a5sdv8wi41ecOb1wORLSCkDDRocoAh5nOM7k67hH8U=;
        b=LLo8UYdJnpvw4FYWj/Q6Bs2hTJ1LrHMH+sfUCO55Q/SmWzYxUDRGmZMyn7PsmN3vlo
         t/QyAAvXyeBAvW7CDVv57FNnsiBPrXkJDQPQ3Ej/CgGJvU9SeEQ+4FMdLjQT6hPjx6Cc
         Yx0RDAtpGYAE8csjidxPHc915I1CrStwPSu2LvXN8vgQy02tUB+4h8hXOFLLYMRCszxR
         79MsglWQfpFulb9ZSTkW/37kqKF5O1E9MK6+NcB2JaXwEF5h7cMR2hFb9FM8tNOdKc8e
         sS67cCXW2F9Ud/Fg+5YO8e4+WpS8fXsLuDhXNL9G+NKMh6fN05E3rlkMB92Ow1PX5+NX
         eYDw==
X-Gm-Message-State: APf1xPAIEwHS7UZP/3TvXUABZSuHfII0nqQhffyChdYv5xHe3nY1QWui
        o94ekICeCObB//SYWECR4tI=
X-Google-Smtp-Source: AG47ELveZfSORi898YIW78+U5sqTcGx0H/d62v/zbdHzdc+ccgEzU+E0UGQWWNqQw3vs6Pev25FQDw==
X-Received: by 10.28.10.206 with SMTP id 197mr12066892wmk.61.1519773419392;
        Tue, 27 Feb 2018 15:16:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u136sm579207wmf.5.2018.02.27.15.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:16:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision.c: reduce object database queries
References: <1519522496-73090-1-git-send-email-dstolee@microsoft.com>
        <20180226013048.GA8677@sigill.intra.peff.net>
        <20180226013822.GA9385@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 15:16:58 -0800
In-Reply-To: <20180226013822.GA9385@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 25 Feb 2018 20:38:22 -0500")
Message-ID: <xmqqefl6nhud.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This code comes originally form 454fbbcde3 (git-rev-list: allow missing
>> objects when the parent is marked UNINTERESTING, 2005-07-10). But later,
>> in aeeae1b771 (revision traversal: allow UNINTERESTING objects to be
>> missing, 2009-01-27), we marked dealt with calling parse_object() on the
>> parents more directly.
>>
>> So what I wonder is whether this code is simply redundant and can go
>> away entirely. That would save the has_object_file() call in all cases.

Hmm, interesting. I forgot all what I did around this area, but you
are right.  

> There's a similar case for trees. ...
> though technically the existing code allows _missing_ trees, but
> not on corrupt ones.

True, but the intention of these "do not care too much about missing
stuff while marking uninteresting" effort is aligned better with
ignoring corrupt ones, too, I would think, as "missing" in that
sentence is in fact about "not availble", and stuff that exists in
corrupt form is still not available anyway.  So I do not think it
makes a bad change to start allowing corrupt ones.

> I guess this is perhaps less interesting, because we only mark trees
> directly fed from the pending array, not every tree of commits that we
> traverse. Though if you had a really gigantic tree, it might be
> measurable.

I tend to agree that this is less interesting case than commits.

A huge tree with millions of entries in a single level would spend
quite a lot of cycle in slurping the tree data to in-core buffer,
but we do not actually parse these million entries upon opening the
tree, so it may not be too bad.

