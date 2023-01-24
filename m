Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7CC25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 19:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjAXTSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjAXTSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 14:18:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26A94DCE4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 11:18:36 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g16so2001661ilr.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 11:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0s4glqa4eS4tuwgUxOmf1OYeFQ6bitnyjQM6p7n3Mlg=;
        b=uwXB6qZjWWnzcn2GTs5ObLzYbM91Kb6/WGesz4IDVhPIHTFDOD2JOgeWQYfgb/Kdce
         iSsRmEWYcrGDNrd492OOMi3soNqnIAi5ShuprTG7DGPv07pMzJpdYubw9YnNiKO8ZTPj
         YrpJvvC0vb5/A4yCGEUisOEfZQPY5S+FKmJ8cB/xxGtScA87mKwS75CVtPrjpxZI9Tkv
         af1a67bUieBkkVCIxorfOJ5+R8jjpS8hNoBp54Jlyb0ohmKiokowu4/RPJFuzoQD8cqq
         vA/IrMriMy2ZR8XCNPFRY7G6/9AIbmzyNlqaWbV/hdHN7F1lodZkLNkqK8oozVjJFWr/
         Uf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s4glqa4eS4tuwgUxOmf1OYeFQ6bitnyjQM6p7n3Mlg=;
        b=wdRdAoYe8Tmkljyg5YIuOIRs6dhu6SF6LQZgtPYy3zeObsk+2cY0CH0Ws/10Q4QokD
         z6LEEW22UT6V1fGOIqiQe4s/Q11k6heysgukZFDJyqEm5Mbpf1ywXq5Ic4vfx7cFlOzF
         qNhDf5fJFstth7SWIy/DVNDCHAv8zRmytiw74EFHNHy/lHw0BjawcJuuvtZo0pMBsRDf
         ATMiN5Mt6RxhI0NXZ4ToXf75JroWBrqyPqRVXy/vpd5+rcC7WHgljlTbCHa0qoNpf9KQ
         JRhMU2QGU1pku4lPMyVbIPT9c9Nmg93FX0v7eTiRI11egqkp5eVFM5JRNQDqkLwpdCxy
         7jEw==
X-Gm-Message-State: AFqh2koGAjrhEtmXDxl0nwZN43v4dTec4zS1Gcf9t3vtTJdmBWlBPy3h
        n5Sk7McnGc9bq0q4Ns8gmkzDng==
X-Google-Smtp-Source: AMrXdXsOJRXQ02Miv9VRI2q1VbebUfONHk81k8ucgMe+2TxiVfz+RtKoeMhszn1dCxcJb7cWLKlPmw==
X-Received: by 2002:a05:6e02:2194:b0:30f:423f:b979 with SMTP id j20-20020a056e02219400b0030f423fb979mr18325871ila.19.1674587915899;
        Tue, 24 Jan 2023 11:18:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f21-20020a056638023500b0039e6a310d4csm932036jaq.110.2023.01.24.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:18:35 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:18:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: GSoC 2023
Message-ID: <Y9AvCPC4+37XIZug@nand.local>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
 <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 05:38:31PM +0100, Christian Couder wrote:
> Actually you were already an Org Admin last year and it looks like
> they didn't remove people from the roles they had last year, so you
> are still an Org Admin.

I think that puts me in the same boat, though I can't remember if I am
actually an org admin or not. If I'm not, and you folks need some extra
help, I'm happy to participate.

I am going to pass on mentoring this year, though. It was a fun
experience for me last time, but took more time than I had planned for.
If someone needs or wants a co-mentor, though, I'm happy to help there
as I think it will end up taking less time.

Thanks,
Taylor
