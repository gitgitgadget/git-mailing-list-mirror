Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC34E1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 22:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfAGWFp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 17:05:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33349 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAGWFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 17:05:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2097099wrr.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 14:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkhNBLnybZovoOYuyhLRotsHaFF+CjVWvoVWHb/mqFw=;
        b=WdPDCtXQ+44wcl0S6tG3eXqtsMXwCVVk3t3hTMyxoixU4UOpHScuygSboAlAvz4RHc
         w/aeUtboSo1cNOkC3Kc8q77FXefVd2q20205rtowjhAvA8WxFluGiooFtmylkuN0w8d1
         iALuBZkpuRMR96mwKkeBi0KfcQB4MKTWDAE/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkhNBLnybZovoOYuyhLRotsHaFF+CjVWvoVWHb/mqFw=;
        b=CH7OQEGHuLKU2/UQk5z11weo08y5AUw23O6VZo0SlSgqSsYLH9+2ftlNi91xeodDqW
         7J3kH5v8unecuwn03q13X5YFEvhdzffUIzgz5QNQbLS2s7vOC/d3sKblaKYcNhVKKUyD
         xrjYJY/lOtjh6nVyybPlcssNzjDTCQPCRsgMTgrjWxWkbg3raYQwKQB5b1GD6x3erX7G
         1m0/zzeZKf820e1DIWdR3kSUSrktsTyGkicxl0yofAyx5EduwJyFim9Kq44ndO0JT1Po
         eiz+mPXEoYxyoVd86BsSJ2nSmhKKIJkFC6cJP6H23UfUVxNwii/cuWwDMbbQcJKbcvh2
         suFg==
X-Gm-Message-State: AJcUukfOSBgQXLD1V8W9tHPQfCR/v3uzrnekCuHqefxSv/ITufU7Ifbj
        NVBjxIPH45OXD9ao7dfhUg2bG6JYbBTR+YSjJxabkA==
X-Google-Smtp-Source: ALg8bN7QghPcNgCcTFmhuvwGD9L2KcYywcBDCyDpfZFzMzlN2qfgcHEnR1F+8XDKk/v6bsm4v6NUYOGQmb2c7QeAadE=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr45536633wro.35.1546898743900;
 Mon, 07 Jan 2019 14:05:43 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1901072148380.20807@fractal.localdomain>
In-Reply-To: <alpine.LFD.2.21.1901072148380.20807@fractal.localdomain>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 7 Jan 2019 22:05:32 +0000
Message-ID: <CAE5ih7-qFrYXfsWr6MebSFBtDERLKGf0zb73yaV6Eit4PJHcJA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: fix problem when p4 login is not necessary
To:     Peter Osterlund <peterosterlund2@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 7 Jan 2019 at 20:51, Peter Osterlund <peterosterlund2@gmail.com> wrote:
>
> In a perforce setup where login is not required, communication fails
> because p4_check_access does not understand the response from the p4
> client. Fixed by detecting and ignoring the "info" response.

This is caused by my earlier change in this area. I think this fix
looks good, thanks.
Ack.

>
> Signed-off-by: Peter Osterlund <peterosterlund2@gmail.com>
> ---
>   git-p4.py | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 1998c3e141..3e12774f96 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -332,6 +332,8 @@ def p4_check_access(min_expiration=1):
>               die_bad_access("p4 error: {0}".format(data))
>           else:
>               die_bad_access("unknown error")
> +    elif code == "info":
> +        return
>       else:
>           die_bad_access("unknown error code {0}".format(code))
>
>
> --
> Peter Osterlund - peterosterlund2@gmail.com
> http://hem.bredband.net/petero2b
