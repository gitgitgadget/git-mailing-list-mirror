Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBCCC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAPHSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 02:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAPHSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 02:18:04 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692BCC06
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 23:18:00 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id A8BB9260BB4;
        Mon, 16 Jan 2023 08:17:57 +0100 (CET)
Message-ID: <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
Date:   Mon, 16 Jan 2023 08:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <20230115135245.GB16547@kitsune.suse.cz>
Content-Language: en-US
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230115135245.GB16547@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/23 14:53, Michal Suchánek wrote:
>> Many people think that bit errors cannot happen because the memory uses ECC
>> and the file system uses cryptographic hashes to verify the integrity of the
>> data. But what many people forget about is that when copying data from
>> memory to disk, typically using a DMA channel data is copied w/o any kind of
>> integrity protection, because the integrity protection is not end-to-end.
>> The integrity protection is only per-link.
 >
> So long as all links have integrity protection it's end-to-end.
 >

Hi Michael,

You clearly don't see what this is about! Only if the same CRC mechanism 
is end-to-end, you don't have any good integrity mechanism at all!

Let me try to explain what this is about in very simple words. Because 
memcpy() does not copy the ECC CRC values along with the data, it is an 
unsafe memory copy mechanism, which may introduce bit-errors without 
noticing. It does not help to only have ECC RAM or for that sake protect 
the PCI links.

--HPS
