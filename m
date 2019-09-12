Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77381F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfILSUZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:20:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfILSUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:20:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so28900274wro.4
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 11:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wea1tLAdWD1oruD+/k/8k6sB4KTUyXX2Uey/TBdZmlo=;
        b=UfmjO9P2CxPDp2tEb9RgiHNMbVsf1ftiQLScP0J9aaEeP1kPM75XG39iAMQApfhHgh
         D3g+NNZF5G8BgaCJ9DJbuWmIFqGbsAmR7leUkH5sgHBuLxxnTd4P/NrUk2LVYHpqi8ap
         M40zJuZumKqxbIhrxfDLxmzBUs4+rC8x6dn6f/3tiwxCbJIVv1ioNn+XxWj0phIdsuXs
         lvt7zYadXoZJOt5skZfGlIJ23OH8t3lp6zuvCbM/aExL6Oa14r6a5s0h+r+tYo8LipDX
         b4T89NYtORqHW+oUBbV9JtpaQXHDBz8BNziR2AvrSGtNHOeoZ7xzVYF06pK6lwakoou5
         TvAg==
X-Gm-Message-State: APjAAAU2LKTidbWt0CUaCCf7RpNGbhLbKorEvT4PVp1k9ZIXhxTR2p6B
        lKJAM2bGIfbEu+v6E9cugPX2RRmblopEUhIKgak=
X-Google-Smtp-Source: APXvYqw7geVF6N16OzjIjv3aTxhISGN3FM9nsoYbQ5l7StbH5fTNBgXsOw8eLehkanUzIpk5fN3CoqudutAeb0Ot9D0=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr36406806wrw.170.1568312423667;
 Thu, 12 Sep 2019 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190912145638.32192-1-tklauser@distanz.ch>
In-Reply-To: <20190912145638.32192-1-tklauser@distanz.ch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Sep 2019 14:20:11 -0400
Message-ID: <CAPig+cTAY=4cuDyrsPiDH+MUvz4+H4eMKAsmTAETep2On5=q3g@mail.gmail.com>
Subject: Re: [PATCH v2] git-svn: trim leading and trailing whitespaces in
 author name
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 10:56 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> v2:
>  - move whitespace trimming below defined'ness check as per Eric Sunshine's
>    review comment
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> @@ -1494,6 +1494,7 @@ sub check_author {
>         if (!defined $author || length $author == 0) {
>                 $author = '(no author)';
>         }
> +       $author =~ s/^\s+|\s+$//g;

Hmm, this still looks questionable. I would have expected the
whitespace trimming to be below the 'defined' check but before the
length($author)==0 check (since the length might become 0 once
whitespace is trimmed).

Also, a minor style/comprehension nit: Perhaps I'm just old-school,
but for me, the idiom:

    $author =~ s/^\s+//;
    $author =~ s/\s+$//;

is easier to understand at-a-glance as trimming leading and trailing
whitespace than the more compact (noisy) expression this patch uses.
But that's just a subjective review comment, not necessarily
actionable.
