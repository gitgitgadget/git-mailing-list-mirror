Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F9F1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeHSXNz (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 19:13:55 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:43158 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeHSXNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 19:13:55 -0400
Received: by mail-qt0-f172.google.com with SMTP id f18-v6so14114161qtp.10
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 13:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hluqf8ajhpUYpjYHu3CNdQQYydCp4VJDNVBFUYyQl8Q=;
        b=gtKYqbFM3mnAyurYnFWi/2L/dFL0kDYnea20rueD8UCwMBY335mgsRB2ePz/CGJR9J
         WXayIu32i5dexmkh8CrQGSwVhTtMhS7UvlKNz6v8bd/RZPx7hQhiM6T9o8iKItak4b55
         nds+E9uPgVhGOopPO/NmoBOaK/Vzl8Lw5mmqU5Hem+2ffYIMZzzqQa8GI2lLK5UdUQYf
         EQzKSITgQIR4KXXE9r0awuPrKsEdPhI2bJ0hBIWe9bfkNqj3oOaafE+sFc3AKDEmwpx2
         /v9yv/Z9McWQqy1q5is96p4pRHv13kamDNh091lUeifZ06zqz8CXZhSimMNBKpkClZXE
         8qHQ==
X-Gm-Message-State: AOUpUlE7EYWCCg0PDF5YyImn3GMifu1HN5m5C6zTNnNkNapx4xMxcg2R
        bpO1ZPPM6hGJBOC1iTM2s45wYgdnOBHF9SuS5cQ=
X-Google-Smtp-Source: AA+uWPyJa/d0otreZyguMvByEphTFQVPBKe6EQYkqE281kJLUZDn/xD9ICgCAxYAul3SCAtlnpWGlg7z7uam3pB9H14=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr38130685qvm.6.1534708876562;
 Sun, 19 Aug 2018 13:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net> <20180819175351.449973-4-sandals@crustytoothpaste.net>
In-Reply-To: <20180819175351.449973-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 16:01:05 -0400
Message-ID: <CAPig+cSRYZ6X-71oZ473g_pChcfNcFyFPO3e8YoJmYyg+KwoyQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] t0000: update tests for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Test t0000 tests the "basics of the basics" and as such, checks that we
> have various fixed hard-coded object IDs.  The tests relying on these
> assertions have been marked with the SHA1 prerequisite, as they will
> obviously not function in their current form with SHA-256.
>
> Use the test_oid helper to update these assertions and provide values
> for both SHA-1 and SHA-256.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -868,8 +870,9 @@ test_expect_success 'writing tree out with git write-tree' '
> +test_expect_success 'validate object ID of a known tree' '
> +echo $tree &&

Debugging gunk?

> +       test "$tree" = $(test_oid simpletree)

If test_oid() fails to find key "simpletree", this expression will be
invalid. Therefore, it probably would be a good idea to quote the
$(test_oid ...) invocation.

> @@ -911,17 +914,18 @@ test_expect_success 'showing stage with git ls-files --stage' '
> +test_expect_success 'validate git ls-files output for a known tree' '
> +       cat >expected <<-EOF &&
> +       100644 $(test_oid path0f) 0     path0
> +       120000 $(test_oid path0s) 0     path0sym
> +       100644 $(test_oid path2f) 0     path2/file2
> +       120000 $(test_oid path2s) 0     path2/file2sym
> +       100644 $(test_oid path3f) 0     path3/file3
> +       120000 $(test_oid path3s) 0     path3/file3sym
> +       100644 $(test_oid subp3f) 0     path3/subp3/file3
> +       120000 $(test_oid subp3s) 0     path3/subp3/file3sym
>         EOF
> +       cat expected &&

Debugging gunk?

>         test_cmp expected current
>  '
