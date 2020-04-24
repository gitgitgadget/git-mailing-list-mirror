Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560EBC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F82074F
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UptNbmKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDXBJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgDXBJ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 21:09:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A5FC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:09:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so3283551pjw.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YO30+55lx7XbfocjkK/8Rbv97lZRpoYNUqFMhxpr16E=;
        b=UptNbmKsR+cJykHYwX/ms/ykCdRrg89pvjtvvbr9qK0jVgqIqWhAEuQmRkDYXHEo/X
         vC9YrJZSGBKZy7k/qitzpLadXUFkBi+nj4p6vBeSxqGTqsCLQ84mQAIcaddyS0Y62f/U
         fyeWoxUj59j5ywRZe1qzpk2SXtZATDv1CbvO0F7CnQ4rhVJa1xSSnuuKWOL+4XuaKI5I
         +bZjUrabmn1Dlg7V3DqleZcK2/rdMH2NGlMPsOQewoSRMY7YbtCWjWYsYEoYROpGVTIJ
         yORMCJJ2+gEZ10s1GKc7gTJVzRlSkxpFz9CjrAqwuWsC4mfESuCoRM0n6PQnoTc0MV9r
         /swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YO30+55lx7XbfocjkK/8Rbv97lZRpoYNUqFMhxpr16E=;
        b=Zlb6zapL+S4sijdgYFFqbAn/O0S43d1KLFYwaz20p/PmsrqiIgtLUIiONL49zIxdr4
         EGccXYQmnV5kCY4jDKm0tGUjKcLmQLmeOMC9THV9FmC3FG5E1PhoRtF4J5Udl5gXRkRH
         BD1TNX720W7rZxKC1G/vAcEnjvBVBmpsOmPkQwt5D8ADp1mfydlC1jWfh0cVOjMUXXxa
         CGuyXtIdahbdelOBcf1FnBKvxGKpwBsPNTp3UxQz1a0eCkLIz6ui8QBixrY+8cmNjGav
         uXjaeqR8wGzt4k+ezYNLK+0NcyDgGPiysyR7yyMbaWjJYtiJpI9+lSStzZCONRIWj2qJ
         2Wng==
X-Gm-Message-State: AGi0PubKSxiQI9hXNYUU94pbOWUnZGaRPSTKRBekvZsebv4lU4YvJp18
        93lYayfVKyvd1LYtTWMwRiQ=
X-Google-Smtp-Source: APiQypLnQkmP7vAfeTpP4ZEd1767an63RvSTPKSk7uaUAkBVzMCRHGGi35G1f74rrYHL+KqbfRyiBw==
X-Received: by 2002:a17:902:aa44:: with SMTP id c4mr6391027plr.302.1587690566324;
        Thu, 23 Apr 2020 18:09:26 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id w186sm4038641pff.83.2020.04.23.18.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:09:25 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:09:24 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
Message-ID: <20200424010924.GF1949@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
 <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
 <xmqqd07xem9l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd07xem9l.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-23 17:54:30-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Actually, I have a patch somewhere which suppressed the sparse warning
> > for the '= { 0 }' token sequence used in these initializations. However,
> > I don't seem to be able to find them at the moment! :(
> 
> AHHHHHhhhhhhhh.  
> 
> Thanks for reminding.  Yeah, I recall that the concensus of those
> who were vocal in that old discussion [*1*] was that "= { 0 }"
> should be taken as an idiom and should not be subject to s/0/NULL/
> conversion.

So, to follow that idiom, this patch should be changed, too?
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet/

+Cc: Dscho and Han-Wen

> > [Luc, this topic came up on the sparse and kernel mailing-lists at one
> > point, but I didn't get around to posting my patch to the list - something
> > came up. Hopefully, I will find some time to find it and post it soon.]
> 
> 
> [References]
> 
> *1*
> 
> https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/

-- 
Danh
