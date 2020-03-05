Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74300C3F2D7
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 22:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A107207FD
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 22:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="j2p4FlNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCEWJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:09:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCEWJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 17:09:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so90802pgr.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i8aaBYvAD+7LvinzQBrYDlrCuLdrebsSYRPR3ehvb9M=;
        b=j2p4FlNyOxh7fBluThlvq0OTQMcKSsn7lNVsA+QDWNPCRACHgLnIdWgKdoAx1g/Zhe
         AsUqPmh9dHH6ojHLaTfsQ5V6b6qIB+5masWFGR8AVqGLkkBy5yJlKC+x5n99HbccM3cJ
         kZJpVv3lfbxQOFugSiZk8tb3EziHJvEVrRtHPXlysGjg/J4E70tK0tmQrYeRgUUpApAm
         Ud1U5JyXchnkLrb5IEQSWAts+B1aZ/M7EcfBX/obPF9DBKUILYGxxvct5YW67xbjraCZ
         wLzsVyET5NAJBqdGksrIVactcDiiFebzJSzHHZ2Nl4i9BaKIQUgqw3LwfVlKYPk9pGWP
         lXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i8aaBYvAD+7LvinzQBrYDlrCuLdrebsSYRPR3ehvb9M=;
        b=Ii0SOXiieXeC3H8uitypPPrZxaccuUKhuP17w8dMqUBPYgOqVthxTrVVLF+GOwj/5F
         n4Tsd9rayBAb6lItFL4DUo/fn+AUff+s1bdgXxrD2g7664O1MZBOEdu3c9QWj/ylpznq
         tVnr1hkEq7pGn0oDr34vGms2c4IjqO8Oqwnz9oY5ozIgkVP5QKv8+CgSelMBOOzvKKXr
         ukoMLUqgbyR0xUzy+H9F2ai5AW93DHXjmARssqpC4ceHCNHbSiQFfWePpeMefMAmACzI
         8RXxCG/+x/7wkuLW2tjmxziNUw0gWHtotl+7pz6ig6JOt1QgxzXXBeX0Bnyw0JhNZ/M0
         GLLw==
X-Gm-Message-State: ANhLgQ3m9yU565rQrdi5vOtttNoXkuBlpSmf3rMKgiopysWI6uyMn7Zx
        1jTjhg02OatncBwsXccqyHwwFdh3Js0=
X-Google-Smtp-Source: ADFU+vuhtnbwOp4SfmsDriIAUEw1ldis33w66FnTT65MEVft92zbEF8+o403vdslU5RHaAXUg+dELg==
X-Received: by 2002:a63:2323:: with SMTP id j35mr245989pgj.440.1583446140640;
        Thu, 05 Mar 2020 14:09:00 -0800 (PST)
Received: from localhost ([2600:1012:b043:a67e:800c:c9b0:dbe6:ad23])
        by smtp.gmail.com with ESMTPSA id z3sm33295840pfz.155.2020.03.05.14.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:09:00 -0800 (PST)
Date:   Thu, 5 Mar 2020 14:08:58 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #02; Thu, 5)
Message-ID: <20200305220858.GA61427@syl.local>
References: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kv24fzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Mar 05, 2020 at 02:02:51PM -0800, Junio C Hamano wrote:
> [Cooking]
>
> * tb/commit-graph-split-merge (2020-03-05) 3 commits
>  - builtin/commit-graph.c: support '--input=none'
>  - builtin/commit-graph.c: introduce '--input=<source>'
>  - builtin/commit-graph.c: support '--split[=<strategy>]'
>
>  The code to write out the commit-graph has been taught a few
>  options to control if the resulting graph chains should be merged
>  or a single new incremental graph is created.
>
>  .

I noticed that this didn't quite make the cut for -rc0, but I'm
wondering what the status of it is, since I haven't seen '.' alone like
this in your mail before.

(It may be that you forgot to write the thing that was to come before
the '.', but I would like to know what its status is either way). In the
last What's Cooking, we discussed [2] going forward with it, but I'm
happy to wait until a later -rc or release if things have changed.

Thanks,
Taylor

[2]: https://lore.kernel.org/git/20200303230554.GA11837@syl.local/
