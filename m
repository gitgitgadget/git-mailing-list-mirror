Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4002E20970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdDNUUF (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:20:05 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34259 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbdDNUUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:20:04 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so47341026pgg.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aZlFeaEevDXBWNgv1VDodIcuTuTqahngIbuitp46zSs=;
        b=Rhx5Me/e4r90JP5s9LueBH3rS2h4lS40hgAS3KeeaRJQA3MG0P3NxlgNmZdsYPr8JS
         Z1k8mZM+UT10UQijXUcEFI4V/MzzVdSJng2qcXA84mLWUM8lLsU46tM7ZZmlFE9Vq8/B
         NdiHxfUIRa95gAMHe/8HxPqn1Gg1/jxldLfCoDFlpN4jn44OK9161NpEo2zRNW7k5OM3
         d7oSMRXLdrZaTaD4sKrNLGPmFznozhhCm5tmv628aASPo+Qh0e3YYOY8SWi1c6wB7hnw
         LUO4xmwhReg0VnnS9lx3QA9SlT1teUaqaWgd5LPG6oXnvyuE8f3isc7jK4i2ZTfphxdn
         UfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZlFeaEevDXBWNgv1VDodIcuTuTqahngIbuitp46zSs=;
        b=nOyQqgVkH4p7iP1FRw8bk0tnGW45yBCvtD4u91So8md929UgTieaJ7miJMX/GyLqZ6
         2JX2xoPpMVqmAwZ11C6k42wWw4lBNaE0/FOh+Z+rGNiEXZSK7yw5aouMmzLfgi4d8PUV
         tK6KVUeibIPe0qAF2vRDa1N/l+Yp9ktf1ZDcHIQ1rSmLpyLaJI8N0Yhgtai5B6k18WA/
         PxjS1L2KCpLQCiU3RGZk5klmiHEcfeDTG9reK1g+/u1voRRPJt32WH+P+IMaTckBFZ5t
         wJrOLEJgbhwzc7znADYBtmo1ZUpDgjAoIJ51EB00vAX2POH2DoEKRfZluVIe/lgZVCo7
         YGxA==
X-Gm-Message-State: AN3rC/5Ig2XE3nFGVOGXX0pgNHcCDSWiaGMn8X/wYQZopyVX1dhUbT1I
        CZT/YPCAgyqAU+Rj
X-Received: by 10.98.50.71 with SMTP id y68mr8769579pfy.220.1492201203553;
        Fri, 14 Apr 2017 13:20:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:11e7:137a:7479:ecbc])
        by smtp.gmail.com with ESMTPSA id k88sm4734807pfj.79.2017.04.14.13.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 13:20:02 -0700 (PDT)
Date:   Fri, 14 Apr 2017 13:19:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v3 06/10] run-command: don't die in child when duping
 /dev/null
Message-ID: <20170414201956.GA54940@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
 <20170414165902.174167-1-bmwill@google.com>
 <20170414165902.174167-7-bmwill@google.com>
 <20170414193833.GA5290@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170414193833.GA5290@starla>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/14, Eric Wong wrote:
> Brandon Williams <bmwill@google.com> wrote:
> > +	if (cmd->no_stdin || cmd->no_stdout || cmd->no_stderr) {
> > +		null_fd = open("/dev/null", O_RDWR | O_CLOEXEC | O_NONBLOCK);
> 
> O_NONBLOCK?  This was in my original patch, too :x
> Wow, I wonder what I was smoking that day...

And I apparently wasn't thinking enough to catch that!  I'll fix that.

-- 
Brandon Williams
