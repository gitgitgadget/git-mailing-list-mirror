Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D67C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6F56513A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCHU5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHU5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:57:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAEEC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:57:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id f20so11473100ioo.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XKjqADnynR2KG7o4QkMVngBbBnHzOrmjO/pHZ4KJKGU=;
        b=JkjDpxLoy7ySyd4Js8i8AW1g5bi8HLyP0cfSoKCwRsSnDRTGu+1/UtN23TzbAoXHaa
         brO1UpJVdnmwRgMekgflrWL3YP7Z66SX9MpyQHY9mL0de6igJWAQMIo0WePE/9bJvniq
         Klud1juJGUZHliJjmXbdA0Drr4NiZBkj9vpUbHMli7zQbku50Vg1xaQ8d+IYHfuLl7QZ
         LJY0a6FvUzywr8rz3Q+o57gVQf/Eenchib0/8QcvuljvRjPvJdN5kUkU4qTkseb3drsN
         ZM6CUiI6EPB+/TY3awNK6dverF8GPwOrw+0OOFc6IjmfT7eFh9TaM1G0v+RiHDTjJKy3
         6l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XKjqADnynR2KG7o4QkMVngBbBnHzOrmjO/pHZ4KJKGU=;
        b=c2EDq+VI7h1JIUG7bJXXfdsDfrG+GJ4mPyHv2KkcT5yLIN3fJSly+fontA9a6idVQZ
         65sPc9oVP8OAcLCGvK/nZc7M2jmcONFi6jqe39RIWErJrMUm2rEFQwWojOsL56nssWr7
         IhVZvbcCaltL0OLPCGPKb6F+sKzIuaYrEbntzS7pCdqEIEJCgZqIBr+9GDA0q4PcXk5Y
         mbmtCJStWr6USPZj6IBufvyTJPIpPnZxp/MIMqraQcl4MJln301xRZ6+bJZol59r6Y4D
         7JYQVDflX1gaQ2rBjMRtuEeqH3DWfTQlYdhUjn2coFduUka4U/+XH7TB/xE2/8Dm7IfI
         e4QQ==
X-Gm-Message-State: AOAM5321KgVPbCcvlm+RDSocZ4DeVj8KqQP9aRHNALUAvUY0oumGH5aT
        AwNUX+DmhfPE5TLmyRkjsbZMAg==
X-Google-Smtp-Source: ABdhPJyIUFfDhiOnAnmMe42mNuUCwJTjsPnWS+qPemaWd4C5JQxe8Wv3wUCRcziQZLwqGzJKTzXqvg==
X-Received: by 2002:a05:6602:2348:: with SMTP id r8mr20529038iot.77.1615237021707;
        Mon, 08 Mar 2021 12:57:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id h23sm6384470ila.15.2021.03.08.12.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:57:01 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:56:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] object.c: make type_from_string() return "enum
 object_type"
Message-ID: <YEaPcFTenqbUGC2C@nand.local>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-3-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the type_from_string*() functions to return an "enum
> object_type", and refactor their callers to check for "== OBJ_BAD"
> instead of "< 0".
>
> This helps to distinguish code in object.c where we really do return
> -1 from code that returns an "enum object_type", whose OBJ_BAD happens
> to be -1.

I'm not sure I understand the intention of this and the following few
patches. I could imagine that you eventually want to use other negative
return values for a different purpose, but OBJ_BAD _is_ '-1' (as you
note), and we use 'int' and 'enum object_type' interchangeably in other
parts of the code.

That's not to say that I'm necessarily opposed to picking up these few
patches, but rather that I don't fully understand their purpose.

The patch below looks good.

Thanks,
Taylor
