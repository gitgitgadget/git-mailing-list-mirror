Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E5C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE56622241
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6Rsapad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgJ3PZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgJ3PY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:24:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070DC0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 08:24:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v5so3216930wmh.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=f9qZsLrWcLdWi/d5T0AA17TEiHDmZsx+2vfUGKazU+c=;
        b=h6RsapadcDHCZ0dgh2ucNh+mH1JXQsw9bK+eTcilLjo1rO/vGQMc88MqmIL0ESp35R
         2KKB6kvNB9dF8sA67U9PhG5Xk3klGYhO6waLimS0QkLYCH+HmYctvpL5t+9lv88IWhCX
         rbqzw3Lwm1UAzJrC8U6Kh/esFcjI5K6NBVdRCiXnuBuD2jwAOUD5mLXxEKwDslneLRhF
         1vWunH2AvxqZzjq8hlHuS9rMrP4OTttd0QdHmIWnLSa9znWYnkqc3BSDtD34DZCMbr3E
         FSe3i699KiJdLJ5Zy/qysO3juhansXu+dajCiCcOmFVnTbSnV1w0Gqu1P2MRXyzAIyRc
         qXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=f9qZsLrWcLdWi/d5T0AA17TEiHDmZsx+2vfUGKazU+c=;
        b=E22XQCM68eiCPHY6LSWHX8XbKdG1SFMxQxKTDK4lsWeVD/x5FQZ9tEgF52x+ef9o61
         z8VNIR+g+Xf5//NUoPoQfMlBimabgc/BKf37Y2iuhD6+5un5mYXE4ohaqbUIPz99rOgK
         dOQ7GUVvJNdOFDzsB7VQDZQVCnOlt5/paL0eJByTaxsk6eCeMBgm0jGejRLOlU14Ffg4
         H/gQNkNXY+E6fyQKzlUVin2yC9lS6zu7ijUSg38qOG2FCE8rC1q33naBHqKh0eqGLoE6
         sOVrpRmEmwXKzi7d7N7XhVf3IqHUXHkIo5eCDc99hHG9UE6bbc8h8BtPRs9caWz8dVyA
         WabQ==
X-Gm-Message-State: AOAM532YImMDafbvcm764qvmv8OsFmfYRPuDfsn4MSETODH+hZvZpXp2
        /a0RH0P80OvDvUMmNo6gbN/RgeioHt151g==
X-Google-Smtp-Source: ABdhPJy2ukDsTtpB4ctRXxeqaKdBpJUx+s+KAtrj4Da3M8dFStfov3UK9w7iPcrKW0cx73b0cbGbSg==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr3250183wmj.176.1604071497497;
        Fri, 30 Oct 2020 08:24:57 -0700 (PDT)
Received: from [192.168.1.66] ([46.98.123.221])
        by smtp.gmail.com with ESMTPSA id x7sm8320611wrt.78.2020.10.30.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:24:56 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:24:49 +0200
From:   serg.partizan@gmail.com
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Marc Branchaud <marcnarc@xiplink.com>, me@yadavpratyush.com
Cc:     git@vger.kernel.org
Message-Id: <DHT0JQ.CD3G8694SGVA1@gmail.com>
In-Reply-To: <95c91585-5249-b0cd-bd06-a014e8770d37@xiplink.com>
References: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
        <20201029232816.68285-1-serg.partizan@gmail.com>
        <95c91585-5249-b0cd-bd06-a014e8770d37@xiplink.com>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, Oct 30, 2020 at 09:58, Marc Branchaud <marcnarc@xiplink.com> 
wrote:
> I think our emails crossed in the night somewhere...
> 
> I've found that
> 	git-gui*Text.Background
> in ~/.Xresources does the right thing.

Hmmm, for me this doesn't work.

But, if I define it like this:

 *vpane*Text.Background: ...

It works. Probably becouse root window name differs in my case, but I 
have no idea why.

Considering issue solved.


Probably, this can happen to anyone on Kubuntu (or maybe KDE), but 
don't see a way fix this on git-gui side. If something is changing 
theme colors using `*.background: ...`, this "something" must also set 
color for git-gui.


