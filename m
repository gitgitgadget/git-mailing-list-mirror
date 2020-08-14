Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F98C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF7E2078B
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 00:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD3fK2z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHNA7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNA7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 20:59:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33092C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:59:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so3628653pje.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 17:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WfgzivxsGaA1kRY0P2uM9n4ejkrKqoFCfwpIAGrh654=;
        b=oD3fK2z2YqjpEwG63ldeJsVPUWOLcLYQ1sryxSljNCi1qjLkc/Si70EEDQsS/7REWl
         qayPIQLD7ujCm08+Tb6rtes+yIlpAOjQQA9wAIwxonqocl9/UfdZq+2PjhVobBBv5p+f
         A6uddIfNc2MJdvBHs6fby0k3CaRwYqdh0W+ZCAPUEQkMCXWshWJB6N1NBJGWkbPjF0I2
         rddtibJGx1s88VRGoFSQdIElIaJUT2bujPOCW6CVO1k3bkHCzkbedmI6iZub037ezZyu
         chV9cRTx1JnTIh0WoShqzPtW0O7iCCw1wBb+dI5tukp/Ab93H1ypxAORWMTcAxtew7oq
         ME1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WfgzivxsGaA1kRY0P2uM9n4ejkrKqoFCfwpIAGrh654=;
        b=p1rJM9eBu5yWANRr2Fvzf6rTIT2GsF7hBF+1x+EglDpgNvMNPf+2DEPrKLpVj1QJ4W
         ue5x5wbz8HTLJFiUQ+CY8hOe0Klg+U44+DteAgEf+vBH9koqCcyfLRg36RAQGkV5zSDV
         Bng01stDttDmYaodVsxKECdW43lA96LVzgfFM4y/ecYd+u8hKafZULn5IUisW8cjDg4G
         Fc04PSMeCRdUwwue7DtIO/9M/CCSz8RCTYeVN29gaivm5QBYEvGiN/MCvslpirhqwPWK
         9x5ro4Tk5n84beV9rkvcZDocZUcq2NoeAoYuchcb7peMAgqrioYFIdPRoEpbYRIhTesO
         HFtQ==
X-Gm-Message-State: AOAM530L5KqZ4mMrKUWjMwL59C86ReIs6gGRVuG9t/Tav3+OP7RPT2Ay
        9OJMClfuhgjpvLr9yLcDOLFWFyKM
X-Google-Smtp-Source: ABdhPJwaWOjQpujKfYZNVThRasx7OVo7hW7qqunhfCdt+2GNergt2V8MvX6DYpYAuGRnYdu6ttvC/g==
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr279407pjp.32.1597366789600;
        Thu, 13 Aug 2020 17:59:49 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id a6sm6532632pje.8.2020.08.13.17.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:59:48 -0700 (PDT)
Date:   Fri, 14 Aug 2020 07:59:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked
 explicitly
Message-ID: <20200814005947.GA9518@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597364493.git.congdanhqx@gmail.com>
 <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
 <xmqq8sei125k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8sei125k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-13 17:50:31-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > When we see --no-abbrev in command's arguments, we reset the 'abbrev'
> > field in diff-options to 0 and this value will be looked at
> > diff_abbrev_oid() to decide not to truncate the object name.
> >
> > In a later change, we want to extend --abbrev support to diff-patch
> > format. When --abbrev supporting diff-patch, we need to differentiate
> > those below scenarios:
> >
> > * None of those options --abbrev, --no-abbrev, and --full-index are
> >   asked. diff-patch should keep old behavior of using DEFAULT_ABBREV
> >   for the index length.
> > * --no-abbrev is asked, diff-patch should treat this option as same as
> >   --full-index and show full object name in index line.
> 
> Sorry, but are you saying that the above two cases cannot be
> differentiated in the current code?
> 
>  * If none of --abbrev, --no-abbrev, --full-index are given, then
>    diff.c::prep_parse_options() will leave options->flags.full_index
>    and options->abbrev untouched.  They are initialized to false and
>    DEFAULT_ABBREV (typically -1 when unconfigured).
> 
>  * If --no-abbrev is given, options->abbrev is set to 0.
>    options->flags.full_index is not touched.
> 
> So you should be able to tell these two apart by only looking at
> options->flags.full_index bit.  Perhaps, even though you said "we
> need to differentiate", you meant something else?

Oops, I shouldn't say anything about --full-index in the second point
to reduce confusion.

Let me list some combination here:

* none of --abbrev --no-abbrev --full-index -> default short index
* --abbrev --full-index                     -> full-index
* --full-index --abbrev                     -> full-index
* --abbrev --no-abbrev                      -> full-index
* --no-abbrev --abbrev=[n]                  -> shortened index to n char

So, we can't use full_index bit, because --no-abbrev can be defeated
by --abbrev, but --full-index will always win --abbrev.

> 
> > While not doing anything is very effective way to show full object id,
> > we couldn't differentiate if --no-abbrev or not.
> 
> Hmph.  --no-abbrev without --full-index would not set
> flags.full_index bit; using --full-index would set the bit.  Are you
> planning to do something special when BOTH --no-abbrev and --full-index
> is given?  I am confused X-<.

I'm not planning for anything special when both --no-abbrev and
--full-index is given.

I'm planning for:

* BOTH --abbrev and --no-abbrev but NOT --full-index;
* BOTH --abbrev AND --full-index

Sorry for the confusion,
I hope it's clear now, and you could help me rephase a bit to reduce
confusion.

-- 
Danh
