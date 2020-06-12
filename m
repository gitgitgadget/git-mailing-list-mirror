Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B5C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F1C20835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXVNoJuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLOWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFLOWI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 10:22:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B28C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 07:22:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a3so8835490oid.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d30JaEEgOxoyHptQTgPAfj2gIHvjmSPzxZyinKQFsiI=;
        b=jXVNoJuHXJog+UG/A4kwh9D31rDB0KOrWynia6ymrSMsEVPz/DKMOMtvuZAHCMxqIz
         nIUiCkho5xOwIPG/Uzu9CmlgdVEUu7pCqdUQdSrSGexwDq3f4/VCfhtSEWHqZzjjMJI5
         GG315h4IJXOnhdI9XfQXRHau0uPlwcDxqUuFDjAiw2r0fHQqneeDJu94wOq0v/GFbXk7
         WLuzeQUMyWbugrHK/JAhyz1jFHgQIG/kiyLgKciDM9Kz8kMtTxlW/rPv1oboOBQEZPYC
         inhSHQash2LHQc+7o/zBevhYQHI/3SjBJanIBYsMxewLuim3OVDTNBpj4/snNqFaSQ9s
         jGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d30JaEEgOxoyHptQTgPAfj2gIHvjmSPzxZyinKQFsiI=;
        b=eOY9d1QAuJFWEa5QI6gkG3AQn2Uc7KZ9QinUd8djIn6rIDtwDXVN+VFeIC1Z1hmb7w
         O0E6mTQUvgf9HMhroqsFj5t9QguNa9125qFa03ZN7IBFjgp+ITKS9ApMiEsIIr3BsFC7
         TpLIFL1jb9nMU0NmXs9tMufI4pX3xSfwcpp5tSmbEtSuPLbEUgLMDGRAwO6uCMi0aQ24
         gkl0232mpZzFA4H/ddjTXs5wlPpjyecW9phF8fstWemrL4cp9NSGjGXMaV4QNytSwGxw
         x1Aqns0XlySBsqWzlxJ5xy7eYw7HXsmktWow5zCCPhmAn4nTXysbndCCnpYqRD30pv9M
         V6yA==
X-Gm-Message-State: AOAM532o/EalyQ9yQvSNxd5x2seFzKpXpDV3rBke0vEcrijOUVVIann6
        vE/sak2xHGzScLD1Tt7DPgjkqDeHr4g=
X-Google-Smtp-Source: ABdhPJwsdjnHe+Zv9zMZNnuME9bGsjEe/5Ijl1eIsch9BSOQAMD54SIchn2ZdEm+oAoHgVRaahr7/w==
X-Received: by 2002:aca:df04:: with SMTP id w4mr2344387oig.27.1591971727832;
        Fri, 12 Jun 2020 07:22:07 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t18sm463645otk.42.2020.06.12.07.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 07:22:07 -0700 (PDT)
Subject: Re: Virtual Inclusion Summit
To:     Don Goodman-Wilson <don@goodman-wilson.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
References: <20200610222719.GE148632@google.com>
 <xmqqwo4eedwc.fsf@gitster.c.googlers.com> <20200611011040.GB21728@syl.local>
 <xmqq7dwecpsp.fsf@gitster.c.googlers.com> <20200611023503.GA24130@syl.local>
 <CAGA3LAdz21nZFeztkHp5XUQ4h-kWnqTzb8pDXjne7PqeMFhLRQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c6a3ab8-e84e-f621-0d4a-391d672a1bdb@gmail.com>
Date:   Fri, 12 Jun 2020 10:22:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CAGA3LAdz21nZFeztkHp5XUQ4h-kWnqTzb8pDXjne7PqeMFhLRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2020 4:58 AM, Don Goodman-Wilson wrote:
> All,
> 
> (First of all, it’s Don, rather than Dan; I think Johannes’s
> auto-correct got the best of him at one point in his email :D )

Sorry, Don. This was my fault. I was helping Johannes craft
a cover letter and I mis-typed. Thanks for setting the record
straight.

Thanks,
-Stolee
