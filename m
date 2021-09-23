Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A32C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD46109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhIWRxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbhIWRxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:53:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A01C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:51:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q205so9171577iod.8
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0S9XAbg+KCeQNcexN+AZ1+6GHkpR/NMtb+OHgeWM++4=;
        b=fsHF/MOtD4/M4ll+EG3TGC06rTmdiJt1EOvHszAk06uAjvftevGd+bwS6Eb7EjqgK2
         wjlzkuoUiCCCSFIr5ZlkaIjFMiLMHHRhy7yvdaYEh85onrZGdMsgw/6G2DF/K+kWjta4
         2JfsqoxU1WzfTswjEF3UmA5Qa4cHURpgfs6biQRZJFs1vXYpOfHtHw8H4kk898SfAc6o
         ZCUt1IlNt1400czxZuO4vO8xUw1kpl6qqidf+CQIfALb2axrDIG/XbqgWj2dGfpbLujT
         OeRngSS1YuSSQnUmqdAb0tCbMytEW3UGmcqJ1xDnHHyq/9XyczJMQkDujHtW0/eLpgeW
         ZbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0S9XAbg+KCeQNcexN+AZ1+6GHkpR/NMtb+OHgeWM++4=;
        b=6Hf5xMw0pwbA79b9wPHo2ppbvkFYFvFBHDzcQNG84IbXKQM1k/A+g07q/I/a/MTZCW
         rSVw5din7/CpocUu4yvyVsKk4yYb33Q/fdmva0ZivZxRqF+eX2NGW1H4s8JsMfuSW7sv
         j5FsW+rtkN+KwiAqZXX8GkdlUz42lB1/9c8q0hqODu/BswtQw53b1xFYq+dVrNZ6yK+i
         13df5+4CmjmCcieGZ95E8vOtkqssx/MmP6IOBtqNFGQkaKnOR6AAA9GawGjPmSkmCGXr
         adGGuqZlvKiFu8g23ECWeGjfZaZ/4NXT8Vb3nOGOFiK2geIomteyK4xpd4pFBVGoyHDt
         gvPg==
X-Gm-Message-State: AOAM531UnJdk/pPTiaukGgEN7G+O1BCv2JF/o8gwWTvUpLOgJiVQ3P0r
        861monTP0IEMUWsxhvbx46M9aw==
X-Google-Smtp-Source: ABdhPJx1lFyeLFpXwye3PyNTUAGH12xtT/aCfT93m67mEC7HW6j4hKplM+fj3Erz3OkmLPwsDYbqAA==
X-Received: by 2002:a05:6638:2722:: with SMTP id m34mr5239406jav.49.1632419507077;
        Thu, 23 Sep 2021 10:51:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14sm2869070iod.18.2021.09.23.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:51:46 -0700 (PDT)
Date:   Thu, 23 Sep 2021 13:51:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/7] Builtin FSMonitor Part 1
Message-ID: <YUy+sd3X+Hc+pFnz@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <87v92r49mt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v92r49mt.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 04:33:20PM +0200, Ævar Arnfjörð Bjarmason wrote:
> E.g. here (just an example that includes Taylor, since he reviewed v1
> here) is a case where Taylor suggested something that I didn't go for,
> but i'd like to think noting it helped him catch up:
> https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com/

It did, but to be honest I would have been totally fine with you
mentioning the changes you did incorporate into the rerolled version,
and omitting mention of any insignificant suggestions you decided to
ignore.

In other words, when I got to the same spot in the rerolled version, I
would have either thought "looks like Ævar didn't take my suggestion,
OK" or not have remembered it in the first place. Either way, the point
was trivial enough that I didn't bother to pursue it further in that
thread.

And I think that's what is happening here, too. Yes, I find the forward
declaration useless on GCC, though it appears to be helpful on MSVC and
hurtful on clang. Even if it does produce a strictly worse error message
on clang, do we really care? It may cause some mild inconvenience for a
developer later on, but I find it highly unlikely that it would allow us
to ship a bug that wouldn't have been caught one way or another during
development.

So I was a little disappointed to see such a back-and-forth about this
quite trivial point. I realize that I'm piling on here by adding my
two-cents, but I think it's worth it to ask ourselves more often what
points we're willing to concede and which are worth advocating more
strongly for.

Thanks,
Taylor
