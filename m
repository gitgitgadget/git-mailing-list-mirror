Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E051C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4661106
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhEGXEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEGXEk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 19:04:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C58C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 16:03:39 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so5270571oic.2
        for <git@vger.kernel.org>; Fri, 07 May 2021 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YwZEzWGbxlZOwzeZ/BvahXt5Q5LTjpR9UsVUB1gyjk8=;
        b=ghia/JB20KRHIb10AsE+OBb0eyy3FUEkbxZcmrmycQE/hjyB6Ekc0esG6i8HgAfTPg
         1UMNbh3MetD6+pEUdGQfKr+nDNdLxqRqdi6W1KlNNudhVePgZeiAVcIeQNz13R26UmsZ
         IxD/Fi8JQ8v2FRaAyZBhDfZgjfR6iVVjTZYgJ4bf13LNo9axPgcuFkCtC7kpRPRNO8WW
         E0pqBMWEsekbfu2QDjpRmhhx+Xg+ZP4PUg0lIla740CH3TT+LA1NnPUDZ/QFN7iYW4tn
         AHhI7ulp/OlTK7C49DEEtcuEXp3IUTYPyASYtr/mCC76w4QZLmQbKke32nJxv0g71kKn
         /grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YwZEzWGbxlZOwzeZ/BvahXt5Q5LTjpR9UsVUB1gyjk8=;
        b=pIeJdjaGpC7CiizH+OrFvVtAUccCmi/RYCP/BFOVBX1C8fi6ei3l8DT/Bj1be7ht5j
         0EaaF8KRVO/rGkhsRSHOqOih+QRW3mEdlwRx177uSB8KnJhBzM96yVtpoIlHm8QohJDH
         vurfuY66p93IZp2Ku3nn/mAOj0T5r1Y4/DyRC7SI8Nr4qc6fbxHNmb8nIFh5tEcUr30O
         +F9rw0VfibpC1TPqIELIK++vpbnuaifkSg6IOZIyXXwNxtOJVqLNgpuWJ/Rda6QFyPH6
         MhdI2MgGhGQeLTrYNjz0+Ae81+O+M4HteN1pXbBjxDD+rtvdryqQ3GyAbkWqCHTMRzYp
         JezA==
X-Gm-Message-State: AOAM533IijlneSbmp1oPZOMhWYpuPv7RS5ws6KI21HwGMPj1+gFjwCTu
        o2vPbpdZsuNqs10Jgq/mXbZ7Dnd4GMbx7w==
X-Google-Smtp-Source: ABdhPJxHFnHrl3jfX0gxhf5K8up7OjYJixEBVZZu+ZWypqtsZMRUE8Z0AUXXpLhpvpfGS1scLtYY/A==
X-Received: by 2002:a05:6808:1150:: with SMTP id u16mr16675117oiu.74.1620428619251;
        Fri, 07 May 2021 16:03:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id z25sm632940oic.30.2021.05.07.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 16:03:38 -0700 (PDT)
Date:   Fri, 07 May 2021 18:03:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Message-ID: <6095c74993f19_cfc72085d@natae.notmuch>
In-Reply-To: <YJUyHkYAIth0W9dY@danh.dev>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJUyHkYAIth0W9dY@danh.dev>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-05-07 13:06:31+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote=
:
> > So completely migrating to Asciidoctor can eliminate xmlto requiremen=
t
> > for generating manpage.
> > =

> > What do you think about above?
> =

> Hm, I'm pretty sure Ruby (asciidoctor's language) is very hard to port.=

> Last I heard, it's buggy on some platforms.

And I'm pretty sure it isn't.

Ruby is a mainstream language. At some point it was #8 in the TIOBE
index, above PHP and Perl. Right now it's #11.

A lot of effort has been put to make Ruby work on all platforms.

> I think we're better to do like this:
> =

> * If we're using asciidoc, we will use xmlto
> * If we're using asciidoctor, we will generate man-pages with
>   asciidoctor directly

This certainly is the way to go.

I'm not sure if Bagas suggested to make USE_ASCIIDOCTOR=3DYesPlease the
default, but first we would need to make sure the output without xmlto
is desirable, which we don't at the moment.

So, even if we were to consider this, *first* the option to use pure
asciidoctor needs to be in place.

Cheers.

-- =

Felipe Contreras=
