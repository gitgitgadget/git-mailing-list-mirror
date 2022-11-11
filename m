Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B2C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 04:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKKEtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 23:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiKKEsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 23:48:15 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727136AEEA
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 20:46:56 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id x16so2070190ilm.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 20:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbpbK2GqjjeNx93WZhrI2qVHgIPeJ8MPr6zf2xU30n4=;
        b=niNFLDE83y9+yHViRnN6RsKr/QpvePO5pHpCDM6rwvVAvpMMo8t0+/m2vVm7TIU5qg
         x9xHtZ9EtJ3tX/HlqWDsA0OEdszzCYVBjHSIowLOd0gsh2y1UOFNoj9BsOsUugHIplf3
         FKKUvKEER9ejnCqVGVZ2dwnxqv6mTSCwMTBrdAb3XTtqHny47QbaahmHOccYt21+Bh8w
         tDusEjITnsfh9w7k0RcXW5kfUiefEg4qlGiv9GF7LB0NYylIzl7rX1API2w7DvWXDGLu
         znIQM3EBRZxU7kacr/kCEjZfztgP+HuHUH4I5cp/yZJ/jVNafIRyeJn97T5K1YIpezGi
         amgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbpbK2GqjjeNx93WZhrI2qVHgIPeJ8MPr6zf2xU30n4=;
        b=wdHigRGkeTEx3PdnLE0+HYYUO6kLBpEIpn4r45HI1QluyuGbeLHh9xXQn6usdz7hsV
         J2tTqHKDFPTc9KfF9MZx0iT4644MWf0kbgbSVL78BClwQOu+ZL/P6rKVhX4Y2TLcgTZK
         rDd9Ia0vQyycZWRF8RFqzfCewyV0QZiigl59NDbuH8Q98p0O5nlHcvvgupMI82Mt3pQL
         t6dqYVwnRbETDqBXILWMQF5MccnWb527Dm12B3DlA1fZZmlnPmYcjgbyNNWE8Yfirxg8
         oJGZFjVl0e28AtveGG1BHsHluq8+rpk5NYcZg3wHh3tgoHQQQcibeMRXI5nTu7JxVw2R
         uJFA==
X-Gm-Message-State: ANoB5pnxm7JMLV0pjZvtvUYvncMW2+lsGakIN4Y3dhqW9ukiCG+wRggZ
        RwKrO6mlGs5JW0sltroW3bpmdw==
X-Google-Smtp-Source: AA0mqf6kjwUqh1wCVvJEG5WKA8HuRIRHkHfevCYO3/IGtgSN4+cIJSgoFNaUUo/uwg07/jJrPk25Bg==
X-Received: by 2002:a05:6e02:1bae:b0:2ff:e796:926 with SMTP id n14-20020a056e021bae00b002ffe7960926mr272444ili.216.1668142015802;
        Thu, 10 Nov 2022 20:46:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 18-20020a92c652000000b002f8d114ca84sm530789ill.17.2022.11.10.20.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:46:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:46:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
Message-ID: <Y23Tvud88nwDm0Va@nand.local>
References: <Y19dnb2M+yObnftj@nand.local>
 <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
 <Y2KoKO5Sj71Nfa61@nand.local>
 <8r1s24sp-8p26-sr61-3pp0-8o7r6pr72641@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8r1s24sp-8p26-sr61-3pp0-8o7r6pr72641@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 02:35:26PM +0100, Johannes Schindelin wrote:
> So basically, I thought this was finally done and the next thing I hear is
> that it is ejected. That's quite a frustrating experience, I must admit.
> At least I am not a new contributor who would be very much deterred from
> contributing any further by such an experience.

I ejected the series for two reasons:

  - it began to conflict with newer series that folks are working on,
    and

  - because I hadn't seen any activity on it from either you or any of
    the previous reviewers.

I don't want to drop the topic on the floor if we are getting close to
or are at the finish line. *But*, there are a handful of other series in
flight which seem to conflict with this one.

It would have been much nicer to graduate this earlier, and certainly I
think some reviewer-signaling could have helped that.

But now that other topics have appeared, it would be nice to see a
rerolled version on top of any topic(s) with which it might conflict.
That, along with clear instructions of which topics it depends on will
help me queue it in the right order.

If it helps, I can try and take a closer look tomorrow when rebuilding
'seen' with the new topics. It may be possible for me to resolve the
conflicts with minimal effort. If it appears in 'seen', then you should
be OK, and we can start graduating this down. But if not, then having a
rerolled version would be very much appreciated.

Thanks,
Taylor
