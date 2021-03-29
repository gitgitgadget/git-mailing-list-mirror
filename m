Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CB6C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EA660235
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC2MPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhC2MPa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:15:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A28C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:15:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so19029644ejo.13
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHJ6fcSglUASdAl6QO2RL+3+1qMlmw+UNHVZ1O1ODMU=;
        b=CIyANWOTdsyvGnvbSf1eYDHXiBLcV/IEMsn99eR1ptUO2YKj+9o4t3RCnrglsU24wE
         qsAiU3g9wvdngi+xOOqdyee7Nz0xTkTNWhVG3T0dYbBUJzjxkQuFepRg9i+A4SydTT/l
         1GrBkgy7El3GiNvkvQZdhXASjz/3qWcH+yyNhkIDlgg5YUVolJfDrS9YXjhr7ywceVXH
         e/C3B7/XWT7G314WBE7Yk9QSEENLXIiK2+g/+K1IxR1pL9K/yJGym4ApqUMEb+Tzkpeh
         sa0v5s4guhKI3Sr33n1QhdECJcvSmptwNhk4XuDLYksyYz7ggy2sPIxBa5VOwUCygX2g
         pJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHJ6fcSglUASdAl6QO2RL+3+1qMlmw+UNHVZ1O1ODMU=;
        b=KWO+Zyb0WpTlY5tgyw7m5vg46gEj125HXo45rKdE7dJelN2wqFV2UAbCifvnqqmoIt
         CP+tDYofZeSWhQ/9AWLjjdksbNOtpFXjGXND7PpYcQ9r6mzEL4JZGtDsqtlzTo8M1oN/
         8fZSS5ydsEtIo3v9CKgcWC7hxb3MykMh0QNw8Mq3vpywFPQMV2SHa6v0nRNsExjLn+/M
         lGBfkddU8s5ipxMyHYHUSwXKzAYCCIPCg3UW+n1v6+eYP7e1SO+qAWqAlfauVFRdM0SM
         RTh+s/xCJH0txcgq1U46Gi2lQP4J7eQ7VL4gdhDU8RHAvCxDrQwq3CIEI03yz+pQ2qU3
         B8sw==
X-Gm-Message-State: AOAM532CRxSEj4Wk6/U1nMQ1ZgdImYS+A1majYCizo+H1blkHGkakN6m
        JT0Odk+WhnHZ2W24Z1kG7JGIeWh0bP+lrye8SNJ2UAOUM5k/VA==
X-Google-Smtp-Source: ABdhPJymaOYZHAzMzH1WQryEjWhRh4A3HuRGJyHZNk0AvyxpOAIYZWI3D24uRU5SZzcUwTuqQmaQE2QbLqnf05Bh/h8=
X-Received: by 2002:a17:907:68a:: with SMTP id wn10mr28539935ejb.551.1617020128490;
 Mon, 29 Mar 2021 05:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
In-Reply-To: <0e32b0af-cd05-39a9-51a9-4d983e7085cc@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 29 Mar 2021 14:15:17 +0200
Message-ID: <CAP8UFD1TmckvQLVQ7eWMKakMKOF76J+Z+E25vUCGkWveXMWv1g@mail.gmail.com>
Subject: Re: Upstreaming Reviewed-by to git.git
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 29, 2021 at 1:03 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> I had reviewing patches here, but how can my reviews be credited with
> Reviewed-by tags to the applicable patches on git.git (Git SCM)
> repo (upstream)?

When you have reviewed a patch or a patch series, you can tell the
reviewer you are ok with the patch or patch series, and that you are
ok with them adding your "Reviewed-by: yourname <youremail>" to it.

If you are applying to the GSoC or other such program, you can also
put links to the discussions you participated in in your proposal.
