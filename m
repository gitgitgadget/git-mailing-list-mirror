Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C833C7EE2D
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjEHTTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjEHTSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:18:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDEC49FE
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:18:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7577ef2fa31so429601685a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683573530; x=1686165530;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=humIR6G3stmA1/w1yKE9aIkyNkG1GwP+++kqO3SfyA4=;
        b=hNgA4gaPSUEohCpGl3duz3x4e5v6+aa3YdLbSAHU/MZo1S1S3z1xowBHq+IV/4agfs
         H4rBYnzXUrhVzWlw+5V19P0F4K3qhjLgH0uOuTNfijXxqY+KVfARRvAkdiVfz5r6LFVl
         m8D3m7tICTnmKrgNq0oFm/84yBlYNtlYHmcU2MfADSun1EaURfRZylaMLdYdUI6xWsHd
         A8RMiwdnx4GBWFeF0JvVXvyQYNVeuMpxv9Xc3cxvhkucWXpBSev2ROdJJ/RZ79UB9dGf
         snAnmUW1xYtSNiCbZC3rfoDd1ABaBMU4BzddDkbXterHtIP3LjQY3MTm0ECf1F/Fa6od
         ifrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683573530; x=1686165530;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=humIR6G3stmA1/w1yKE9aIkyNkG1GwP+++kqO3SfyA4=;
        b=Zymlkkp+2q+aRo+x+dAu5jRbYqUXI4zVZAWFMtL0+1iOmH1hFIf+PhsRIZ8A26FaCx
         5otGYHfecDm6Z72i7KeTSLEEx7JhuPt3fvwKGclfLeJcwCyc0IKmrz8IJDCwi5XRgYJx
         8b1M+OR8o7J2phRJx46r90i4Pqcsd86MU8K8/Op5AMWyjorbHGjfE6GELtIKkzmVNhAj
         tB1UFhBjZaPC0BYQBWWyt29bkelGTpRYFlj5Q9fT6Pot8U834eSuSSV2h6JvtFKfcc1x
         3QTODV96UwTqYpPosIjFhX4v2Yq5xf9umyCSUiZ6gYI5rATWQioQDkBxlTsyIFF7q4+x
         /nVw==
X-Gm-Message-State: AC+VfDwq441DVK8otw9Yswvh1SS7YDCvg6DNMJVgi9Lp39K5Dhs6smoL
        Kpg/oKw4JlzVs0CNLHwpJSepfoHaHTovrg==
X-Google-Smtp-Source: ACHHUZ6qkj1F/wAGU5SIiUI8+8h3vlmQZlt5MznX4g2VperWGxg/TCK1k0+hXDJkzkstgoZWqXeYsw==
X-Received: by 2002:a05:622a:1c1:b0:3db:9289:6949 with SMTP id t1-20020a05622a01c100b003db92896949mr27404589qtw.3.1683573529867;
        Mon, 08 May 2023 12:18:49 -0700 (PDT)
Received: from hurd (dsl-10-131-119.b2b2c.ca. [72.10.131.119])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a108700b0074d1d3b2143sm2740114qkk.118.2023.05.08.12.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:18:49 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] send-email: add --header-cmd option
References: <xmqqcz3s3oz7.fsf@gitster.g>
        <20230501143848.19674-1-maxim.cournoyer@gmail.com>
        <87r0rqvp2z.fsf@gmail.com>
        <CAPig+cTEngaoEbipX9cFSZn3Mro5qW_OKeK32Wkoof-cy0jBiA@mail.gmail.com>
Date:   Mon, 08 May 2023 15:18:48 -0400
In-Reply-To: <CAPig+cTEngaoEbipX9cFSZn3Mro5qW_OKeK32Wkoof-cy0jBiA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 8 May 2023 12:59:42 -0400")
Message-ID: <87wn1ityw7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 8, 2023 at 11:07=E2=80=AFAM Maxim Cournoyer
> <maxim.cournoyer@gmail.com> wrote:
>> Just checking if everything is OK with this submission?  If not, let me
>> know.
>
> According to Junio's most recent "What's Cooking"[1], this patch
> series is slated to be merged to his "next" branch, which means there
> is nothing else you need to do. Eventually it should make it into
> "master" and (presumably) into an actual release. You can monitor the
> "What's Cooking" emails to see how the patch series progresses.
>
> [1]: https://lore.kernel.org/git/xmqqmt2ibcq2.fsf@gitster.g/

OK, great!  Thanks for the update and link.

--=20
Maxim
