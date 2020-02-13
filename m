Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A8C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEE0217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="r9BzrYk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBMRlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:41:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35772 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMRlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:41:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id y73so3429988pfg.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=24v46qvszMQHOjebEy3ZHMKWsFEYScIH95lk67l274Y=;
        b=r9BzrYk+H79GMq3/6Pe3Ft9m2qOXWHXrC/HkySCzWvyqLQRPBwcNJy6h/wL+scpt2O
         Rye3UrtaszxggFsvyi8cmx6vf58f50Wwa4uCQAjxW4O6uZIwPiUTMRMBjk0Joe94zV6v
         R5Uaj/ypqZ3qUYvDTHuy7SdbT8QVH9PCiqE9aVaU6nkuLhAJdSTWDlEMXrVxox1a4dva
         yhEQopPwYUui7gwl2lc/K+yKJ5QKo6xrd7RLWsvkqsbadS9V4h9GP8UDiIxoUNKdAT91
         Cvo6NnqI82ldRDvBA6Dxw4g/5YDPNC5MGNKeXqx+eLLM/zxNK4Kdv66LaQvzWx7pT8TU
         OYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=24v46qvszMQHOjebEy3ZHMKWsFEYScIH95lk67l274Y=;
        b=PRSblf4tExs/N7xCLE/D4u9c1iTcNt9zqsQnk9KB54fhfUo5JuMivvRqPRAPJZHPig
         sMtXmbp1X6I147SicKY3b/JyfyBrdYHHgaNOOUCONLKZ9/Y0qtiaDNwEhIBB2DhMrHEf
         04K00LiP4lUzZGlhVbMPa8P40Bz7MpcVLHh5sAGqUXUPB6tkua+cOHfQefZkOs32JLSK
         U4ovISIZXsPhg58+sxWdxqWyRrQXBAmwwlvISFcp+VKBNToHY1tCwQg7ybqHzQyFem0o
         5nfvtgUAzDNagDqiNOmWUxhrzozEhtEyFhP286fNLazVxBjdSLrKo3VpAxj/+WuB5TTw
         GbHA==
X-Gm-Message-State: APjAAAUuH2U8jAUlCqQwwf+59AXjmV20Kig/G8SXwHM4qGCZLFGFcVWZ
        2esyrwUwTl71+t2LNXmhPZ3kQg==
X-Google-Smtp-Source: APXvYqwqG15t7nltPJ2s7ZCn9w4fJFwyq6JtaTurvVk3h7j2IjGOxhprgwXurjFWqGObqtCWb8oM7g==
X-Received: by 2002:a63:515d:: with SMTP id r29mr18671331pgl.265.1581615671389;
        Thu, 13 Feb 2020 09:41:11 -0800 (PST)
Received: from localhost ([205.175.106.72])
        by smtp.gmail.com with ESMTPSA id b3sm3818201pft.73.2020.02.13.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:41:10 -0800 (PST)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 13 Feb 2020 09:41:10 -0800
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garimasigit@gmail.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <20200213174110.GB45518@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
 <xmqqy2t7u0rh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2t7u0rh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Feb 12, 2020 at 10:19:14AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Attached is what I anticipate/hope to be the final reroll of my series
> > to add new arguments to the 'git commit-graph write --split' flag to
> > allow callers to force or prohibit the commit-graph machinery to merge
> > multiple commit-graph layers.
> >
> > I was keeping an eye out for more discussion about whether or not these
> > flags were acceptable by reviewers. Martin Ågren and Derrick Stolee have
> > both chimed in that they seem OK.
> >
> > Since there hasn't been much more discussion in this thread, I replayed
> > this series on top of 'tb/commit-graph-use-odb' (which was itself
> > rebased on 'master'). I picked up a couple of ASCIIDoc changes along the
> > way, and a range-diff is included below.
>
> I haven't had a chance to form an opinion on this topic, and will
> let others comment on it first.
>
> This topic and the "changed paths bloom filter" topic obviously and
> inevitably have trivial textual conflicts.  When today's integration
> result is pushed out in 6 hours or so, please see if the resolution
> is reasonable in 'pu'.

The resolution looks good to me, thanks.

> Thanks.

Thanks,
Taylor
