Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8931C4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 23:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiK0XgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 18:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK0XgS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 18:36:18 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC53B869
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 15:36:16 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f9so8457125pgf.7
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIgaO34rKUn2/KtyEx+wNU0BZj4o3yGMNqJBmjfAmms=;
        b=VRzMncmdWNl7IiogQIJBRm0GRZ6lOuExJAR58hod6HBfjcwSzKRoiYmQXJY2obhKv0
         EQmsvNB/L8txJW05jYY3po+8Y/GZCyrWQa2OJnv1+zKy0QZ4B0u7BWsjsmkGV7rorVg1
         E+kzGwpvhOjLDPY27JNfzQjL5QgusnwRPJwjm/iKMMdO3OyjlCqJCvoepm6zxLCBGu5X
         tmb3wts1r77NkZ4LZAS/UJtxxEsrEHUsaSEJDZN7pmYH6feY/vu+i9i0J+hbM6AFrHXL
         dmn0VThfHvj1kUVEDUaELHsQWB/OdJzJtVQU2IfEJKfgpmBiJKn6N+vUhaH2/CQuSVjY
         hoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIgaO34rKUn2/KtyEx+wNU0BZj4o3yGMNqJBmjfAmms=;
        b=QXmBsOwKq7z+Adx3uSmE6EqmuZczBtSFpMOCTJ4s3huqpx+Fr2N4jfJZ1JF1yKWUyP
         TpwbjV0mF/c8nOWmfR4bqrx3nTEw7gQ21khKxSB3JhQRO1wAu/nGey1BpYcVsMXaLGfn
         +LfSyHxLPvvmmM3SKpoNjdV40Syi72X/AdevG4BigQDBttftFtxL5gJm83TgqIBeX3JP
         0o3TFNBTmCmoqOTDE4ZiI7H8Q42FMOZEllKyxU3McdXY6rB1OzQOMeH0/az8ENfq2/Jl
         Hncvc4UwT+6joTqltlRADi5ZkTNKa6/PvYQWoueAA69vIHQ7aeozWc+AFgOqh40NFFND
         6ElA==
X-Gm-Message-State: ANoB5pms3hvC+goPo9rjqmvA23LdG6fqL1LnRN34mo+hzg/+jnHLmO4/
        +Ir0VXZFk3ZEAG0CKTh55lM=
X-Google-Smtp-Source: AA0mqf6vSgAs6sXHutvct1tchxQQuruMmNTbx0z/RQ0fbrqN2rSFfHQGm3hXBD7LgiIGVZh9cahPDA==
X-Received: by 2002:a63:ea15:0:b0:457:7285:fd2d with SMTP id c21-20020a63ea15000000b004577285fd2dmr26372661pgi.580.1669592176052;
        Sun, 27 Nov 2022 15:36:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b00178b6ccc8a0sm7376623plh.51.2022.11.27.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 15:36:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 4/4] ci: install python on ubuntu
References: <20221124153934.12470-1-worldhello.net@gmail.com>
        <20221125095954.4826-5-worldhello.net@gmail.com>
        <xmqq4julb5nk.fsf@gitster.g>
        <CANYiYbGmZjBzRNd9W2kws9KCnxXAvVpkGNUzRJs4LtLKW+ukmQ@mail.gmail.com>
Date:   Mon, 28 Nov 2022 08:36:14 +0900
In-Reply-To: <CANYiYbGmZjBzRNd9W2kws9KCnxXAvVpkGNUzRJs4LtLKW+ukmQ@mail.gmail.com>
        (Jiang Xin's message of "Sun, 27 Nov 2022 17:01:04 +0800")
Message-ID: <xmqqh6yk9dht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>     $ apt-get install python
>     Reading package lists... Done
>     Building dependency tree... Done
>     Reading state information... Done
>     Package python is not available, but is referred to by another package.
> This may mean that the package is missing, has been obsoleted, or
> is only available from another source
> However the following packages replace it:
>   2to3 python2-minimal python2 dh-python python-is-python3
>
> E: Package 'python' has no installation candidate

OK, I see.  Thanks.  I wondered if "python" redirects to either one
of these versions.  Not that I would suggest another approach based
on such a redirection, even if it existed--as I said, the question
was purely out of curiosity.

