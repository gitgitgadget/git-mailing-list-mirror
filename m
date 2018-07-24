Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D308D1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGXS2j (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:28:39 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:44481 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbeGXS2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:28:39 -0400
Received: by mail-yb0-f169.google.com with SMTP id l16-v6so1918543ybk.11
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgMTVNPfSIf9gPEjbJRcpLDZ6ssctTke8HfE+K6bFFg=;
        b=Gy7l7mJXk57FGxC30Fsyx4W3ZIMivyf3OULHb2tXW7gyWAh3bf/8ct5mjJbUOfU2ZS
         2A0pKz1aQXLdp/qignuNBCSW1l4VZlV0GBxmgtu/nrF/7UzGuYr8YGGb3qabhSza44Xy
         HDibTmp4IMLKLjWqLgjixHmzFmtyDIgNYm0ZvuDoPHNNowIDu4LBut7Rztxkj0V0HEWk
         /vNi69WjN/C1M52v+yk6CKUoasP0cmVVUvwMJwQSZEzm/YsP/DP0866ea+te03PtiRSw
         amfvVZTmqIWfNr8xdZBxN0Gh+mNpXHRQkCd2GOSwJRfRFGXnFSudlk8Kmp1e1pXMMfBz
         O6Ow==
X-Gm-Message-State: AOUpUlHWoblZzVNkNA2kPwcYI4hrLpBCmIkjPggs3RD+tNbiZagjhHRX
        HcFWu8ARI5qZrFVYfooRG9R1q0mxMG/ZyVTV19I=
X-Google-Smtp-Source: AAOMgpcmYSqST7XW5T6GykjK484m9Xdw17wIFd4pTR16HdvtTXl6MJdmZKVPTDEZt76fxXPaaS7DAAjx9fsrhimrQwo=
X-Received: by 2002:a25:9b03:: with SMTP id y3-v6mr9698204ybn.194.1532452869590;
 Tue, 24 Jul 2018 10:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180724092329.GA24250@sigill.intra.peff.net> <20180724092618.GA3288@sigill.intra.peff.net>
In-Reply-To: <20180724092618.GA3288@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Jul 2018 13:20:58 -0400
Message-ID: <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] automatically ban strcpy()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 5:26 AM Jeff King <peff@peff.net> wrote:
>   1. We'll only trigger with -Wimplicit-function-declaration
>      (and only stop compilation with -Werror). These are
>      generally enabled by DEVELOPER=1. If you _don't_ have
>      that set, we'll still catch the problem, but only at
>      link-time, with a slightly less useful message:
>
>      If instead we convert this to a reference to an
>      undefined variable, that always dies immediately. But
>      gcc seems to print the set of errors twice, which
>      clutters things up.

The above does a pretty good job of convincing me that this ought to
be implemented via an undefined variable rather than undefined
function, exactly because it is the newcomer or casual contributor who
is most likely to trip over a banned function, and almost certainly
won't have DEVELOPER=1 set. The gcc clutter seems a minor point
against the benefit this provides to that audience.
