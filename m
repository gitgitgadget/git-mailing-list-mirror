Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB3C35249
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB0D21582
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecWBoeuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgBED2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:28:18 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33311 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBED2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:28:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so591798oig.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J4QL2JdIYxPP4geoQhK61Ps59uHAZMnP0ck38I11whA=;
        b=ecWBoeuY/lJZjB9Z9v8uCjmAwYSDwEu+MDsblu1PNQYSQjMXBa5lyLaSX0ka1H7/lA
         D0j5Q8QtKV6c0/qll4b1ZxI8Tg4Xz7VQ2GWA+ZzeZhqsIszOTx0+Y3zV5SfV1hoBDk6C
         k0b1dglnC48MbHEtrauNB/KgsBkmlkFjlvoIQKIkCDyJhKRAJebwDBJwo3A47Z6g3scJ
         /Mo8Rr/UR6fpNjO22g76wpA2ON1ATCKS8NGdHNHmMy51/eSL+gWMcmOt5X4aqUGjDmBR
         ZcKi/kPDJeDuGfFpOGuzj7ESXZmjNn0MVBiy3JmV73JKiW2j7yohkus5MBry7mf/NLhX
         Ww+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J4QL2JdIYxPP4geoQhK61Ps59uHAZMnP0ck38I11whA=;
        b=gtd5RRujeHVG9lLsKB1U+ksZiZK5J20Y6XUOFH7g7G75DLtzVPZo6xcrwN2klHzcg2
         n4Z0+G2RwO9UX9fFQb21LNcR3f6e0JZJf8o7jF/bQ34epsv76luCYQitXh9AmBW6cKiO
         hlk7AXQKpMqehBqvpkJkCbw9b/VDS0QiMnZL/YfYM1K1Fk/qF//n64+C7Adsmz2Fiyd2
         8HIPSLRu/JPJ9J+RRa61jZAjkogP+J/7yORgHQjFjXzTfdbRjyCfKK7ayv4whk953Wtg
         HBP+eKa/Aa7Z1taVHmh3ZrKzzdbnty2MjC7M8VpnW0J+tOFe2cNruxqvdHqja5ja4A8t
         fmqA==
X-Gm-Message-State: APjAAAVNXVITa1UjA9dE9MSuOsueLIEm0E+IlUZzo5a5eHbVKgyNm59Y
        OFPv/0IysLbEjDoma8TQrsc=
X-Google-Smtp-Source: APXvYqxi7TcaTuFy/NqF2+zWr10UUHct1gupd58IaWkbPahVa3Wr/B7YGUyJiy45uQNn2ZOM1CRwiw==
X-Received: by 2002:aca:5746:: with SMTP id l67mr1578503oib.60.1580873297229;
        Tue, 04 Feb 2020 19:28:17 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z17sm7167926oic.15.2020.02.04.19.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 19:28:16 -0800 (PST)
Subject: Re: [PATCH 00/10] name-rev: improve memory usage
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <06f8c44c-66aa-d9d5-7653-436424f5c864@gmail.com>
Date:   Tue, 4 Feb 2020 22:28:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:12 PM, René Scharfe wrote:
> This series seeks to get reduce the size of memory allocations, the
> number of reallocations and the amount of leaks in git name-rev, to
> improve its performance.

I am generally very happy with the performance benefits and think
this series is very well organized.

>   name-rev: don't leak path copy in name_ref()
>   name-rev: generate name strings only if they are better
>   name-rev: release unused name strings

I don't have the right context to understand these patches without
applying them and investigating the methods around the changes.
They intrigue me, though, so I plan to pick this up again tomorrow.

The rest of the changes look good.

Thanks,
-Stolee

