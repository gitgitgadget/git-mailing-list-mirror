Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A9820802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbdFVWOj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:14:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34811 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbdFVWOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:14:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so4822859pfe.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=98esgoPQgLrknL9vSzvG+x8eAVPFQ+O45FwcgYRwl94=;
        b=CmqgLRkmS+fz7q3lS2kvYKNQulGX4mMwa3v5t7u1DfcmZJO49Apnl43cQpr9xuCOGa
         zyMpIsYex+uqsRC/HN/tRWxG8/pBfZfFhjtQgmco/L+pPBeknwZwt8xylpZPF15pcLJB
         4C3H223ifYU0ZXteZ5hRKaoQTq9rNXdAF3Ys8Yr6y9jopdTALD4GqYu9RMC2TBy8IBrq
         RMc+hfB9jV7+jC7yThvk0Q/AL3AB9wWDQu9ej3JcrUGEXV8F6/nx9ypue0+CFzcA4h3U
         L2rfuFDqE+0IFxTzBkzVI5fmXLK8KwW1lnrALM/2tbYWlTpm3C5oMz/rJVFDPsQQdLyY
         mjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=98esgoPQgLrknL9vSzvG+x8eAVPFQ+O45FwcgYRwl94=;
        b=CJkEFlO0X5yxVYelgPRCMqgjv5yXWHHVdmO7frg4Ibb+qSONf31Rqv/IXGEYUl1uBg
         tAu+KyCvBaPlGhWkXcG7aLdV37NnelwMph8Eh5uPYgICsKEA1FkXpq4gqoeZsf1nFZUR
         RWzEW8EXSIqmZZbf9eRdqMA33GtCSg6ifM7DsGHKiAQbfov6HXJgzX4xFgZtdja1Glvp
         2I5viuuT2k1ZOEzGTSXQ1Y0Ijzaf5Yq5/Ol9kFYRkR+IomwchN9HFoQIWZD9NhrRsdn3
         3eYFWBGu0jrEwAcHRmJROfhilVviiGhgYUvvhU6RFQD/82yzjI7fpXIwRMafJ8OHDxF2
         jMNA==
X-Gm-Message-State: AKS2vOzNd0VGfLKD3hrGoQSy4/bICKDbb2DuFpD6vsHL0icZU+e2rXWT
        mrX55w3fA9j9HQ==
X-Received: by 10.98.93.154 with SMTP id n26mr4744426pfj.82.1498169678178;
        Thu, 22 Jun 2017 15:14:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id n2sm5678379pgd.26.2017.06.22.15.14.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:14:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, jrnieder@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] pack-objects: WIP add max-blob-size filtering
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-3-git@jeffhostetler.com>
        <20170622145440.7609fa8b@twelve2.svl.corp.google.com>
Date:   Thu, 22 Jun 2017 15:14:36 -0700
In-Reply-To: <20170622145440.7609fa8b@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Thu, 22 Jun 2017 14:54:40 -0700")
Message-ID: <xmqqvannhdpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Thu, 22 Jun 2017 20:36:14 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>> +static signed long max_blob_size = -1;
>
> FYI Junio suggested "blob-max-bytes" when he looked at my patch [1].
>
> [1] https://public-inbox.org/git/xmqqmv9ryoym.fsf@gitster.mtv.corp.google.com/

To give credit to where credit is due, I learned this from akpm.

When you are tempted to say "size", "length", "weight", etc., if you
think of a way to phrase it with a more concrete unit, you'd end up
with a much less ambiguous name.  People can imagine max_blob_size
is counted in kilobytes, or megabytes, or whatever.  There is no
room in max_blob_bytes to be interpreted in multiple ways.
