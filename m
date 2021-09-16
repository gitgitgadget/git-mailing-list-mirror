Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930BC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5007A61251
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhIPTw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhIPTw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:52:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC1C061768
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:51:06 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p80so2752614iod.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e1+GCHPy39VIROvsoDLKsaIBihcji9KXoDPbCBkVjS8=;
        b=XIHIulj8LlQ8fYGpA2KCa58f8EiqLSpUyAksgdzn+Camgrj6ZCfYiGsIrZPAiap0pg
         fecUvvokpljNC3AFrPiwPpe3trzqypwC3nn9bbZshmYIUbD8A9s7MPsAc8A7VkaksYUO
         o/VouRUdLYi1wtk/ir6YebIOJYVLI8UrfudIcI4beWL+0QeSLEAZctlHwiPJ3X4ukylr
         KV9l11pEp3RsBWJ6fqsYcl0XlGrG7WPIeuY5HdguIdy4YYSiTXJ2Myj/m+DN2+fDpczM
         GGiOrFrUop6Am+6qgTrFDmnsBepplqPqvdO8fQQRHCMJAZqxjKPouO4K4bwMfH7ATjXd
         /+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e1+GCHPy39VIROvsoDLKsaIBihcji9KXoDPbCBkVjS8=;
        b=hyufnoRYVnN5UbuTB0JMKjgQ5Vg6jieWK3T1pVf6lpkLB2PJMkZsGcDccjZfcmc3N5
         Y+KykZOoUanl2WlBPsoh0gJSVBYveknfXlMrgxldhsCEsYSWc3eHfdPjjTHscLki4m+Y
         XSBuPO42yvICfBldT0KDan3Jwrv7S1jXrizcY/PFCSJrSdvaP3+3l4j2nwhSu9m/Dken
         3Ul71vvqxSfDL+q7qWKDmTEkekoNAK7m0K/a7i4pFk8604cXmBcKezXpuys2nGcPzOqd
         2w42ZbxLdYyDv5NloJ9ithi0tQWcB25IQ83JOehh9b0zoGV08OdSKBGmyO/Y+BkuJWoo
         zTeQ==
X-Gm-Message-State: AOAM530/tFiU43/D2xubEBnrg95VMvXZq4Wh40i4+SVEyDhmmD/jLzjK
        EVVaQjqOMoNfJ8fDfqphliQWKw==
X-Google-Smtp-Source: ABdhPJwLNVeJjxps+nqhRJD61pDNyxBiA6rc4wkOr4gCMUhG1m90oyj2ptpYslBYiJUXlpZafIpQZg==
X-Received: by 2002:a6b:ec0b:: with SMTP id c11mr5649067ioh.207.1631821865655;
        Thu, 16 Sep 2021 12:51:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h1sm2056702iow.12.2021.09.16.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:51:05 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:51:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 02/22] fsck tests: add test for fsck-ing an unknown
 type
Message-ID: <YUOgKKRf9ZpMzNaS@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-02.22-9072eef3be3-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-02.22-9072eef3be3-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:57:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Fix a blindspot in the fsck tests by checking what we do when we
> encounter an unknown "garbage" type produced with hash-object's
> --literally option.
>
> This behavior needs to be improved, which'll be done in subsequent
> patches, but for now let's test for the current behavior.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t1450-fsck.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 7becab5ba1e..f10d6f7b7e8 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
>  	test_i18ngrep "bad index file" errors
>  '
>
> +test_expect_success 'fsck hard errors on an invalid object type' '
> +	git init --bare garbage-type &&

I wondered whether it was really possible to not cover this, since I
figured such a test may have just been hiding elsewhere. But we really
do seem to be lacking coverage. So, adding this test is good.

> +	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
> +	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&

I'm nitpicking, but I find the -C garbage-type pattern less than ideal
for two reasons:

  - It makes every line longer (since "-C garbage type" is wider than an
    8-wide tab, even indenting this in a subshell would take up fewer
    characters visually)

  - It pollutes the current directory with things like "err.expect" and
    "err.actual" that have nothing to do with the current directory (and
    much more to do with the garbage-type repository within it).

So I don't care, really, but it may be better to just put all of this in
a subshell.

Thanks,
Taylor
