Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8134AC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4A2207FD
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LQRKoCxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSUoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:44:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33138 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:44:34 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so427969pjs.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bx7IgPzptIKk1nuCcckePy/II8Y8kwlejfSAqBVJLr4=;
        b=LQRKoCxQVph+HltdFVLArRuQTxbo3I1tOUzQt7in1qYM9lTmxKRWoSBNitHefUpwzm
         i1cRlK6WEvexyPSpMI9RwMQxrucSHJ+CJwGYBnqqRapXBB9+s7hKmSqe14Qlm1gA4ngW
         VpxU/ogOuNRo3UQxQW49BugEymceefqGNkQHetMJRA6wP4QE7Enb+9IP3dZDUU3hPcew
         QHdQ/6pZOzn8lA/bUa+7YuEQtyT/hCCX5f1P86i73v8Z9cBoHvHsFQeyfOvPRlEv/AQx
         woMqiLI/+5DFav1TLhcOqA/FRwRu+R5I3BOaGgktg3d04D1WHBIf3jIeEPr2X9ZZx2PE
         cmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bx7IgPzptIKk1nuCcckePy/II8Y8kwlejfSAqBVJLr4=;
        b=nb8ivbxqLfm5dLqJVW+iX4++MZ0VwLoEV8tgOrtg01JSHjkOw6b0zxI+q1f/9f3BMG
         Q/u2XWg6xOussWPbL/zJ3AaZ8OMGattJ45kLKqtR8dzWea08P9Hr8p24FKSdMGfzLb0I
         58jpvMuTLrEC45D0nu506j3e3tDkQRwiMKhjY0OYiGVIZXKiboLltD+SseSQIEWeKheE
         jCy74KXCyDYDsekj2ZjgTsWNqXPchY6SwmkmUzlrSxIxQAwEI51iQRJvYG9p2sHez5Sp
         ZaWyeMRKyEZiWP1xIjPsEC138ay7oIPKjoI80z52iZLUlHXhZicN593US0b3NgQVd60g
         XVkg==
X-Gm-Message-State: APjAAAWmNsKqx8lb1CeVsKES1d9nBiyPLYVF17wSGZD0aBMmlso8JQLi
        U7Ov6eRAdTkslhoKrMobd4qP5g==
X-Google-Smtp-Source: APXvYqxj/2X5koUmJOxim0PzHzDKwXLCn8PKKHu5ztvHHWU79NoXVCzkMEa7A21aPtA3nvf4n4Zd8A==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr29059137plp.323.1582145072147;
        Wed, 19 Feb 2020 12:44:32 -0800 (PST)
Received: from localhost ([205.175.106.52])
        by smtp.gmail.com with ESMTPSA id b12sm528789pfr.26.2020.02.19.12.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:44:31 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:44:30 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Feb. 18, 2020)
Message-ID: <20200219204430.GB5101@syl.local>
References: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

Thanks as always for collecting these. I always finds these emails very
helpful.

On Tue, Feb 18, 2020 at 07:46:03AM -0500, Derrick Stolee wrote:

> Taylor Blau	5d5916fd builtin/commit-graph.c: support '--split[=<strategy>]'
> commit-graph.c
> 5d5916fd 1751) break;

This 'break' line only changed indentation, so I don't think that this
is new 'uncovered' code in my series, only that it got a little bit
harder to trigger.

It is interesting that this is uncovered, but I don't think that there's
a huge sense of urgency to add tests to cover it.

> Taylor Blau	a599e2c9 builtin/commit-graph.c: introduce '--input=<source>'
> builtin/commit-graph.c
> a599e2c9 75) *to = 0;
> a599e2c9 76) return 0;

These seem more interesting to cover, but only marginally so.

> a599e2c9 86) *to |= COMMIT_GRAPH_INPUT_APPEND;

This one I think we could ignore, though, since the same behavior is
triggered by simply '--append' instead of '--input=append'. We decided
in [1] to

Thanks,
Taylor

[1]: 846706e9-efe2-448d-67a3-a96638e9bcbc@gmail.com
