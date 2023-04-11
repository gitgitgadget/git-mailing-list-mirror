Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F65C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDKVNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKVNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:13:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5973430D0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:13:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id q5so12529161ybk.7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681247594; x=1683839594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Iddy4MIkPAzDb37d1Pjb12xFg3EhfTw7hnvj1Kh47U=;
        b=UcXEhH5aFlmioehOUqO8Xj65RqR0ZI6JwtvW7G1bBWPP2xC6f88r8K1Xt+DJscMbBD
         tUNEJ7wtiPUapildROr4QGIlWzRfVnbIhAbUKgyKca+c2RBbqEdmov0eSJHnHsZ7A5Kq
         0AqGFAtKOiggHxyeZ4zaJXXrCLk9FUWBzYC66CzYCKUgwqaUxthG2NiVt76cRHuLpOCx
         JnybNOj5VXklYT+a0/dgvgNL1T9LemcJHuEXhDlJSg4ZCeKNNsOV9qoAyX3nPkwA0Ct+
         ChNbXwsvNRjshfriVJ+0u5o5jQU9HCVvKYeRcJMUGCSFU1ixfr352lWnjiJnMtUIhcRC
         Gsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681247594; x=1683839594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Iddy4MIkPAzDb37d1Pjb12xFg3EhfTw7hnvj1Kh47U=;
        b=3xRVrPbn5+cPtpLZBTSlCWkUlMSoFYgJqaC3WPDmKQCnB8v2M2RMBiUfxWCEGe731d
         e00lp/VOsi9VPnCSfJdc/Foo+u1gIPY30TiQhM3kxxaXTHmx6gqP0151d7yuu/HNmXY3
         qPAZLh99tjBGTtk9KpYgYKxXhIeRk4dK10Wy88xzqtTNDLYOnMRVREzF6G+0s6sYtMLp
         Dz8duXOFwxaIgMz+sj9XDDBMMeH6vJ4pzZ0hPcQ0qB7nibQgss/Cfp4bMyAIgWvgmYjh
         cW5qw2DuRRBzcRnUEwcMikzJTorkEsEM5QkYR7Qb+lVH1iWftI26T+ZAIY76LWjbeYpG
         6wdg==
X-Gm-Message-State: AAQBX9ef9bL3OQqqvhq6zPOigFcJ/ljjkaLjrQJkRIjkf4F302prdHDG
        EZQedawHjMHy5IVQlQmtEWf8ow==
X-Google-Smtp-Source: AKy350a0YZZuMubV0w8s+8Z57KvPYGkLmOvLRWUV6oXv3WXG+shymDHRuZPyqx3ne1foo1znTQ6RPQ==
X-Received: by 2002:a25:3757:0:b0:b3f:208d:ba7 with SMTP id e84-20020a253757000000b00b3f208d0ba7mr196420yba.16.1681247594413;
        Tue, 11 Apr 2023 14:13:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i125-20020a255483000000b00b7767ca7496sm3901803ybb.51.2023.04.11.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:13:13 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:13:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDXNaCYV+DhxaBt3@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
 <ZDSgbYa+j/5c5t8j@nand.local>
 <ZDWVSuFJLU54txwc@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDWVSuFJLU54txwc@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 07:13:46PM +0200, Patrick Steinhardt wrote:
> So ultimately, we would only ever write an MIDX containing only local
> packs already. It rather feels like this is only by chance though, so I
> think it is good to include your patch regardless of whether it actually
> does something or not. Better be explicit here, also as documentation to
> the reader.

Doh, this is definitely right. I even wrote that code a while ago; shows
you how good my memory is ;-).

FWIW, I agree that even though it doesn't do anything in this instance,
it is a good safeguard to have in place, so I think including it in your
series is the right thing to do.

Thanks,
Taylor
