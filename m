Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5E41F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeHaAiw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:38:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34207 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaAiw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:38:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so12221008qth.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zU2k+tkrExuPkk+/xR24EgF2S1tLrkRs9UWmqQ7kG1w=;
        b=iipm6ylq/0Qi0ynjJsmFQ05WJMz9rms3EVPsv3Ade2CdvBqr2XZzCsInn+wTWBY6nU
         8Hc9mj8lC9WPyjWKUz4kZC3kLqW0AejiZUwRzNhAwSfoL3ZsVfLvBIGS3yzwTBJhTdyi
         L8fd7xgdGkpeyci7VCWtSiOb4vj2i3NRHbI8zjujgZ4QQf3BEvKEY30LANWdwfC9RqVi
         31d4B3wiwc7Jo3Yp77kQ3S5PS1DJlz1hu3yb/xrpfHDvHF2AoJi+EJD9ViBlB/+zfq9c
         hpo3xmzwyHOxBB5j8RRUF8W+NV3sdC2+whV49FVqA0SE5aJxNL0XTwYsVyxbhMAJi/U5
         TIgw==
X-Gm-Message-State: APzg51BOS5HtjlqJ0soLZSqVJntsnDC7Zmo3G14huep2Y6hlOV+y6weC
        CkQlgiPVXUTCKY4lzy588S9LESBXRnqK93cTQdM=
X-Google-Smtp-Source: ANB0VdbIywUIK5rbCYLjyOQ1BqdbV+YzIAgyqXIxYMtqZI0367Aj1+6tIWI3HeSScm+m2od9ffVlVzZONQuPrXc93As=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr13462770qtc.50.1535661294818;
 Thu, 30 Aug 2018 13:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180830081202.GA10224@sigill.intra.peff.net> <20180830195546.GA22407@sigill.intra.peff.net>
In-Reply-To: <20180830195546.GA22407@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 16:34:43 -0400
Message-ID: <CAPig+cRXEegGwm3QiyEZqkVN1NYv5xAAYRuAKHUE8n-g9m6jqw@mail.gmail.com>
Subject: Re: [PATCH] doc/Makefile: remove tmp-doc-diff on "make clean"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:55 PM Jeff King <peff@peff.net> wrote:
> The tmp-doc-diff directory isn't strictly a build product of
> the Makefile, since it's only present if you manually run
> the doc-diff script.  But anybody running "make clean" would
> probably want it to go away.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> @@ -332,6 +332,7 @@ clean:
>         $(RM) manpage-base-url.xsl
> +       $(RM) -r tmp-doc-diff

Taking into consideration that people might be surprised and alarmed
to find "git worktree list" showing a worktree they didn't explicitly
create, would it make sense to do something like this?

clean:
    ...
    -git worktree remove -f tmp-doc-diff 2>/dev/null
    $(RM) -r tmp-doc-diff
