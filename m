Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14368C4332B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77D823120
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbhALRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406000AbhALRLo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:11:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81980C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:11:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id e18so3112005ejt.12
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ee1g2MpYUkhztAEQgKir12S/CElbBk34l0/LpUl+16Y=;
        b=jTDYzeHvP/ehPwN+tBc5Bn1tIRfI8On9PBhc4QTXT37N2su2aXSTDQd4RTqH+EcfEp
         3SOLGfhk3i6+BlwA+CmbVQG4nBm4Rk79ZZt0iqMtHWwkHlng3U8RhNty/JyN2frpnFho
         783PcPniDK2ihExEkcTvnvSgVihyviQWWilYt2L1ZJmYA1fTFz6MPaLft8NrWsaG59Rx
         Uiwuqohp63xRpIXVAT4+pdFPCCNidnuNanuejUNmrrkJiXq/O29qEqtdiiaZVdkbLTYf
         k8XJGLL8A/xtV2Hp4D8wyuxJDpIyiFYCklQIa5iClyiA554TGYRBz8tdW57AnhCPLUci
         rLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ee1g2MpYUkhztAEQgKir12S/CElbBk34l0/LpUl+16Y=;
        b=K7RxhCxD1cwiDmrxPWeUvAUflK8DoGqPflGIUN4+wRCMfjvhM4P/A/csLlYBkOcrx8
         tKI+bUAIVDuWxW2xl+GrVvZxRQyyaXtdJH23UqnyjQaLDA7WqPoyhjBv2DPvOufJsx1Y
         yiIOMUMB603xrYgdtzgwdOiqV0vobo5UpOlrbtbDD56DTIYXfDijnwYIkhIUPmiF6LJP
         r/ovtqQyo4tev9WJNtSbkB93yurHulHuANJEPnceX1K1DEwR02urQeZxDW+Z8I096yLv
         XvZG6guDLUX9GQjJcQrvc8o39bZbN+0Pnzb4dpJgpscNnWEC/Qm5qu0v9iPnIsjHg19q
         iv/A==
X-Gm-Message-State: AOAM530BL+EJJoz8/A7scz+T2syfntHiXu5DN5SSXi/k3cRrP0o2YfyC
        cs1yxgfzlPf8tQGghNqMmEqZVCC5BMo=
X-Google-Smtp-Source: ABdhPJzRzLpI75cIi9z3peZI9pojccEC8XBnen1U0qzv5pTDvmRvH9VPAMjHUFnVBsaryzmURKenlw==
X-Received: by 2002:a17:906:ae55:: with SMTP id lf21mr3831058ejb.101.1610471462084;
        Tue, 12 Jan 2021 09:11:02 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k2sm1435890ejp.6.2021.01.12.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:11:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 6/8] t: prepare for GIT_TEST_WRITE_REV_INDEX
References: <cover.1610129989.git.me@ttaylorr.com>
 <2288571fbeb83d6bd98917f4788c3221aa973c81.1610129989.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <2288571fbeb83d6bd98917f4788c3221aa973c81.1610129989.git.me@ttaylorr.com>
Date:   Tue, 12 Jan 2021 18:11:00 +0100
Message-ID: <878s8y5bdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 08 2021, Taylor Blau wrote:

> For now, sprinkle these locations with a 'grep -v "\.rev$"' to ignore
> them. Once the pack.writeReverseIndex option has been thoroughly
> tested, we will default it to 'true', removing GIT_TEST_WRITE_REV_INDEX,
> and making it possible to revert this patch.

Maybe some of it we can change/revert, but some of it just seems to be
test warts we can fix:

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 297de502a9..9696f88c2f 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -710,7 +710,7 @@ test_expect_success 'expire respects .keep files' '
>  		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
>  		touch $PACKA.keep &&
>  		git multi-pack-index expire &&
> -		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
> +		ls -S .git/objects/pack/a-pack* | grep $PACKA | grep -v "\.rev$" >a-pack-files &&

This seems to be testing "a *.keep file made my pack not expire". Can't
it just check for *.{pack,idx,keep} or even just *.pack?

>  		test_line_count = 3 a-pack-files &&
>  		test-tool read-midx .git/objects | grep idx >midx-list &&
>  		test_line_count = 2 midx-list
> diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
> index 431699ade2..5a59cc71e4 100755
> --- a/t/t5325-reverse-index.sh
> +++ b/t/t5325-reverse-index.sh
> @@ -3,6 +3,10 @@
>  test_description='on-disk reverse index'
>  . ./test-lib.sh
>  
> +# The below tests want control over the 'pack.writeReverseIndex' setting
> +# themselves to assert various combinations of it with other options.
> +sane_unset GIT_TEST_WRITE_REV_INDEX
> +
>  packdir=.git/objects/pack
>  
>  test_expect_success 'setup' '
> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
> index 2f7be23044..d064426d03 100755
> --- a/t/t5604-clone-reference.sh
> +++ b/t/t5604-clone-reference.sh
> @@ -318,7 +318,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
>  		test_cmp T.objects T$option.objects &&
>  		(
>  			cd T$option/.git/objects &&
> -			find . -type f | sort >../../../T$option.objects-files.raw &&
> +			find . -type f | grep -v \.rev$ | sort >../../../T$option.objects-files.raw &&
>  			find . -type l | sort >../../../T$option.objects-symlinks.raw

There's an existing loop just below that where we grep out
/commit-graph/, /multi-pack-index/ etc. whith other test modes add to
the objects directory with sed. Seems like this belongs there, not in
the find above it.

>  		)
>  	done &&
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 7d5b17909b..9ebf045739 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -848,7 +848,7 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f h2found &&
>  
>  	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
> -	ls http_child/.git/objects/pack/* >filelist &&
> +	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&
>  	test_line_count = 6 filelist
>  '

Maybe just check *.{pack,idx,keep}. I was looking at that code the other
day and it's really just being overly specific. It really just cares
about the *.pack files.

> @@ -902,7 +902,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
>  		clone "$HTTPD_URL/smart/http_parent" http_child &&
>  
>  	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
> -	ls http_child/.git/objects/pack/* >filelist &&
> +	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&

ditto.

>  	test_line_count = 4 filelist
>  '
>  
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 4a3b8f48ac..d52f92f5a1 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -106,13 +106,13 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
>  	test_commit "$(test_oid obj2)" &&
>  	# Our first gc will create a pack; our second will create a second pack
>  	git gc --auto &&
> -	ls .git/objects/pack | sort >existing_packs &&
> +	ls .git/objects/pack | grep -v \.rev$ | sort >existing_packs &&
>  	test_commit "$(test_oid obj3)" &&
>  	test_commit "$(test_oid obj4)" &&
>  
>  	git gc --auto 2>err &&
>  	test_i18ngrep ! "^warning:" err &&
> -	ls .git/objects/pack/ | sort >post_packs &&
> +	ls .git/objects/pack/ | grep -v \.rev$ | sort >post_packs &&
>  	comm -1 -3 existing_packs post_packs >new &&
>  	comm -2 -3 existing_packs post_packs >del &&
>  	test_line_count = 0 del && # No packs are deleted

This is all part of account where we later use comm/wc -l to check how
many new packs we have,so just check *.pack?

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 308c1ef42c..100df52a71 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -1629,7 +1629,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
>  	INPUT_END
>  
>  	git fast-import <input &&
> -	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
> +	test 8 = $(find .git/objects/pack -type f \( -name "*.idx" -o -name "*.pack" \) | wc -l) &&

Yay, there the existing multi-pack-index case is amended in a
future-proof way :)
