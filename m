Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A506CC433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C6023403
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbhATTOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbhATTOu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:14:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D58C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:14:09 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so19796873edd.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ojsKE/VsHFJ/QFqP74Y6a5zjZ52PBNodPWg1w3dltZw=;
        b=MZ7L3Xo2bpS2g/2DOhxF7X/5yfabi7ADgLH42hsOAMnu7sVANYn7WzHx8fEzZBqtFd
         XBwS/gqK94I8mKRe6S9gKEMi6YGkeNRO6kL97IsyLfg6aYLHiW7Eft1XjdaMldq+gwP+
         cTOC4CTumb4orV/qAqTnz2l0V5LTiO5Bh3OpPt6AS+dnM3iSViAwEAHt6qdTmh8eHxMc
         f+0PkoFk/Ee8TYKPU0Gs0xsT4yHo4eOrwqTbGYBZjuYXvh8VFyDRL4tUH2InyHiMQb9j
         Pwc/QbjWg/uE3jwN4cDg//xVA/e8I88EIV9OY7rtf7ndGc5u0fLpagy5FqOkqBr+/BFb
         Nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ojsKE/VsHFJ/QFqP74Y6a5zjZ52PBNodPWg1w3dltZw=;
        b=HcQGrWs3HmclRVKzbZXJxvVExKoPuM4CgQIG5huBiiNMf4JQ1qlvL0b0UyPjF8+uJj
         ARdtL+gBiGKTbK15muYmCGQ1h6kz58YlyL0asKDTT17P3z8679qCOiMrusHEjNfbhB/5
         rGGbTK6q+1sdzKYawH5O5AF31d0XbYSyTiM88e7tdW23/EMZwyG48+whVHA8sPBr0buR
         IMZczs9svRkMIKH9UhCWHZCx1kjPPrgGYIDNWpxoLIMXaA7g9IHIJ2OCvawlrjHV59ht
         yy3l0TajcSIPW4Kv2JFYalFX9seFRYc54SYW1761eOQvri1cbfJyofbbCvAx8jIxWRJu
         kHsQ==
X-Gm-Message-State: AOAM5314sZkFV0J28YqhdN/1F9mtAUiSw6fhUx0hAmBhOoN7dosyBldZ
        aQfqGHsc5I3BDiKXt6Es07g=
X-Google-Smtp-Source: ABdhPJxCJZXBYNYwZP6/NNeFtH43PwsnlZw10k702MfP5/TkJkHY149h8ilMf8aSWkrNyiTdrWa7AQ==
X-Received: by 2002:a05:6402:3510:: with SMTP id b16mr8124634edd.242.1611170048743;
        Wed, 20 Jan 2021 11:14:08 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id de4sm1572818edb.38.2021.01.20.11.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:14:08 -0800 (PST)
Date:   Wed, 20 Jan 2021 20:14:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
Message-ID: <20210120191406.GE8396@szeder.dev>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
 <20210112085051.GV8396@szeder.dev>
 <87a6t38p71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6t38p71.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 06:59:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jan 12 2021, SZEDER Gábor wrote:
> 
> > On Mon, Jan 11, 2021 at 03:47:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> A subsequent commit will remove GETTEXT_POISON entirely, let's start
> >> by removing the CI jobs that enable the option.
> >> 
> >> We cannot just remove the job because the CI is implicitly depending
> >> on the "poison" job being a sort of "default" job.
> >
> > I don't understand what you mean here with a "default job" that the CI
> > is implicitly depending on.  There is certainly no such default job on
> > Travis CI, and I don't think there is one on the GitHub thing.
> 
> I'll reword this. I meant that the poison job was using the default
> compiler etc., whereas the other ones were setting custom values.
> 
> I vaguely remember some list traffic about this in the past, i.e. the
> reliance on the poison job not just for that, but also as "the default
> OS image" setup.

Oh, I didn't mean that the commit message should be clarified.  I
meant that the GETTEXT_POISON job can simply be deleted.  Sorry for
not being clear enough.

