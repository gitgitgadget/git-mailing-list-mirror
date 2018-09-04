Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294641F404
	for <e@80x24.org>; Tue,  4 Sep 2018 00:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbeIDEYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 00:24:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44673 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIDEYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 00:24:16 -0400
Received: by mail-qt0-f193.google.com with SMTP id k38-v6so2134915qtk.11
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 17:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ckkANDxKweLcTU61bS18OZ3kHqIPUgZnP7C+dYzyrA=;
        b=m+8DchtE5vXCyM/16PkSwtqjLDr3P5pXeRAAtYTZzS5kAH4oq2qyI3wTFQXRQWrz6A
         LQ8Q+ISFDCja9paBfea8fhN3SLrFB1xKGiyqfG+FQMGDcEXNdXaHQ4T28OFBSNjuFNXV
         SIL65mxmFkhw28B8W76Dk/J6vnI/smZdc34TI6T8yOSLbzPNFAqvgKQx1fkFl/TVWSmT
         yDWD6V5MyDuf7NU9idURmTPVbh/DX7S4WsusEs6ncv9OzhT9Yn0XSl3vGFaa3Kx1J3Ka
         jlUG9UhZmTH5vpc9lmlDDQTo6koJhsTc0kRvZIh7ooqiGFW6lQKb9u5GnJ1PXKED1d6N
         B49g==
X-Gm-Message-State: APzg51ABCsWdgYIysXmmaczCuHxall7J8pk4qXdrnquyrpLKUrP9ItMA
        Kqq29igJSOzdb91tcBSQwAQKlT25IGg6N0tDIm0=
X-Google-Smtp-Source: ANB0VdbDVrfgjFKWdjvj9TG2enK7wFxkGQDWrb3urrA5Ack632a3WBz79ofEevO+ZmVagNOgYFvrneJwUmpz1YAIqJU=
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr27231837qtr.250.1536019306812;
 Mon, 03 Sep 2018 17:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180903232515.336397-1-sandals@crustytoothpaste.net> <20180903232515.336397-2-sandals@crustytoothpaste.net>
In-Reply-To: <20180903232515.336397-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Sep 2018 20:01:35 -0400
Message-ID: <CAPig+cQZMEvJZ2b3RjtXvy9ZtTjRKUvye_xT0nibOqcHtpApZQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] t: add test functions to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 7:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Add several test functions to make working with various hash-related
> values easier.
> [...]
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -1155,3 +1155,70 @@ depacketize () {
> +# Detect the hash algorithm in use.
> +test_detect_hash () {
> +       test_hash_algo='sha1'
> +}

Not worth a re-roll itself, but if you do re-roll for some reason,
perhaps include a comment inside the function saying that the actual
"detect" part will be fleshed out later.

> +test_oid_cache () {
> +       local tag reset k v

s/reset/rest/

It probably wouldn't hurt to &&-chain the above, as well, to
future-proof it against someone coming along and inserting code before
the 'local' line.

> +       test -n "$test_hash_algo" || test_detect_hash &&
> +       while read tag rest
> +       do
> +               case $tag in
> +               [...]
> +               esac &&
> +
> +               k="${rest%:*}" &&
> +               v="${rest#*:}" &&
> +
> +               if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
> +               then
> +                       error 'bug in the test script: bad hash algorithm'

Did you want to redirect this to stderr like you do with error() in test_oid()?

> +               fi &&
> +               eval "test_oid_${k}_$tag=\"\$v\""
> +       done
> +}
