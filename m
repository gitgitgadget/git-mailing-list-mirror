Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF62C3B1BF
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7822081E
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AC5LhIml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBNX6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:58:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgBNX6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 18:58:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so5624318pfc.5
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mb7Y7qxDiySBvzaLKovoIITF06z2ANto39s+5IzjfxY=;
        b=AC5LhImlj7fXriAJKSzXyC6rz8Jfp1d8xpS/wqCQf61UQJaZ+yUnin4w2JfVSopi5K
         TmFL5TFQNlKpM391KmneGrrLCyEmUVIEEEpPr/iyXwgmkKdAvwqsFFgzX1FYltmIpfFw
         SuhqC8DjBmnbJMJmDTJi9Ws3C+01DnqEhiimr2bRXzaPE0RPONg7hUR4ddeLTku8Qv4p
         T49oI+ijWkzH8fWl2VlsMdlEKD75t2+Yi3BJBwfUeiv0AYcHVPKatxeBtzlllj7SYDsm
         P4VSnIBAOtJwKWsCcC0mFBJYdTbeYBxNNKNR/SETM8xExl8spZi2tBQ16W41UKjLFwdR
         BwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mb7Y7qxDiySBvzaLKovoIITF06z2ANto39s+5IzjfxY=;
        b=bcgYgBpHt15GuNpffa9JTTj0VlxSsE4tNFMGx0PlHJrXhXJSA/qJq3s+5erGiAPFxd
         JghoMYo53R6x1xGDrwjbQrjwn6vQUtF6dl26kZloVj0Xc8NlXtEyyhTH8Us0+6r4S2oE
         fAVnEKiYttTRq7URwD1Q/bNZVC8ZTxxYt+G2p2wNFBulRu9xuTj/UhjXISaqyg3J9blt
         PqqnRDfpahN4lemk3Ur8sdAmsQBmXapjkrFGPExCunR9Yg48YjAffIAkkbf5Ysry8DGC
         Ri08DuhbWS78wSgL0IYEWWwsew3M++TAKLEweABQi629p4ZbI/jS4M/5FweOvylN4LZN
         aTYQ==
X-Gm-Message-State: APjAAAVxc80zIBTS24s+vvjLmMl6R2cS8S+dlwTjCc3xdrqBz9c+mzua
        TKIh7Tp5PlfkHwUZ3Ivko7i8oXmUr6BiyA==
X-Google-Smtp-Source: APXvYqx7GkMMs74xDhmEaEYE31R04dJocTSgX9TAU8f57NPL9TxsW+/5eGtgWLPs4qILDGZ7Uow1bw==
X-Received: by 2002:a63:2006:: with SMTP id g6mr5905341pgg.50.1581724704644;
        Fri, 14 Feb 2020 15:58:24 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id e17sm8440934pfm.12.2020.02.14.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:58:24 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:58:22 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Wildcard matching for credentials
Message-ID: <20200214235822.GA11400@syl.local>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214225929.541306-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, Feb 14, 2020 at 10:59:26PM +0000, brian m. carlson wrote:
> This series introduces wildcard matching (that is, urlmatch support) for
> credential config options, just like for the http options.  This is
> helpful in corporate environments where custom credentials should be
> used across a wide variety of subdomains.
>
> In addition, there's an additional test for urlmatch behavior with
> multiple subdomains and a mailmap update for the email address used in
> this series.

I can imagine that this is perhaps for Git LFS, which I could see
benefiting from this change. My review has nothing to do with my
affiliation (or lack thereof) to LFS.

I gave your patches a review, and they all look quite good to me. Thanks
especially for 2/3, which I would have suggested were it not already
there ;-).

This looks good to me, so please have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> brian m. carlson (3):
>   mailmap: add an additional email address for brian m. carlson
>   t1300: add test for urlmatch with multiple wildcards
>   credential: allow wildcard patterns when matching config
>
>  .mailmap                         |  1 +
>  Documentation/gitcredentials.txt |  4 +++-
>  credential.c                     | 41 +++++++++++++++++---------------
>  t/t0300-credentials.sh           | 20 ++++++++++++++++
>  t/t1300-config.sh                |  6 +++++
>  5 files changed, 52 insertions(+), 20 deletions(-)

Thanks,
Taylor
