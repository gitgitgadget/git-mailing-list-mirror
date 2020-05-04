Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C745C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E522073B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 12:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSUa/IZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgEDMAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDMAc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 08:00:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA4C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 05:00:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x2so5373728pfx.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NVtB7gU9lyhzLndXjulnAj0MSqszWmwtO5VpbRbhSpY=;
        b=nSUa/IZJE8BL9URtsl2MXEbj9Wv1dF8NRylrSIG9HVIbg93LavwJEvZJVmr+blRk5x
         sEiXAjZageWgys2w0CrFcER7uFO5pNMXLNvYU4zEh9vKJ8YIDv1fHSSQ1T0YM4bNeYF4
         zNtaurb3iLtbtb0fEvNUVfU2dqqSjCdsDBAQ7q8rA9bmPvhV4NQZFpVP8rYfEdiosTsI
         C6dckmnYni1a+ydGYd7oKUS6T+3XjMDLe2YVqkdu7tev+YhioWDh9mySF3nyn5KJblXJ
         vKUk1sdsIJoTox78bg/i5sllhLGTUqYIGCw/ukzFVt7My/HVZNdAKKxlPjBLpOKBaJGp
         yBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NVtB7gU9lyhzLndXjulnAj0MSqszWmwtO5VpbRbhSpY=;
        b=Zdt6m2mwpvCvisGCIbendgzKZY3Vt/DgjkaA6oyrm8s3lmb+K2m65h1ZpB6Tbcy1kC
         50qQiOJ0RV4MFgSKx793Km9C4rXN1OvlTdDYxKGBEedeKf+bBEACmeJaH4g3kdGBodji
         sSZdv/siW3ni0ytnffuUnFUHsuBoBlIG1Pz8euB8KQ3OhYq+ockC2VvGFaCTKQ84PsgP
         IZsyXCK8qIe1uOnlaioKOATWbN8Iwk18vdxbd74hI7Of2Bja4tGzMw5DbYQoQXbxNwkG
         8AMnp9D8b0d+up53TWC/gATlRbx7Hi7PLRNLohn36rHR47pChseIpRKqvYADQgUy/ZSx
         2Twg==
X-Gm-Message-State: AGi0PubKFRtvrCx3zD0o8ehC1oms02WISvdSEPigM6QaNZbik9I7F/H2
        eo4fxx/JJ5um0QuBcDPxIrg=
X-Google-Smtp-Source: APiQypJfTj0Qbb7gsgnfBDWU2K6bmr0wuxwqrtisR/6chhThcM0SR9h8Y4dtsJ04XUTV0gD9wAMXuA==
X-Received: by 2002:a63:511d:: with SMTP id f29mr17122427pgb.212.1588593632105;
        Mon, 04 May 2020 05:00:32 -0700 (PDT)
Received: from konoha ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id y6sm1790579pjw.15.2020.05.04.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:00:31 -0700 (PDT)
Date:   Mon, 4 May 2020 17:30:24 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Ewa =?utf-8?B?xZpsaXdpxYRza2E=?= <kreska07@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
Message-ID: <20200504120024.GA3372@konoha>
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha>
 <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/05 10:11, Ewa Śliwińska wrote:
> Hi,
> 
> thanks for your response.
> I consider what you propose rather a workaround, while it is really
> important for me to get to know what happened here.
> Could you help me investigate this?

That actually was a solution to your problem, not a workaround.

> I though that I might add those files accidentally before. That's why I
> checked it, I wrote about this in the original email.
> Did I check in a wrong way?

If we go into detail of what might have actually happened, the `.idea`
folder must've been tracked before getting a mention in the
`.gitignore`. Now, the thing is that `.gitignore` ignores only those
patterns/files which were not tracked since their addition in it. So
most probably, this would have been the case with `.idea` as well.

And yes, you might have added those files before accidentally, maybe
when you did a `git add .` or something alike.

Regards,
Shourya Shukla
