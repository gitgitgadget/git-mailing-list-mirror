Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8011F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeHBVR2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:17:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53712 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHBVR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:17:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so3750230wmh.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 12:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6s36FZNgp+XsIa60/tQWxrJcIBNSv/pFz6yuie6zlsk=;
        b=KD2GNSpPq3PouziYXl/XtmsjqVQbha+hxPs8taJQRREjbMtRBSXvG4xyhjYc3HNDmZ
         l1GxcHcg6FKK8tPl/ueqvbySOGNlM4eML0Hgdrs2LnZnk1ZlKNsGoznw+5umCwIggFGE
         AG7CR/qSIphxorqpX8gLbUn1YHxWO/NCOBtVK0o8jkJktALJA4iS3jfPhRUiMfS6jUSY
         buvNnbtrRkR/dMY4OW6LDYnIfzuB+S1EKutu4gHeLVV42HdSW3I0ExdN7r+wY2QSkua1
         V5OathhDIftQn8Yaxe3z0ljvyBwJGo4cxOswuy/v5e5UDO4KqBBY02aDUbuPO3kRIvQ3
         ndZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6s36FZNgp+XsIa60/tQWxrJcIBNSv/pFz6yuie6zlsk=;
        b=bRO91plrcAWBFkTo+YRJq+RvzB7R+T+cVidCNnjmFusTjIkXT4m9NAkUvjdKQnOnrJ
         k2pcKtjoMQDaN9w0X3/yBaYM8UBq1grThkChOZujrBJ+li5PrlbDnYhw/5+zXqAJYpIx
         lOccnQEDUT0pIgvuBosgJo7CqQhh/iXGF7/7OgvHPxurcQnUsoEl9C/VGzbhF1WW0K8h
         AzmQ+4MNLvJCPx3/RdR2mPzW+TmBhQZnD76F15oFFEEhwSMi3BtEOyAcpZamiFWNl2dl
         OCdI7F6BAjwfpYTzuGvKt5LvVYFb8Ao/nDgoDmLVAlK5PoKVweW/jlPD2ItuNJ+OBfT0
         PClg==
X-Gm-Message-State: AOUpUlHmOlGzC8MuFB1XGuqgRwU4F0mAgL737lH4tpsFivjszl8qG+WV
        Kb/v1xvykgtoXZ3ljFKavS5o7rBC
X-Google-Smtp-Source: AAOMgpea5N6x/JfP60D4HB7x7kHZz2vOA3cyI+U9B65YktGijUtbdcHPxpVPucadJg4oURSfuvpX3g==
X-Received: by 2002:a1c:ec9d:: with SMTP id h29-v6mr3004733wmi.94.1533237896100;
        Thu, 02 Aug 2018 12:24:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x7-v6sm3482029wrr.95.2018.08.02.12.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 12:24:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] color: protect against out-of-bounds array access/assignment
References: <20180802093208.27420-1-sunshine@sunshineco.com>
        <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet>
        <xmqqftzw3c21.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQyYRvF5QkJRUi6W2LiOo_poxWyJw9dn+FOimb1ryX8Mg@mail.gmail.com>
Date:   Thu, 02 Aug 2018 12:24:54 -0700
In-Reply-To: <CAPig+cQyYRvF5QkJRUi6W2LiOo_poxWyJw9dn+FOimb1ryX8Mg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 2 Aug 2018 13:45:08 -0400")
Message-ID: <xmqq8t5o1shl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Aug 2, 2018 at 1:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > ACK!
>>
>> Did you write a buggy caller that would have been caught or helped
>> with this change?  You did not write the callee that is made more
>> defensive with this patch, so I am being curious as to where that
>> Ack is coming from (I wouldn't have felt curious if this were
>> a reviewed-by instead).
>
> The code being made more defensive with this patch was authored by Dscho[1].
>
> [1]: 295d949cfa (color: introduce support for colorizing stderr, 2018-04-21)

Ah, OK.  The original by Peff done long time ago didn't check three
fds separately, but just did a single check_auto_color() implicitly
only for the standard output.

Come to think of it, would want_color_fd(0, var) ever make sense?

In any case, thanks for unconfusing me.
