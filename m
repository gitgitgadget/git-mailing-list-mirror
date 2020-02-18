Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46AC34047
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0347922B48
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTr5z7Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRUMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:12:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45751 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRUMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 15:12:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so20760146qko.12
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u5krjokyB+PmxBR9AKdA4BT7e/woqY8tB4HVrQmlGrY=;
        b=oTr5z7Wm+P2ZSnB8lvB1mwlNrvavcMney5J1kVoWUVRvYUERC+Pa/oa4oKrsYP18B9
         EK+mHkFCg2WPFEA1zWewBLmkHOk/bhPWOQ7ghPzdMELrkJkKrO0qcyfeaLJdrnAyaoZr
         t9YY6lOgq8mxkNohH1sSowBPaoN6VVaspZlGNvZbLqNxwMHd8g/EIlAJqYZFOf3bYf8q
         MliijIr1lppOnGWd9QSzAtrlHYyMitHRBON1RPCdXrm6aVCSpVN3WQR3593xTpHc/too
         4i2DlDPXxOwRGW3qp3+gKykrXmo3mNuS05JYq8RQIF+Dg5JdkJjWQCrkN92f/ZwEIH5k
         MDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u5krjokyB+PmxBR9AKdA4BT7e/woqY8tB4HVrQmlGrY=;
        b=tGrQMTq6aAAGoIMVjznG57vvMJVfjhc5RWPI6oyME7IuJWOgHKEu8aaCc39L8yNvNq
         ZhUz4OssAhaACUx2D5LZYK1b32k18KlhNuXzqT7Bi+evjl4X2a9A9I2oOdRhGZMAOncb
         w+JcLcN9j3KBz2Wkg6eQcHxUuYgne6uIhspRxBoGgViQKZzACbSX350Gz+yJbl9aLBI6
         IHi0+1AbfpTdxV+EPYu0cawuGG4Yi8ASd9PYJboJqOwjt5uXkmMV3yY6D8k7z0h23fnT
         Da0Nvll6Y6ToOM7aHjWOT8vP1szk2TgxMZfeARReuz19qUhxKgx4mnnbCuN/Ptu+BY+b
         pQUw==
X-Gm-Message-State: APjAAAV3i8qi6wyZY8EO5TyeJK11TsiSGtXkIJIuE2vSBBUXOrKu7Gze
        pQQpDRLYS1lQjos+udeOvwo=
X-Google-Smtp-Source: APXvYqwulfeqkCRhnn5/9Zfm/iSfnS8A4y/QCIxmfjU1hrdckwQKvNeYh8O6F86/vZqCpWbwvLfYzw==
X-Received: by 2002:a37:a38e:: with SMTP id m136mr19719172qke.116.1582056719715;
        Tue, 18 Feb 2020 12:11:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:493e:b22e:e9c8:d09a? ([2001:4898:a800:1010:fa73:b22e:e9c8:d09a])
        by smtp.gmail.com with ESMTPSA id n189sm2397264qke.9.2020.02.18.12.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:11:59 -0800 (PST)
Subject: Re: [PATCH v2 09/15] rev-list: allow commit-only bitmap traversals
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182227.GI150965@coredump.intra.peff.net>
 <967821c8-aca4-52ff-8eb9-01a74f5a8144@gmail.com>
 <20200218200541.GD21774@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dad539af-adcc-4cda-17f8-423ce1cc9eed@gmail.com>
Date:   Tue, 18 Feb 2020 15:11:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200218200541.GD21774@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/18/2020 3:05 PM, Jeff King wrote:
> On Tue, Feb 18, 2020 at 01:18:21PM -0500, Derrick Stolee wrote:
> 
>>> +	test_expect_success "enumerate commits ($state)" '
>>> +		git rev-list --use-bitmap-index HEAD >actual &&
>>> +		git rev-list HEAD >expect &&
>>> +		test_bitmap_traversal --no-confirm-bitmaps expect actual
>>> +	'
>>> +
>>
>> I was wondering if there is anything we could add to the "expect"
>> command that could better guarantee these commits show up in a
>> different order than the bitmap order, allowing us to drop the
>> "--no-confirm-bitmaps". Perhaps the issue is the merge structure
>> of the repository, and how it will cause these orders to always
>> agree?
>>
>> I suppose "--topo-order" may actually present an order _even closer_
>> to the bitmap order.
> 
> I think in the partial-bitmap state it may have a different order,
> because we'd put the new commits at the end. But we run this test in
> both fully-bitmapped and partial-bitmap conditions.
> 
> We could add something like --topo-order to the expected output, but I
> think even if it worked, then the bitmap-confirmation in
> test_bitmap_traversal wouldn't really be checking anything! I.e., if the
> "actual" traversal didn't use bitmaps, we'd still say "oh, these two
> outputs are different, so one must have used bitmaps." So saying
> "--no-confirm-bitmap" at least documents that we don't expect any
> difference.

That's a pretty good point. Thanks!
