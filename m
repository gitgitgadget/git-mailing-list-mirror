Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83751C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDLVQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDLVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:16:22 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FC5244
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a6715ee82fso2330555ad.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681334181; x=1683926181;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew7jnduykgCNiXLA2hSD8gWlQ4y+fLcpr+dZ07PKkdo=;
        b=s5NjQoGDDprsl2X2ljEZP/HlVoo5oQX3Zeqt5vuPgHiOEkdsYeF+cCZXcWA0Q95jVD
         GXb4K9opjsxKDC6r+bzRQnPZOdhfxyl6Lcjxy9J9ubKkjpnx9acu2m88XrgdT7hDwWbO
         CVL0dIvIPDz9nEPkMuYdK41fHs0oypYqHi19c9il0MYgMoQWkOBlSQTvkIC8rki8GXOV
         2MzKtYBEsEEMq8zdU+lKvtInoelN3jrphJGYzYgDNeSpa8FnCkHFzu+F7W9DxAz76D7o
         Od4X+VamGZ+HEw15KPcjZAhCsM4gn2pvn9bDkMP2hW8OPa1nnF7XFWxqKrx/RSoY8ys3
         QR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681334181; x=1683926181;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ew7jnduykgCNiXLA2hSD8gWlQ4y+fLcpr+dZ07PKkdo=;
        b=KDFE7RdccUHyecjhLti5yi0zJIxFEaxTFVNtN2B0fH0KXVTKopIgpH/dwwLdaGsP/S
         uIGBcM2Cff66sIVfA5Gy6/UQyupojUM+vMYvi4B3LdBQrSgs0NtY9a4HsKohhbLvX9sx
         pd43lZFoip4tZB0HsLISIf+xiZmDHhah2cQx/TMTz+Nmhg+RVvZqg7rGHBnBK8Hu4d0c
         uy5w1jf3jA/dUa8pHZDSu/s9kgVRVtq+vRf4vscMkhkv4SDbDILY1mSNHuYqjBjg4GrU
         JL39GwXHKwlaMIw493iuGdkXeiaGEtWrxLRZAVh/jIYn474YlOYsNnm9Dka8wLBJOGu1
         2i5g==
X-Gm-Message-State: AAQBX9eTmdZnJqn9EvOmljSi7lFYCIq+/gc8a20Zm/IkHNU/ksX+A8hv
        n34Xj7yzBWsRQ8lwMrMgUXQ=
X-Google-Smtp-Source: AKy350YyVFf51K0K48jsEy+7h3SgWFtxxtTZydWQTCGG4Nf+3jXkk6x2gClrVYO6rqXyCuQdhO/4xw==
X-Received: by 2002:a05:6a00:190b:b0:63a:e097:26b with SMTP id y11-20020a056a00190b00b0063ae097026bmr323980pfi.13.1681334180851;
        Wed, 12 Apr 2023 14:16:20 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b0062d7c0dc4f4sm12058596pfi.80.2023.04.12.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:16:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, adlternative@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v3 0/4] doc: interpret-trailers: don't use deprecated
 config
References: <cover.1680548208.git.code@khaugsbakk.name>
        <cover.1681326818.git.code@khaugsbakk.name>
Date:   Wed, 12 Apr 2023 14:16:19 -0700
In-Reply-To: <cover.1681326818.git.code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Wed, 12 Apr 2023 21:52:11 +0200")
Message-ID: <xmqqr0so7qe4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Replace deprecated `command` with `cmd` (patch 3). While visiting this
> file also:
>
> • rewrite heredoc examples to use files which are shown with
>   cat(1) (patch 1);
> • use input redirection instead of using cat(1) piped into `git
>   interpret-trailers` (patch 2); and
> • fix an example that didn’t work properly (patch 4).

This was a pleasant read.  I had small nits here and there but
overall the series is very well crafted.

Will queue.  Thanks.
