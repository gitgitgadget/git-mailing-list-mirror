Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1EC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjDDTsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 15:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjDDTsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 15:48:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51D1733
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 12:48:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so37286811pjp.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680637692;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5/eSzlZzb8CNRK7YrImKWk6Oz62YJRPc1MGw9+NIcw=;
        b=JgTKLuK8bahz96zXAhAv3fQn3pBCbq7PSEdusnnkiCfm3U8zP0TEW+tkwiAMitBDUW
         Y3Jr6cwYeb3ANISsNymhkBs64QVc9oQCZ25+fd+yW/y0mrpYoF/xekXBxCSJj2j0Drae
         urpNAKbxt3YlVGf5XUNH8U7qHsT48pV3Pp1JlaHLwOhk1RurxbCqK9l58T1QdSmNcBrO
         Zlc74xrnu9EqexQUegcskyYDk/Z4lYE0ccQiOOnPtvl9Dp0beqiwGUY3DcBCx3Tn7FaT
         hkKRCH0Qxlh1A9myXZ0wjIDqT5YUi2B5I76wxJ4FQJdNt+bTBIoazgIMww+CWmWjkSOA
         z0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637692;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f5/eSzlZzb8CNRK7YrImKWk6Oz62YJRPc1MGw9+NIcw=;
        b=35WWd9/zerbKXJm0uY5aBox7Wjt6rf4AgvOYwDpekr/tZSz9hDUYF7knJ5tBIwTBJK
         Tv3Rg/gstroq0XhPQnZrnb1JGAapICL7HwkNT+gfHrHSFQJN4ZC/uUA9qlxEoEDhg5nl
         Cj8Ts9sler18wqg/ZsAy1ZBraLCdXZZF+RhfaV6FxO5grvi4OFCMWLW/6fJ6XCMkhcfu
         O1ZaqKh3/tCvhw7Eyvm8thC5tAAdm5X3fttHW7rHD00S/y9mEoGDMTWa1k9JjNpbW894
         xu39PoxeDyv6Zlgo1yIyD78XMPo2QteeuE9NxoifEpA/liqskUhRhnZm2UhVQUDsNid0
         +Drg==
X-Gm-Message-State: AAQBX9dpDNA/aGExD0cocoGoE60Hc6uZk5kH2iqe4G3N7ekJ7/La/Cdo
        ywzxV/2tp2DcK4d5QU73MYT4wTp3hIc=
X-Google-Smtp-Source: AKy350ZtAbluoI2ZcJWa/tvCZQ+S4EeltLvMVf9lPcbUY31zfs+/viyQIHVBYcCO/bd7XJxWyUFxCA==
X-Received: by 2002:a17:902:e54e:b0:1a1:a90f:6766 with SMTP id n14-20020a170902e54e00b001a1a90f6766mr4813489plf.52.1680637692520;
        Tue, 04 Apr 2023 12:48:12 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090ab01200b0023b5528b8d4sm8250014pjq.19.2023.04.04.12.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:48:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Hongyi Zhao <hongyi.zhao@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Git List <git@vger.kernel.org>
Subject: Re: git revert with partial commit.
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
        <87edp0ak45.fsf@vps.thesusis.net>
        <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
        <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com>
        <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
        <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
        <87lej7zhpt.fsf@osv.gnss.ru> <xmqq4jpv1pcj.fsf@gitster.g>
        <877curzb9u.fsf@osv.gnss.ru>
Date:   Tue, 04 Apr 2023 12:48:11 -0700
In-Reply-To: <877curzb9u.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        04 Apr 2023 22:40:29 +0300")
Message-ID: <xmqqmt3nzax0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> If I got this right, you believe that "git merge" should never have
> support for "partial merges",...

Correct, and that is not just a belief, but it needs stepping back
two steps to understand why.  Unfortunately I do not have time for
that today, so maybe some other occasion.




