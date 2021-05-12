Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF06C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A976661928
	for <git@archiver.kernel.org>; Wed, 12 May 2021 06:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELG0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhELG0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 02:26:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DAC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:25:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso19692440ote.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=yK0oX2qduNzTWiYUbu6fN+P9ZplB8o5PpmWLSIhEgSo=;
        b=tztCzDLG7294CFLqJBwtxbxqjnQYtrUyl7oLeWTiAKNugWpT7z4K2/iEglbfBS8WoB
         oqIGrKCsAO0SSComTKKTwEmU50z2ynxAt0iIkdcZc8lBapS9nHyD2BS3ILW1mOo3tAFP
         ile9EUEzfthdu9K4lk6ntYxArT8pnVPVN/SsPJ0sqFVyH0KviDVPZzb7rMSYt3Kjg0+9
         OWu0oN9BeRVJ2BkV94LhrWkaAMQIc5OPDlBi/gQ7a+SG7MI3f14IW9zqxVEPz6K7g0SX
         D7BSA8HUcuP8uylqq9AN+Eb0+2zH9sQLti7AGnrvj++3731gwC/jxzJM5PDuxpwBwAtn
         cpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=yK0oX2qduNzTWiYUbu6fN+P9ZplB8o5PpmWLSIhEgSo=;
        b=nIMgfJRg73lbVcG1iFJLZEYobQ93eHish/nTxzHPyGIKFRWyuSGrqaEzMu84f/Lobs
         592Cq7S4YqO7RuZ51E6ah4QQJHG5tuBIe3oAuhM4pn77xagyvxNAwWoR/JWAM0lopQFt
         6SqpPZX3y6N8L4NPFj/0i5dkLgNRVPuvewvz+YP8E+jhdI8C5Tnfwi9kEXPmgaupS4qH
         oxCiTN6Mapgz10GPaDVBYR4h79a/Moe+pVF7LcQC5i1yCpyFE6q5k7E96vAv48F/V/m5
         4/JFELKuGsqBjpv9ZHwNo9zgMdmzFbHyLXkkpZ1yU5gMVcGZVZ5ClWyq3KygcLGaz+RR
         Zcmg==
X-Gm-Message-State: AOAM530DTRezBmJVBh+vwm/fm3CCkiry25TIbXh7tn5+8FtMtS0KxVG+
        8RE8rf8a73ikPasEzqWbGlo=
X-Google-Smtp-Source: ABdhPJxlPRh9XIU6PoWkz8cm1bZzn3BhUqApebdmTiWFGYZM0CzkWkPeYvT8G9dPkOTcTtpX3No4Mw==
X-Received: by 2002:a9d:7312:: with SMTP id e18mr11456164otk.334.1620800738127;
        Tue, 11 May 2021 23:25:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r2sm4312873otq.28.2021.05.11.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 23:25:37 -0700 (PDT)
Date:   Wed, 12 May 2021 01:25:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Message-ID: <609b74dd87714_6d8972089f@natae.notmuch>
In-Reply-To: <20210512025746.GA1899@localhost>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512025746.GA1899@localhost>
Subject: Re: [PATCH v1] Writing down mail list etiquette.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> Doh! I forgot to make this patch In-Reply-To the previous thread that
> sparked this discussion. Well, at least this patch email doesn't have a
> Mail-Followup-To header.

Ahh, that reminds me of another point I wanted to raise.


In general people should try to start new threads rather than recycle
old ones (unless specifically necessary).

I suspect this is contentious at this point, but I personally belive
this is the way to go.

If people align with my view, then you did the correct thing by starting
a new thread rather than using In-Reply-To. We'll see.

-- 
Felipe Contreras
