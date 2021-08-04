Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09668C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E687660EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhHDOW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbhHDOW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:22:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BDC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:22:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h10so1485651qth.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQ8L0LY3MgGhod+CGFe/ISW71TBDm9MtjiySqnewhJs=;
        b=ceebiS6WTHCc/4r2B854Wv6JBOldhGTDaBsDrpnXjuXPMRORFUkPgA7WeSbRDKlcqT
         BsTvS8LcVIB60sMjLjHi/A0d5qFli4rJZJ0FjAhtvKtioloBak7szLV+8w4KP+bLnntb
         wbDEdm3UuttYGBqi5xk8wTjY1sD/fWTUeP12LHSMpr81nhpQ7C92PDQk6TRc5kuxhtzk
         eAleNOC2GBKbIhWJLeo8l2KeqKOR67Kw1M527HgbaDbKofWTPe4xNSwB/U1xCwTdUVts
         Fd2TKNSBd/jBBdDoSGQxhXK17tdDiRPwWCI47s+0d9LufrT1YSuE/CjVHhSDFQatqDy1
         uTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQ8L0LY3MgGhod+CGFe/ISW71TBDm9MtjiySqnewhJs=;
        b=GVH+/hJS7dD8wssIF2ZOflmXWNbIQ//Yc3TwnMvREp7oOaxiUn+fPkiiIDBvD3QybN
         7h4yUz2s/v00dIzzjk3qvOwRifJxLxEqF3zEPbEHRm2YIXwhF2JbCzdyhpF87S/QJ0Jn
         iUBUIdLL5OtMcxdy+FRl7NMrspsZ+V9W/dyOpBrmAfitHnRC/+uFHf+8i83WV+5DW0C3
         XWGlQdRNGgf22SBxzl7wfZUbdVdDyeHHWmvEHcf7gytmZDTOY4I2Ga7ZPNxrPMBvyudq
         yvf6HEt/aqmBQhT4ggcUxKeWklLekFdzvU2+cgMANJShIlFhqRrpd1Gi3q21mZmcZL2g
         icPQ==
X-Gm-Message-State: AOAM530OU+9yuwnurzGISwaSCTBAzs3shu9HGYAfKys61zix9Hi6HJBc
        26T9GmqTjFnB6Wyi+NznXgkEVQ1upsPL7Q==
X-Google-Smtp-Source: ABdhPJylPxp5E3gUXJSU+1l+tAGoi1g9ncg0kLXB/TTC6Sm514P3krPPpfR8XmIJ6XWRKH5VHotwQw==
X-Received: by 2002:ac8:5d8d:: with SMTP id d13mr22756112qtx.386.1628086963470;
        Wed, 04 Aug 2021 07:22:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3da5:bc29:43f3:f85c? ([2600:1700:e72:80a0:3da5:bc29:43f3:f85c])
        by smtp.gmail.com with ESMTPSA id w14sm1382030qkm.81.2021.08.04.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:22:42 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfsvpr8t5.fsf@gitster.g>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>
Date:   Wed, 4 Aug 2021 10:22:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqfsvpr8t5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 3:03 AM, Junio C Hamano wrote:
...
> --------------------------------------------------
> [Stalled]
...
> * lh/systemd-timers (2021-07-02) 3 commits
>  - maintenance: add support for systemd timers on Linux
>  - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>  - cache.h: Introduce a generic "xdg_config_home_for(…)" function
> 
>  "git maintenance" scheduler learned to use systemd timers as a
>  possible backend.
> 
>  Waiting for reviews.

I just took another look at this series and see that there were a few
items that have yet to be addressed. CC'ing Lénaïc and reviewers to
see if those items will come in a v8. Here is a quick summary of my
understanding:

* There are some non-ASCII characters in a code comment that are a
  bit non-standard and could be replaced with ASCII representations.
  (nit, but if re-rolling already this might be worth doing.)

* There is some discussion about using string_list_split() instead
  of hand-rolling a string splitter. Discussion decided that we
  should _not_ use strbuf_split_buf(). It would be nice to later
  create a version of strvec_split() that takes an arbitrary 
  delimiter, but isn't necessary for this series.

* There was some discussion about using #ifdef to make certain
  logic be compiled in or not. This seems (to me) less important
  in the case of returning 0 or 1, but in the third patch there
  is a large set of logic that is only compiled on Linux, which
  seems like it should match the pattern of the other methods,
  if possible.

Again, this is just my drive-by summary, but hopefully it renews
work on this topic.

Thanks,
-Stolee
