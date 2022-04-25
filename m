Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C640C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbiDYKWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiDYKWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 06:22:00 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C842A10
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 03:18:54 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id w21so5492382uan.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o2ydQJoeSgIIOtJO5gfmJtNFUtz9jLZHwlDmzjtJwUY=;
        b=fVOdO7QDjG8U/EyNLKG50MhjMveJbnfoWc26Tu4UEwMO5NBTAScJGxmTcni1MYDjxr
         gNb/OYbnjFhWIKq1nezZi7oimDY4uyGyTkm0piGR0fv7O6XZ+mu7EPmbrKmTnaV09cRK
         tQKScDc6S5RWlOxaTy6C9/JYul+zY3n/M+gH/v+zpe231H+PzoZXdqROlOJz2kCBiQqQ
         3FBOGlRTwzC1kqkdqs3OO+2zb73qlXlcbBir9Ac6CCJM6JQvH4eQp2KdwEb+bchMjyNU
         SSJG8sR7bQy9Zj/zCxjGXuW9YM0nGByEKxQL9dwRf97Bd/Du5XujExbyGPej1R/hyrqk
         uDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o2ydQJoeSgIIOtJO5gfmJtNFUtz9jLZHwlDmzjtJwUY=;
        b=CZkJWILiZSlNm6Ft2441zpzZ4RVaMR00sLeKV03cFsM/4TNpPlQaXU89uG9WxVhiuL
         6Cq1UzxxXEe624d1CgCmm1dTz/vTJaxj1IuA/tLRKqufcz9uLh9jCoyuHzLrA9QOwMDT
         Rvd8EJsOG7wkjQDe+/UaWQYC9FEbokdg8nbi2/CEQEjZ409gLMTn/QAa7Vcu5yv+CdtO
         jJ0rnPSRWtslaUKPd+naQwyftwyXehpUa/RduYjNd2szQ/simNwwvn2fLI/02wxcRynZ
         mfwvXFzBFZF+nEBYBwtRkQp8Qhvkoh0TR33PavSQLoHTxtdrAHQbsu5xB2Gip/nq7uoe
         j+6w==
X-Gm-Message-State: AOAM531O6rLOhvU1VWPQHD3OTERQPS7pQEj0SYka94puF7sBdncOpE/M
        HRVUle4V1Cix4mdzG0uxBnzroa1rqSFsHJJG8KGvrQ1Ou1I=
X-Google-Smtp-Source: ABdhPJxqtnjAzrWkxnDqtsyubE2TQVrUDTnpnDUtUJ81DF9WBBF7ffzVBv8JRAFhLVvljAkHHKjMzpE7ANlnKKHOUFA=
X-Received: by 2002:ab0:d95:0:b0:35d:4d4b:c59b with SMTP id
 i21-20020ab00d95000000b0035d4d4bc59bmr4899484uak.97.1650881933513; Mon, 25
 Apr 2022 03:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220415070236.25280-1-carenas@gmail.com> <20220415083058.29495-1-carenas@gmail.com>
In-Reply-To: <20220415083058.29495-1-carenas@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 25 Apr 2022 12:18:42 +0200
Message-ID: <CAFQ2z_MnFmyW064xPqc1EG1pRNq53pzab9zmt=rxHdGxA2Txcg@mail.gmail.com>
Subject: Re: [PATCH v2] reftable: avoid undefined behaviour breaking t0032
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2022 at 10:34 AM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> 1214aa841bc (reftable: add blocksource, an abstraction for random
> access reads, 2021-10-07), makes the assumption that it is ok to
> free a reftable_block pointing to NULL if the size is also set to
>..

either patch (data or len) LGTM

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
