Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B4C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1B360F55
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhHPSEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:04:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E0C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 11:03:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r26so1930202oij.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZVpqjSUT+ichdm9tLBOhQ1CT6a+3oSfUtHZ5z08yxs=;
        b=xa+E+FwZrtpT7vYGuMjUH6clobEC29iuv0MBfupJpnmiwcChxL7277ylvmw3YWVXjp
         jo4VpyJawQo3n0QZz3SiT0JbR/TOaKYO9ZrH7bim3zDY3ZxCMxIZuH1XWSAzwWsLMDi2
         CYQJHMIrXKeojsgwf5kwgsUgZiQxbPZIlD5WuQPcqKLiuSR1m3xHyCdMjLaqwWGIIEyK
         zjH+iVvpt24kTnGSx2YPDxiZ5HAC4Su40Hj+NqqgWFXqP5xBVdcBhhybcBvmT4i2CST7
         VXlWNPbIfVZZwPBnF9miTXqrpb7PAlA4Zznxg3jRTbaZ2zgfIWx7VE+PqBINf7MOOAyH
         ++Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZVpqjSUT+ichdm9tLBOhQ1CT6a+3oSfUtHZ5z08yxs=;
        b=JY2GGAnFqzxHBIy8zMIJxXyhtzl8Qo17Xlsgmo7iqBww+GIi7LN+OElKecXUZraIIx
         s0ZeJmGIa6Cd8KQXfx3PvXew0VMMymDGV/5RnwC/0u2bC8oHFR5LiTawkjPS/RFKJ188
         7/HXL/8jqhfRmiGvwIXIsUdi/uxHMCLjMnga9Q+yyrOAoKevREOhh9ABXKM/XIgpcQJd
         W3/i+reKrgvPCzoGbMBw9PbxDjFbqUZBpgRu3WHfD3p8q1LBv815dX0d3obW6XleWaUM
         6LKSmWtWtqiGMXK8Kru3e+O8g6ylx07iWXK+H6JF4XpWoIYDzCRmULJhDcDK7RLyRh4N
         4j/w==
X-Gm-Message-State: AOAM530aluSaTrVTSdVud0Wc/iGWqN7akdBmmseeRFnZogmMFKzlKduG
        q6o0btK12/0f/qFGCbrFVWbzfw==
X-Google-Smtp-Source: ABdhPJxGBa4BCGpGYwVOxt/fWmQyPBZVeWqsPFqVSwO/eBya+PlyCK4ZebFI9vFxmJlAIZpaaH8eZg==
X-Received: by 2002:a05:6808:13c5:: with SMTP id d5mr56376oiw.56.1629137012505;
        Mon, 16 Aug 2021 11:03:32 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:253d:b663:5848:5da3])
        by smtp.gmail.com with ESMTPSA id bj14sm19782oib.32.2021.08.16.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:03:32 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:03:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v3] connect, protocol: log negotiated protocol version
Message-ID: <YRqocoVEi1knSQa+@nand.local>
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
 <48180cecc7a8013ec19ed8fc19842d81b356ebd7.1628615309.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48180cecc7a8013ec19ed8fc19842d81b356ebd7.1628615309.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 10:20:39AM -0700, Josh Steadmon wrote:
> It is useful for performance monitoring and debugging purposes to know
> the wire protocol used for remote operations. This may differ from the
> version set in local configuration due to differences in version and/or
> configuration between the server and the client. Therefore, log the
> negotiated wire protocol version via trace2, for both clients and
> servers.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>
> Changes in V3:
> * remove unnecessary `test` calls in the new t5705 test cases
> * remove the wire protocol version formatting function
> * log the wire protocol version enum value directly, as in V0 of this
>   series
> * avoid logging the protocol version if negotiation fails (i.e., if we
>   end up with "protocol_unknown_version")

Nicely done. This version looks ready to be picked up by my eyes.

    Reviewed-by: Taylor Blau <me@ttaylorr.comg>

Thanks,
Taylor
