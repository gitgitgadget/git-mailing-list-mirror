Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C4A207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbdDRVCz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:02:55 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35185 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdDRVCx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:02:53 -0400
Received: by mail-pg0-f50.google.com with SMTP id 72so2276611pge.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=829JjfLFUC6J+f97OpRgxGtl90/3AFsUYdDEUFKtrP8=;
        b=oELSruuR4axmcew3KprgpHc8KAxNoQsVu1VAnmgOLLqKlj2pHIYfOv5mK+5bMMvSjY
         /5eOMxmL+s0zEDBdfElz4zwhnLEAX47RxSkkNXYpVejZvxqMNjBefx0Kmi/avu7j3OV4
         qgr+vdQ+A4yMPoQUU6hQhlHFWsMv8YQl3eMivKdP3K9NrZ7AMs285i58WsM/6DOxKFA6
         /oGC5YtL/a0CuCpgCHhbnsIx6sbLIdrnaYrbgHpC/LQUza5zAdXL8T6NXBX4BVGQH//W
         DCfIjON4ynWzlI9ampHgebFzCnWpzZj2jW1Y8gyBaJvepUHXw/4guz7KUwhVShKobCZh
         RTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=829JjfLFUC6J+f97OpRgxGtl90/3AFsUYdDEUFKtrP8=;
        b=X7Ck/r3hC3lkumWsi6omKMmgevw+Sv5M1D2kp8iNciJUqojMkIX22sljiEjaXqzXz3
         OsoIwejWyMziOTWjjW/lrTbkPjRf2iMWV3RKYLnuEbc/3uXePD8wT20gNvIdqYv8tn/x
         U5ZYUVMDFZnAXOv/SJUPskgn622KZMlHDlG7zhGInv8po7sXTVsCc8I0i4dsbmVoVGxf
         WRKrkLyKmYfc+DVCDGazdT+ujtgYsGPSrk5whibDl+OMog+xg7yPI4FIO9grBJ6MGfEA
         CF1hxI/2lNCk73iOpkJU9DpbOqb+q5IxzdgZEvhhwu6jg00dHNaFZw67zJczByrX/62f
         +OPQ==
X-Gm-Message-State: AN3rC/7fNMaZm7A9qVWu4r6QfIZkKGik/szrYfn4+PtoyLAcdvtRInMT
        ++Wu/tfqA1MxEG2s
X-Received: by 10.99.122.12 with SMTP id v12mr20342432pgc.98.1492549372583;
        Tue, 18 Apr 2017 14:02:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c085:9655:b875:4bbf])
        by smtp.gmail.com with ESMTPSA id i189sm254582pgd.61.2017.04.18.14.02.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:02:51 -0700 (PDT)
Date:   Tue, 18 Apr 2017 14:02:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH v4 05/10] run-command: prepare child environment before
 forking
Message-ID: <20170418210250.GA10227@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
 <20170417220818.44917-6-bmwill@google.com>
 <20170418002651.GA14303@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418002651.GA14303@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/18, Eric Wong wrote:
> > +static int env_isequal(const char *e1, const char *e2)
> > +{
> > +	for (;;) {
> > +		char c1 = *e1++;
> > +		char c2 = *e2++;
> > +		c1 = (c1 == '=') ? '\0' : tolower(c1);
> > +		c2 = (c2 == '=') ? '\0' : tolower(c2);
> 
> Dealing with C strings scares me so maybe I'm misreading;
> but: why is this comparison case-insensitive?

Well i was pulling inspiration from the stuff in mingw.c...looks like i
probably shouldn't have done so as you're correct, they should be
case-sensitive.  Jonathan pointed out that doing this env stuff in
vanilla C may not be a good idea...and I kinda forgot about that cause
it worked (it passed tests) Let me re-write this section of code to make
it correct, and saner.

-- 
Brandon Williams
