Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0427C1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbcKQTC7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:02:59 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33849 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbcKQTC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:02:58 -0500
Received: by mail-pg0-f44.google.com with SMTP id x23so91335951pgx.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 11:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N2ZeiBY+TZ6tsTkgmZDavTJsPTpxaGg8RtMO99sJ2UU=;
        b=iLaxjubzDmdUc/HdR8MO1tpWK9R6GK3r0QTjaWPQjeQODj1mHGXrL8j1jybckiK+wt
         seX5NVMqZNSJoaJD43ymBkR4mRdG1SlRHOdw2oSBdk3mTwEx99XLuufcpsbxJYRua5v9
         fJl0n0jBcQX0uZ3NodFRByicYb9t0evCgu9Y0YLS3m8QMpxVdKRnqGl0qgbL+8phleLH
         8C/k0XEDppgrcKMjqFjbb8nt8XP+KK7l5JwXPbt8Vj8g3JGbmUULmXpHoAs735C0btMc
         UAS0t8n1jolp2nY1Jd/kISoCalWB7qmCv4A+5WyWMlSUjnkj/r7qJfprWNOvR9FZfP7K
         MgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N2ZeiBY+TZ6tsTkgmZDavTJsPTpxaGg8RtMO99sJ2UU=;
        b=M3BL0ye/Pi9MzG7Jz5/PIU5ccSozWio5VOhtkxOPp5nyl1m1Ukf5F0ddRVMRhUfzj9
         OOO1iIDhQweFoNMEQZMWbEEDVOBo9INza+8KIiCMdVmsfBs7H9m5/MMhvEX7E9aI9xJl
         UwRsehrtogD7bl5Cr9g2TWUqsDE6+19KOEGQQOvi5xZYyUp6k4rNZM5xQQVaVS+zsZg7
         GuKYiHWxmwNv3NHoacyGj8xAtnM8+XhLEzpcmnEi6CIeOxGJwuzmFug20IlmW3HNHCUA
         C9iF5CSI7X6MjY3N9FcGS2am3ZCeqU9yi/yOH8KyCKtNkD7mTJKTLkiK/hVWihZZJikf
         /2bA==
X-Gm-Message-State: ABUngvcV7HFmr3HpeI+hCAoPth+CbR+2CFqM6tPHIB5dCCxVubbculmJp+ELk82w9nWRxFhD
X-Received: by 10.99.37.195 with SMTP id l186mr10265624pgl.91.1479409377416;
        Thu, 17 Nov 2016 11:02:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:718b:9d6c:8235:ef51])
        by smtp.gmail.com with ESMTPSA id p67sm10019466pfb.2.2016.11.17.11.02.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 11:02:56 -0800 (PST)
Date:   Thu, 17 Nov 2016 11:02:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] push: fix --dry-run to not push submodules
Message-ID: <20161117190255.GK66382@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com>
 <1479408364-150268-3-git-send-email-bmwill@google.com>
 <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17, Stefan Beller wrote:
> On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
> 
> >                                 sha1_array_clear(&commits);
> > -                               die("Failed to push all needed submodules!");
> > +                               die ("Failed to push all needed submodules!");
> 
> huh? Is this a whitespace change?

That's odd...I didn't mean to add that lone space.

-- 
Brandon Williams
