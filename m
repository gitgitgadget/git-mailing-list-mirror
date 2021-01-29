Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C085C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5779864DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhA2BfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhA2BfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:35:18 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08EBC061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:34:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l27so7383155qki.9
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9UIXp/HJcmqBuwap9O4glanBey0UFwFwvoW4hnKMCQ4=;
        b=1a951u4Ii9VbczDZRqHuHdYCFNZygg1dEUgMhLB1You+iEzN52NoelhD1yPbGQWFAi
         Qo1Il7TNoBG55/hOxJvCc/ohOnGeggzRkJ3U7yPHmH9WMVobGOEtwrpQ3tUaPbgNbBAW
         jx6+aJLpl8+BGPI/SSrzw1PzxfTLLoRvfs1GkoqrCNyLrm9jL4A69R/P1OR8c/Z9iLvK
         qS+eYpq1cIMDS2LPgQQFMSYhP6sCarFz06bhl9dVH7/Ta1E2KtwUJqZ1FtVgkhj+vwej
         TdmnAzY3gd0v1C0D9KZ+SwNdIYJy9r0RWUw5NRWWD50PauohsT6mBhs5Voxn8Vj2CSLM
         70mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9UIXp/HJcmqBuwap9O4glanBey0UFwFwvoW4hnKMCQ4=;
        b=Hmoo+2t4FgLDrlXkQig1AKJYVPZCSOEEGJpjWTrlTBByXO8BMyLMZU5f8fxYerF+4e
         pK/ShPvJNgs/tzcBF/53QFj3UqIScT7oQjGAk7ayfS3tIYqJN9qVH1w4H9Nn9PqZV0yj
         1lUZRhLgrbivTPQtoSjhB+TlmLQ40F8O53XCOqZ95FMAsL9WuilQKOdJR+T68xb5gqDY
         rixQ7JdBY1hhUtsFxcR9mwM09ImThe1NFrrUl3JHyTGchVYaO4Jlnute3QTgcWyLxbK3
         Gx6QCSKRbe6q67J4HJK422db6gQ9g6JSuM9bZI3r4oWNoONbIasWSkXkrr02O707X3WL
         v3Cw==
X-Gm-Message-State: AOAM532ifPQ0sLI++ohz4e5q074ZtHxUMZ9Gh4FU2IKYjIcqRyTU+6sJ
        f+hJCBaXWaZ9mGgypCHF8MlOoQ==
X-Google-Smtp-Source: ABdhPJxyabaXRKJzw+82LclBQtmD5jS+Ll8nW5kEBESgg8FcOVxRb7sGtcNcNY7ronD/X5IETkfKXg==
X-Received: by 2002:a37:9b42:: with SMTP id d63mr2190299qke.216.1611884076981;
        Thu, 28 Jan 2021 17:34:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id a188sm4763764qkg.33.2021.01.28.17.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:34:36 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:34:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 00/10] pack-revindex: introduce on-disk '.rev' format
Message-ID: <YBNmKXy9qxvbjltG@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <YBNfgywXe5nr+96y@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNfgywXe5nr+96y@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:06:11PM -0500, Jeff King wrote:
> On Mon, Jan 25, 2021 at 06:37:09PM -0500, Taylor Blau wrote:
>
> > Here is a third reroll of my series to introduce an on-disk format for the
> > reverse index. Since the first series (to introduce a new API) has been merged
> > to 'next', this series has been rebased onto 'next', too.
> >
> > This version is largely unchanged from the previous, with the following
> > exceptions:
>
> Thanks, these all seemed like improvements to me. I hadn't read
> carefully through the test patches yet, so I did so now (in addition to
> checking out the changes in the earlier patches).

Thank you; I appreciate your close review :-).

> My comments range between "musings" and "suggestions". I wouldn't be too
> torn up if they are all discarded and this applies as-is, but in
> aggregate there may be enough to merit one more re-roll.

Thanks again. I discarded a fair amount of them, which I hope you don't
mind. I think a few of them could be reasonably dealt with outside of
this series. Mostly because they have implications on other parts of the
codebase. So I'd like to deal with them all at once, but without adding
to the scope of this series.

I did especially like your final suggestion about the new test in t5325,
so I sent a replacement patch that takes that suggestion (as well as the
typofix that you pointed out).

Unless you have any objections, I think that this is ready to get picked
up.

> -Peff

Thanks,
Taylor
