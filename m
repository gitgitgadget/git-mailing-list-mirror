Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7E3C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589D61152
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhDOPdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhDOPdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:33:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C64C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:33:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so14642823pjb.0
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zZmYonZNosSeZ7cZrsCtWaPTu+sdATtIOX96L9Uga9g=;
        b=MvLkc6lfYAgM4BoqEZHrcmLDsKCaQuvsveMnryB0KcrqTO3xondaLjHgaSO34x5pxM
         h+zB8rx9KW80cEc85KhZRAk8Qjd0tRLhTdZ0XdIomSqO9+m8dtF0gjB5DKgilNznzr9J
         m2DOyyFzdPyg439oRHal6ys8NHlkKqap+9fYXsEoV10Etm/GwAotgvOqcEpBGmLU4QBq
         NTZNfBTVc8uLxAZ1dorKAYruDxI+Xvaa8O4eJiQcQIEsYzhvYL3RGobiU684ASgDMheC
         txq8694vx2fETDkcyO3B8y3y2nmCJvZMs1mWCAf2cfUfbCSN4Cj4dBqp4EFVmX3P5QTF
         kgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zZmYonZNosSeZ7cZrsCtWaPTu+sdATtIOX96L9Uga9g=;
        b=bM8C/v/0vXMeir9/vDnIFrWrOARLmB8SSzVpAe4uUSM6w1meFVvBQaQnHvCD0OWKtw
         01hsolq2yZn3sEaZWpGhH8qvPxHNvv5L2hy88PC7LArQUJ173Ek6x9ZWdZdX9+Zgdmbf
         6o0izXopSdFFppmiK8oLUm8zOV7yijlG+/E4AsF5cmu6rkMJyDOK/ShBevGIyLbDz//c
         llrHAf+VO+3U2UuWi0xgBmjhMNxNiA9sIw/O7HMbIdZlzV8urfVF3knMsV+IQj4IrXli
         i3v4quny6yydMz8DGfhXucbLj5gC9wLi4Ni2FiQjjixO1HFmsoQbnruT8CldJApxjAta
         nImQ==
X-Gm-Message-State: AOAM530p7OaB+UqH3Xlw8BkvOre4QGLuuMpXBpCxRo3IL+6vnD6AjxI1
        oc/tugBEHC1Occ3PYTjGnpE=
X-Google-Smtp-Source: ABdhPJztCwZ+sFT9npo6jrS63SPzCQy5g5gxyx9IJN3RnAE6HfnjWENds76CeB7blCjbRsYoiBb4aw==
X-Received: by 2002:a17:902:d305:b029:ea:db56:e7d with SMTP id b5-20020a170902d305b02900eadb560e7dmr4566760plc.66.1618500805840;
        Thu, 15 Apr 2021 08:33:25 -0700 (PDT)
Received: from localhost ([2402:800:63b8:e237:6144:daaa:2a78:8b4c])
        by smtp.gmail.com with ESMTPSA id s5sm2691554pgp.7.2021.04.15.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:33:25 -0700 (PDT)
Date:   Thu, 15 Apr 2021 22:33:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/16] test-lib functions: add an --annotated-tag option
 to "test_commit"
Message-ID: <YHhcwzYstq3i9qT4@danh.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-06.16-8d43fdd5865-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-06.16-8d43fdd5865-20210412T110456Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-12 13:08:55+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>  	git branch B A^0
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index fa3e3e975fd..a0fcc383d0b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -180,6 +180,10 @@ debug () {
>  #   --no-tag
>  #	Do not tag the resulting commit, if supplied giving the
>  #	optional "<tag>" argument is an error.

This comment applied to previous patch, but I think we need this patch
to justify for optional "<tag>" argument is an error for "--no-tag"

----8<----
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a0fcc383d0..ed0a4e5e5d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -253,6 +253,10 @@ test_commit () {
 	    $signoff -m "$1" &&
 	case "$tag" in
 	none)
+		if test -z "$4"
+		then
+			BUG "<tag> given to test_commit --no-tag"
+		fi
 		;;
 	light)
 		git ${indir:+ -C "$indir"} tag "${4:-$1}"
----8<----
> +#   --annotate
> +#	Create an annotated tag with "--annotate -m <message>". Calls
> +#	test_tick between making the commit and tag unless --notick is
> +#	given.
>  #
>  # This will commit a file with the given contents and the given commit
>  # message, and tag the resulting commit with the given tag name.
> @@ -192,7 +196,7 @@ test_commit () {
>  	author= &&
>  	signoff= &&
>  	indir= &&
> -	no_tag= &&
> +	tag=light &&
>  	while test $# != 0
>  	do
>  		case "$1" in
> @@ -220,7 +224,10 @@ test_commit () {
>  			shift
>  			;;
>  		--no-tag)
> -			no_tag=yes
> +			tag=none
> +			;;
> +		--annotate)
> +			tag=annotate
>  			;;
>  		*)
>  			break
> @@ -244,10 +251,20 @@ test_commit () {
>  	git ${indir:+ -C "$indir"} commit \
>  	    ${author:+ --author "$author"} \
>  	    $signoff -m "$1" &&
> -	if test -z "$no_tag"
> -	then
> +	case "$tag" in
> +	none)
> +		;;
> +	light)
>  		git ${indir:+ -C "$indir"} tag "${4:-$1}"
> -	fi
> +		;;
> +	annotate)
> +		if test "$tag$notick" = "annotate"

Perhap I'm missing something, however, I couldn't get the reason for
inserting "$tag" here. I wonder what wrong with:

	if test -z "$notick"
	then
		test_tick
	fi &&

> +		then
> +			test_tick
> +		fi &&
> +		git ${indir:+ -C "$indir"} tag -a -m "$1" "${4:-$1}"
> +		;;
> +	esac
>  }
>  
>  # Call test_merge with the arguments "<message> <commit>", where <commit>
> -- 
> 2.31.1.634.gb41287a30b0
> 

-- 
Danh
