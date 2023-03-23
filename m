Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB386C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCWVZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWVZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:25:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6C13513
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:25:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u20so69198pfk.12
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606704;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evfW38MJLhwPhYQQCVrguUi/Tb7PIk27vW1F/oaii4o=;
        b=cOpmfwE2klwMNabCGDVm+/ghYgBbDcre5GuHR+sNiKC2eUnavaBO7NUJgo049GbiL3
         Hh1Q8P8cmkdi3b0uE39U8vd1stIYM9sb/jqW49vDhk8YgEXrFl+9zySBLw1Qv/FyiA6F
         fJxQX5Avh2bg18ZBTqrE26AvFpN7tYGhtucBI9COqqe2EV5n2tWHJq8n7oZyUbytm8FI
         LyYCNTQBEW7dNnAtVyKVs4vzQYnBnhSgHA+NuRbTBumyrwSS3A9Chl01uHYwX+hIg1gK
         LF6PteJLbiYHowte7lAPiIir8amDEfzEpSXawMCBiAsEkGj+//KHMrl8kdIt7FWNeqyi
         3hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606704;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=evfW38MJLhwPhYQQCVrguUi/Tb7PIk27vW1F/oaii4o=;
        b=w25a0ch4Mcd7wbVHOxy44bTgrpmlKBaTRb2zLICu7WlVkpzYvbjC1DoMFAWdWThod9
         Vavouq5plM6Q6/qpoEPyo/heio+ezejlBWMTHPP6NrrkcwLteOGOMyjPUyZe5w2NPGby
         sJkkNlOhmWvXz8RaFD1KfGSsgdqq0vW/C/JFMDRLojWd99Imx2GEFxE1pjLqf7+M/g2l
         a+vn4NCorYuXXj1PnMOy1kL137dMHgZEAqhmtlVfFjIZJogOFBL3AaYLPteE6MLxISd2
         s0vudai8o9krocGcCjleOWsqoFhyETVx+vwcZz76Foax9y5BanB1ypU8ixFzQdZcL3Zj
         A7uA==
X-Gm-Message-State: AAQBX9f8Nonntr5OWglQVJVUIpwHCn7SdMy7E+uBspyzhkecBjVX+4Ty
        lhODR4XUg6mtenYrANZVV+Sw0pUZxbo=
X-Google-Smtp-Source: AKy350aXr0t5AsJz7ClxSohwV1wqPyKnYkPxZMMWlZKaeTScUGoy2Od1ldn1Ue4+uL9Wq8RkrVBiOw==
X-Received: by 2002:aa7:9629:0:b0:627:fc3b:4cb4 with SMTP id r9-20020aa79629000000b00627fc3b4cb4mr717504pfg.19.1679606704586;
        Thu, 23 Mar 2023 14:25:04 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78085000000b006254794d5b2sm581798pff.94.2023.03.23.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:25:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] sequencer: actually translate report in do_exec()
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
        <20230323162234.995485-2-oswald.buddenhagen@gmx.de>
        <xmqqpm8z6vxk.fsf@gitster.g> <ZBzCoZ0MuysnVj9t@ugly>
Date:   Thu, 23 Mar 2023 14:25:04 -0700
In-Reply-To: <ZBzCoZ0MuysnVj9t@ugly> (Oswald Buddenhagen's message of "Thu, 23
        Mar 2023 22:20:33 +0100")
Message-ID: <xmqqcz4z6tzj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> yeah, but unless this is on someone's shortlist, i don't think it
> makes sense to hold up my fix.

My point was that your "fix" is not really a "fix" that is worth the
code churn.  Or did I mis-read your patches?

Thanks.
