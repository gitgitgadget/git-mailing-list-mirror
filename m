Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006CC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjELVCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjELVCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:02:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592859C4
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:01:59 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3909756b8b1so3355129b6e.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683925319; x=1686517319;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwtPEtXrXwypteEfX5Uh9sMn3Ikmif8jSdYuRLMgewI=;
        b=qbmyQvUBe2AyM387tfmnFdGWPuJ5rzFT5der8smGJFeC2InVXBq1aihJOKpaJD16pa
         DDllOQI8a7JB0MDn+PK3h+rdKZ/YOjy/o/JB0JylxfygqXDZHII6WlT624AvgaLwbCkU
         cqWbFWzCISSizFA/T99tdC9HCuqjkycJRmbn5O38ZboVHqRPhRrAUOFIAwP96rVJKtLm
         bHrLikw3Q3Sqhs+zMj2dzfvYVIdtLj5vTp/0FRsTAWUPFYvZ5bpZ20xP+W1a+v38nI5p
         pV1W+csFwF4movwo9Z+eQrdk6+Aeivc35U3KBNH3Qa7n3BeUSlzqH//88DspuYfWmCiC
         4djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683925319; x=1686517319;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwtPEtXrXwypteEfX5Uh9sMn3Ikmif8jSdYuRLMgewI=;
        b=HL3gWiZOTDb/cdxM/8unJ0MZdcycQchEWmKuHUM92GuwFqmAfyx2sSZowAMDSc6WBq
         42j+GaZdNTTtfdmAv63m/wwNor7BvbDg+MnL3svvNNjkbkAxSOv9/1HBvkJwg88If/75
         nQLKGwwZIqv1EdSpC3t8T7UqpfB2WZfyAB5Gln8ggvaqzH3tAhcUxBpWixkAA/nGpzg0
         XmhnDf7dDyUPeJ+8EJnw2Bzp7GaSuvoSEQvB+nLwYKZFrxri4g/6/UJONWRTlqlTOErB
         kfguajxRgSCcPpFbwQ9/22oWCFf+5VSVAl1FuBB4Y6DxFzj6klMf6GDR8IDw0loUIhKb
         SCfg==
X-Gm-Message-State: AC+VfDyNWxS8AmTeKNT2PwlghHP85cFe8lBERx/mwklptpM0W1Ay3XfJ
        83sfouNHPgobUXCoJIXHdQNCADMU4dg=
X-Google-Smtp-Source: ACHHUZ5ph0S4kN6aEEgZoJAuS4ApYx7aUxI7DKVn+XQyuqjQwc84XDslaVgbOhb2sg+KPxcZZUaDJw==
X-Received: by 2002:a54:4695:0:b0:389:4f86:205e with SMTP id k21-20020a544695000000b003894f86205emr6546384oic.9.1683925318875;
        Fri, 12 May 2023 14:01:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c16-20020a544e90000000b0037b6f5d6309sm4775006oiy.2.2023.05.12.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:01:58 -0700 (PDT)
Date:   Fri, 12 May 2023 15:01:57 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645ea94569b79_21b4f8294e7@chronos.notmuch>
In-Reply-To: <xmqq1qjlp98j.fsf@gitster.g>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
 <87h6shif6q.fsf@osv.gnss.ru>
 <xmqqv8gxpd8r.fsf@gitster.g>
 <645ea15eca6fa_21989f294f5@chronos.notmuch>
 <xmqq1qjlp98j.fsf@gitster.g>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > So your rationale to reject a perfectly logical behavior that *everyone* agrees
> > with is that it might break a hypothetical patch?
> 
> Everyone is an overstatement, as there are only Sergey and you,

Matthieu Moy also agreed [1]:

  Looking more closely, it's rather clear to me they are not, and that

     git show --raw --patch --no-patch

  should be equivalent to

     git show --raw

That's pretty much everyone that has participated in the discussion.

> and as we all saw in public some members stated they will not engage in a
> discussion thread in which you were involved.

Smoke screen.

> > Just do `--silent` instead.
> 
> I am *not* shutting the door for "--no-patch"; I am only saying that
> it shouldn't be done so hastily.

> But conflating the two will delay the fix for "-s sticks unnecessarily" that
> is ready for this cycle.

That breaks backwards-compatibility.

Why are your patches excempt from bacwards-compatibility considerations?

[1] https://lore.kernel.org/git/4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr/

-- 
Felipe Contreras
