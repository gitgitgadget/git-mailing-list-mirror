Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E95C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJJSKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJJSKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:10:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569741D1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:10:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p16so3351433iod.6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHgLzXP+FA573pG1IvNlXso/CUHObWcM6W/VVPwkL1c=;
        b=YqS6lVp6GiBD6BHnAmtM4bOh1ZjoTbMhstEOHS6UNk3Owiup8Xoj97B9n+kCKFT9og
         his6ZYntFcp6NpBUOTOsCVUGmA7uo8t0jfsbI8mvC+LftFobdoMRiWeaW/i2q3aATTt9
         YsHdrhsfi/CPhrEIduJnkZWG6OAwLyb0Uhs5iqNRrScEgiiTx+qyvhtLuGzueLMIRNya
         a99AZgilur4ml7mleOPqurPzuzsWXuKkZ4h0JLaVDfjpFxt3p8AHWN/WfofE8AAXOS1Y
         UzCzGIm4FfgRSgVELLTvnhZPiNKvVH5AYh1HIZ/RbntCK0MHxxW787xr1s1tgGS5Bv8T
         p/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHgLzXP+FA573pG1IvNlXso/CUHObWcM6W/VVPwkL1c=;
        b=3TAdszq771VGE8q53DfvfMlQzpFAFbzFjm0J4gJttBLUKVErU5bMqLPRci2sXLJcnJ
         y7kTX/R9uSlnUAz/I2ylyuFfXhynm950i4YHdrzN6K9GlHWxzBv7iRSx5j05oKm263VV
         /K4SBS5pv6aObW3CiaIXdgz4ftP0UTji1PHMKl43TKpU0nyonwBv7HvIF2W4lnnldizC
         AbjtqGi5UrmQGqDS5d0QBAVH715ubfYfZme19ZuCfgXnB/9qkyCuWmqtqBp/P6PLRk5S
         SSDH5k8Xj1VnasF5soo7FPDoSBVtY7SMwgQsc17+yVqYB76BNgiD4QYVLQ4dwLhSxMvT
         D88Q==
X-Gm-Message-State: ACrzQf00Hq7pbj2NLHLlM9cYWYSEe7qChTK7Y13JqoMwLzLoNSIxkt0o
        BpiT1fQxWVVjZUpxhlqRAFJA7A==
X-Google-Smtp-Source: AMsMyM6zeVhNRNJGz7zkRWJYJmcYRT3+mOEQIQJkeGqdmMEwAQA5P1U4PZzLzfFJYHvhXGQzJWFFPg==
X-Received: by 2002:a02:cd26:0:b0:363:74f2:6d7b with SMTP id h6-20020a02cd26000000b0036374f26d7bmr10531147jaq.139.1665425441420;
        Mon, 10 Oct 2022 11:10:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q8-20020a02b048000000b003628c926876sm4457043jah.45.2022.10.10.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:10:41 -0700 (PDT)
Date:   Mon, 10 Oct 2022 14:10:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        orygaw@protonmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH 2/2] grep.c: tolerate NULL grep_expr in
 free_pattern_expr()
Message-ID: <Y0RgIGpxXXilh7YM@nand.local>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <cover.1665423686.git.me@ttaylorr.com>
 <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
 <xmqqy1tn36pc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1tn36pc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 10:54:23AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > @@ -790,8 +793,6 @@ void free_grep_patterns(struct grep_opt *opt)
> >  		free(p);
> >  	}
> >
> > -	if (!opt->extended)
> > -		return;
> >  	free_pattern_expr(opt->pattern_expression);
> >  }
>
> I do not know about this one.  We used to avoid freeing, even when
> the .pattern_expression member is set, as long as the .extended bit
> is not set.  Now we unconditionally try to free it even when the bit
> says it does not want to.  Why?

It's not "does not want to" be freed. As best I can tell, we conflate
`opt->extended` with "there is something in `opt->pattern_expression`".
So checking whether or not `opt->extended` is non-zero isn't "keep this
around because I'm going to use it later", but instead "there is
nothing to free, don't bother calling `free_pattern_expr()`".

A more direct way of saying the latter would have been to replace the
if-statement with `if (opt->pattern_expression)`.

I hinted at this in the commit message, but I will make it more direct
to avoid future readers' confusion.

> > diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> > index e3ec5f5661..44f7ef0ea2 100755
> > --- a/t/t4202-log.sh
> > +++ b/t/t4202-log.sh
> > @@ -297,7 +297,7 @@ test_expect_success 'log --invert-grep --grep -i' '
> >  	fi
> >  '
> >
> > -test_expect_failure 'log --invert-grep (no --grep)' '
> > +test_expect_success 'log --invert-grep (no --grep)' '
> >  	git log --pretty="tformat:%s" >expect &&
> >  	git log --invert-grep --pretty="tformat:%s" >actual &&
> >  	test_cmp expect actual
>
> Especially for something this small, doing the "failing test first
> and then fix with flipping the test to success" is very much
> unwelcome.  For whoever gets curious (me included when accepting
> posted patch), it is easy to revert only the part of the commit
> outside t/ tentatively to see how the original code breaks.  Keeping
> the fix and protection of the fix together will avoid mistakes.  In
> this case, the whole test fits inside the post context of the patch,
> but in general, this "flip failure to success" will hide the body of
> the test that changes behaviour while reviewing the patch text,
> which is another downside.

Good to know. I had considered it good practice, even for a small fix,
as a way to show your work and prove that you had a legitimately broken
test case demonstrating the bug. But if it creates an extra hassle, I
don't mind squashing it down.

I can send a squashed version of these two patches, but let's see if
there are any other comments, first.

Thanks,
Taylor
