Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF1C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AA26109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhFPVGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 17:06:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216BC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 14:04:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso3937973otj.4
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uB5rkNdMxqBY89f6UC54hY5z7lypdN7lmjTjgDquUO8=;
        b=sHOXnsytSnS6v8hmheG7QUhW0BjKo+t+Lu7l3q7v8bhMxONYxUK4PaG1UaqGKwHct9
         P5lPQRAEyYFnb5LJQmC/AtxzTk8xcrqveW4pIahY7OlxqTX8ws/LxyOgtWulfXy26QwL
         2xFLl7aPUEYkEPr+QktRrHoCvNCR5gLCPzVycC2YZUgfQQ3QkqEz8Gyw6zaP9R3hLkVj
         /yH60pYTvYMwCKcr1J5DcpRiwE3d+iOVvw6uLcR45+5zCl/hSCg6RPCvHHJ0igJ0+rZC
         ZfVbMTFYnJiuLqsCiJSU2MURJXlA2/fnxi2upVErVW6MNTiLSYoPe3OA5mkGreAJIZz0
         9fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uB5rkNdMxqBY89f6UC54hY5z7lypdN7lmjTjgDquUO8=;
        b=uOL5vsaJWVzwJRALDlogXSLi+2e5sjZC3z7MplyCZYOrgCske77lhh5/2JsOE6dP4r
         Xa9rb9SymgSj4pTgkjaT5KLPMXkonIRkr6GICmDYkaEbeVPuczpbK6Xu5YCLbDztXU0A
         VME9Q3WgzSn14Ky+cnvap1X2pFLw963mhq3RDWbIoahIbvHOLWce92sV15n69E81pV14
         frR8dKQnD4TUC/5UAYWoIlppL3t6kSpL0byvAUsS7eRRpc5K3Lw6WazMl0pHjSh/k+YE
         9NNchLI+R4xvM9Z0VPLXC5UwdOpV7aCi7dV/7KrESIJ/FQkhigUC7Sik9fFTULTdYYIV
         +t7g==
X-Gm-Message-State: AOAM531BiB8cWKCIqZubdSoQD0DJfq+GCro+jGrhrmCByo3QctmQj4YB
        vPCMUABgmJcZq+u/tFNV4h4=
X-Google-Smtp-Source: ABdhPJxE13mMKUUN6A63kMh5CzFesVQA62km9iTotjYOmAVbN+PTIdJK8l09wkqQPwcbks9qIJcT7g==
X-Received: by 2002:a9d:6d8c:: with SMTP id x12mr1544076otp.121.1623877450223;
        Wed, 16 Jun 2021 14:04:10 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g5sm721788oov.43.2021.06.16.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 14:04:09 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:04:08 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <60ca674883abc_6027208d5@natae.notmuch>
In-Reply-To: <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
 <8250d8af-2d52-321c-36a7-d71c29fc1ef1@gmail.com>
Subject: Re: [PATCH 1/6] gittutorial doc: replace "alice" and "bob" with "you"
 and "www-data"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 15/06/21 23.17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > -Suppose that Alice has started a new project with a Git repository i=
n
> > -/home/alice/project, and that Bob, who has a home directory on the
> > -same machine, wants to contribute.
> > +Suppose that you've started a new project with a Git repository in
> > +/home/you/project, and you'd like another user on the same local
> > +machine to be able to contribute to it. E.g. a www-data user to serv=
e
> > +the content up with a webserver.
> >   =

> > -Bob begins with:
> > +As the `www-data` user do:
> >    >   ------------------------------------------------
> > -bob$ git clone /home/alice/project myrepo
> > +www-data$ git clone /home/you/project /var/www-data/deployment
> >   ------------------------------------------------
> > =

> =

> This assumes that we're on Debian or its derivatives,

True, and not all derivatives. In Ubuntu it's /var/www/.

-- =

Felipe Contreras=
