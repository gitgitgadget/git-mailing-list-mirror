Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03406C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 07:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiFIHfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFIHfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 03:35:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FD19C1E
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 00:35:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so20352236pjq.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F03ote6be15tp3l4FNypH0ZtwBqt03oCTrOLmBh8y3s=;
        b=ljQt41hMGrXRokkymkVtVcY7CUc9THfoPDlmKwvMu4/UCtRs8pTRDEmoNRekbtYuM7
         RhQYWW5otYt/tiBu0FGTkVk2aWYYd+Nz0s9fOgvtWIHsD2z8aLQHuME//cV9mc3Dh68Y
         qnUxRFq75RV0GzVmUzMIJaLmJ+81XzQuPcvkW2VAPdS3QULutUOQebfJLEVYAlA07U8i
         m7kDVQy0saAtdX3JpHqwH0l29j4ztSBq1s9kV0eK2W/Cz5pOTtR1LjZvgxT2Mp3h9z84
         iba64bmGbKebeVNbvdRbz6fApZGN5Dw4QVCnbRJLb4JeMxPDa8XEzbkB8FCH/YDfCkPK
         TMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F03ote6be15tp3l4FNypH0ZtwBqt03oCTrOLmBh8y3s=;
        b=ILKCSUvqBob20j1M10Y9VGI0A5BleJRqK5xUK+kgsWOOVa8gVL91pQ7wfIReEWgwim
         +lrB2Ojk32wBtdgbaUXn7RlxvDvgLq+wWfc4XD4BPcSB+Eumr4hW6kyGdU/EJkMJoKZR
         JD3BSnhVwhdT+UzY0JGdr4Xt5BLE0NqphAIPD0f3V/Z4iFNnd8ae3eP5OhAuCrOR2roQ
         SemJthQd1K4duK5wz1j21RLU0EZwOCMI1RkAB7L5l5EsXvaDOoQLL5gEHR/tvPRd3htC
         P9P7mxWlrW+RKwiDW5TDQpNxF1jiykk/zDZ8VklPdTD+SqTfpvQ9xlEYmoGKQZsx8s9E
         o/sA==
X-Gm-Message-State: AOAM532jgtD3R80mytacBU1ql9ZYtYrD08fw0P0YU0zMXKrVeb2u4jwH
        nqHvXq5JiuXvkJ5K790X3tU=
X-Google-Smtp-Source: ABdhPJxPYCi8FqDt00LCUWcbF70g1tcFfk+YH7C0sLniE3w4kAwyU/ZcA/Tu4rB+D2yGSawYou6Bhw==
X-Received: by 2002:a17:90b:1651:b0:1e8:3f13:5cb9 with SMTP id il17-20020a17090b165100b001e83f135cb9mr2108041pjb.20.1654760113220;
        Thu, 09 Jun 2022 00:35:13 -0700 (PDT)
Received: from [192.168.1.164] (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id k197-20020a636fce000000b003fe4836abdasm1926484pgc.1.2022.06.09.00.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 00:35:12 -0700 (PDT)
Message-ID: <f4a193ab-8226-fbc9-2276-a4f5d5285843@gmail.com>
Date:   Thu, 9 Jun 2022 00:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] object-file.c: batched disk flushes for
 stream_loose_object()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        l.s.r@web.de, neerajsi@microsoft.com, newren@gmail.com,
        philipoakley@iee.email, stolee@gmail.com, worldhello.net@gmail.com,
        zhiyou.jx@alibaba-inc.com
References: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
 <20220609030530.51746-1-chiyutianyi@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
In-Reply-To: <20220609030530.51746-1-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2022 8:05 PM, Han Xin wrote:
> Neeraj Singh[1] pointed out that if batch fsync is enabled, we should still
> call prepare_loose_object_bulk_checkin() to potentially create the bulk checkin
> objdir.
> 
> 1. https://lore.kernel.org/git/7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com/
> 
> Signed-off-by: Han Xin <chiyutianyi@gmail.com>
> ---
>   object-file.c                   |  3 +++
>   t/t5351-unpack-large-objects.sh | 15 ++++++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/object-file.c b/object-file.c
> index 2dd828b45b..3a1be74775 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2131,6 +2131,9 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
>   	char hdr[MAX_HEADER_LEN];
>   	int hdrlen;
>   
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		prepare_loose_object_bulk_checkin();
> +
>   	/* Since oid is not determined, save tmp file to odb path. */
>   	strbuf_addf(&filename, "%s/", get_object_directory());
>   	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
> index 461ca060b2..a66a51f7df 100755
> --- a/t/t5351-unpack-large-objects.sh
> +++ b/t/t5351-unpack-large-objects.sh
> @@ -18,7 +18,10 @@ test_expect_success "create large objects (1.5 MB) and PACK" '
>   	test_commit --append foo big-blob &&
>   	test-tool genrandom bar 1500000 >big-blob &&
>   	test_commit --append bar big-blob &&
> -	PACK=$(echo HEAD | git pack-objects --revs pack)
> +	PACK=$(echo HEAD | git pack-objects --revs pack) &&
> +	git verify-pack -v pack-$PACK.pack |
> +	    grep -E "commit|tree|blob" |
> +		sed -n -e "s/^\([0-9a-f]*\).*/\1/p" >obj-list
>   '
>   
>   test_expect_success 'set memory limitation to 1MB' '
> @@ -45,6 +48,16 @@ test_expect_success 'unpack big object in stream' '
>   	test_dir_is_empty dest.git/objects/pack
>   '
>   
> +BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
> +
> +test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
> +	prepare_dest 1m &&
> +	git $BATCH_CONFIGURATION -C dest.git unpack-objects <pack-$PACK.pack &&
> +	test_dir_is_empty dest.git/objects/pack &&
> +	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
> +	cmp obj-list current
> +'
> +
>   test_expect_success 'do not unpack existing large objects' '
>   	prepare_dest 1m &&
>   	git -C dest.git index-pack --stdin <pack-$PACK.pack &&

This fix looks good to me.

Thanks.

-Neeraj
