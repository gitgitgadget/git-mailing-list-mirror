Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85709C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5485E2072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 11:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFSzl7E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgAJLa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:30:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45035 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgAJLa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 06:30:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1540292oia.11
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIwuTEBSCuwNbXGx1B60m7BpkEoNVgh5xjpKYZ+tBSk=;
        b=dFSzl7E1/8EpJ5hCXUw34mrm4tyttP3Cr8huPkX+VDEvFhsK0Gju/VH+L112AsDAFp
         j3ze3Jzi8vsZU0secPITAgzV5a8fPWp6ia7KKzTH6e2pzOn3zv5mCatKM/COkCpU1xRl
         EmxcfJ5zqHaBq6RrJOjV+Cal9dv4Uc3xWYMvECr1WYpFrZYrMMXk4J7dwQqaaL9IFq8m
         7p8dtoI9iQ9N8/XjE3DP2tDxUN7tV8SmyqXYu/HtTiRREDBLJBmMBIHez07fCaKDwYxn
         ZinjKIuOPly6ZQ3u57E+D6Spci6FzaluG6eal2LqprsRyd1Jxz2FFEDSUrtvSoGq4e1C
         NIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIwuTEBSCuwNbXGx1B60m7BpkEoNVgh5xjpKYZ+tBSk=;
        b=abYYaf4LIA0MSAZicDKS+CVrUNm+eUVA9BsPT+6Wd86k8hWeE1uK1kd3W87EVIvc6W
         0QOx/0SyNsyCulA/4RWc/adFX3Lz1lU37EjFFTkmJBQp66D/U3ebpHHnLwH4Rm2ZzUIt
         rf9GBH0tH69QwSv1XG6Cdn6SkxNadh3YJzgfCVysuWwHH8QvB0TBs8jJ1kP7nzkhXUum
         6dJrkGWRql4kNFpbWVLwFszWuGUbk1Y/nfo77EXlzNZDE9+am8ABowCbg6Rc2yvqvk7y
         XGg8UdmKg9cuBG/DgUbuNRW9Jn6xafOTbKyQWMWyssXoMp6Y0QlHlwOfKv40Rf4hPkYW
         03cg==
X-Gm-Message-State: APjAAAXfy9yTaeeJwqkLRExbxNbG6zoXSKS7cWL4VUT7KLTiNzK8+OF2
        rQXUkTEfLSjvtDPIMsZxz1s=
X-Google-Smtp-Source: APXvYqwSJ3BKb973JPEB2AWIf32SyHVieJ69Bv6NjFlR+whqRTVDaDODe75YNLykSe3UnPZijjE7tA==
X-Received: by 2002:a05:6808:643:: with SMTP id z3mr1872442oih.19.1578655826427;
        Fri, 10 Jan 2020 03:30:26 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 69sm698583oth.17.2020.01.10.03.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 03:30:25 -0800 (PST)
Subject: Re: [PATCH] unpack-trees: correctly compute result count
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
 <20200110103729.GA470836@coredump.intra.peff.net>
 <d9a465bf-843b-2a8f-66c0-73fb706dbfc0@gmail.com>
Message-ID: <40ff5504-9cdc-a97f-9dbf-84529d6596ce@gmail.com>
Date:   Fri, 10 Jan 2020 06:30:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <d9a465bf-843b-2a8f-66c0-73fb706dbfc0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2020 6:24 AM, Derrick Stolee wrote:
> On 1/10/2020 5:37 AM, Jeff King wrote:
>> On Fri, Jan 10, 2020 at 01:59:30AM +0000, Derrick Stolee via GitGitGadget wrote:
>>>
>>>     As for making it into the release, I don't know. The change is small, it
>>>     has a very limited scope, but this flaw is also not really hurting
>>>     anything in a major way.
>>
>> I could go either way.
>>
>> This counts as something small and obvious enough that I'd consider
>> slipping it in at the last minute if it were fixing a bad bug. But given
>> how minor the bug is, being conservative makes sense to me, if only
>> because it's good to exercise our release discipline muscles. :)
> 
> Perhaps this should be an example for future release windows.

(Forgive me for fat-fingering and accidentally using "gmx.net" instead
of "gmx.de" for Johannes' email address. Fixed in this message.)

-Stolee
