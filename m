Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD3C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiBVNVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiBVNVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:21:09 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341AEC334E
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:20:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p7so41618811qvk.11
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXyGVH32OCeQgP1R2nttgjOJxSiOV6SZF15UpXVUCtY=;
        b=q7Wbn8L/l4Z7s6B7iWGyz432mwA84ll2Z7OkFo5Tv8pHnvrHtq7ryU6FNmb744ePZU
         2QW4QYTcAOEz6KfWkdx0HwUYLtxW7ES56rt4EDsPB1qVF0KbJyXiRzdAXL31V4x3Xn5N
         8PJWu2rGQ5lT9I8Sou8dqrjWCVD/R3KjVovBnsQR4LB8yhFj36BA6U8/TG4+oRZV5wX/
         6tMcDN5gYsYD7/44j7jh7efAZyQ/uG7y/MtZaeipu9+iCqqdeA6TIDF2txA0KiCAmHGT
         LU5CgTYR5Fo/VwK9f2VbtH4K/2v1ZUSNT1susA3uy+SlzxdAExA8DUnaW8BULmal8aml
         wa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXyGVH32OCeQgP1R2nttgjOJxSiOV6SZF15UpXVUCtY=;
        b=fTf9W1Zl0wl6Eo01S+Fwks0qwxaoy+FhVh+4YmgEg9pz7ruBJVjm7Y99QUQ8w7wLWx
         2o///lXVQARsnISYdBJ4g5FxR9uKf5Zq+ifiJ+qDjF4Qmrp/L1ASg/xSH6nY1QKpSkLX
         ve7nGS2+sfnUSNvSFb0nOqT5jOuVXt5OpB2a7/PuPGL28SwBn5uskmXeq2pNOY+JP6HE
         kGl/w+ajWgFmR4w1zDHm5GpstMgBfacq8NMfqTIuLgaq/AyIpndgulzs2j3Qv0r3h33H
         TR8NQtV53f5sR8NTkYyTgdzN59kqCWI+iG63DIGfNe4bvKkQU6ixQZ89BOYM7Gfg+7iZ
         JXIw==
X-Gm-Message-State: AOAM530LYQabXDyDUQ7pKVi395vk5HYqXBHms8dnCmmADREf2YRp0ONr
        o0Z7OjJIXKDU/K0RQinWQhO3tyDvKec=
X-Google-Smtp-Source: ABdhPJwQ2/7d9Z/+UTS1JOjmVbQj/TWD0vuUTk1j7CKBIxx4cheS+bA4h7iTilbUE9+3ChqB+kp3zQ==
X-Received: by 2002:ac8:7d90:0:b0:2dc:8dd3:276f with SMTP id c16-20020ac87d90000000b002dc8dd3276fmr21767924qtd.508.1645536041724;
        Tue, 22 Feb 2022 05:20:41 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id k10sm1015333qkj.45.2022.02.22.05.20.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:20:40 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 3/4] cat-file: add remove_timestamp helper
Date:   Mon, 21 Feb 2022 22:31:14 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <7905D997-249D-4DDF-A97D-0667499AE786@gmail.com>
In-Reply-To: <220219.86a6ene548.gmgdl@evledraar.gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
 <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
 <bf74b6cd75bd886c1b5954693beeaccdfd2e51ec.1645208594.git.gitgitgadget@gmail.com>
 <220219.86a6ene548.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On 19 Feb 2022, at 1:33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> maybe_remove_timestamp() takes arguments, but it would be useful to ha=
ve
>> a function that reads from stdin and strips the timestamp. This would
>> allow tests to pipe data into a function to remove timestamps, and
>> wouldn't have to always assign a variable. This is especially helpful
>> when the data is multiple lines.
>>
>> Keep maybe_remove_timestamp() the same, but add a remove_timestamp
>> helper that reads from stdin.
>>
>> The tests in the next patch will make use of this.
>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  t/t1006-cat-file.sh | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 145eee11df9..2d52851dadc 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -105,13 +105,18 @@ strlen () {
>>  }
>>
>>  maybe_remove_timestamp () {
>> -    if test -z "$2"; then
>> -        echo_without_newline "$1"
>> -    else
>> -	echo_without_newline "$(printf '%s\n' "$1" | sed -e 's/ [0-9][0-9]* =
[-+][0-9][0-9][0-9][0-9]$//')"
>> -    fi
>> +	if test -z "$2"; then
>> +		echo_without_newline "$1"
>> +	else
>> +		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
>> +	fi
>>  }
>>
>> +remove_timestamp () {
>> +	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
>> +}
>> +
>> +
>>  run_tests () {
>>      type=3D$1
>>      sha1=3D$2
>
> I may have missed some previous discussions, but is there a reason this=

> echo_without_newline dance is needed? At this point this on top passes
> all tests for me on both dash and bash:
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 2d52851dadc..8266a939f99 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -104,18 +104,19 @@ strlen () {
>      echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
>  }
>
> -maybe_remove_timestamp () {
> -	if test -z "$2"; then
> -		echo_without_newline "$1"
> -	else
> -		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
> -	fi
> -}
> -
>  remove_timestamp () {
>  	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
>  }
>
> +maybe_remove_timestamp () {
> +	if test -n "$2"
> +	then
> +		echo "$1" | remove_timestamp
> +		return 0
> +	fi
> +
> +	echo "$1"
> +}
>
>  run_tests () {
>      type=3D$1
>
> The move is another comment, if we're adding a remove_timestamp() let's=

> define it before maybe_remove_timestamp() which uses it, even though in=

> this case we can get away with it...

Thanks for these suggestions! I'll adjust 3/4 to include these changes.
