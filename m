Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B52C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35572222C4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 20:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb6OJbE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgBNUnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:43:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53179 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgBNUnl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 15:43:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so11332491wmc.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hciQzN9MJUkywsUQWWH3VgBhX5k7o8aTEefNy2dWfxI=;
        b=Vb6OJbE8riKn1lRXE/hGAuwxfl9KFY6gCUVebzAancOHe16wF2MJhAWgbFZjFEynJX
         Wa719mn2tNddX5bbu1dDESS+1EhNjDGVZ7+riBovy/4rvIKGBbkqC0+X3uBCRdQn+v46
         2pp+LzdKmiNTzlUsjLzv0+LxTRu82+KF21zSziqKm+MBK/oWSPs55Iyh33/k778EuXjc
         ejiDABP3a9ZSY+/MBe6HuJ99fmb6tK+bkO0D3L0jSvWYm9viSFoVxmbr1HCBYBhFUl12
         01DPHIEMTAr6NMp6oeFq4DaQjg2BCwPcDO6AUjneNBtju/itLPnsV5ectfvyFeG0UhxV
         UQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hciQzN9MJUkywsUQWWH3VgBhX5k7o8aTEefNy2dWfxI=;
        b=lO49zbtwjcQJSQjcxsDuSZdI329wRcfro/S5G0mjAymY74hXIwNBrOduiZeyPLx9nX
         xWwFJnXNCjNxqUPeIk4rsqt02hXc5Ji5O1HGsHP4YqaMDRlQzi/txYW9rpHkdz62uBTv
         ngSdPSII2A0b2Hm9WJyjKaLXfUGcik3eYW4I/nCAhrWygvqA/E0IWOz6tNlY/ftO+pfG
         qbHJLQfBm18IUinheUkgPxzmli4bLqwyTDFesSH78rXEyxx063Klim57O1t923RxtBlG
         IycCJI/8DlPwmvzpfTSwAg4kY2VOrNBRPRxC2dTOXMktMB2+tXpsfVLooH/kA0ny+ZbA
         OdkQ==
X-Gm-Message-State: APjAAAWHKtZBfZLI5I1Ck4Hc5MNC0GsaVUK0S1zLds3sqjtgJJ3mznBO
        tO3gG038TZY9rcC9PQlTd4g3p5kC
X-Google-Smtp-Source: APXvYqzlJLpcW4N8ligkE+EPlziJabyz9/tk6UBq87PSTFUDzCay1Hs+FCyk15Jw6ZKBUkRhLcJjcA==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr6296449wmg.140.1581713019232;
        Fri, 14 Feb 2020 12:43:39 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-28-28.w86-222.abo.wanadoo.fr. [86.222.27.28])
        by smtp.gmail.com with ESMTPSA id r1sm8238310wrx.11.2020.02.14.12.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 12:43:38 -0800 (PST)
Subject: Re: [PATCH v1] builtin/rebase: remove a call to get_oid() on
 `options.switch_to'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200121193226.24297-1-alban.gruin@gmail.com>
 <xmqq1rrr6ww2.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <df9ede1c-f657-d96f-2d4c-479245f2a2d8@gmail.com>
Date:   Fri, 14 Feb 2020 21:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rrr6ww2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 22/01/2020 à 21:47, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> When `options.switch_to' is set, `options.orig_head' is populated right
>> after.  Therefore, there is no need to parse `switch_to' again.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>  builtin/rebase.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> Sounds good.
> 

Did this patch fell through the cracks?

Alban


