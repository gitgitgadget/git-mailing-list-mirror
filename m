Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC27C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873EF6023F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhGZOf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhGZOeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:34:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C0AC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:05:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j2so10115747edp.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2h2SUrGTGaoQ0r1W+mjRpIjGIqCtXaWs+wV5EsNqhdI=;
        b=hr746fLgDqKdSMens93IIvT8sAqr7DP4bD6cI7lDAsvZtHUA0xVcCjPJ32llZL7KwT
         NdXfI9VvMcClpVmPfEee64Iigt5rWqNQzqe7/zfFsp5laZvZ3r+3uAIlHENxvbJWvDfq
         O88pYpqBB1uX1T4Vb3jx9sGaVvTTwkth/5089Izi/BcPvgMTiy2sJqJFst9dIyBieE2X
         LXrC9UkgXJdzXgg0UJdVkSLLE1yr0q6a4D6mOYisRMQ5DIjMsDZgsAY435+CsF+okBHF
         H8G33VKviWRxJP28TfndcEd3RBsEm8IVPyFrg48EZdV/Mq04tFy3D0Wp5GTS5UsQNfo+
         Dn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2h2SUrGTGaoQ0r1W+mjRpIjGIqCtXaWs+wV5EsNqhdI=;
        b=c0WJTHOosj0kbZbSttKZVPD1z+XOuFnL5zqgjetGgZnCUVC5rPnO7/7vwXStBA7x6x
         udTI7aKdHmivOT6w1keJMUurs/eTemo/CLuCPm6J9p/nbXW6QfiibCmdB+XWVINGArI1
         bYhhRcdF7t/liav6uQwC+x2X/X76QE8DkgFgxTJPWApVg2U1heiXzbtO+PqiAjkejYQj
         B8eZFLSvMNyURHcEkaK06UC9TSbmUeI+KdcABFGQZGETFxrXbd5WTfGQc4V6ItWcey7I
         bIfGlTJS3JHUfIDVHcYRpJY2I8RUEe0bVtagMcP9KBfgFT582yjE01MlJzXZHQ7D+lPB
         4R8w==
X-Gm-Message-State: AOAM53152IwQvuYWJnPrT6dxk/emWLB124bqRw62ehe7HeA13/G8MFr1
        MlLfBulMDbLqCUU80Zli52o=
X-Google-Smtp-Source: ABdhPJyysHHFyzl3Bm36j8JyDIujCOIBLeiVU+p8kJcXp3sI1ofOAYVZ6ekzmn0lzSrJan1m2nyiyQ==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr8972345edq.170.1627311902342;
        Mon, 26 Jul 2021 08:05:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n6sm14362128ejc.120.2021.07.26.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:05:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v3 2/3] t5702: support for excluding commit objects
Date:   Mon, 26 Jul 2021 17:03:15 +0200
References: <cover.1627292424.git.dyroneteng@gmail.com>
 <92def8c72b8df57a41df3b53216e193b5d05a1d6.1627292425.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <92def8c72b8df57a41df3b53216e193b5d05a1d6.1627292425.git.dyroneteng@gmail.com>
Message-ID: <87a6m9ru85.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 26 2021, Teng Long wrote:

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  t/t5702-protocol-v2.sh | 166 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 133 insertions(+), 33 deletions(-)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 2e1243ca40..bcf21e1445 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -753,7 +753,7 @@ test_expect_success 'ls-remote with v2 http sends only one POST' '
>  '
>  
>  test_expect_success 'push with http:// and a config of v2 does not request v2' '
> -	test_when_finished "rm -f log" &&
> +	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
>  	# Till v2 for push is designed, make sure that if a client has
>  	# protocol.version configured to use v2, that the client instead falls
>  	# back and uses v0.
> @@ -776,7 +776,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
>  '
>  
>  test_expect_success 'when server sends "ready", expect DELIM' '
> -	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
> +	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child" &&
>  
>  	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
> @@ -796,7 +796,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
>  '
>  
>  test_expect_success 'when server does not send "ready", expect FLUSH' '
> -	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
> +	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
>  
>  	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
>  	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
> @@ -824,17 +824,44 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
>  '

This looks like a good cleanup, but should be split into another cleanup
commit. It looks unrelated.

>  configure_exclusion () {
> -	git -C "$1" hash-object "$2" >objh &&
> -	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> -	git -C "$1" config --add \
> -		"uploadpack.blobpackfileuri" \
> -		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> -	cat objh
> +    objt="$1"
> +    P="$2"
> +	version="$3"
> +
> +    oldc="uploadpack.blobpackfileuri"
> +    newc="uploadpack.excludeobject"
> +	configkey=""
> +	if test "$version" = "0"
> +    then
> +    	configkey="$oldc"
> +    else
> +    	configkey="$newc"
> +	fi

You've got all sorts of mixed space/tab indent here.

> +    if test "$objt" = "blob"
> +    then
> +        git -C "$P" hash-object "$3" >objh &&
> +        git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> +        git -C "$P" config --add \
> +                "$configkey" \
> +                "$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +        cat objh
> +    elif test "$objt" = "commit" || test "$objt" = "tag"
> +    then
> +        echo "$3" >objh
> +		git -C "$2" pack-objects --revs "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
> +        git -C "$P" config --add \
> +                "$configkey" \
> +                "$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +        cat objh
> +    else
> +        echo "unsupported object type in configure_exclusion (got $objt)"
> +    fi
>  }
>  
>  test_expect_success 'part of packfile response provided as URI' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> -	rm -rf "$P" http_child log &&
> +	test_when_finished "rm -rf \"$P\" http_child log" &&
>  
>  	git init "$P" &&
>  	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> @@ -843,10 +870,10 @@ test_expect_success 'part of packfile response provided as URI' '
>  	git -C "$P" add my-blob &&
>  	echo other-blob >"$P/other-blob" &&
>  	git -C "$P" add other-blob &&
> -	git -C "$P" commit -m x &&
> +	test_commit -C "$P" A &&
>  
> -	configure_exclusion "$P" my-blob >h &&
> -	configure_exclusion "$P" other-blob >h2 &&
> +	configure_exclusion blob "$P" my-blob 0 >h &&
> +	configure_exclusion blob "$P" other-blob 0 >h2 &&
>  
>  	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
>  	git -c protocol.version=2 \
> @@ -881,18 +908,40 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test_line_count = 6 filelist
>  '
>  
> -test_expect_success 'packfile URIs with fetch instead of clone' '
> +test_expect_success 'blobs packfile URIs with fetch instead of clone' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> -	rm -rf "$P" http_child log &&
> +	test_when_finished "rm -rf \"$P\" http_child log" &&
>  
>  	git init "$P" &&
>  	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
>  
>  	echo my-blob >"$P/my-blob" &&
>  	git -C "$P" add my-blob &&
> -	git -C "$P" commit -m x &&
> +	test_commit -C "$P" A &&
> +
> +	configure_exclusion blob "$P" my-blob >h &&
> +
> +	git init http_child &&
> +
> +	GIT_TEST_SIDEBAND_ALL=1 \
> +	git -C http_child -c protocol.version=2 \
> +		-c fetch.uriprotocols=http,https \

Isn't accepting http and https the default? Is this guarding against
config leak from a previous test? Ditto some later changes.
