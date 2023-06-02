Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72AC7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 07:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjFBHaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjFBH3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 03:29:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8351A2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 00:29:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d18d772bdso2040305b3a.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685690975; x=1688282975;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omH37iKhdlr+t2tvVE9f5eE2Fkr0Y5gl2hPRxGtDUnw=;
        b=QhqWzDeoPecITbbkfToyD32IGCfGJQJemqXzoadQ0h3ninpse0ojxvmxtbAIE+T+ak
         xcUSWkn04Hq2KUvJPrSrZpDfNJA8MEsfpgyZIwLpPf4k0wbdzz6e0htyvIeDyksht+Rx
         wv+OfEDGwxE46ekeeSo7sf6icIV3eVKCf0yiRe6bJUk73rkZfOGodwPcLgCINtOPTEJw
         uftnADVa11ObFBZRxmDDPJNigEB2ltCdhos1/ojPaP5h52Gz+MwccWXRthalUGUZX1er
         qhmcf/jW/bWcJm6LEjTFRMH50F3UwHOnCf4HDuK/mDt/8MnC/zjGugNhnZ7ikR0yPji3
         pszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685690975; x=1688282975;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omH37iKhdlr+t2tvVE9f5eE2Fkr0Y5gl2hPRxGtDUnw=;
        b=BXFNtQsSDUVrTdzxAcz37iVIwGeDOs5vfMuns+m5jcYBtFrvCeVdNp+r7hg1xukOPq
         B0safFSiVKNtmUeHI95BLhFjYNdeOwNDBIZ4y4oHurF0UyVcrY9rxFd18f/L9+/BtNAH
         DC1b8R3x19bfpMxtnVm9bcxEyJpYSvXSI+BTPgl1VoO767F0qAV7TpU+9kZpqkleQpSQ
         s3jbKKG087hQLLBTLhN5jGNo26nYxKF6/sFVBqrEr1HJ8CMeJo/5zs46SSvrtyeiM4Lj
         iMmjqJEf6MK8tci35P378nZhtOmWd4Zo1/Dg55oQXY+iNZIuNMXr6M+nKptGmEI4I4FC
         5jRg==
X-Gm-Message-State: AC+VfDzc3juhfawz+BXgo4/VPmT3zWnRmX/zDzre1y047SWvyXiB1FbX
        JQaZp4ft82A9rcCVJ4QZXh+P73wrnnVb6g==
X-Google-Smtp-Source: ACHHUZ6zNt/v9cVwoHQ+GSR45gcjCcHp9Tq7u4akbzayn5R0eCwAmJR1lMdR27O2V3uaZJDKuSYXQQ==
X-Received: by 2002:a17:902:d509:b0:1ad:eb62:f617 with SMTP id b9-20020a170902d50900b001adeb62f617mr1750090plg.45.1685690974899;
        Fri, 02 Jun 2023 00:29:34 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b001b1a2663e9bsm641055plm.77.2023.06.02.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 00:29:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add new "signature" atom
References: <20230529192209.17747-1-five231003@gmail.com>
        <20230602023105.17979-1-five231003@gmail.com>
Date:   Fri, 02 Jun 2023 16:29:34 +0900
In-Reply-To: <20230602023105.17979-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Fri, 2 Jun 2023 07:41:53 +0530")
Message-ID: <xmqqzg5i8gpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> I have also rebased this to be on top of v2.41.0, the previous version
> was on top of v2.41.0-rc0.

I am still feverish and feeling weak so no real review from me yet,
but there is one thing that immediately jumped at me.

> Range-diff against v1:
>
> 1:  5c97d11b79 ! 1:  87465ef1a8 t/lib-gpg: introduce new prereq GPG2
>     @@ t/lib-gpg.sh: test_lazy_prereq GPG '
>      +  test $? != 127 || exit 1
>      +
>      +  case "$gpg_version" in
>     -+  !"gpg (GnuPG) 2."*)
>     ++  "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")

The last '*' being inside double-quote would not be what you
intended, I suspect?
