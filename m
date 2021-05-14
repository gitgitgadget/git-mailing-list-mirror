Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC6C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04C361285
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhENMZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhENMZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:25:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A388C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:24:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso26283928otn.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ufAuZ2scmEGCDTLrqSnEoTxEsw9DSb+f+cLyaxrFU/o=;
        b=hQZnaQSzI88nKEVtKOBbjrAiDgnE0JUOKKaxZqM+ZU+MiBGFG79OT0rzRUiIRYVXfe
         d26sZqDo1/4Y/4BFy4msQvKSGLm+8/k97/YzF0sBK06h9ENcd5ilEbMxhxOSXFE3uhCL
         gAR8ynT8r7rFUMJQ8S+dLJ2nTHfNpLaNwengDL+bf6+nzlsiPX7cBcG9GEBuoSe5UbAC
         SyFYGh2pfJwYPG3m4jsOnCPalGYRy3fx5E6+X2pkBEAsWcEGKGmUJtsU1JmnmiyER+BN
         n4g5XuvlC9CHS0ksFiyJ1juiWkjGm73QNrwZ5eYzyIDVOc3wZ4tj0sI2rYOTR1US74w9
         PvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ufAuZ2scmEGCDTLrqSnEoTxEsw9DSb+f+cLyaxrFU/o=;
        b=KqgxpFdcytL8USJU0UOJgM8mc9V8sE6DSo9pxqjo832Ts+hbvmlRVfY9OWeZXWqcMe
         cBGePVh+wEV1oP8y0bUPRzFNaiMjp2TN8X1m6/E9zNwitDaYbvpMu1Y0Uc8D5Or10UqF
         IRXO7gHpD0CH3qJoqPH15pT39EeEbuj00Og/YeqQhWRqGSLApAVZWof8rSGJLQLoboW4
         e+yYzTnEWiXPPAZKiCJbCU5maMQrhzodFeu3J+N0aeJmbuAd6CZDDE1nRgnpsuJlBppZ
         jjKO9/rhvjB55wQ3F0cw4uhIJLTtt8ildxMWzFkX+udJmieHuoAfBd1J8Lr0JB4wHu/Z
         dkjQ==
X-Gm-Message-State: AOAM5301jY94GsztGj41Q2e6L/sa2BEvH/d+JvuAo96s83sWEyqIdxAX
        3gwZNZVWYgkiS5DuQjQsqn8=
X-Google-Smtp-Source: ABdhPJyRYfOMKvXuWezOG6KHg7DUql/MxiTn9riBaH/IpW0ZXrv5s4cfmDUtsvGXytPYTZvyBYtt1g==
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr24169882otl.132.1620995051504;
        Fri, 14 May 2021 05:24:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w25sm1338331otq.40.2021.05.14.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:24:10 -0700 (PDT)
Date:   Fri, 14 May 2021 07:24:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <609e6be4bc14d_4312720861@natae.notmuch>
In-Reply-To: <CAN0heSoK5VfP68Us2e2bwSfTzY=5FBEBjxuTHRXeA_qg5MH65w@mail.gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
 <609dd5171e7de_19566208ca@natae.notmuch>
 <CAN0heSoK5VfP68Us2e2bwSfTzY=5FBEBjxuTHRXeA_qg5MH65w@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Fri, 14 May 2021 at 03:40, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> =

> > We should be submitting bug reports to the asciidoctor project as wel=
l,
> > so in the future it's less likely we find ourselves in the same
> > scenario.
> >
> > Preferably the bug report should be in the commit message.
> =

> I don't have an account with the website they use for their issue
> tracking.

GitHub? It probably takes a couple of minutes to set up an account.

> If you want to submit a bug report and post the link here,
> that's fine by me and I'll include it in the reroll.

If you would rather have me act as a proxy, that's fine by me.

Just give me a simple example that produces the issue.

Cheers.

-- =

Felipe Contreras=
