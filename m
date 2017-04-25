Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23AD3207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S975416AbdDYEqt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:46:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36594 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbdDYEqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:46:47 -0400
Received: by mail-io0-f194.google.com with SMTP id x86so52494841ioe.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bOiPv9hJHeoO5Yl5DJvTRNBlU8wCavHrQw70FII+iYI=;
        b=gMGuqGCqweTYITMNXZcfsiLqb2xQPD9AC5q0zzo5uM8KhxIJvt9Hz1Uk/RCzkQkHaj
         39UM7MPzZWe5/U4K4xE46r44ZerBpGF+SJzr0Wi1ZneOROYcpyrCWoc3LRQXSRzfFGLm
         giC9OhrOnvFE6RrcUl2u6/sSEQShT/e+xfr6qW1baAlqGka0NdNsfaRWLBL4+5VLWUZ4
         kQ8ork4EAziadh3lMexsrNrH1z9YcF1RGUzygtmWuF+O984fMqfiwSAxhjeGlXjbsQC3
         qCZDAWaItY5rDGOBbbT7THEk5Guaq09O+9xuLbtNMSjViLY9TvURoecHEhZXruv2irZC
         3J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bOiPv9hJHeoO5Yl5DJvTRNBlU8wCavHrQw70FII+iYI=;
        b=YjcPuxChddcZMLoqBoAsSmLzPmoNViuxIvxPVLYvp5ArZRe6k9MbCFNO5FVszCvoHJ
         CmNzMFE09TVtE2N/SX783FHFFEZkElncgXnR3MNlM0hoGzohCf0JRhM8V3WGY251ayUO
         /L7zP2F/iLwegPzjh2Rxo5tbheFH9F8oV0pkDH9Lvv07L2hWgdjakFBftuR47khHrO7w
         Tas63zyzxpjoFEG8Pu/GfMdIKoeOX7XeZ+9OxUe4bLWgNvpZkX3T0Orxd9sYTuf3sXyv
         3M5qS3qx8JVi1zZJKoJw2O5KYb1XFYUmsCXMyvyiei8AXnxxUrZQwY0gfrr4JBnEJVXK
         nqEw==
X-Gm-Message-State: AN3rC/5G0Kgv6MGFNeBcT3hDwHsDwgbfehQBp7Cj7dVwHOO2ysNb++e+
        DUxawowpLeAd+w==
X-Received: by 10.107.142.197 with SMTP id q188mr11487173iod.197.1493095606232;
        Mon, 24 Apr 2017 21:46:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id b91sm1045816itd.26.2017.04.24.21.46.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 21:46:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 5/5] archive-zip: support files bigger than 4GB
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
        <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
        <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
        <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
        <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
        <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
        <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
        <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
        <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de>
Date:   Mon, 24 Apr 2017 21:46:44 -0700
In-Reply-To: <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 24 Apr 2017 19:33:34 +0200")
Message-ID: <xmqq7f29w0uj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 0ac94b5cc9..a6875dfdb1 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -178,7 +178,7 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
>  	"$GIT_UNZIP" -t many-big.zip
>  '
>  
> -test_expect_failure EXPENSIVE,UNZIP 'zip archive with files bigger than 4GB' '
> +test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '

This is a bit curious, as 1/5 adds this test that expects a failure
with three prerequisites already.  I'll assume that this is a rebase
glitch and the preimage actually must have ,ZIPINFO there already.

>  	# Pack created with:
>  	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
>  	mkdir -p .git/objects/pack &&
