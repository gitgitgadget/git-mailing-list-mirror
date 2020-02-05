Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F77C352A3
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8FE222D9
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab7WX0wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBEPUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:20:33 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35042 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBEPUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 10:20:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so1828887qtv.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 07:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZB6kiioUbnDg9NKexifqlbHXOE3qAvUPswtqGWS7wfU=;
        b=ab7WX0wKViSEVVmB7RwcwWogcHeU1dzzAhg1eAwUa6gg0CQ622JrZBtxCfx8GVLFuf
         f8t16ZxwtVqDk7TADxKDPt6q80HxuKpcffghCKZN9A6qMTlKj8Hgf/hPflDSFfDXzltV
         Q8JKKhfgYbTtoRKruX+bC1gMTAh+bzm7Yt8RO9PaOIpgnpxqF0QqECuEVRRiVNGZjATu
         TA95UU3Ba5x94DuJAfD6cOWtk0JwfPTUFxpNiwKc1DjqtLG4LF1GTeMZZXUoqbwMzWcO
         zLPcq/m/37CLDYGWMb5j2UFAKi3G92arcJylNzIVuQXzUFcKecpPCYAGg7ToinQDHjHg
         gEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZB6kiioUbnDg9NKexifqlbHXOE3qAvUPswtqGWS7wfU=;
        b=k7IJOg67vTsaaXHQRuZttwukdTNQndlYPugQzTrh3vaTsqFGSBjFWTciI1WUFiGBLJ
         xuYOpwv3cG5FO8cCkodhQxPNqTee2VHntaJhZOh5Cchmt/Owc0j+hgktOBgHTnhwQZJa
         OHYoyjm55V1eL+iIECC5nqAv4aK4DSNU7H1ZSEU+5WQbp9evqvElMH5q7PBIqVG7syMd
         PoapOXvY9Ld7raMABK//YZjP5tG6lPTKuv2AcO/L1epmXEbNKz2JB6julMrkSw1+bcjP
         JrzqQCa6qCgEbNaiRRArJT0HHWoOEJtNg/tCVaXYHdJb0FouL2+nqK8x7LUdT7INHVvZ
         OwOg==
X-Gm-Message-State: APjAAAWbV21fHdaiWk7GgRBrdqhVU5RZHYv5DCqtwM1Hi4ke1MvlqZqd
        lBFRkYYC2IswuCJi1NobIDA=
X-Google-Smtp-Source: APXvYqwZNgP84KeYVS8E12BbyMkhPF6eX9+GEdo3ibm5QHKkx2jOl89FuPGgZt6xlRfmPkO/FDdoIw==
X-Received: by 2002:ac8:734c:: with SMTP id q12mr32021153qtp.325.1580916030663;
        Wed, 05 Feb 2020 07:20:30 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c9b5:7cd5:1ee4:5066? ([2001:4898:a800:1010:7aeb:7cd5:1ee4:5066])
        by smtp.gmail.com with ESMTPSA id w53sm21625qtb.91.2020.02.05.07.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:20:30 -0800 (PST)
Subject: Re: [PATCH 00/10] name-rev: improve memory usage
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <06f8c44c-66aa-d9d5-7653-436424f5c864@gmail.com>
Message-ID: <d4815a14-eb7e-ae9e-54fe-ebfcdde70128@gmail.com>
Date:   Wed, 5 Feb 2020 10:20:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <06f8c44c-66aa-d9d5-7653-436424f5c864@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 10:28 PM, Derrick Stolee wrote:
> On 2/4/2020 4:12 PM, René Scharfe wrote:
>> This series seeks to get reduce the size of memory allocations, the
>> number of reallocations and the amount of leaks in git name-rev, to
>> improve its performance.
> 
> I am generally very happy with the performance benefits and think
> this series is very well organized.
> 
>>   name-rev: don't leak path copy in name_ref()
>>   name-rev: generate name strings only if they are better
>>   name-rev: release unused name strings
> 
> I don't have the right context to understand these patches without
> applying them and investigating the methods around the changes.
> They intrigue me, though, so I plan to pick this up again tomorrow.

After looking closely at these three, they LGTM.

Thanks,
-Stolee
