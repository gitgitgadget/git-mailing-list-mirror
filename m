Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84345C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjFANDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFANC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:02:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243EA97
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:02:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so8070635e9.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685624576; x=1688216576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=truI6ynoeCqZ1cO3ewUwgIoy6HJ5PjG16qgLaDwGuZo=;
        b=ERrYQdQY50FXBGYGtmv9xzsETLbEnyG+LHaOWiBJccvuVEBEOR2bsE3+930urp7qjg
         ioM1KhY9oEJPJ7OfbTU1Sw/06c/KNJobvJjM9YVp9yxHQfzTR7h74uqnB/aotuWAwi6Y
         aED/YbMRsUt7OVrR0UBmxH9djLTy5hGlz80tfoQ+NUKCzgzqQmybfQjS7MEcOO2JVp36
         BbgAuY07FeI3zvexaGaqH7cSP+P7nJ4kEbdQEt2jWIfkrBUFJB6yRB0PtrRW0IwR3Lx7
         z2Vvqio6Anov9FtJPy7YsLfCQ4XcUJNCQb93vSbCk2bZLuWVe80IGcUNLGcrGzG5bhzU
         zuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624576; x=1688216576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=truI6ynoeCqZ1cO3ewUwgIoy6HJ5PjG16qgLaDwGuZo=;
        b=eUQRc1WdurAciTKNUOrUhwcfsbIh+PLdmGvqskCiqt7BJA8sOZmsFN3nF8H5s4CC6n
         AKahUDwzN2HNXDfvhdweiLUrmNhl7ylrV0fGOGQiap1JlhKt/ipMHswrnUINswu3phZF
         M6NkYBndf8GlBgqReIpZXYezULk37Pltc85GYW2qgfV3QTxRSrCr5/D2sjJ7QcaQv+8v
         l98GlWfCvfOljxPKQpJosBmqYX/pEqEBLy5YTLsj5afLR5n31UR8LUgSqGlXNu6Aom7W
         +cb0kkJjYn5j3GIUim3VBbfhMyOa/SQ8QFMnn7PA41ADi0jbpZSPKvkzPt9zZdpaSdUx
         TlXQ==
X-Gm-Message-State: AC+VfDwL0pB+ZJPEb2lRDdyFtcjogZRByVPUfRQpAoM32AasCvYWWouI
        qjr/+4lM4lAlnP5wPfthVk/xfHhZdUw=
X-Google-Smtp-Source: ACHHUZ4cm78apF0uIozQyY/v88OqVIzs5C6MxlbZzkV1sRwCHeljr5WhUa8gR57BGx+3K3/yk0ho5A==
X-Received: by 2002:a05:600c:22d4:b0:3f6:552:8722 with SMTP id 20-20020a05600c22d400b003f605528722mr1986197wmg.18.1685624576405;
        Thu, 01 Jun 2023 06:02:56 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id l3-20020a5d5603000000b003063772a55bsm10149124wrv.61.2023.06.01.06.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:02:55 -0700 (PDT)
Message-ID: <35bd6c86-66e8-13c8-4a8d-5822953fedb1@gmail.com>
Date:   Thu, 1 Jun 2023 14:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/1] Unit tests for khash.h
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Siddharth Singh <siddhartth@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20230531155142.3359886-1-siddhartth@google.com>
 <ZHfLwpX7nNVjBvE5@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZHfLwpX7nNVjBvE5@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 31/05/2023 23:35, Taylor Blau wrote:
> Hi Siddharth,
> 
> On Wed, May 31, 2023 at 05:51:41PM +0200, Siddharth Singh wrote:
>> This RFC patch adds unit tests for khash.h. It uses the C TAP harness
>> to illustrate the test cases [1]. This is not intended to be a
>> complete implementation. The purpose of this patch to get your
>> thoughts on the unit test content, not the test framework itself.
> 
> Thanks for working on this, and for opening the discussion up. I took
> only a brief look through the actual changes. But I think the much more
> interesting discussion is on the approach, so I'll refrain from
> commenting on the tests themselves.
> 
> I am somewhat skeptical of this as a productive direction, primarily
> because khash already has tests [1] that exercise its functionality. I'm
> not necessarily opposed to (light) testing of oid_set, oid_map, and
> oid_pos, which are khash structures, but declared by Git.

I agree that starting by adding tests for third party code is a bit 
curious, but those tests you linked to look like they're testing 
performance rather than correctness.

Best Wishes

Phillip

> Even still, I don't think that we are testing much in that case, since
> the boundary between Git and khash is limited to the KHASH_INIT macro.
> 
> So... I dunno. I'm not strongly opposed here, but I think this is
> probably not the most productive place to start adding tests.
> 
> Thanks,
> Taylor
> 
> [1]: https://github.com/attractivechaos/klib/blob/master/test/khash_test.c

