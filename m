Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9AC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700B261417
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhFOKgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhFOKgS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9170C06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:34:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h24so21748548ejy.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U+N6N3qt7YOkVpqPG7HvZ6DauIzBqF/y1Z1J41VSoqA=;
        b=eQcfugpdrqSiX3pvQrKIqLUZLmDtIdEi8qDcv6CsryQoztnS122j4XXjxCY55IRKR1
         e6ouLRwUMoFBhbJYu0CHYPJAIl0JL3+1ehwm/F1DHye1ExDskWDDeLvXt8vxpQyLzxp3
         eWPLxBh87ORICQ76FeAfGXGZ8VzqZD1rn7n7VyBiPi3hTM1DtLhSKKR580D6eJ4adC+S
         BMNGmbW8rt+d+NhNj08uW+pa5gBcgH8bIY3x/gmgyxe8EGIsMbnR2bdb6he8prm0KQuw
         BniFOjzXe8kaMLfI7EB77IA+Vh/jo1Ny9delGrQjxlvv8R15yq0Bqo5CG0MgmeDMo9K/
         YmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+N6N3qt7YOkVpqPG7HvZ6DauIzBqF/y1Z1J41VSoqA=;
        b=gR+aaHYqiGn+4o6N5aQSj4ncffLw/UQKQbeAsABBJbWwyxwlJ3bUHrwA+idtC9yPsv
         h4GHK4WkJ8vLryPaWXBBWsUpfW4EaCD+LdinDPXBJvddDtkADgfnxpdKFhaJx9b9jc0C
         hWjbC1A+12Tp1WsFofUAIb4u1+P+xkpk7/8lF/AO7raWdhC3KIWXwFUgGK1n+4ZsGUMd
         7mLeQVOWq3EKSs6WFCMHdT4kNVdM9Cvsikw8QwwX6S6o8snI3YS6GipWaS5ndLt31ZNg
         fsM2Ms1fRve+feMTVPhM7KInA1B6+8EW9O9iagpEQVmBHhKfFwLwJ0EKCq+Jr5DcqoQh
         T9EA==
X-Gm-Message-State: AOAM530MHsuYyZ9uHPj0HUxhP95waCim8nhXVWJ6qopMk51OMeP5/Idp
        +qijlAi3hESX5WrDnT2yAALBq226RTc8fcHrj8Q=
X-Google-Smtp-Source: ABdhPJzXZvuNrKzIvg60yJe0HWpmsZaY1/Wp0gDWtLOwJhGM4qAaNaA5RUDRObVRQg+YQ0qJhaQ9+g==
X-Received: by 2002:a17:906:e2c7:: with SMTP id gr7mr19804683ejb.20.1623753251970;
        Tue, 15 Jun 2021 03:34:11 -0700 (PDT)
Received: from [10.7.18.6] ([138.199.18.136])
        by smtp.gmail.com with ESMTPSA id b1sm1019961ejz.54.2021.06.15.03.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 03:34:11 -0700 (PDT)
Subject: Re: [PATCH 3/6] mktag tests: test hash-object --literally and
 unreachable fsck
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
 <patch-3.6-96520b3e89a-20210614T172422Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <6148debe-fc44-67b7-ac9c-f27d376bc9f2@gmail.com>
Date:   Tue, 15 Jun 2021 12:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <patch-3.6-96520b3e89a-20210614T172422Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2021 19:28, Ævar Arnfjörð Bjarmason wrote:
> Extend the mktag tests to pass the tag we've created through both
> hash-object --literally and fsck.
> 
> This checks that fsck itself will not complain about certain invalid
> content if a reachable tip isn't involved. Due to how fsck works and
> walks the graph the failure will be different if the object is
> reachable, so we might succeed before we've created the ref.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t3800-mktag.sh | 48 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 951e6d39c2a..43b67a149f8 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -16,6 +16,8 @@ check_verify_failure () {
>   	message=$2 &&
>   	shift 2 &&
>   
> +	no_strict= &&
> +	fsck_obj_ok= &&
>   	no_strict= &&
>   	while test $# != 0
>   	do
> @@ -23,7 +25,10 @@ check_verify_failure () {
>   		--no-strict)
>   			no_strict=yes
>   			;;
> -		esac &&
> +		--fsck-obj-ok)
> +			fsck_obj_ok=yes
> +			;;
> +		esac

