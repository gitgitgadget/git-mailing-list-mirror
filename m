Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D8BC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6A0206D5
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akAQAgsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgGOKMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbgGOKMB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 06:12:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219DC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 03:12:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so1564946ejc.8
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPC5eUNzNWiaCqwOczz2PdepJQEc9w06bNkdoCRd7NA=;
        b=akAQAgsydHWWzHnkxxmVq4BmXuTU0NV0FI6yWH4UOWEcKnEQhOmn625dmUuX22uq0a
         MrRrOPOBlUgkld/tnkCOwENPs2DYfqGdWiqwC53Sg12AuYinEWTZ9x7S07Eg/1KW7mCP
         Q5M0CNRxUcriOnASxY1HV2LLAUho5COrQf/gswKBt7FHkJa2v50NDNoKffvE1XyTtgRm
         i/1fOplBMMxKDZ7ToA/sWgsWmss1p4Oi3knGM19Paa0NwY8ami1zrLr9lFGOz5j/tjVb
         CeLprdU8Z1R/HaqSpL22/hEiEbYiVVT4hzQl31voFLxLRE3QYHoDncffQfbqSRWsLEtb
         Nxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPC5eUNzNWiaCqwOczz2PdepJQEc9w06bNkdoCRd7NA=;
        b=QDl0kusQD4ZXfPLBnGKWCcaYl3LLwftZ+dNJzrUXxtBAwNCisyoJKWR2fi1FNVbgOX
         8k3AhnkcScKS4jaSqoklU8e38MIKcWUKVUWWWzk1AMZThS4mAyIRv8tuPUn+05HnNp1H
         STeNHozRTbnKW3IdWPUqtcW5fI3Zc437lvN/5rpVMdnaxdOS4juhUbWe/qss18UPUlha
         f9mihjw5fpw3wn8jruPlTG6xIS7Z3/EzxHNhPeZuMs4kGI0vAkZwz23OO/OIQGASuGW8
         zBOKuhHWGbo1P+skT+HNKrnSF7HaOAtoix8TUYM5OhWYUdBj3dezPd5uodsXHorHex77
         nKkQ==
X-Gm-Message-State: AOAM533apR8MVxArAvGibVSmGlYF3+JzOiFeyVn3C5OD0qBREIAbNxAa
        UJKfX5qYgwuCLZX+K4clBVU=
X-Google-Smtp-Source: ABdhPJzn/zelH28PYhVS7C8MdcHJwb5Rd1HT9h3mO3r51s6MTwTj/T3VARVeKOU+Up1xhUxwJWNhHw==
X-Received: by 2002:a17:907:20b0:: with SMTP id pw16mr8205879ejb.551.1594807919980;
        Wed, 15 Jul 2020 03:11:59 -0700 (PDT)
Received: from szeder.dev (78-131-17-71.pool.digikabel.hu. [78.131.17.71])
        by smtp.gmail.com with ESMTPSA id h15sm1598984eja.44.2020.07.15.03.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 03:11:59 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:11:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 4/4] upload-pack.c: introduce
 'uploadpack.filter.tree.maxDepth'
Message-ID: <20200715101156.GB22114@szeder.dev>
References: <cover.1593720075.git.me@ttaylorr.com>
 <9fa765a71d25ef3462ce81cca9754daa9b2579b6.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fa765a71d25ef3462ce81cca9754daa9b2579b6.1593720075.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:06:40PM -0400, Taylor Blau wrote:
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 5dcd0b5656..8781a24cfe 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -261,6 +261,14 @@ test_expect_success 'upload-pack fails banned object filters with fallback' '
>  	test_i18ngrep "filter '\''blob:none'\'' not supported" err
>  '
>  
> +test_expect_success 'upload-pack limits tree depth filters' '
> +	test_config -C srv.bare uploadpack.filter.allow false &&
> +	test_config -C srv.bare uploadpack.filter.tree.allow true &&
> +	test_config -C srv.bare uploadpack.filter.tree.maxDepth 0 &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
> +		"file://$(pwd)/srv.bare" pc3
> +'

Unlike in the other three tests added earlier in this series, here you
do use 'test_must_fail ok=sigpipe', but you don't check that the
command died with the right error message.  Saving stderr and adding

  test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err

makes this test flaky, too, like the other three:

  expecting success of 5616.20 'upload-pack limits tree depth filters': 
          test_config -C srv.bare uploadpack.filter.allow false &&
          test_config -C srv.bare uploadpack.filter.tree.allow true &&
          test_config -C srv.bare uploadpack.filter.tree.maxDepth 0 &&
          test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
                  "file://$(pwd)/srv.bare" pc3 2>err &&
          test_i18ngrep "filter 'tree' not supported (maximum depth: 0, but got: 1)" err
  
  + test_config -C srv.bare uploadpack.filter.allow false
  + test_config -C srv.bare uploadpack.filter.tree.allow true
  + test_config -C srv.bare uploadpack.filter.tree.maxDepth 0
  + pwd
  + test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 file:///home/szeder/src/git/t/trash directory.t5616-partial-clone.stress-4/srv.bare pc3
  + test_i18ngrep filter 'tree' not supported (maximum depth: 0, but got: 1) err
  error: 'grep filter 'tree' not supported (maximum depth: 0, but got: 1) err' didn't find a match in:
  Cloning into 'pc3'...
  fatal: git upload-pack: banned object filter requested
  error: last command exited with $?=1
  not ok 20 - upload-pack limits tree depth filters


