Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C0EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378792AbiFPWId (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378701AbiFPWIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:08:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE85C84C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:08:24 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id e20so2473482vso.4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBzw+hfrU95A1haoiuMQ3pIeGryybr0DHKQvjaeUGPU=;
        b=W7RQ+U/LIi9ELsDoQEiExcS1EWAnYQZR8yGF3VYCeG8+RlW9HtNk3BYyQdurY2APmG
         KlyaszOKLoFHLHRBjvOKu6Fbhb4aXUIY4lhzuzNxuAB/ePdNlJi6Cgy6TNb3BmiQO/Ea
         q9xapox7KZaZvmgZzpqDM1tn1jk09Nk6mjyrbpiQcD8H39By+0ZPB27R2HU9Kw/2nget
         YSwDk/bpefKket4BknjSNjbA+w+6h+GRtPoSGKra7FMnQJ5YTCNunjrZbxpxB34O11vJ
         0+FgATSOyMYl1lEZyZZX6FadYUP3mPY0QShn01yxSMBIWZGM/nrdHTS1KTrGmV1+KwSy
         Ff0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBzw+hfrU95A1haoiuMQ3pIeGryybr0DHKQvjaeUGPU=;
        b=XIVzSUmZlrQ1VMrCdMesfeDGJ68dijg58mDdfRVVZ7RgfpGO4K+FofV/pGzA7HnzO1
         mN7IXlckq0jyNceUR+AUYZFiZ9vZULs9q7LnuqSXNVC8Fwlqy3U2batdu6KIiQKmRKpo
         pDXHRpuRsM+ZfOXdSjU2o3UbRKg2ei9AsZq1P3NqdYcEU6zBO6AYmxdUvpSLl+oGQeIU
         z6p+2M+GekDf8iQIrP80v33vZkEu5JG/4YOfCEOikPnYN96gVkJljEJS2tIbW6Rmm57+
         OxwiEGMlGADFfN06B98n0SctNmhZtS8bwtbXUZgKdQY7hAA+mYz88GNeL/8K1RkjW11v
         /gWA==
X-Gm-Message-State: AJIora/RTJjB26LfkEdFJWx50LSYsgpZTZfCtKSkcZImKKmDj/LiEOrM
        aTGBIDOUEYfvoZpSsFTYfur3cu9ZeJdXhZgaOmxVo4E6
X-Google-Smtp-Source: AGRyM1vbGN+yaE3CJIx+dLTYBgGAxOT5RuGFDtHG820aA1+Od6ePl5GFBQYQrog1dCDsf1C5XwdgyMoglX8LZ0Xsjj0=
X-Received: by 2002:a05:6102:3126:b0:349:f1a7:fe32 with SMTP id
 f6-20020a056102312600b00349f1a7fe32mr3659840vsh.55.1655417303156; Thu, 16 Jun
 2022 15:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220616205456.19081-1-jacob.e.keller@intel.com> <xmqqv8t0qoqh.fsf@gitster.g>
In-Reply-To: <xmqqv8t0qoqh.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 15:08:13 -0700
Message-ID: <CA+P7+xoZ=_qxV1VwP=eUjfNGLaVpfDJQObXKPkbg4_qm4bgZjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] support negative refspecs in git remote show
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 2:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > This series adds support for negative refspecs to git remote show, fixing an
> > issue reported by Pavel Rappo.
> >
> > In addition, it includes some cleanup of the t5505-remote.sh test script,
> > focusing on removing subshells and using test_config more.
> >
> > To support this, test_config and test_unconfig are extended to take and
> > handle more options. The test_config_global is removed in favor of just
> > using test_config --global.
> >
> > In addition, test_config now passes the value and --fixed-value into
> > test_unconfig so that only the specific value is removed (rather than all
> > keys of the name).
> >
> > The original v1 can be found here:
> > https://lore.kernel.org/git/20220614003251.16765-1-jacob.e.keller@intel.com/
> >
> > If the config changes are too controversial, I'm happy to split them out
> > into a separate series for further discussion, or drop them if they aren't
> > desirable.
>
> I did not see anything in 5/5 that substantially depends on all the
> code churn done in 1/5-4/5.  Am I mistaken?
>
> It would have been much nicer to organize the patch series so that
> the first one is the [v2 5/5].  It may not be able to use the
> improved test_config, but writing test_when_finished instead would
> not be the end of the world.  The three-line test body will still be
> three lines.  Then test_when_finished will have to be updated in
> follow-up patches that corresponds to [v2 1/5]-[v2 4/5], but that is
> the cost of "clean up".  The main "fix" patch shouldn't be the one
> that is paying the price for it.
>

Yea, I can re-order this. I generally opted to put it last since it
added code which would get modified. But yes, I agree it makes more
sense to be first.

> The clean-up offered by [v2 1/5] is a worthwhile thing to do.  It's
> just that I do not think it is wise to make the fix in [v2 5/5] wait
> for the 1.4k lines patch to be adequately reviewed.
>
> Retiring "test_config_global" in [v2 2/5] is probably a good change,
> especially when we are to add more featurs to test_config.  Again,
> [v2 5/5] shouldn't have to be made waiting on an extra 800-line patch
> to be reviewed.

Yep, I'll re-order it.
