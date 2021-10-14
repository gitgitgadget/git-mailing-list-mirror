Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB04C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5266D61166
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJNUsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhJNUsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:48:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC3C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:46:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so6524385pff.3
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A/b/UBOkTFQ/flHu3xA4V1QquN9mjZ8cwL0+pR+VErA=;
        b=ZMs2/zoqRuIFRoHwKFMnoLHfGBigBSt/DfqfkxY5z9wgKaX2aTK7kChm/gA8DoIbGZ
         bGIS6586IAtM4/f991wGO3euuq9d9Kd+cX8gM8A5QPM4RYVBkhyXjzso6Wn6nEccxg+i
         DyhAx3nKrrauRVzpgAR11K9ZWdRhajga01F7I5fnOLd7q3boaxwFLlnKRMtL+eR4/6fi
         DR1XNnll0jkjhsJluqHsemk4+7TmlOjnBKHM0oA9DfyIFxC2vo3k2w+ea4lM0cijrVd9
         RgFtUv4zNdE5wJHNGVhMv19ezoplWPvFdTlPiK0Zg9LLnD/Et9ufh2ejYTvjtNheFLpi
         SM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/b/UBOkTFQ/flHu3xA4V1QquN9mjZ8cwL0+pR+VErA=;
        b=PFve8KB2wxrl2FlNZhCBL/yp3f/W8LFUnBSFLkaoKXuhVog3Sjx1qXmR9xxKhfUrwQ
         CLwRi2BkYfvvS/gXCBgp1KLI49DkzOBgu/cXyi9cRXPTh46pHpA2C7z7ZQWlCPfZx7uP
         YcDRhvNKu7P9gek1cKgRjsPgTZ6bdYB1Ht2D21qR1qHYtd0tuA7sHRSi5hymmXvydWG+
         omLCYaXU2TovB9ce5oF8tdrdStqLr4xWvvgRvRq9FDYbi1oF7VxE7QSbJMWM1d/kDxV7
         VvAG8vnf8HZu4EQkYhyF/YwCF95SGUTwYXOi2zakpEe08kL9bs3ZudXhTrr3IkAjf2pl
         F+CA==
X-Gm-Message-State: AOAM531p189Oej4cbiotA17KApdkLqQN6LwJdcBfBzR6I0S6ovKGzyhM
        PiJzuVTs2tvASYnVYUoY9Dj+8Q==
X-Google-Smtp-Source: ABdhPJxQLlYsULC7w+ROkRpqwEsx5e7MK3Hw9lU/5g1KJKdvwkJwEABDNcaIB08TQiCkgPcqptJLSg==
X-Received: by 2002:a63:1d13:: with SMTP id d19mr5922922pgd.383.1634244405841;
        Thu, 14 Oct 2021 13:46:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
        by smtp.gmail.com with ESMTPSA id k14sm3241346pga.65.2021.10.14.13.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:46:45 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:46:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v3 0/9] submodule: convert the rest of 'update' to C
Message-ID: <YWiXL+plA7GHfuVv@google.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
 <xmqqczo8eahl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczo8eahl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 13, 2021 at 05:05:58PM -0700, Junio C Hamano wrote:
> 
> Atharva Raykar <raykar.ath@gmail.com> writes:
> 
> > I have attempted to make a version of this series that is based on that topic [2],
> > and added the superproject gitdir caching code in C [3]. It passes the tests,
> > but I am not too confident about its correctness. I hope that branch can be
> > helpful in some way.
> >
> > [1] https://lore.kernel.org/git/20210819200953.2105230-1-emilyshaffer@google.com/
> > [2] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware
> >     (fetch-it-via: git fetch https://github.com/tfidfwastaken/git submodule-update-on-es-superproject-aware)
> > [3] https://github.com/tfidfwastaken/git/blob/a74aaf2540c536970f2541d3042c825f82a69770/builtin/submodule--helper.c#L2922-L2930
> 
> The "C rewrite" of the code [3] that unconditionally sets of the
> submodule.superprojectgitdir varible seems straightforward enough.
> 
> Emily, how solid do you think your "superproject aware submodule"
> topic already is?  Would it be stable enough to build other things
> on top, or is it a bit too premature?

As of the version I sent today
(https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer%40google.com)
I think it is stable enough to build on top of. There was general
consensus on the semantics of submodule.superprojectgitdir as it's sent
in v4.

 - Emily
