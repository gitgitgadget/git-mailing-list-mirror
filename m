Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D6C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDVis (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDVir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:38:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C8DFA3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:38:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d123so4814571iof.7
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2kVuk3+wgFjXt7gUTZMC8mc7W6xz8GFhueXX70xGWM=;
        b=hQyfb3zFMZi/RMsJCKpBmqZEngG8qf8jIHeToodnEqVN0pOYCQWdri8BZ5a92rky7b
         1VhoG4D5p+cdRbRVQMGMMhgSosvGL2lpAifwU4yFQF9mFPYUaRg39UnzSszD6oK8AXcZ
         fi7bVlzSbH9M6MiEiFWNUDy5FxSmrDBRUaS6t2x8UQRfB2QJ7T5t3+mMiimXbvP+IBY8
         umb6aEGgEwj/rAJ384+7E8B5U8vCgExt9VLSwn7pIvvth1KRmEQ0VKfk0m+bDLgL0IGJ
         tp2LL2uHQ/Jv14leVPAab/19Uf/tAXF2XrVvsocd+ry+XkFaUL5r7OC0FzZYAdBfbKgX
         Xo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2kVuk3+wgFjXt7gUTZMC8mc7W6xz8GFhueXX70xGWM=;
        b=J2ffRclwwRoh7/ccKLdFnPY9DP0SHQr8fn0jgw9bDMajmiL6oIg1ef5rECS2Uepn4X
         sVRn6+H2Yt/F8IcO2ZagYB5a57m8bVbyXzILcGL8A6yW237S6j68ZhOFYrjqkeNm+/qF
         rVTwXlM7Mfa1hvdx4b3uwxuqYca9ypFb/cRVty2XZ3h2bwJ5mcjg7OViJGlVT0QLI0Nt
         yJWA1HlFc4q2lLeqgOMzEdahk1des7zl1T/i++GC8VEU2+rVf7CpX/DmdIomnJ0Z7lGV
         xYYaXAzBGqSYC9C18sjampprpw4sJ5/rHeC1lWD+ywLXn7Dr/uYZtRCt2MeEvKHqi42M
         1PuQ==
X-Gm-Message-State: ACrzQf3Z+g8hie10aGlSou9bVxwpj7N+f0PiRHHLVE3G52kMm7nby2T+
        oHMQBTVolkkSmTaAaYi2UDEeghMibPMuh5Ho
X-Google-Smtp-Source: AMsMyM71J96DXPyqWAyacS0gx3eTKbw24QuDyR4lhqmXoMnTFxOS+05yOGxRXRqo/4V5d2JB7ca6pg==
X-Received: by 2002:a05:6602:2cd2:b0:6d7:9e4f:66d6 with SMTP id j18-20020a0566022cd200b006d79e4f66d6mr2641527iow.187.1667597925853;
        Fri, 04 Nov 2022 14:38:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i12-20020a056e02152c00b00300e6efca96sm205231ilu.55.2022.11.04.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:38:45 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:38:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] status: long status advice adapted to recent
 capabilities
Message-ID: <Y2WGYIEAZwBOpvxe@nand.local>
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <8abc5272-4e01-e793-5155-ea116e9ad4fd@jeffhostetler.com>
 <Y2MEXyhh2cJ14ba9@nand.local>
 <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANaDLWK6-KkfKP0mipuWccfQFacDWsLHFNjS7ogL_xWvvmrCfQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 09:28:56AM -0500, Rudy Rigot wrote:
> One slightly stronger opinion I have, is that if the advice message
> was just
>
> > It took %.2f seconds to enumerate untracked files.
>
> and nothing else, I can definitely see a strong UX downside of not
> giving a hint of next steps for users. Basically, "you have a problem,
> and we're not helping you resolve it". Were you thinking more of
> something like this?
>
> > It took %.2f seconds to enumerate untracked files.
> > Please look up the core.untrackedCache, core.fsmonitor
> > advice.statusUoption, and status.showUntrackedFiles configs
> > for potential solutions.
>
> I'd say that's probably somewhat cryptic and a bit verbose (which is
> what we were trying to avoid by telling them to go see the doc), but
> we wouldn't be leaving the user stranded, so I can see how that would
> work out ok.
>
> I'm very interested in what you think.

I see what you're saying. On the one hand, it feels redundant to say,
"we noticed 'git status' is running slowly for you, try running 'git
help status' to figure out why".

But on the other hand, enumerating all possible configuration values
that you may or may not want to set given your particular circumstance
isn't practical either.

Thinking on it more, I think what you wrote originally is reasonable.

Thanks,
Taylor
