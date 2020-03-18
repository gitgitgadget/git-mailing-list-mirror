Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A386C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422CB20775
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZbfCbJug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCRVFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:05:42 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51098 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbgCRVFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 17:05:41 -0400
Received: by mail-pj1-f65.google.com with SMTP id v13so1884586pjb.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PXNL5X2qKOSP7WMjyUfC7ZMq0nOejKdXY7WIMmi+WVI=;
        b=ZbfCbJugGXrX3rswCzV/1EpBOB4IcLdVnm6yzHGlaPdsBe7w47Is9wM8+uSTQOM4E4
         tfQJvWFW3J/5MK1oQnve/GofKpamCJSMbpIQcJ+6MecMfdxDBCNfeeUa+1prnac08JcJ
         Xm7c7vVrqiO7+KVvPhS5u7NXNzVmppx0sjwc2Gck90Q3MjERQ/7XqSvcHuviftSefrdU
         Oy8j6u3kYVTqaBkkDyKYjMCGeo3NeRECC6sChN1hwuUVkPUE5RHPJKMmdz53uDQUtcu4
         WaLzFjDMNijc5QSBze/I6ITYhGnFN6JxDcl2e31TP4iNgJ8swlAw07KAqPU/Ub3cHd9F
         LBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXNL5X2qKOSP7WMjyUfC7ZMq0nOejKdXY7WIMmi+WVI=;
        b=Pc3uLNhBq+zp4Jbc19vVBuTGjychMzQDBKd9HujTUfOgfv2WtMXHkmcn/SqpPeHkx+
         xXxsCJP2gDz8WiEkwGvtnA1A268TeoZkQloAsm0Dd2qc+fN3K3eVg8OFGafx9tJlXV4g
         koq14uMzSYLTDjhgpCO/ZThJu3J07uDP3R4JG4FZGHLaGlARGxsTfiiWzJkxv7JJefMK
         sO+IGj/cGiPBrAOBy/b5y6pogQRw4g0jO3s04EwuXsu8D/fjVXAiNaoRgYTqGvv6qlXN
         ZpIdbiG1Z6Rc0lWZd/w4xCnwg2Qy7t+VD7ixeReGLpiXphKeDJlohqH/Yut1oVHH4VT4
         8qkA==
X-Gm-Message-State: ANhLgQ2o0fDek6VqXK+ab7k4endqnMZTDLQDLbeNhsXzHHFHxjYvm2bR
        sMLncyNOY4W5NZgO9pTcMNY5MPgZN4M=
X-Google-Smtp-Source: ADFU+vsp8/PxXF6nmOuUjIp/plr5xJuhNJQrwtQNcHyqSQjVXxCsDpaS+A8/78lqzA206KYEMOHjRA==
X-Received: by 2002:a17:902:e981:: with SMTP id f1mr5818448plb.103.1584565540105;
        Wed, 18 Mar 2020 14:05:40 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y18sm7148538pfe.19.2020.03.18.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:05:39 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:05:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, james@jramsay.com.au
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce
 'list_object_filter_config_name'
Message-ID: <20200318210538.GA31397@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
 <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Mar 17, 2020 at 04:53:44PM -0400, Eric Sunshine wrote:
> On Tue, Mar 17, 2020 at 4:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> > In a subsequent commit, we will add configuration options that are
> > specific to each kind of object filter, in which case it is handy to
> > have a function that translates between 'enum
> > list_objects_filter_choice' and an appropriate configuration-friendly
> > string.
> > ---
>
> Missing sign-off (but perhaps that's intentional since this is RFC).

Yes, the missing sign-off (in this patch as well as 2/2) is intentional,
since this is an RFC. Sorry for not calling this out more clearly in my
cover.

Thanks,
Taylor
