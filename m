Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B6C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKKCpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiKKCor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:44:47 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B568C59
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:39:40 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m15so1987816ilq.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTFW5NIVSBEKKmxUpfWVzUSUOnSL6fppD05C/cRT57U=;
        b=SbNhpgwDi015o8ZxT+K8SN1v1sBF27nvHi3+2wiEm7CLsVPjNre694WKyMKvo7oYC5
         nbdDEcEUil4FvYpwuUQ+TLPbYs0uxxBWv/oN8lm1oOOJ6nsh6IcMtoHzxrMmBuBSlVa4
         1fbf76Jh2Yv5WkGnDwn0g6kEOzPyA/HyKI0uO5Z2FgcGoUFF5s3tYWG/McqQ0PUeYMrp
         U4hrtQ7rAqL0/gIPrlo+fHBYlvjtSx8xCXDxBeGtLs2KT6tF9DgO0TId5OxuN9Y9cf6m
         uGaNY3ZR7ZBaq90ne9LrRLkr+uMZKHgJltvLe5irPZ1PuAQztN0FiOUwLskTXiLK3fig
         qHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTFW5NIVSBEKKmxUpfWVzUSUOnSL6fppD05C/cRT57U=;
        b=kfgdcN7CMAOcF0BwgAtLiOsWguWYgcOi4MmrvdYVzodvuzqs8ERTJoYWwaFLPRm9XA
         ctsmHYo1hVYSZTkzjoSNpG4Em9AMitTHRrn7LOb0WtjyEQwtoKHj0racX57IQjkManKX
         kwsMB2kmAP8JLVE4TnMwhA7Ma8BgKQbIVnHIkYrqa7pxMhSNLnCtJMkoHIKnV8vFbpgX
         oUHYCVvZIuqwZmbrBmYTwI1gepz80EcLlKw8pfrcWedY/epyJpaEUsLkzumygfBXBTul
         +6yTfvz9xFKtOyHb78Px3dCeVuTvB5FLDku745RpBg87uoxK4ssqKFAPv+ZmNaEYSS8F
         e3kA==
X-Gm-Message-State: ANoB5plhNvx1OqNCd0Hu4zCVCnR21gviIEI9IcB3F5D3OW+0yCBCpFgI
        OsxJBnL4lIryk5u7IAyoGCC9eA==
X-Google-Smtp-Source: AA0mqf7XgOFbkKlBR+1eohy/RUdcRdjwLxC6HQxrB2b3MABvEwjWoOXnLTrY+dO8H0JYUcc8vId0EQ==
X-Received: by 2002:a05:6e02:152:b0:2fc:ec3c:98bb with SMTP id j18-20020a056e02015200b002fcec3c98bbmr109349ilr.155.1668134346637;
        Thu, 10 Nov 2022 18:39:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12-20020a027a0c000000b0034a6d12aa25sm425029jac.4.2022.11.10.18.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:39:06 -0800 (PST)
Date:   Thu, 10 Nov 2022 21:39:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] http: redact curl h2h3 headers in info
Message-ID: <Y221yQva4WfZEE94@nand.local>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
 <Y221kGaQUfZJznO9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y221kGaQUfZJznO9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 09:38:08PM -0500, Jeff King wrote:
> On Thu, Nov 10, 2022 at 10:57:34PM +0000, Glen Choo via GitGitGadget wrote:
>
> > +/* Redact headers in info */
> > +static void redact_sensitive_info_header(struct strbuf *header)
> > +{
> > +	const char *sensitive_header;
> > +
> > +	/*
> > +	 * curl's h2h3 prints headers in info, e.g.:
> > +	 *   h2h3 [<header-name>: <header-val>]
> > +	 */
> > +	if (trace_curl_redact &&
> > +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> > +		struct strbuf inner = STRBUF_INIT;
> > +
> > +		/* Drop the trailing "]" */
> > +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
>
> This will misbehave if fed the string "h2h3 [", because that strlen()
> becomes 0, and the subtraction underflows.
>
> Unlikely, since we are being fed by curl, but possibly worth asserting
> (though see below for an alternative which drops this line).

Eek. Thanks for spotting. Let's hold off on this one until Glen submits
another version, or you and him coordinate a combined series.

Thanks,
Taylor
