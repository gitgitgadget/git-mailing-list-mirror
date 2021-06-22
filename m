Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB22C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA58E6128C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 05:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFVF0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 01:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFVF0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 01:26:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F322C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:23:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g192so7831858pfb.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SCTTybRf3+MugJLApMoG0yfpT5383ayJ/uY4A0LZ/vw=;
        b=o/kiD+IpJwZ8qQwH7Bgl87bZVg2YtEEBdUSjQNWd+r/4rJe2EtUNXrvKodDHb4YATZ
         rnsp7UVSw9CuaTTcF3Zkr8xsqqGrxxHP8mewqy/BQ6Hdy+QqnCdybvcz5dCcUTrozJLD
         tDjghZnFtmHp7+2eeHIWOj+4+X/+tEAvXrvQXNBcSHz7f8E+HQ26sBmgGhMussmf/33X
         VN6SBjGPh+wyYWcnw3+H2A3WaFedDB8Mgxz/oTVA49pCTsAvVsSal5unQ6ZDfUXS23wC
         Ph1C1FgzftoJILIC0J4W6J9VuSfwk6nkX9ijN25I/TLFo3J1Xc3V6Rm9gftOfw1M+6YS
         BDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCTTybRf3+MugJLApMoG0yfpT5383ayJ/uY4A0LZ/vw=;
        b=iKvH+w8S3ynZY8mYRsYUtHroBYrjsTVzWvC0fMAIwDXvOYgI2wOQ6Dp4kSPBJszDHo
         oraZb0odFJL1s0/D8XLpoPvs0UvirG2NtDbmCdqpxya56TgKelCWAFtT7YWnSpCdKR9s
         Si8dDrd+X3riWh66shP/3K75Xxj34QA6H8RxfEMtZOuXBCstWedI79WOqfyEIPGvFKP2
         b2HiAroeHGFOO0C67OYlaPd3Kx8GgC8aoje2ptLu7JD3GOAbbc7f3pCX+4hsAlL8zNTp
         7zj/YL58tKxXzYsnbZYcBpNM0hSN0/ne+QAzpVEPalaf+czbu8N4S8GDFqCwcU3bCJ35
         iKEw==
X-Gm-Message-State: AOAM530euOhcqrbGQXeJVbhkbaNhgyf8kLI4/9LndHCxUDrV/qULUqma
        g9x6JrU3AWMvsvKPCWc1o+s=
X-Google-Smtp-Source: ABdhPJwGl+r8onuAWSw5Y5aEbMI2PP4rU3kAvylBOWlMUbG85RlxgmaBFvSbVHOvHHXGz1RlwXay5g==
X-Received: by 2002:aa7:9901:0:b029:2ff:17ed:feaf with SMTP id z1-20020aa799010000b02902ff17edfeafmr1886597pff.34.1624339430028;
        Mon, 21 Jun 2021 22:23:50 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-29.three.co.id. [116.206.28.29])
        by smtp.gmail.com with ESMTPSA id x5sm5829567pff.37.2021.06.21.22.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 22:23:49 -0700 (PDT)
Subject: Re: [PATCH 15/23] doc: use asciidoctor to build man pages directly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
 <20210621163110.1074145-16-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <cfa20758-ac40-1fbf-a8f9-411e795c77b7@gmail.com>
Date:   Tue, 22 Jun 2021 12:23:39 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621163110.1074145-16-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/21 23.31, Felipe Contreras wrote:
> +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
> +# instead of building manual pages from DocBook (using xmlto). Has no effect
> +# unless USE_ASCIIDOCTOR is set.
> +#

Why not just USE_ASCIIDOCTOR_MANPAGE implies USE_ASCIIDOCTOR?

-- 
An old man doll... just what I always wanted! - Clara
