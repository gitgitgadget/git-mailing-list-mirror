Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24995C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjEKRY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjEKRYy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:24:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F7A8
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:53 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1960539df06so4298049fac.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683825893; x=1686417893;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh9sd3uKQg90kAid47yIPy46bCMb9AysPi/7/v9dITY=;
        b=bHLNn0LJSM5isHWDQzQiOaN7HjR9ArBC6s/3Trv65W9pUEJ1CoaclQrN65Sx6bzjzi
         KVRDJhkOiLzqn7IxlLGhDqDYxm3zbu0sPX44WTiSYeQOdDf+6qRSw7h2BFrEeBsKlVDY
         d8ZFGfvrqTjt1g2H1NnnsN1BEyEskuW/fl9RNGu034mP9UH0eiYyaY00HsBY88JdXmuK
         i+sgaERIfBANpTRcaW9acuxIvnNbSgy6nFlr+poDpoKk+oKgQYOiZEWymcuUSPWIINxB
         Rr0kVY7uRg8BXA05TtNsNof1ivpab2vaI184KTAdJTO6OZIp8D1s/ZOXa4Ov7gW/05zm
         38TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825893; x=1686417893;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dh9sd3uKQg90kAid47yIPy46bCMb9AysPi/7/v9dITY=;
        b=ek4+ldzVfHA7BFqiK3foBfSjtWGgtd+oVxBGmrR5B/pAyGK1okeNlH8wvUFoUfMktd
         w2aDe78QMv0xBJgHaL7V1V8RX/Ww1e+jUX3Hj4fSkMVBkNJYWirpQ4QLeEciXzMkx7yq
         FSNsmsXpyJC+19e95pXzdQdPWM0966KhhvYOPBQi3BwHJCoImEquvOPX6s0Fezf9Fmdx
         r6V5Owd2Tbx73GQvAALfRs34txXxi7xvKJMhAA/Hq7mGnpaP5027iDPffDfW6HFutJJR
         Yqjz5uOoVW93st+9svEqCz+6XDX1JBVskPeWktUxBg1atwxZD+ROjvtDlscFbAVZtTpX
         /uLw==
X-Gm-Message-State: AC+VfDyx/56dEBPTfD+dpAwY+glPpzrK3PtTaMNzcE390LL8b1R0zD22
        5CB213zpAY/X331O6vQCJSX4hri9w7Y=
X-Google-Smtp-Source: ACHHUZ7sH+ye//rXizcWAqH1pLZVW/d5sYxoDJEeBsAT3fLoew/rf/D7qqme3E1IbXCK4h/J4DUTZg==
X-Received: by 2002:a05:6870:e406:b0:192:b847:360 with SMTP id n6-20020a056870e40600b00192b8470360mr11797124oag.48.1683825892933;
        Thu, 11 May 2023 10:24:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w22-20020a056870431600b001925ab4a7ddsm8122353oah.22.2023.05.11.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:24:52 -0700 (PDT)
Date:   Thu, 11 May 2023 11:24:51 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <645d24e37eadb_26011a29488@chronos.notmuch>
In-Reply-To: <ZFzMDCK8rprq6qUs@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
 <xmqqwn1g3vvk.fsf@gitster.g>
 <ZFzMDCK8rprq6qUs@ncase>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Wed, May 10, 2023 at 11:05:19AM -0700, Junio C Hamano wrote:

> > OK, this time the familiar "prepare a variable to its default, let
> > config callback to overwrite it by reading configuration variables,
> > and then let the command line option override it" is used and the
> > result easy to follow.  I do not think .display_format is never
> > assigned DISPLAY_FORMAT_UNKNOWN with this change, so [6/9] could
> > lose the value from the enum, I think.  The defensive switch
> > statement that has BUG() to notice an erroneous caller that pass
> > values other than DISPLAY_FORMAT_{FULL,COMPACT} is still a good
> > idea.
> 
> Ah, right, `DISPLAY_FORMAT_UNKNOWN` isn't really needed anymore. I think
> it's still good to have valid values of the enum start with `1` so that
> it becomes easier to detect cases where we accidentally use a default
> initialized variable. But that can be achieved without giving the
> default value an explicit name.

I think it's standard to have an element like that. It could be UNKNOWN, NULL,
INVALID, or even DEFAULT.

For example, you could have code like this:

 if (format == DISPLAY_FORMAT_DEFAULT)
        format = DISPLAY_FORMAT_FULL;

This would distinguish cases in which the user did not specify a display format
and we choose a default, from those where the user explicitely chose the format
that happens to be the default.

-- 
Felipe Contreras