"&&" after "esac" got removed.

>   		shift
>   	done &&
>   
> @@ -37,6 +42,23 @@ check_verify_failure () {
>   			git mktag --no-strict <tag.sig
>   		fi
>   	'
> +
> +	test_expect_success "setup: $subject" '
> +		# Reset any leftover state from the last $subject
> +		rm -rf bad-tag &&
> +
> +		git init --bare bad-tag &&
> +		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
> +	'
> +
> +	test_expect_success "hash-object & fsck unreachable: $subject" '
> +		if test -n "$fsck_obj_ok"
> +		then
> +			git -C bad-tag fsck
> +		else
> +			test_must_fail git -C bad-tag fsck >out 2>err

This is the very end of the check_verify_failure function. It seems
that after "out" and "err" are created here, nothing else checks their
contents.

> +		fi
> +	'
>   }
>   
>   test_expect_mktag_success() {
> @@ -183,7 +205,8 @@ tagger . <> 0 +0000
>   EOF
>   
>   check_verify_failure 'verify object (hash/type) check -- correct type, nonexisting object' \
> -	'^fatal: could not read tagged object'
> +	'^fatal: could not read tagged object' \
> +	--fsck-obj-ok
>   
>   cat >tag.sig <<EOF
>   object $head
> @@ -216,7 +239,8 @@ tagger . <> 0 +0000
>   EOF
>   
>   check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
> -	'^fatal: object.*tagged as.*tree.*but is.*commit'
> +	'^fatal: object.*tagged as.*tree.*but is.*commit' \
> +	--fsck-obj-ok
>   
>   ############################################################
>   #  9.5. verify object (hash/type) check -- replacement
> @@ -245,7 +269,8 @@ tagger . <> 0 +0000
>   EOF
>   
>   check_verify_failure 'verify object (hash/type) check -- mismatched type, valid object' \
> -	'^fatal: object.*tagged as.*tree.*but is.*blob'
> +	'^fatal: object.*tagged as.*tree.*but is.*blob' \
> +	--fsck-obj-ok
>   
>   ############################################################
>   # 10. verify tag-name check
> @@ -260,7 +285,8 @@ EOF
>   
>   check_verify_failure 'verify tag-name check' \
>   	'^error:.* badTagName:' \
> -	--no-strict
> +	--no-strict \
> +	--fsck-obj-ok
>   
>   ############################################################
>   # 11. tagger line label check #1
> @@ -275,7 +301,8 @@ EOF
>   
>   check_verify_failure '"tagger" line label check #1' \
>   	'^error:.* missingTaggerEntry:' \
> -	--no-strict
> +	--no-strict \
> +	--fsck-obj-ok
>   
>   ############################################################
>   # 12. tagger line label check #2
> @@ -291,7 +318,8 @@ EOF
>   
>   check_verify_failure '"tagger" line label check #2' \
>   	'^error:.* missingTaggerEntry:' \
> -	--no-strict
> +	--no-strict \
> +	--fsck-obj-ok
>   
>   ############################################################
>   # 13. allow missing tag author name like fsck
> @@ -321,7 +349,8 @@ EOF
>   
>   check_verify_failure 'disallow malformed tagger' \
>   	'^error:.* badEmail:' \
> -	--no-strict
> +	--no-strict \
> +	--fsck-obj-ok
>   
>   ############################################################
>   # 15. allow empty tag email
> @@ -446,7 +475,8 @@ EOF
>   
>   check_verify_failure 'detect invalid header entry' \
>   	'^error:.* extraHeaderEntry:' \
> -	--no-strict
> +	--no-strict \
> +	--fsck-obj-ok
>   
>   test_expect_success 'invalid header entry config & fsck' '
>   	test_must_fail git mktag <tag.sig &&
> 

