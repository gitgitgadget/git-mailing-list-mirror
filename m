Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F9C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C5D217BA
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uootwTDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGNw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:52:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39902 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 08:52:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so2854061wme.4
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=//ucFbbVcumdczs1XHddo3pYcdhwPj7OH3tPqesAovA=;
        b=uootwTDhWkf4qeteQJhMeDawifg0jboO5ro4h4je744jnMQAixVPJi2Eahnty4EGdC
         8d7iQ1zhyzM72vWHJ6By/4U/CnQzTkctOEr1gRFOzJnpxOx0+x916xmLKdFVZf9sCgTO
         krekZuUkOJJJu11XqXzX02ZdahMNXEF23B4IvwmtnFAvQZo8LZhJHOn7mW9dx4aodTgS
         nxXbGFwbn40DklZUEJSZjMTJew/2OvKH+E+kYL1IonOeqDeYZxW6J3EVjUNEkDueJc5f
         Yaz7y556zomby/2R9l4acrMnmBaEp5qdrgmyfK8cK/5KBWobDFGXv7p1EpALOaa1e0/E
         XTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=//ucFbbVcumdczs1XHddo3pYcdhwPj7OH3tPqesAovA=;
        b=P9Xac0O8wI5PGAAqEojna5udS5Qf0/oJhtE0UQabapJoB+N4HOZATQTvG/Ze19S47D
         h/Rde1l94dDbYC2DDYYrd38oH4vn82U2mT0FgvUwBXS7a1YUyd+8LL10supvphRHBT+M
         lTjVeGf1U8DmP/vTwMsaO6dTZP5YWHOZ5LRAN6FUedOIT1YKOW1I3cGpVkBxpWFXKZb/
         4S5Pje4/dwh1U5p43mLm+fuDwbEQhtj/dK2SFhn+MbCl7CFl7dY/yGPUL3EgdaYGyP+m
         1O8rloZuCIvD67Bkm2FXJ4cGbtEgq7fhg2HB/78jXrrEThdk0BAN5NVY+CYgDL22S2ts
         F7MA==
X-Gm-Message-State: APjAAAWQSwOTLejd8As3F5tSXEfYBeYN/EzsnOPZLP+DoKATqK8AP+z9
        8FBBTIx7jNTGwe48cnXr33A=
X-Google-Smtp-Source: APXvYqz4xtoSub1sGoEL7PBDLgc+QjwCojZ/pSrL/DypYEcvLWMVKPrl5JzPAz32Q4IFHTn8QuNsUA==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr4427758wmd.7.1581083573522;
        Fri, 07 Feb 2020 05:52:53 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id w7sm3276714wmi.9.2020.02.07.05.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 05:52:52 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:52:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
Message-ID: <20200207135249.GD2868@szeder.dev>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 10:56:19PM +0000, Garima Singh via GitGitGadget wrote:
> Hey! 
> 
> The commit graph feature brought in a lot of performance improvements across
> multiple commands. However, file based history continues to be a performance
> pain point, especially in large repositories. 
> 
> Adopting changed path bloom filters has been discussed on the list before,
> and a prototype version was worked on by SZEDER Gábor, Jonathan Tan and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's proof of concept in
> [2]
> 
> Performance Gains: We tested the performance of git log -- path on the git
> repo, the linux repo and some internal large repos, with a variety of paths
> of varying depths.
> 
> On the git and linux repos: We observed a 2x to 5x speed up.
> 
> On a large internal repo with files seated 6-10 levels deep in the tree: We
> observed 10x to 20x speed ups, with some paths going up to 28 times faster.
> 
> Future Work (not included in the scope of this series):
> 
>  1. Supporting multiple path based revision walk
>  2. Adopting it in git blame logic. 
>  3. Interactions with line log git log -L
> 
> 
> ----------------------------------------------------------------------------
> 
> Updates since the last submission
> 
>  * Removed all the RFC callouts, this is a ready for full review version

Don't know when I'll find enough time to properly review the series.
maybe someday...

>  * Added unit tests for the bloom filter computation layer

This fails on big endian, e.g. in Travis CI's s390x build:

  https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/647253022#L2210

(The link highlights the failure, but I'm afraid your browser won't
jump there right away; you'll have to click on the print-test-failures
fold at the bottom, and scroll down a bit...)
