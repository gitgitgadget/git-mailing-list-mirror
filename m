Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28AEC1F517
	for <e@80x24.org>; Fri, 15 Jun 2018 09:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965441AbeFOJOl (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 05:14:41 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38524 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936076AbeFOJOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 05:14:40 -0400
Received: by mail-wm0-f44.google.com with SMTP id 69-v6so2582866wmf.3
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgexEAdrjk7aFcdE2GNChn8d+U3bi96nnL4NphKGXBA=;
        b=XFYNWNmDYtRWapm8hF23oBqfF5++nyR/FU0chlTYo9AH0HYFdYm4T0aFicmDL0QdUn
         voau+6XcXoBmkGw7dKme5oZGYW8JgfKeJx3RnqcUJpMs9G+JO240TbY/SnAnav9i0aJa
         FbvNSfW2E9d/bpK4aIyco9xeVgKe4gIMrMel9qqaVwJE/+i7KmfWS01UDiGFOHLZlFcU
         9rjZYJhW5XBo9Lirs9wohS3qDwyPmeQ65Uy0xThxG37j8VnpVtUPgtg0IxbtTkZnFCDs
         pzeo8lE0qimHs+6mmjABn5hHXhYVKU6wtxcZDO3RQramSsx1AWYbgh2WXRbxPVu7fbOB
         U2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgexEAdrjk7aFcdE2GNChn8d+U3bi96nnL4NphKGXBA=;
        b=BLYPRPHgBzYfJ24m+RXvzm4s8M2jaik1RM1nxvtR5RVwV8Z8PMlhpr6u1OF3dGdUra
         pjVtO3U5M6W6aVovxG1K2/ZnUwV1LexTJnmAzKt6N2v4wVx4nSmBupf7w6Yw3Ar9oInG
         R9cqGSY7gWEHXIy0XdncYO4WNz4WTS1BK4p/5DuUCFivOwBQw5x9x/P8L+9OQAzjxuyO
         Suoi781UWSIsvZeoZ4kT/QEIBncHhjkoh15mlM+2AnE7XcYenWCa5hqJJBVQoKnd2P3t
         h1vCOVKyOSf3njsP3XfEK6z6Tc6i95jerCgu5eUm0x3VxJJ6cj1fyMuWjhzkci+f7OP9
         JF+Q==
X-Gm-Message-State: APt69E0Sji5Qu5Nh4hSI6ZZZXg154fbdUV9wV5mgRmf2bBrF/LZ3Ugqp
        nLPTYNPO41Mpla+WQooCrPY=
X-Google-Smtp-Source: ADUXVKLeVvWi/VufMYmfWrvCz65rkbjdF0cs9m/7N7i8tqlS8riKKP/JCx3P+2XAlwH4c++pQ5Oawg==
X-Received: by 2002:a1c:36e0:: with SMTP id y93-v6mr577677wmh.67.1529054078852;
        Fri, 15 Jun 2018 02:14:38 -0700 (PDT)
Received: from localhost.localdomain (x4db1df20.dyn.telefonica.de. [77.177.223.32])
        by smtp.gmail.com with ESMTPSA id k17-v6sm1470653wmc.23.2018.06.15.02.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 02:14:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Date:   Fri, 15 Jun 2018 11:14:32 +0200
Message-Id: <20180615091432.7155-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180615033112.GA20390@sigill.intra.peff.net>
References: <20180615032850.GA23241@sigill.intra.peff.net> <20180615033112.GA20390@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 423c0a475f..237ee6e5fc 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -331,4 +331,17 @@ test_expect_success 'pack reuse respects --incremental' '
>  	git show-index <empty.idx >actual &&
>  	test_cmp expect actual
>  '
> +
> +test_expect_success 'truncated bitmap fails gracefully' '
> +	git repack -ad &&
> +	git rev-list --use-bitmap-index --count --all >expect &&
> +	bitmap=$(ls .git/objects/pack/*.bitmap) &&

I think the 'ls' is unnecessary and this would do:

  bitmap=.git/objects/pack/*.bitmap

> +	test_when_finished "rm -f $bitmap" &&
> +	head -c 512 <$bitmap >$bitmap.tmp &&
> +	mv $bitmap.tmp $bitmap &&
> +	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> +	test_cmp expect actual &&
> +	test_i18ngrep corrupt stderr
> +'
> +
>  test_done
> -- 
> 2.18.0.rc2.534.g53d976aeb8
> 
> 
