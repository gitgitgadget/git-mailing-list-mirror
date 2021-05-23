Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A40C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8560E0B
	for <git@archiver.kernel.org>; Sun, 23 May 2021 14:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhEWOuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhEWOuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 10:50:10 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657F1C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 07:48:43 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so3952026oou.7
        for <git@vger.kernel.org>; Sun, 23 May 2021 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=C27+VglY3svLGh+vXlFRhJytI15P/s16CSTcXvPF8GA=;
        b=dgfHBJMLXgHM9l57OGHsW7QAK/Rf32NTS7rdVudIHGQKPbrTb00HZApjqChvSH/d5Z
         Hg+LgwbshHTftZeQiPClmNFpT910TQmDM3B6TiVnpu1ANco2IKhZl/6JMarmYqE3skYz
         AFoKlRHLbg6DcuxHXkKYObrdYNk4Fo+P4eo4ohtjzuBs8utM0imafdWSNmagTiAwTOH/
         ppTDR+fo60umCnCWCdR1YfFk1NLUrLLr4QG2JI7xINNX+0r2ilOeBBCzbOpB4s15OgYa
         KKcta1UL467vJbdqQH2lc6jRbM7j/PBICAP2inQucaJC06eHw1loB8U5RTAVUdg9sv2A
         HT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=C27+VglY3svLGh+vXlFRhJytI15P/s16CSTcXvPF8GA=;
        b=HXutrZRqZwTCVL+5Dc/pTtwnlMCK7uU+UwZVSDPnxgyRXI9MyACCksxv9Hdp0nPspO
         5lr7Uyk5uICDZjzyaXm9iG7HckXo6wD77yGx/rL7KW3dANczGmPlT78GEAZJgjHDmpEO
         rYaGhhqSVCUuInnnanjOtakQFuQEL1+IlIMf8suZ5+V81rpSQo4KYmYsIyiLBOAo8zWv
         hGWEqVWeiLZu42bUkXa1F3DgRFw1y3fs6C37i984JOvDgzY5zWTRCkYRJvbgYSxAKw3y
         7QJj9LSZw1JSOPiC5zFx0qNv0ZA77enJjW/+v4ZegtRACXYABFynwvzYyxOmikGtMnM3
         nsYg==
X-Gm-Message-State: AOAM532OLIGqCH6mh51/NtmkVBRsDsbM4ABfh4FuamQYmixOa1pQ3Dq0
        tWCO1ZSqVUpM+ikxGWR+TwV/HDWWAG7g5Q==
X-Google-Smtp-Source: ABdhPJypxN+rceEGj0La4+Q81lwH/UXHipI5cPD2sCyiJmQIu4eXBNwTVrVxY2upUR5i0HvT0tlLhw==
X-Received: by 2002:a05:6820:20a:: with SMTP id i10mr14988866oob.6.1621781322767;
        Sun, 23 May 2021 07:48:42 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id f8sm2270976oos.33.2021.05.23.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 07:48:42 -0700 (PDT)
Date:   Sun, 23 May 2021 09:48:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60aa6b48c0623_1234e6208ac@natae.notmuch>
In-Reply-To: <6642528a-b270-5862-bfdc-7bfa22682c2f@gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
 <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
 <60a83c794ed4d_81cd4208f3@natae.notmuch>
 <e669d76b-0bed-4eac-a942-c89b7523ca34@gmail.com>
 <60a97c12d96a_85723208d4@natae.notmuch>
 <6642528a-b270-5862-bfdc-7bfa22682c2f@gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic wrote:
> 
> On 22/05/2021 23:48, Felipe Contreras wrote:
> > 
> > Language is understood bit by bit. To properly understand the sentences
> > that follow you first need to understand the sentences that preceed.
> 
> Except you can't deliberately chop and butcher mentioned sentences in 
> order to "understand" them in isolation, as the meaning is largely 
> determined by context - and yes, the following sentences as well.

Please explain the context that makes this sentense makes ense:

  It is not reasonable to allow the user to configure a text editor to
  not use color heavily.

> The NO_COLOR[1] homepage text, read in its entirety and even if not 
> perfect, seems clear enough for everyone who wants to understand it. 

Yes, it is clear: software who use colors heavily should respect
NO_COLOR.

Others on this list agree.

-- 
Felipe Contreras
