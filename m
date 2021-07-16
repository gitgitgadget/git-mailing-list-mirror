Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A2C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18F1613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGPRC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPRC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 13:02:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6009C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:00:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id s2-20020a0568301e02b02904ce2c1a843eso999otr.13
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gtds5ElBxcv0pW+W9ataGbJCBYwvF+gDNV7gNmNpynM=;
        b=CByOxed24hEHT6JihxIuURpbcVElq6Mw18zXyzySDWQjdje9xXNuEo8jSTBqBfSV04
         vOX3Wyv0zum6p0GrszLq3ooUAn6CJBhc4+G3P+HFXyFA6CF2tvPrSsJtbg3iLpnreYYT
         l0B788nWAvqNWfKBgSfT13JXLDqA1EeMFG478eui6CNJ077jtXKiKxvWfaL8v0+3oeS8
         2oB6wKkIOikgHJK2DiiekcQCg0JiRW4YFzKzWANFTkGBibmdUfVGSkpjG0JsjhC/ELS8
         cviKYt75Xqki8Mtq/Pbeea7JptsXYFdmVYLPmmyb69FQ262zd+fPn3tA+ROqexabaBSh
         6qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gtds5ElBxcv0pW+W9ataGbJCBYwvF+gDNV7gNmNpynM=;
        b=jPnthUcB1M3mAdVIkFoyFRZAGIImlJS/7SdCMhPv5JG29PZicUL4EPRtTOEtWvGJZy
         00ZYv9inFcyRwcm9gBrGRImYYaM3qKHH0WvZNHVEkCI8q4J9atwE2yVIN+cvzOB4ao3f
         gUXGYq72dZSeYuEoAdQk6qezR5j8GpTITbWzJiZ+Ovd/v3LVsvzaFFEv5inmwWDjsLI7
         kyI4Zju+k/lp9C7Rh36TZ+7kXvIvOOgghfPHB2602ySO43qLGj0v9cT2Ubij65+QdGZP
         QGbz+NcG/YI/GWtTmmbU4FH8/xzgRjtx6/c2KByJT7L4bg+RE9cnocwnujRZ67znHyNQ
         Wlwg==
X-Gm-Message-State: AOAM532FZscdxEbL5u2tnkZyDQ8J005Qy8/Nu5GSwapYD6ddzABz8abm
        8dHVjpkLHeMAjDouLynCDNw=
X-Google-Smtp-Source: ABdhPJxZoLCOdAzth3U5XAqmUFYRY2d5pBz0HRSYhyRES4D8qqNjw6yRPSjuNAAgGAMqA+1IawK7pg==
X-Received: by 2002:a9d:36d:: with SMTP id 100mr8752196otv.11.1626454800997;
        Fri, 16 Jul 2021 10:00:00 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id t207sm2165398oif.27.2021.07.16.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:00:00 -0700 (PDT)
Date:   Fri, 16 Jul 2021 11:59:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60f1bb0d67e97_ade9208a8@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
 <87v95tbqgh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> > > @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
> > >  	@echo PAGER_ENV=3D\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))=
'\' >>$@+
> > >  	@echo DC_SHA1=3D\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' =
>>$@+
> > >  	@echo X=3D\'$(X)\' >>$@+
> > > +ifdef FSMONITOR_DAEMON_BACKEND
> > > +	@echo FSMONITOR_DAEMON_BACKEND=3D\''$(subst ','\'',$(subst ','\''=
,$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
> > > +endif
> >
> > Why put this in an ifdef?
> =

> Why not? What benefit does this question bring to improving this patch
> series?

This is a common debate tactic known as "shifting the burden of proof".

=C3=86var does not need to prove that your patch is undesirable, *you* ha=
ve
to prove that it is desirable.

You have the burden of proof, so you should answer the question.

https://www.logicallyfallacious.com/logicalfallacies/Shifting-of-the-Burd=
en-of-Proof

-- =

Felipe Contreras=
