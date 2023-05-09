Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4DC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEIBiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIBiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:38:14 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B4A4C3A
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:38:13 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-54f83997f10so883111eaf.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683596292; x=1686188292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szByPDPWptHVfjkjuldb811uq2dN6snDXORP71V4rFc=;
        b=rgrlLwORW+t3bRx+y0j1Ifgo6S/Rla2y3PSTLJuGC1dUR4lUj2J4pltLPKtV9gmiXX
         csLfa8ci+Rg2vU6SBh7mBi/7n4Ayjwe3hirE1T83+Wydr+fTt5O8JfBqOM10oqZcjQ3S
         SJOOe+Sz8qaKI/MTQg4QZI8SO4B02hCUM+YvVZSY1wfFmq1tIz0XjRJpOPPFmJ7V9HDM
         O9gV7ieU9ser5be/XqwGu95DgARqu+YkbSvHmSLNpMzbq4Nro0eDFTNvmrDvu4WEgslq
         JhqzWXYTZ1inEiJEBz4UUfB6U3dl+KcTLLeGvu3dE5Hh3FbUpbMPpRZ0JXAooi/DmmQL
         L/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683596292; x=1686188292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=szByPDPWptHVfjkjuldb811uq2dN6snDXORP71V4rFc=;
        b=HgPEw6g+dqIy7Mhd5E/Tn+staQ1L29+fTo9RL91daKxCoanfxpFHJ4IlQXImkQavsB
         e1n0jLHZrAdNwTMVwGBlOnDfbboe7fcr0wFoM0T2PrQ2qEWy4WR0cIscs8Wd1Zc96GaP
         6XRIPnbS0OwvmqGw9w57QFvoAqUf4q9vF0yMP8U7Xb6O4sHI6bGUvATk7Wgi9geTaRAa
         F/j3yKSKYj4JNCg4g3VCEIFq+iGs6LWiYRrZC5nU07Z6PmoAeZPFcV5CLTwH2Gv608KK
         ZyRL7BChjebRjY3IDjK5h8p6t5QI11bSJixYfb1VdWVjtGizX+NmBHEso8UX6GWpAhLI
         Op3w==
X-Gm-Message-State: AC+VfDy9sLR8Cny482dZnOefjwUCqvSH/M2jdY4Zn/49dd86PnlWPGp+
        XywjhKu5rrerBTYNY7PTLgs=
X-Google-Smtp-Source: ACHHUZ6unTMmavtKuCMtt7+55uQ5X4uu1lD0z5+Jo+aFxTTAB4QJdI+QJHahMsFa2BxZwm+87hLCxQ==
X-Received: by 2002:a4a:9297:0:b0:54f:5e31:31c5 with SMTP id i23-20020a4a9297000000b0054f5e3131c5mr500256ooh.2.1683596292018;
        Mon, 08 May 2023 18:38:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w18-20020a4ad032000000b0054fb6c7b791sm511855oor.20.2023.05.08.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:38:11 -0700 (PDT)
Date:   Mon, 08 May 2023 19:38:10 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Message-ID: <6459a40291a4a_7c682948d@chronos.notmuch>
In-Reply-To: <xmqqbkiupv4m.fsf@gitster.g>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
 <af2111f8-2669-b952-6c4e-45ee0330ec14@gmx.de>
 <fce603aa-ceb7-d601-6a19-657e36d9059c@iee.email>
 <xmqqbkiupv4m.fsf@gitster.g>
Subject: Re: [PATCH 0/2] gitk: handle long command-lines
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
> > On 27/03/2023 10:17, Johannes Schindelin wrote:

> >> Paul, is there anything I can do to help you integrate this into `gitk`?
> >> Or is it time to pass over `gitk` maintenance to the Git project?
> >
> > I just tripped over this problem while trying to de-stack my Git backlog
> > https://github.com/git-for-windows/git/issues/4408 "sdk gitk interaction".

>  * The two patches that originate from GfW have been applied on top
>    of 465f0386 in the gitk history; the result of this is 7dd272ec
>    (gitk: escape file paths before piping to git log, 2023-01-24).

Why only those patches?

Does patches signed off by GfW developers carry a special status
regardless of their content?

-- 
Felipe Contreras
