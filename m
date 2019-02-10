Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8801F453
	for <e@80x24.org>; Sun, 10 Feb 2019 08:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfBJIhi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Feb 2019 03:37:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35195 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfBJIhi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 03:37:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so4722586qka.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 00:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6NhhFeEzpPpYAzf3Ou7usjbCr5mLOBxqHYB4AnsRxzU=;
        b=AgL7L2P3BN2QssUSelUsRjziMTXV1xMv2Z6k3pRHmwmZmiwYKV0/RDq0WzXZZiTpWX
         NmzN/s8cNfU3o3TC5CZEUqe8iWEBAmVmLXZsrVfu1so/LCpYbSZT3iUG74ml3c9IoefX
         x5q76wwGnQrE54Vms92Oq72T96MQITDU5mZ7MpHf+NJrWKA67Fqmx6ly/3jyRAwyEAOH
         6IQ5lHm9Ue/K0hUxSEXZEeqQ+4anFLaLnjOI0SIyy+SEBzrDPZIzCO5DibX2dGTWMxrG
         t6C/jsKvRKJxWrKWkH30rr5aehTVnID5mVa4BkPIX+jcEzPPERXs8J8BFSB9xvhO3De4
         05Ng==
X-Gm-Message-State: AHQUAuZCpbD47O53xt7gOZ6gEpqkUBaoqoXlgP8Vb3hChShsFV2d//tC
        1uB1JjPefPBB6GIsKSvU5cuLuvRIsTPIFNwoUqg=
X-Google-Smtp-Source: AHgI3IazTlStNKfbI4LCiS89r3ul9lDM3Bz4R2rCsX4mOX3J7ui5ITJg5GbEOM+IWbtiNKdIBbZI1LDjrS8l8OIIYrY=
X-Received: by 2002:a37:a4c2:: with SMTP id n185mr8857618qke.152.1549787857576;
 Sun, 10 Feb 2019 00:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190208090401.14793-1-pclouds@gmail.com>
 <20190208090401.14793-16-pclouds@gmail.com>
In-Reply-To: <20190208090401.14793-16-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Feb 2019 03:37:26 -0500
Message-ID: <CAPig+cQbLLR7QeFXZLtEkHUMENdq+sy=dNvZj7jUkq-7_MXUkQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] switch: no implicit dwim, use --guess to dwim
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 8, 2019 at 4:05 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Similar to automatic detach, this behavior could be confusing because
> it can sometimes create a new branch without a user asking it to,
> especially when the user is still not aware about this feature.
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -31,22 +31,13 @@ branch.
>  If <branch> is not found but there does exist a tracking branch in
> +exactly one remote (call it <remote>) with a matching name and
> +--no-guess is not specified, treat as equivalent to

For consistency with typesetting in the rest of this document, you
probably want s/--no-guess/`&`/, though probably not worth a re-roll,
though, if this is the only issue with v2.

> @@ -182,6 +173,26 @@ explicitly give a name with `-b` in such a case.
> +--[no-]guess::
> +       If <branch> is not found but there does exist a tracking
> +       branch in exactly one remote (call it <remote>) with a
> +       matching name, treat as equivalent to

Most places in this document typeset these as `<branch>` and `<remote>`.
