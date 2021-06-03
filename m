Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D63C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AC9613B4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCTDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:03:34 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB212C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 12:01:35 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so1647754ood.2
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=2eMX4VXoQd/lJ6q1QT34axIzi3U6qA0+kDgRwnxVRlc=;
        b=DNT/W0REWa403ByPA44udQadO0aN5oSwt4+PUarIWxQqTzLgODhCbG+DF4p/6HzNc6
         hhQICtLmHwypMHByYWGmRfb2+CqdUQ4NdkRi9VVI1wwyVniOuT/n3hlnej+XJYM3Zm/A
         Ld6C51Djhzj8kLrNkMlhaYJES32DJ7cIMkweslaY+YnKQvuN5kNwsw+VRa5BUAtBBG5i
         hOmhhvdtqB6d4FueYp4xs/p+qKCkUOqBE4hE2o/Q+6WXqDLJPztMJksmfxEurcviFpw3
         LbZ6/kJO9rdgzksVvFHLxkJLPFGaGldVlyWm3gz8BfwlcuRekzWDq5kln+WcvuaQMc0z
         h6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=2eMX4VXoQd/lJ6q1QT34axIzi3U6qA0+kDgRwnxVRlc=;
        b=aCf2auVhWaVU75tOitYzmov3bQfVi7xnakUVzRJurEpljCH3I6Xufq/AJUMZ3dbDx0
         iEdcRR10DSDBcDC0gehNcmTk5SZhphZk+C1JPhNhXP47ItMR6Vw9zSu7CIo5tabMkNMJ
         WKiagx8m+ys/Ko96HyJAAGXCGYV/UqD3+qBpip/GgS/EyXWygDWjvyEgAydSwTxClGIt
         z8IfJmvumN6/51jDmnbIwVwi9Cb20mpdgd5RwdPkUkdkQcFkfZ7RBGWrBFPw9Z2dPApJ
         MMA3EF9E9Xldw3OLPbHYgDe8ZyRrshkcc6mWM9Miex6RO10SQxuZE2vLmicTApcLQLhe
         bPKQ==
X-Gm-Message-State: AOAM531OmDLY8gYGof4BQhKQy2FhOyhyN4GT4Bk2EUcufgSxk0nOQ7F3
        6D7DXex0mVsvxfDhLazvHY0=
X-Google-Smtp-Source: ABdhPJzm1akrkOFReHUTetI/lJ1B8qdTvK8VklbOfCfnl2Si8aJ6qLnJRq6aqCmvoRUAaQ4tugs6Bw==
X-Received: by 2002:a4a:e1d7:: with SMTP id n23mr607097oot.86.1622746891362;
        Thu, 03 Jun 2021 12:01:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b81sm884652oia.19.2021.06.03.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 12:01:30 -0700 (PDT)
Date:   Thu, 03 Jun 2021 14:01:19 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Message-ID: <60b926ff6ef35_39cbe920875@natae.notmuch>
In-Reply-To: <874keeyfl5.fsf@igel.home>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
 <878s3r73g3.fsf@evledraar.gmail.com>
 <60b9158f92812_258801208e0@natae.notmuch>
 <874keeyfl5.fsf@igel.home>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab wrote:
> On Jun 03 2021, Felipe Contreras wrote:
> 
> > If Google requires a client secret, then it can't be used with open
> > source applications. Period.
> 
> https://invent.kde.org/pim/kmailtransport/-/blob/master/src/kmailtransport/plugins/smtp/smtpjob.cpp#L31

Yes, they are doing something wrong (puting a *secret* value on a public
place), so?

If somebody were to report that to Google that app probably would get
banned.

-- 
Felipe Contreras
