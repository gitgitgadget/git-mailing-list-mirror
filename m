Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7221F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeCPU7G (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:59:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40754 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCPU7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:59:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id t6so5387240wmt.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pN8FqdBAZfVGgcrwC/zbCGUhmynAzeGhJT7Qo4HC6Ts=;
        b=iF05nbi9uMNxmHyzePWZ3PPa+SQO2x0x4DadenopVm+xAP0g0FaVul0zhtCipWOBKI
         YrEp0hGb8ulFemK7V2TnlVHr2URA475IPDKwFYl7uIhUllP8bgzrDdtzsWg7VN/yJQML
         KeaoJLD9VSFZjHRF7hGNX5Gw1MmcmU7Frd7xefCdroCwdCQjd+SEBpmtrZWHTZ3Skt0o
         PGZkCU8Xqszth23niy9NRjr5Zo6d7bfEQgLwrLSGSZAYmtYj/T3heHNQPDr4CUvQ/n00
         LUjXgJ/mk1nIqDogeRKY/wrFNy1JAK5VMN3ndhbLhpL4bdzJDBdL/zohSdl25PvKmHBi
         rt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pN8FqdBAZfVGgcrwC/zbCGUhmynAzeGhJT7Qo4HC6Ts=;
        b=P0QTWBmLv269B4Pci5kzY4rqDrrLds6iy1IOfuqjVuj4CkUi7IvIXD6i3NRCLnqDVM
         pOxahBWTACpU0ec32Ev9u49PUAg7WG2q/wuJiCjfhxUqFAhxi0gbUzNV91ktwsaazP42
         7cxi0NYySxpf1gi5vjHQhBJ9DuZpl8VkuIHSc47DxV8bV1WCSEXCvJOk/PpdC4/Eozg9
         yfl6rYjRy7cGQvmQiwMxEd48A7nomHaEW52nryCIzdtwKQ6Z1nBjozqA5CDNhhKJtG5j
         CU8ZJu2bbS87SgZvA5oy8yJyXC4OL7iVZ6B8mhm6zoLJHGwSk/iQrV3Op5V61Qg72oa5
         TQcw==
X-Gm-Message-State: AElRT7G9/UHtJU4fp4o9hzsciqskwl3V8KCJMGuqhS3KZ10xAdsBTob6
        +4zv0jZX2F9FH4QmcAH4rbnZUlFx
X-Google-Smtp-Source: AG47ELuftmuXDRTkOZvCUFjM70aWgu4etgzkACksh0yrjeOMQosUIBBI/1D84BgLhYDzjct3b9cbVg==
X-Received: by 10.28.6.205 with SMTP id 196mr3095488wmg.136.1521233943938;
        Fri, 16 Mar 2018 13:59:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g25sm8191311wmc.0.2018.03.16.13.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:59:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 07/11] pack-objects: refer to delta objects by index instead of pointer
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-8-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 13:59:02 -0700
In-Reply-To: <20180316183200.31014-8-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:31:56 +0100")
Message-ID: <xmqq7eqb20vd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> These delta pointers always point to elements in the objects[] array
> in packing_data struct. We can only hold maximum 4GB of those objects

4GB, as in "number of bytes"?  Or "We can hold 4 billion or so of
those objects"?

> because the array length, nr_objects, is uint32_t. We could use
> uint32_t indexes to address these elements instead of pointers. On
> 64-bit architecture (8 bytes per pointer) this would save 4 bytes per
> pointer.
>
> Convert these delta pointers to indexes. Since we need to handle NULL
> pointers as well, the index is shifted by one [1].
>
> [1] This means we can only index 2^32-2 objects even though nr_objects
>     could contain 2^32-1 objects. It should not be a problem in
>     practice because when we grow objects[], nr_alloc would probably
>     blow up long before nr_objects hits the wall.

