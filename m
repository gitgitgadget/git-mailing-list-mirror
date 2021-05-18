Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE832C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA29561354
	for <git@archiver.kernel.org>; Tue, 18 May 2021 04:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhEREhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 00:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbhEREhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 00:37:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B64C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:35:27 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so7547090otp.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7wSs9iWT2Ik0sOyGCfDVoQh45CWnCAN7NWb781vqgtk=;
        b=QdwmLPJ7MfkuwKZDAiqe0OLnIYLvI4T/NDnAytjDTrJeBjo2RdyxMRL4PD9JltLmGd
         J6UTH2kQetfZSC6y4cskMEVVlxDPUoJPn0d2CMlnlytw2H8eUg3d51O3QFfVWNRb46mw
         SRTOyPhYF+hvM515co79QyXRTDiFsOOu7JrD6fQ/73VOP0UnAcNLhPi5wASUKj9E8XwK
         OKy3qNgWKQ5Nw2jJW1cJFXB3XmR6rkwEK7fQVyCYSBo8sy6I29Bltu0YgTcCQGNsayJ0
         lyxpNk6HdJIdkxblbofYpJFg+tjZHXPBTrm30ZWykueTSTluy/PF3R6nPTMOY2iCCkbf
         qqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7wSs9iWT2Ik0sOyGCfDVoQh45CWnCAN7NWb781vqgtk=;
        b=pIgJn7nShWv1AiJ193LER5xBMcG1GTFhVuknhoUZDwzPSfaixaOB7x0kPh3qDGPfMR
         gNyKWzx0rMCCNqy7zvUor6x9NK2JkCuoG7Vj9UthWRzcPWAYSIddeQQ8STp+aUxbQaWF
         vtUx0jJi3ARopdIyuZfizQTeKcGxd/R0PjjzQzJb1nRcUFNCCEwdzMd9RFMqsPn/l4Wa
         nWu4DnK1poqwQMwJLY7+QYkO5nLdko4Px0cbxmGJAJSKFApgkkCYyvltqg25loJZidEZ
         1DjYBIIscb8ZFr9oeaJhj5sf5NDVmOpGMOOhyPHEvmvO/0qjH4GEE32ResuumaRfQznT
         qy7A==
X-Gm-Message-State: AOAM533ECfyiHUHu1XZkRkMWbVRrP7CIHJwb3gxj5i+zREwGA3l0KfGJ
        L73CkZpcto/nmhbvyWxJgrQ=
X-Google-Smtp-Source: ABdhPJyExk4OoBuwv0/0MJz71j6FpGhJxnb5JJ7nECyEHUvpxCo9XNy3UWGCn+pinErzNXU3Dmf5Zg==
X-Received: by 2002:a9d:542:: with SMTP id 60mr2677802otw.143.1621312526919;
        Mon, 17 May 2021 21:35:26 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id c19sm3127480oiw.7.2021.05.17.21.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:35:26 -0700 (PDT)
Date:   Mon, 17 May 2021 23:35:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60a3440d3f76e_14d1bc208ed@natae.notmuch>
In-Reply-To: <xmqqeee44wp4.fsf@gitster.g>
References: <60a046bd83001_f4b0f20861@natae.notmuch>
 <87tun1qp91.fsf@evledraar.gmail.com>
 <YKMYUUVVVJMWH7xi@camp.crustytoothpaste.net>
 <xmqqeee44wp4.fsf@gitster.g>
Subject: Re: Man pages have colors? A deep dive into groff
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > As I mentioned on the patch itself, I'd prefer if Git didn't do this.  I
> > have my own colors configured and don't want Git to render its man
> > output differently from what I have.  Even if I didn't, I wouldn't want
> > Git to change the output of man(1) to be different from what's on the
> > system.
> >
> > I should point out that I have my shell configuration set up to use
> > different colors depending on the capability of the terminal, such as
> > using a 256-color palette when that's supported and a 16-color palette
> > when it's not, so there is literally no configuration that Git can
> > provide here that matches my existing settings.
> 
> git -c color.man=false help -m" would let you consume the output in
> any way you want, I would presume?

His configuration won't be overridden. He doesn't need to change
a thing.

-- 
Felipe Contreras
