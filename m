Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F46C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9669D613D2
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFIRjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:39:55 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41917 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFIRjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 13:39:54 -0400
Received: by mail-ot1-f49.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so24732082oth.8
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JlTw5uL2Tpe0r3gQreLwraHbRXn86j/tXiQRYGh+QSg=;
        b=shMn/dnmmTB3BpTdTm6V/bj6XHP8ilXXf/EU4Zmexqr3gYNy2GNqWa5+NZ5ND71pns
         mTV/VgDFZMlL0b9B72z/flwDILD4iLP/zNe+M2mtBdjL8ID2Wvw6Kxg9qOsVZd8TxzRO
         BZ8bykXfEvD0ca3eg7q/Jiho5o8WjJgAn3gi2RuLfgMNEUBZshKL1wayIIfsmp+auyZF
         ENOLOppYSHZvSBetEAMNTbzdMOxSmhTDb9mFW8BddJ0QGhEZuhjrXFfL3cW/nhKFrmzK
         l4keEmSs7C8Rx89FQudflXog+KgAoSpXZEwm1AFxtp8fS9gthexmlnJPN4sZmyRumvpM
         0RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JlTw5uL2Tpe0r3gQreLwraHbRXn86j/tXiQRYGh+QSg=;
        b=AiZy9mtkScyGQ/LGHg7EH2hBw9kEi9aSf2PHgX+fT6g7XaP2Tne4KWPy3XluOSxrhR
         1RfF7J85OIn9F0M9E5Zjch/VzkxxsAAAfV00ZreVKImECr58wo8y6GrH+nl7rnJJm4VO
         8EuzbHFSPzEVwHkFyQ7inLyOSnvHAleTwq+4T0w2JPS1bFHoAePAuDiDH5jFvH+ps8so
         mraM3T/hDiWijoQ2WjnNWOwDEuA1dSnvGpqBGlBSA05VGsn+QP9UlpJAGhDuOS/SQ9pm
         fcJaU98/fMOgKybEiZa5Nj7A7rwLC1+MOTUqP7l4a1z+bl1KJ4b1s9elH05u/Iq/TdNz
         V2tQ==
X-Gm-Message-State: AOAM532/MbcK1SV6wqZtl8rhalTgFqDLnIR+aCX7UAUEcOjtt40R1JXc
        7aSVGa4RLullVvsX8oevVxU=
X-Google-Smtp-Source: ABdhPJyJP7K0LWYPqEMUnoOk6Q/epW6Pt+zNNI6cntFyyI24IR4cuQmV2QJXZpa7BCG2LdDneOi7UA==
X-Received: by 2002:a9d:6453:: with SMTP id m19mr463886otl.63.1623260210770;
        Wed, 09 Jun 2021 10:36:50 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o26sm127670otk.77.2021.06.09.10.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 10:36:50 -0700 (PDT)
Date:   Wed, 09 Jun 2021 12:36:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de, philipoak@iee.email,
        bagasdotme@gmail.com, sunshine@sunshineco.com, avarab@gmail.com
Message-ID: <60c0fc311144f_1096b2081f@natae.notmuch>
In-Reply-To: <20210512233412.10737-1-dwh@linuxprogrammer.org>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
Subject: RE: [PATCH v3] doc: writing down Git mailing list etiquette
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> After violating a few unspoken etiquette rules while submitting patches=

> to the Git mailing list, it was suggeted that somebody write a guide.
> Since I was the latest cause of this perenial discussion, I took it upo=
n
> myself to learn from my mistakes and document the Git mailing list
> etiquette and the fixes I made to my email setup.
> =

> * Add documentation specifically on Git mailing list etiquette
> * Add alternative actions for patches that receive no response.
> * Add section on submitting a final, merge-ready patch.
> * Add section on Mutt MUA settings.
> =

> Reported-by: Christian Couder <christian.couder@gmail.com>
> Reported-by: Filipe Contreras <felipe.contreras@gmail.com>
> Thanks-to: Junio C Hamano <gitster@pobox.com>
> Thanks-to: Philip Oakley <philipoakley@iee.email>
> Thanks-to: Bagas Sanjaya <bagasdotme@gmail.com>
> Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
> Thanks-to: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>

What happened to this? I see value in having this document, so I would
be glad to pick it up if you've lost interest.

Cheers.

-- =

Felipe Contreras=
