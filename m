Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C5C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 00:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCIAuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 19:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCIAuD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 19:50:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B87043A
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 16:50:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so3542277pjb.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678323001;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0a/Oblr0GLcuonijjWHOsF1DEXRb8X21t5VnxcZ5U1w=;
        b=I9P3jib9Cg+cU35cCo0jtQqCAS+p1fJ+R8Um7fEYb6XhOTdBKInIEqqQSUiBLYUSyY
         gPvDiUhZPcumINqIpSY8HTLCeUuhuEZ3BmLyXE/QwH/DBmQH6DidXsczsEjHVAA0TZQP
         I+ctAR1JjiNoqRFJqluX8XQJbRvOU+sGaUGxw9kARYvhWAb9mrqSQ9zYynwrd1yDjC99
         HJOpqmDRvkw13OYIuHY/tQcS/3GeFK3pZWzhmQu50mWCGmW8kbqtc/rFbs8pe0gbftTP
         8xvcov+2G34+1AF+3ebgJfgQzqMBBwxYZ7TgZ0q3otkHU1gmGK8IYtjyk/03iRMOZtL7
         GZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678323001;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0a/Oblr0GLcuonijjWHOsF1DEXRb8X21t5VnxcZ5U1w=;
        b=RUEqLhDtfyjOKfmnI8aUDmUuNMbnMp+wRy9vdf69stzUHLkXiHWonoJfb+J8z+mdJK
         NmbhUmUJK18FUEceXeYrrV4cgrdwa0NPWeFH5KSrxpPsCngvC2/UdY9ug9EqhUHlJxdz
         AUU6zx693DyfBm22mSOEZzdmFzM0MLhVVhgy0zdsP0WnKORzvVwyRB3wXi1PLuypHt+t
         gH3uWTkQCLNO5BOLOtQ4vL7rdX+lvOs39p79bDyw5Rp3PWR5YPVEqsdKAWRsvgNZBQId
         Gwl01HNb9RLfX460D2B3q9mWcV2RBUT0avKUumEKqqOP0e5m8eW8jJxNCaPQIQsS/PRh
         RnCQ==
X-Gm-Message-State: AO0yUKVjHRm3CmcaV9eKaIBmyMvoXHIJYYejnassVwnnK+zm5TFIfaQ0
        gAfprUCBFjbiDOLi4Vnaeg0=
X-Google-Smtp-Source: AK7set+6jOVC4UrzUSfRizgVP9ifaKkzzzfPQT8nwp/VIPVAY/UvFf2Fw8BXWNssXsuxsQfTqy2VlQ==
X-Received: by 2002:a05:6a21:6da0:b0:cc:249b:7b22 with SMTP id wl32-20020a056a216da000b000cc249b7b22mr21463572pzb.30.1678323000891;
        Wed, 08 Mar 2023 16:50:00 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b005d55225fc07sm9900386pfn.73.2023.03.08.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:50:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jay Asbury <vbjay.net@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Writing to err vs std
References: <CAH74SFS3hFzYzJ6eb2YenJh4-Pf_VBzVTo8axnEtHDyaJUB-jw@mail.gmail.com>
        <xmqq7cvqrdu6.fsf@gitster.g>
        <CAH74SFQ9A-hcRfrDs_vE-QhhYTB6V=dbBQQM_0Qdbx88XREwpw@mail.gmail.com>
Date:   Wed, 08 Mar 2023 16:50:00 -0800
In-Reply-To: <CAH74SFQ9A-hcRfrDs_vE-QhhYTB6V=dbBQQM_0Qdbx88XREwpw@mail.gmail.com>
        (Jay Asbury's message of "Wed, 8 Mar 2023 19:15:31 -0500")
Message-ID: <xmqqttyupx3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jay Asbury <vbjay.net@gmail.com> writes:

> Thanks for the clarification. Some context.
> https://github.com/gitextensions/gitextensions/issues/9643 which is a
> side effect of https://github.com/gitextensions/gitextensions/pull/9562
>
> So I just wanted to get some clarification on when err vs std should
> be used to eliminate confusion.

I thought that the practice to equate an error with any byte shown
to the standard error died long ago with Tcl ;-)

Thanks.
