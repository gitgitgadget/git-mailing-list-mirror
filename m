Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65250C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEAC206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWL8thzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgEDRqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgEDRqj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:46:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01C3C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:46:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so5892951pfn.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/7c7dJ+LNdtk6yY/7QMpjHwLvLMKdB/acB9q53D5oSM=;
        b=vWL8thzkoroWW2AHJVQxMIipIBu1i/Hd/DE1RD4aglLvS6Rffr13U6UFUS3pJmcFVf
         ZH9ERwGOVBpj0Nl8dHjfpoFO8AIFRxfTuNe9uBdsdjrDw2Luawvh4dWj1JKDLo9zrM3/
         5Z/kqYyvNkeRIGGDGhlyfP3EOUjVEChfdNfbNvhQMWpy519Ee//2DKHS7NRyAmmaFtP3
         4RYxHhrZfWkdfodIdcrVHZQ9po62fKd2eYR98M9Ol/rKRKMDxXwM4xzv+MAWNyUvqsOM
         QpHUQcZ12n42hokqtP9WnlNeCyIxfi11EMjeTyqgl4nOzvvZow3MKxSZ864Nx6tjufnl
         GXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/7c7dJ+LNdtk6yY/7QMpjHwLvLMKdB/acB9q53D5oSM=;
        b=IMciLM3xD7X/D/zf1Jl9VAEmEUvQTIVfAVfkRBDxWaA3ucdNSg4nF5fEtzxtkLWyLB
         WdZBBJ3CY2bi9AjeQm9c+B5ZVBoa/t0dHfAQGZnq79l5+rTOSw930Sytz4lJekcC/nPy
         4r7U9JrEnGB87G33OPZFmLZ4bImklB8deYxs/QCczGaSD+lr3jISJcd/8JdCG53VCiXq
         8S1zVb8yxngH+rlehFMpB3Y/FHQczSlNsrL/mr4VdmLOqw52s/E6VucfkgPF05PWRFwe
         42zWnbXEkf0pRWV3IvMci36O5CtKyAzkJizb5e/5J8YNwvtjmcUk4L9zbVBGB27EzjDH
         F+aA==
X-Gm-Message-State: AGi0PuaCdRPt4agOe8e/2xvRLkoIYVjorZjsPqYLRfNFbs0LkG7cwrI+
        9UHqpaH6JyhWL2Nvn9FRhUWgX8H1
X-Google-Smtp-Source: APiQypLkzjJagiclccf1jTxyfKttaVLVJbz47sVjACyT2b14bXYsjNQYTh/93JrenbDgJGzz5N3TaA==
X-Received: by 2002:a63:592:: with SMTP id 140mr84476pgf.171.1588614398397;
        Mon, 04 May 2020 10:46:38 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id p189sm9536718pfp.135.2020.05.04.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:46:37 -0700 (PDT)
Date:   Mon, 4 May 2020 10:46:36 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200504174636.GG86805@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 11, 2020 at 12:18:12AM +0700, Đoàn Trần Công Danh wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05e..40a00983f7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -657,6 +657,18 @@ die () {
>  	fi
>  }
>  
> +file_lineno () {
> +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> +	local i
> +	for i in ${!BASH_SOURCE[*]}

this line breaks with NetBSD's sh (and probably other POSIX complaint shells)

the Coding Guidelines mention "no shell arrays" and while the tests are more
relaxed against that rule, usually workarounds are needed, as it is shown by:
5826b7b595 (test-lib: check Bash version for '-x' without using shell arrays,
2019-01-03)

Carlo
