Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F52C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 07:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfFJH5a (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 03:57:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39987 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfFJH5a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 03:57:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so8111611wre.7
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 00:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YB0cMuxOEBm47A3BW7oDQSC4IF/LbA1G3v2ZgCydg34=;
        b=ixSm+erSC20LQPDn6AX45kk/4z+a7eZ+3iu3wDnThr6P4GCFpEl32b+Zh3QE+T1z7E
         8Yskq23uKgxfbzgspLpgQ+v5NL0J0E3EbyFJpa3LarwaJBaECopTpSXTQVtOKm1adj5R
         gyquPFl35+TL54rXkeqDqzBxvvv2xtckFmPboLbqzCm8l9tFBMQVHtLkpissWB7wl9/7
         brTVCJVs7ZKOzWDDLa01KlRXHhEF+p3LiepYjHoSRBIUDlD5DFdrtgRcWtO6b13e/nXD
         dMWWVxEvPwcUiFejL4BXb8HfZmgKW74FEo82tU+fQg87/aFYXHN3vbdBIgcWtzBnJ5j0
         G/wg==
X-Gm-Message-State: APjAAAUbGKPNay7nSxxfRg7XUOyup/5JV4qopTTdrU+8lbkGp6Lb9YZP
        oA2tbTNFZLA9QFSqU9epqzOLHGEUct5lq4YD8pE=
X-Google-Smtp-Source: APXvYqxZHecYwmsefhqPtjIE9FN7XG5F9e3FU2mX8yvrvvwpwg3NYgyZSmYaDEahFla0sc6Sy+khu/9Vtb9OY0nE52E=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr28917412wrw.10.1560153448249;
 Mon, 10 Jun 2019 00:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190609224400.41557-1-sandals@crustytoothpaste.net> <20190609224400.41557-4-sandals@crustytoothpaste.net>
In-Reply-To: <20190609224400.41557-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Jun 2019 03:57:18 -0400
Message-ID: <CAPig+cT_457aAXEXYm1ZrFVuLmFeKVaJ7ahf9AmbrWwuoSRKfQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] t1450: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 9, 2019 at 6:44 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Replace several hard-coded full and partial object IDs with variables or
> computed values.  Create junk data to stuff inside an invalid tree that
> can be either 20 or 32 bytes long.  Compute a binary all-zeros object ID
> instead of hard-coding a 20-byte length.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> @@ -9,6 +9,7 @@ test_description='git fsck random collection of tests
>  test_expect_success setup '
> +       test_oid_init &&
>         git config gc.auto 0 &&
>         git config i18n.commitencoding ISO-8859-1 &&
>         test_commit A fileA one &&
> @@ -16,7 +17,8 @@ test_expect_success setup '
>         git checkout HEAD^0 &&
>         test_commit B fileB two &&
>         git tag -d A B &&
> -       git reflog expire --expire=now --all
> +       git reflog expire --expire=now --all &&
> +       test_oid_init
>  '

Why does this function call test_oid_init() twice?
