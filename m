Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59E11FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBNV7C (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:59:02 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34295 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBNV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:59:01 -0500
Received: by mail-ot0-f194.google.com with SMTP id 73so19184276otj.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+y+Zgsku6B/2nH/92nX5igFpr+m6FiErfuPM2qu27ts=;
        b=b1pA9+qQCZs3b4UTfAuK7X+GzSCI/rLMxAi6vtCivEocwsWrFs7erLUWnAKEFSXX9a
         mZJoNxYo1VnjIXH2ZuJeE0e2VLlz3Iet/ghs363BNkmLOKJTq6Ef2438XbadSvkM5Wz7
         A+ztPIs/p7bTAg6sblnjhjVzf5xoOYg7j8TBM3JI5EXSX2x1tLgDf1JHjnLKurCxZ6pj
         F/nCm12Qd4Xkl6uZJ+y8h117sZo22dL4T20E3CPlv8DirP9/YO5it1PF22xjFHmFUnUo
         sG5blD4a98h/22oVSH6U2Sa7Vd2jivwYI8do+FNqERv+BDvVfK9yvtQpt95OFHAGK6SX
         aCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+y+Zgsku6B/2nH/92nX5igFpr+m6FiErfuPM2qu27ts=;
        b=DjTMP9bBjlcxdm9Eluap+w5BAtF1bVk3KyDtbS5pxVe3ZC+453X1YkWTrxwvBUYMxM
         RksrKnVe8gLIgNVhvudKLEIhUrR8cQmA+KVQdLBfu1LZezCkVybuGG7o/I49ZdW5HTca
         bH6ofCngLHvT5AIZXfcxzlhwLFTTNZE/qh/5z9YIoRrR81S6yiJIDGOEM0V67upBVHEV
         lQnYQ+nGcCqQTuFM41NhbWMeG3r4CMJZnTNPrcKdXZtUJ7A6E7vlDlGrg6no2uhiGD2R
         a/vqf7UQL8U+Da7GiAXK5anbY19L4aUpirpTPjM2ZBkofIn1YL6abwBo+yo7b4jym+CS
         ic0Q==
X-Gm-Message-State: AMke39kXozs3ChpjPYBypj/N8F24SauMdYF+4fO3AtsO9/Nw8lE9BjNFWZ3XSnhxl2b1pw==
X-Received: by 10.99.127.71 with SMTP id p7mr35027876pgn.125.1487109540507;
        Tue, 14 Feb 2017 13:59:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id 75sm2998668pfw.103.2017.02.14.13.58.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 13:58:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 8/7] grep: treat revs the same for --untracked as for --no-index
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
        <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
        <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
        <20170214180453.tpze2hdv3eytxfju@sigill.intra.peff.net>
        <82212eaa-76d2-3357-8e06-5e4d56028c2e@google.com>
        <20170214215436.kqca4c7gv2kwevw7@sigill.intra.peff.net>
Date:   Tue, 14 Feb 2017 13:58:59 -0800
In-Reply-To: <20170214215436.kqca4c7gv2kwevw7@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Feb 2017 16:54:36 -0500")
Message-ID: <xmqqziho77to.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> The rationale for doing this with --no-index is that it is
> meant to be used outside a repository, and so parsing revs
> at all does not make sense.
>
> This patch gives --untracked the same treatment. While it
> _is_ meant to be used in a repository, it is explicitly
> about grepping the non-repository contents. Telling the user
> "we found a rev, but you are not allowed to use revs" is
> not really helpful compared to "we treated your argument as
> a path, and could not find it".

Yup, both sounds very sensible.  Thanks.
