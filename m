Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939F76101A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhHZEZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 00:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhHZEZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 00:25:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BEC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:24:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z1so2035046ioh.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ysgQ/e+ZtoM8b6mCzTJmXHrTyV+d+NdiCIgxgRewGmY=;
        b=N7KZlE9yZ/RX+Z7O8udZ8f70E+xMFIAC5RYzNSxgVdcDhbSyUXYQXzFPmg+JwEJGas
         y+yX9qa62vaeUaDk+N+0OBCmNyQU8E0HfA/b6DCh95AL3ReX2Cvr8ejWvw5G/gaRbaSY
         MyXC6rAYMIaicXQUd5H7de0KSKmn6doMdrBvrcHfTK0+AsyfyDexHi17bqP2+5QbHPB5
         G8y5+yMBTgztdpOlm2+9OLJ04GvdQwFEQBo9YTdsH4Wpl7PMMhuG9C1b+OzKWlllGx25
         c/s23bfu5tUfYflF7E8ndiYkoTDoY3t2TfGEzhps8TjAVlrkzJVfKwQ4/m/0WDKZ3LTu
         4yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ysgQ/e+ZtoM8b6mCzTJmXHrTyV+d+NdiCIgxgRewGmY=;
        b=llJyo8WhJtapSsuVUQ+f1Smx3E+hfV/Qag5D7p+OGzEjWjfLPxE0prF00Maab4c64A
         AtDZgxCvM75OJWsHxmNO6sRwXTgpy9ssxVevVq2cdXqtcp83R03hsYCWHGI8OPTEZALA
         JR6+OTKXbpfI1GGM1FIDCQxJzUFLVtW5bdsC2xH0tD0rAxtHi6UMggKkWYQBC4ygncbw
         dt4U1exBvlM1ygL9SGWgBckL/k8tlFY4fdzJaL4Xw97jDaymgcS/OJDwAo6wINXK1POf
         GqkVwgOiITZZmn34DxWtTr0Rxm3UKF2X+bKUsDP0aaXlqj6wgbyU/W8Kmcf6YiJC68EI
         uMnQ==
X-Gm-Message-State: AOAM530gzQA5tdd1D7eg76b6Q7nPrMH3TaRyx5wKoDn7puCcyXY3Cevy
        DTLve/IXNfg8m1mPxbRMOSUaJQ==
X-Google-Smtp-Source: ABdhPJx7Xk04kUMePbde2Ifa4JumwJ5wIAfS8w0LXiQne4Od3VoTVWajRgnbw4p2trNuXv5gJ9MMiA==
X-Received: by 2002:a02:878e:: with SMTP id t14mr1777143jai.4.1629951855369;
        Wed, 25 Aug 2021 21:24:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h8sm1113801ile.39.2021.08.25.21.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:24:15 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:24:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de
Subject: Re: [PATCH] test-lib-functions: avoid non POSIX ERE in
 test_dir_is_empty()
Message-ID: <YScXboC0M1IPNFon@nand.local>
References: <20210826031710.32980-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210826031710.32980-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 08:17:10PM -0700, Carlo Marcelo Arenas Belón wrote:
> 0be7d9b73d (test-lib: add test_dir_is_empty(), 2014-06-19) uses an
> ERE through the egrep tool (which is not POSIX) using an ? operator
> that isn't either.
>
> replace invocation with two equivalent simpler BRE instead.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  t/test-lib-functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index e28411bb75..2803c97df3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -790,7 +790,7 @@ test_path_exists () {
>  test_dir_is_empty () {
>  	test "$#" -ne 1 && BUG "1 param"
>  	test_path_is_dir "$1" &&
> -	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> +	if test -n "$(ls -a1 "$1" | grep -v '^\.$' | grep -v '^\.\.$')"

This replacement is correct, but I'm not sure that I necessarily find it
simpler. If we really are concerned about egrep usage, then

    if test -n "$(find "$1" | grep -v '^\.$')"

would suffice. But it looks like we are fairly OK with egrep in t (`git
grep 'egrep' -- t | wc -l` turns up 19 matches), so I'm not sure the
change is necessary in the first place.

Thanks,
Taylor
