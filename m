Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E514CA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DF1206A5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dR/rZanL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgELTXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 15:23:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B04C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 12:23:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 186so16853690ybq.1
        for <git@vger.kernel.org>; Tue, 12 May 2020 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zbF/eXtKx/OZpcxchsjiOUUHdyGjgjkr82YUjnPfE8o=;
        b=dR/rZanLdzEWNPxG3MqO7ShfRjqDI85eAxtA1yiBJiz/phIKOzyHlFfa35VtS33vdx
         YpAp5j8fxSirFyHe4Edl05zWWBYle2lnEIwn50Nn8Zo4d0p/R4WGOk3tCIfF71r/Qe7a
         uP66Qd3brQQJShJl7uNMzbO7ciKapopqjsvgwN1MUPHEHabrYb6r8nB7cHuMua8hMGbD
         XVoloo1GznViqJ0zuaY3TkMmlNCl9j1MRvDYQgPlDjmxlsZ54xhxM+EpBHka8X7m1dTW
         mdUBh9JJNumvSBqX4u1TAFsGIv3c4S258+AkvPneCCO7fcaiQKOkqEdANLMMC9A1FZbI
         JDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zbF/eXtKx/OZpcxchsjiOUUHdyGjgjkr82YUjnPfE8o=;
        b=ldo0XznHE6VzS299K6Xk1KRCiCnXhyKMacZjIJBk7OQXhPB04hXs9l8RJVeR4kGwN0
         3n5dr1ksD8cOXLkSj0Wsd3srtmLWkGKJORxQoAlf3sz7yqXkauUTZb/Swc1ZXOdoqWHU
         mW4ryfOWdA9aCMQLvIvuweRSOHQwjvCfuB/hGvDUuE1IzhGH1sdyFEO/lrnlHh4E/sO8
         ItsImvwxZpHCieyCUeWhP14gfTpWsGoWoP6apWHhl+MtX63udjTbvJnaTanDWlZmOXwG
         BP0BjFWxIAs9gcC2nK1lFnFIZ9cs5PVCm+neDaoB/6qZqVh36nBD81y3IvzIeprjnNGm
         svxA==
X-Gm-Message-State: AGi0PuZ7p4taCFXztIK8pR6jiFzDfrCEZ8Z5LTlHtCAnXQgjizV4W+7M
        V7LQ+P1JwWS4jvxLsoCmE/iq3oapyDbYIx6snjlm
X-Google-Smtp-Source: APiQypIYFuOHHT9D5oMFmng+tBS8/76R1HLggp5gwn6J8l1O+2DX99XGGnvX1LSEGV2QsepfBXnkMzedTByXzZeisvSL
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr39438071ybg.376.1589311382194;
 Tue, 12 May 2020 12:23:02 -0700 (PDT)
Date:   Tue, 12 May 2020 12:23:00 -0700
In-Reply-To: <20200512191610.GB54565@coredump.intra.peff.net>
Message-Id: <20200512192300.203201-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200512191610.GB54565@coredump.intra.peff.net>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +void http_trace_curl_no_data(void)
> > +{
> > +	trace_override_envvar(&trace_curl, "1");
> > +	trace_curl_data = 0;
> > +}
> 
> Would:
> 
>   setenv("GIT_TRACE_CURL", "1", 0);
>   setenv("GIT_TRACE_CURL_NO_DATA", "0", 0);
> 
> be simpler? Perhaps it makes the flow more convoluted as we'd go on to
> parse those variables, but it puts us on the same paths that we'd use if
> the user specified those things (and avoids the need for the special
> "override" function entirely).
> 
> Other than that nit, it seems very cleanly done.

Thanks for the review. I thought of doing that, but thought that it
might add some latent complications - in particular, someone inspecting
the environment variables of this running process might see some
environment variables that they didn't set. But I'm OK either way.

> PS I sometimes find the normal trace a bit verbose, but I do still want
>    to see data. Do others feel the same? Particularly I find the "SSL"
>    lines totally worthless (I guess maybe you could be debugging ssl
>    stuff, but that would be the exception, I'd think). Ditto the split
>    of data into two lines: one with the size and one with the actual
>    data.
> 
>    I dunno. I haven't been debugging any git-over-http stuff lately, so
>    it hasn't been bothering me. But I definitely have written perl
>    scripts to extract the data to a more readable format. Maybe it would
>    be easier if it had a few more knobs.

Data can be turned on using GIT_TRACE_CURL=1 and refraining from setting
GIT_TRACE_CURL_NO_DATA. What knobs were you thinking of?
