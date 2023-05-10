Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78800C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEJQhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJQhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 12:37:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27CDE4C
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:37:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaec6f189cso51916485ad.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683736634; x=1686328634;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc+YqhG4n3a459Dt7ckUkA0mSi+yCp1xnV8m2VX26Eo=;
        b=BsEpn+afW52Gs5aUkN9U3j7DoZYfvTTRINU5U8QadSpoVADfydOLs+SR8gLlqEZrWz
         AiUC5qfp1lA/l26aMTz0jhM/m049bWU2h8pomOpbRdODAtD1glST33Frq1YQhg7xpuPc
         yoSWnl++e/0Kmo30lkLwy+yoMFyvcXBTwSs7Or1B6ckjFy7qqJEQ9MSHGCsTYNsEOEq4
         do4ZxcxC82PI3NMqTN63vz9wRWM+MJNWEwPkag82yGDWJaoZosFjGNMeDw3LMqcz5zib
         lJuZX8jnRNg1J5T2p43+aDa0eIK4KsaOuTDEkto9AkotZ1KROn+6aGRRSET1kur6LelO
         3Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736634; x=1686328634;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mc+YqhG4n3a459Dt7ckUkA0mSi+yCp1xnV8m2VX26Eo=;
        b=BqbUhD2N9gqc7LqAS/qs0mbPp+Pu1lCZ7ZTPUrDSVAcGFrMHg2FIc+Fmg9AKB+sue+
         C7rIGRMxIxbdg/+kznssPN35/1sXKXQtpDYuRVr2+iuGo0QAnCDXzVX1mYGgd9mqqFT1
         Bx31EkaYOmB8oUiVtGLIQ9jAKIg6Vw0LsUgbJzbvjDOEmDA6fOza0BBN448N6QdoGZlV
         Pni9SFwfMzBG3m9IALMUFZPV4LfXHh6bhAXn2J1I6+XZKLVfhymQZeHZEYeOIL3TrtV1
         uOOmAVGJcvcktnbfK0D89U6GcbkT2ixRJB4nOI4UnW7cO79BVs9FlhxRn9eKT9q28L8h
         cCvQ==
X-Gm-Message-State: AC+VfDw1GQTqGOuo2Q0Hs0owGOinkFAo1aommSURrOIEX0nyxpjwVbr5
        cz0L+q4AU3ypjy5baaOomPw=
X-Google-Smtp-Source: ACHHUZ6I6ruZ9HlmjKwFBfknXD/gyCyg/6GheaLm5A3X5h16AZf6ltqqeynJnFUa6yfYvWTRrJMqhA==
X-Received: by 2002:a17:902:6b03:b0:1a6:a1ec:53a3 with SMTP id o3-20020a1709026b0300b001a6a1ec53a3mr17824299plk.3.1683736634055;
        Wed, 10 May 2023 09:37:14 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001acacff3a70sm2368758plh.125.2023.05.10.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:37:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 06/11] doc: trailer: trailer.<token>.cmd: add missing
 verb phrase
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <8e36d1bd1f0c8ca6b1210a537f4bb8403fab7c47.1683566870.git.gitgitgadget@gmail.com>
        <xmqq1qjqobl9.fsf@gitster.g> <owlyjzxgn0et.fsf@fine.c.googlers.com>
Date:   Wed, 10 May 2023 09:37:13 -0700
In-Reply-To: <owlyjzxgn0et.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 09 May 2023 23:52:26 -0700")
Message-ID: <xmqqlehw5eiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> Isn't the
>> original just outright ungrammatical?
>
> Indeed.
>
> Should I combine 01+06 together?

Either is fine.  Thanks.
