Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB69C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30D260F8F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhG0Rpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhG0Rp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:45:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F5C061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:45:28 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so12908517otu.8
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=u60eu1GOUg3iMN9yvLiWyz2tW436vy1725vKHDEXZaM=;
        b=CEcIzL53pALBaezRKpnLgmWUctOc9vh8sQEPmfweEb2o57DS8N02aYIwi1NFoyblBO
         IfS6uxK7hNQl6bYDEf+nkkxN7aGVbYqJeWMLtrcWWhq6GMXpfZBdChCBbhYR4dBWmRX4
         Wo/zeVgcYyO5ajvzG40oV8Qtsez02NN5W5yW2DSUPrBNqTOyv7EXlIxoTLmxyPE4MhAV
         +awHUpJhF5gVnL1hnpt67ONrGpBHkz/HjkR3BmIufo4d6QIrF25M8vx7voCX1vg9Eh3t
         yOg35sfmpfS2x6IH04sLT3okP+ReJVj6/Sx+NYtnOdhIAXAsqwecCEaqNVBmCuFhyUL2
         fTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=u60eu1GOUg3iMN9yvLiWyz2tW436vy1725vKHDEXZaM=;
        b=YlGYkE7XJCmuQlIVTI95m8UstHM1paNUeYEzA8K5j8rhVSS3/DLZPKym6pxuKEQyYj
         L+HXOrzpdYKDFwbZcZkoBJR9mkNUyaOHFQVD4foPBPyU4ofCOK/MgTMtb+jdpCS/Nbxe
         Hokbnv/+PqKcuP+HbhR1dbq1oIrKpa9MvZF4IZ/uF/zrJ2ryemhgGVUsrNP4dqqI1bR2
         KaE8aj7lsBAYks/ukBOiemKy125BN1HAI+UWQWJAs8bCLi1LnJ/iGWTgg430LHSepsVI
         GHuA2neMabNMMReLVtRRDwzeJel04om47KOWzypJ4QA2XsOmAzlRWLagVK3SgRW8tYDP
         NcKw==
X-Gm-Message-State: AOAM531BAtrRktbSxVru7Pb/9FSWsU70Ovb613BKguE/ZX66SIm/YGtG
        pwL3D6+dJP8TrJ5jx9t49Uo=
X-Google-Smtp-Source: ABdhPJwtFGYq0qbY5+SzyP/1tyqHtZTESLNUsDJkx+pYK7BFXE+efixNDrMqI2TZHbke49ghvC9C/g==
X-Received: by 2002:a05:6830:15da:: with SMTP id j26mr16141960otr.163.1627407927643;
        Tue, 27 Jul 2021 10:45:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j202sm669782oih.6.2021.07.27.10.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:45:27 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:45:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <61004635d03c5_932820832@natae.notmuch>
In-Reply-To: <xmqqo8anekk2.fsf@gitster.g>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
 <87sg0xbq9v.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
 <871r7yxkq8.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
 <xmqqr1fkfyh3.fsf@gitster.g>
 <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com>
 <xmqqo8anekk2.fsf@gitster.g>
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> I guess the blame goes both ways, though.  We all have worked with
> each other long enough to know which of your recipients are prone to
> go overly defensive when asked questions, and we should know that it
> would help to prepend "I am just being curious but..." to your
> questions whose answers do not make a huge difference at the end
> either way (or not asking such questions at all).

I disagree. It's not OK for contributors to react defensively when asked
questions, and in particular I don't think it's OK that some
contributors are punished for merely disagreeing, while others are given
a pass for snarling at feedback. This is double standards.

The Git project should not play favorites, and all contributors should
be asked to assume good faith.

https://en.wikipedia.org/wiki/Wikipedia:Assume_good_faith

It should be implied that the feedback given is to try to improve the
project, it should not need to be stated.

-- 
Felipe Contreras
