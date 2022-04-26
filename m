Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EEC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbiDZUsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352948AbiDZUsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:48:37 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C6140A6
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:45:28 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id q136so6339vke.10
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6v1tCoPnGUk6VlVhI4IAFDCwKzOyqzwNFNHI/A7B60=;
        b=pUWCdCb7D6WVtcA/duqjsm59pI9KgK/InzLJTSuPOI4hshpeNaKKz5v3W69GQcTJ5q
         ujt8Th/s/OwCZw0sTtn+X5fCzisSL8MSMj9HbDQA+sWM/mkz/DHvTb0tw+bBnBvMth0l
         v8kdPhDBjAJ9e+e4Z8VRl9fGvW+7I7H/xyD255uhN7R7pNBcb/HfGaqq331f0us9gRDj
         WURapUrCLJd6R0FmX8bqbOa1btTrZdh5jGyUUPgdUIy3PGg3hsSk6472WkLF05c6TUNz
         FqRTBy4duyqF5EAto30JsqiAFWuQEnGivC8b7Uxtuom8HkgZBEoYDg2M6jOzkt+6mKJT
         BMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6v1tCoPnGUk6VlVhI4IAFDCwKzOyqzwNFNHI/A7B60=;
        b=sEKtbnN1EtsX0ZxCsuvsbZrumyAJEKSNyZ84W3tAwfHUmpvGCW/3PAC076Gsht94nx
         vbJEna+rM2GutvWOEt4Ko5jxccThf65/bWBWZJhap2RkoY8T5DNdEDpaha8okZQViWNt
         ZUsCjl5Aan1V4p7V7Nx9+aWE6W6mZzK+anYHVJDhC8BlhHYBXuHmkaKwYl21aQJcX8yQ
         PvOXb9ZRvHQxx2UcnvCyNAdrpyKUcwQSTHkA1loiSu5J7pIfNgz6oFDXmTsizJ3/5oO1
         CgPEb9Bb3SRBQwKq8h0ELYT40nkNBja+NwT8AYvWi51GN2okW0BdoYP0VIcD+Bz2EOT1
         YA8A==
X-Gm-Message-State: AOAM5336WbyTDV4wQfORDYLy8x30fJ7qYtFOJKs8nYSv1do6vNyJOIaX
        oH5tpkErqjunCqWTc9x5zNV/dQtuGIBepOS8SSw=
X-Google-Smtp-Source: ABdhPJzbEuEeAxfZ8pxXNC1Fw4qiHRmG8ZCAc3jV9F6+XB7QWCtCl/fq2H5HN3Ydk7RU5VfLBYERVEj2aoE3TTarx/8=
X-Received: by 2002:a1f:a3d7:0:b0:349:6b56:a90 with SMTP id
 m206-20020a1fa3d7000000b003496b560a90mr8182434vke.12.1651005927731; Tue, 26
 Apr 2022 13:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
 <xmqqlevrr53n.fsf@gitster.g> <04bb01d859a9$b759cb50$260d61f0$@nexbridge.com>
In-Reply-To: <04bb01d859a9$b759cb50$260d61f0$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 13:45:16 -0700
Message-ID: <CAPUEspi_mX1xj1Nu2DuE83U9jB6oeRd=8FDPgGXbSC76mGHroQ@mail.gmail.com>
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
To:     rsbecker@nexbridge.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 1:10 PM <rsbecker@nexbridge.com> wrote:
>
> Putting garbage into DOAS_UID might end up causing some unwanted effects

Since it was the root user who put garbage there, we will have to
trust it was not
unwanted.  My proposal to use is_digit() was to make sure we didn't get garbage
from the getenv() call (ex: "") that would confuse the logic, but if
there is some sudo
version that is saving the uid as "ThisIsGarbage" then that is a bug
better handled
somewhere else.

Agree with you that using strtol is better, but the added checks and
logic make it
more complicated and go against the assumption made in the commit message
that the environment CAN'T be tampered with.

Carlo
