Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1691F403
	for <e@80x24.org>; Sat, 16 Jun 2018 14:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFPOfW (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 10:35:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55050 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeFPOfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 10:35:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id o13-v6so7546161wmf.4
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuKMGXxge/a806s/CA++m6+c+tFICyUmc4Wcxbv0uF4=;
        b=dL+rALUN3OQSgVi/O5mGoyaZDhiRbr8pNm/1At8gfd3etsiFgRcr1SIhNxFqHtK+oN
         Ir+Q+lT1BD/7T/AX3aTc3JliNP90EH4VptlqbhmFccHx+DvOtQiSqB8MesbJoeI9Ts19
         jo3taLkEVYqjoivkuii4ptE8duB+1GwolrJd9SmHpdaGT+1fWQIbm9LDx9YBpu1hV5Ct
         6epE8u6tg97x8ucL1OS7TLKL8LeFEcsmvfFA7X6DrliSXPRQRxvgOBgOwXm6JZZ5kM6o
         ChForT22+Uqfqji1NPe2SZOo8HMi8DOL16ia49wu4mmj/ixNurB1OMOnhCW9tIPNQPMh
         yAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuKMGXxge/a806s/CA++m6+c+tFICyUmc4Wcxbv0uF4=;
        b=fmV1wu95BnqmQBLIApP6MFvmbwpJaODReIwyg8B0Qk617zq98REmcHbOiLuqKJPxhZ
         2/AuyGYH0+ALlNLfVj4/wFvo5DWGaiV21gverdQ7UIBtP0EVWCEBEb7h7adOSieA9BlR
         YaKx1LakEug8AFnQBGxx2ZRZ4Faz3AFasACQzYoufAr3xuuhZgDTN1DFLJYtYtko7R6D
         roG8WGqnQFV9qGqpJuTka/kLP7LVp9IvxtEAZOn347tDjTm2sbW/ab/fG3a4nxnZ+Sip
         IpVFczKLyNFR0d/n5g4h5GCDKnDc6/zULke8v1PTGPDHkUcyOo2E47TK6ikBjquJH3rr
         4gcQ==
X-Gm-Message-State: APt69E2RgBN9FfNcsj2af7iUWAT/sONjNgjqbP/mgKjWhPEryyTplZPK
        HrU9U2uMEk8ekvzfALppYqo=
X-Google-Smtp-Source: ADUXVKKXbWxm+ez/0vDBfX7ylqzRIGZmRkGX7RXQuvkxQXiBY8zvS/ZXJPk4dclItFin52VpW3Xo8A==
X-Received: by 2002:a1c:3a91:: with SMTP id h139-v6mr4296579wma.94.1529159720099;
        Sat, 16 Jun 2018 07:35:20 -0700 (PDT)
Received: from localhost.localdomain (x4db06e4b.dyn.telefonica.de. [77.176.110.75])
        by smtp.gmail.com with ESMTPSA id f18-v6sm14498373wro.1.2018.06.16.07.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Jun 2018 07:35:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Luat Nguyen <root@l4w.io>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
Date:   Sat, 16 Jun 2018 16:35:13 +0200
Message-Id: <20180616143513.10086-1-szeder.dev@gmail.com>
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
> +	test_when_finished "rm -f $bitmap" &&
> +	head -c 512 <$bitmap >$bitmap.tmp &&
> +	mv $bitmap.tmp $bitmap &&

This line turns out to be problematic on OSX and ultimately causes the
test to fail.

When OSX's 'mv's destination is read-only, it asks whether to replace
the destination even though in the test its stdin is not a terminal
(and thus doesn't conform to POSIX[1]).  Since the '.bitmap' file is
read-only, and since 'mv' obviously doesn't get an affirmative
response from /dev/null, the original '.bitmap' file is not
overwritten, the subsequent 'git rev-list' doesn't print any error
message, and finally 'test_i18ngrep' causes the test to fail.

The relevant part of the '-x' test output on Travis CI:

  ++mv .git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap.tmp .git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap
  override r--r--r--  travis/staff for .git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap? (y/n [n]) not overwritten
  ++git rev-list --use-bitmap-index --count --all
  ++test_cmp expect actual
  ++diff -u expect actual
  ++test_i18ngrep corrupt stderr
  ++eval 'last_arg=${2}'
  +++last_arg=stderr
  ++test -f stderr
  ++test 2 -lt 2
  ++test 'x!' = xcorrupt
  ++test -n ''
  ++test 'x!' = xcorrupt
  ++grep corrupt stderr
  ++echo 'error: '\''grep corrupt' 'stderr'\'' didn'\''t find a match in:'
  error: 'grep corrupt stderr' didn't find a match in:
  ++test -s stderr
  ++echo '<File '\''stderr'\'' is empty>'
  <File 'stderr' is empty>
  ++return 1
  error: last command exited with $?=1
  not ok 43 - truncated bitmap fails gracefully

As far as I can tell, 'mv -f' appears to make the test work on OSX as
well.

I've run a build job with an additional 'grep ^override
t/test-results/*.out' command following the tests to see whether there
are any other cases where OSX 'mv' doesn't overwrite a read-only file
without causing the tests to fail, but found nothing.  (But note that
the OSX build jobs don't run all tests.)

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/mv.html

> +	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
> +	test_cmp expect actual &&
> +	test_i18ngrep corrupt stderr
> +'
> +
