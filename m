Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66871FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbcLEUQW (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:16:22 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36155 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcLEUQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:16:22 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so139650509pgc.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 12:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gCSwqX+Vy/0K/4q7EcP+CViW8jwd0dF745J/EcXH+8o=;
        b=IUcBs4+jB7OVEKFYQMvmgRJuFiapJObSqLFd4DaRjfpm1toEvNG0hxTwnFaFrZ3SfV
         lmbI9uJONrlmcb9Bm8TpVR68r/9MuNKq93Jb4dXpbuw6HNfBW0Lb7ECY0tpy68PP94hx
         E5HIctpXp3hvYyuR36iM//SJQzeBWifk7qajumCgeXVTkd0y+lWjG8nRbjW9RI9QxYoQ
         A8sKCsc8oGhjZuW7HxtJ6+aMpyF7BuDojndRw//GkgWZci5ap0uYUb5h4JcwoCOKl6lp
         w7X3tvr+R4z9uB5iDMpp5zYKSC+JupPprFcg539uIyOXBMTJN8V/8+PM8NyQzf61dteF
         /CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCSwqX+Vy/0K/4q7EcP+CViW8jwd0dF745J/EcXH+8o=;
        b=jrYkqbS8UnaASBqbI7sF71GRryOr793WNQVm/LkoXMLjx2oXTL5cyV8+/GVMa1Apzb
         4UZv+50xAufDORoZEDFQXZeaVO/aKi7fjztpJSkMQtk7d5oQ3FD56FT527aQUbLdcMiE
         MWFKmP23L+BUqCbPujizzR+7Dfb4MWtDwLJep8vzlLrBsU5BCLCpxJtYOx6ZUtIondoI
         xFAJb1/N2eAtDiZmTF9IoPdjchsAiIq9RHMq3vsj6h13lHaohZfZBuwkcDHniYwd2jCG
         aTfzze+XaUQ/JJ5df9jgkT+tZ2jXGsC2YT2QkmeY+r4HMcdEalreTnaUCkMLamKecIBc
         OZGw==
X-Gm-Message-State: AKaTC00ObnXVHMZGF1eBB1Hll/CiWwO0ZrqhBpBmiA1W+/LPrhutm1jD+2rKgqBEc1LC7Rvq
X-Received: by 10.84.175.234 with SMTP id t97mr128684380plb.145.1480968981206;
        Mon, 05 Dec 2016 12:16:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id g82sm29409679pfb.43.2016.12.05.12.16.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 12:16:20 -0800 (PST)
Date:   Mon, 5 Dec 2016 12:16:19 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161205201619.GE68588@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <CAGZ79katWewdwU3ZDYDj-QZEeersx9XDPZuTdMJG_u_62YwMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79katWewdwU3ZDYDj-QZEeersx9XDPZuTdMJG_u_62YwMsg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Stefan Beller wrote:
> >  static const char *real_path_internal(const char *path, int die_on_error)
> >  {
> > -       static struct strbuf sb = STRBUF_INIT;
> > +       static struct strbuf resolved = STRBUF_INIT;
> 
> Also by having this static here, it is not quite thread safe, yet.
> 
> By removing the static here we cannot do the early cheap check as:
> 
> >         /* We've already done it */
> > -       if (path == sb.buf)
> > +       if (path == resolved.buf)
> >                 return path;
> 
> I wonder how often we run into this case; are there some callers explicitly
> relying on real_path_internal being cheap for repeated calls?
> (Maybe run the test suite with this early return instrumented? Not sure how
> to assess the impact of removing the cheap out return optimization)
> 
> The long tail (i.e. the actual functionality) should actually be
> faster, I'd imagine
> as we do less than with using chdir.

Depends on how expensive the chdir calls were.  And I'm working to get
rid of the static buffer.  Just need have the callers own the memory
first.

-- 
Brandon Williams
