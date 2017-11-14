Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9BF1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbdKNPkF (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:40:05 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:56478 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbdKNPkE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:40:04 -0500
Received: by mail-qt0-f194.google.com with SMTP id r39so9631410qtr.13
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dsiy0pp8M3B9GXpw71Dsv7cU3wp/A4qLpUHp8h8405U=;
        b=ZdumeLkI7v/CLm0+YieTmIU8x4+auKOQj077Zn0/NuNl+YXsAa9hm6sRiIZmKvLEtp
         H2quzbxCFJw5xbw+5a9PACpYdzaDDHS6iT42tr2c6438+dXV6wyHPQ7ep6BJG0pwLx6e
         FpZ3EkQ5cndLdHsW+z732QKzjp1ReKakN1mkytEiz6t1sDQTbtOYX7wiomxSAuSQMgLG
         0spSOr6EgTyXDPunIObQlpzyouXgw0/77o4v7mAedsY3v1PO/eMXvuVCOMhGNXYTUBNX
         d8hvzTE0uW7dUrNA+adP2nhlavMughS7R2gCHUBV4BuV3I5/Hz5L7uAoZjc0jQLqsXkC
         UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dsiy0pp8M3B9GXpw71Dsv7cU3wp/A4qLpUHp8h8405U=;
        b=DPRgSHZwVUc8/DOKEKcepdzsegIpdtz9iCEXxipQMZloGaoXNBOQQMUqNecITRmmAY
         EdtR5+ZwO5fJNDICB1fjztY7IvhXOIwvJn6Ln9Dcgwzw4MqsiW7E8okRRS5u2ivzrAHO
         TtFiP865CBXrRQCYt1Z19dVQ7NieFe3O9nkut6L61IUuJLdk+fbYUtI5jv/8FD+DGu64
         JFamPS3nUcIBIs2LN1A8ui1nLvcgGHR5+eEMlyX+h5VofKhisc6wb+utNd9GsFnh1YRg
         MBwiP3NglMghZcm6L9jYgbT2G0+4vjJ80z83MwwMf3lps1bo0z34+mwavi5A8ovtAyv7
         jKOA==
X-Gm-Message-State: AJaThX7rm03ngK7Q91hFXGzDYGAdvQlRzrYdGeW1lBUlMhCKpsLTk2wh
        q5CwRnF1zJ4ScQ7NHU35oOI=
X-Google-Smtp-Source: AGs4zMajNkvjK4TJrrJQDN7wAZtwFvivRX/hiAiUhJVhmAsiXzD4YnSkCkcAFE78ejhzsrvVLApSWA==
X-Received: by 10.200.50.78 with SMTP id y14mr9061170qta.84.1510674003065;
        Tue, 14 Nov 2017 07:40:03 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o70sm12678504qki.35.2017.11.14.07.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 07:40:01 -0800 (PST)
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
References: <20171109141737.47976-1-benpeart@microsoft.com>
 <20171109141737.47976-2-benpeart@microsoft.com>
 <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
 <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
 <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
 <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
 <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
Date:   Tue, 14 Nov 2017 10:40:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/14/2017 10:04 AM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> How about I add the logic to write out a special extension right
>> before the SHA1 that contains an offset to the beginning of the
>> extensions section.  I will also add the logic in do_read_index() to
>> search for and load this special extension if it exists.
>>
>> This will provide a common framework for any future extension to take
>> advantage of if it wants to be loaded/processed before or in parallel
>> with the cache entries or other extensions.
>>
>> For all existing extensions that assume they are loaded _after_ the
>> cache entries, in do_read_index() I'll add the logic to use the offset
>> (if it exists) to adjust the src_offset and then load them normally.
>>
>> Given the IEOT extension is just another list of offsets into the
>> index to enable out of order processing, I'll add those offsets into
>> the same extension so that it is a more generic "table of contents"
>> for the entire index.  This enables us to have common/reusable way to
>> have random access to _all_ sections in the index while maintaining
>> backwards comparability with the existing index formats and code.
>>
>> These additional offsets will initially only be used to parallelize
>> the loading of cache entries and only if the user explicitly enables
>> that option but I can think of other interesting uses for them in the
>> future.
> 
> If we freeze the format of IEOT extension so that we can guarantee
> that the very first version of Git that understands IEOT can always
> find the beginning of extension section in an index file that was
> written by future versions of Git, then I'm all for that plan, but
> my impression was that you are planning to make incompatible change
> in the future to IEOT, judging from the way that IEOT records its own
> version number in the section and the reader uses it to reject an
> unknown one.

I have no thoughts or plans for changes in the future of IEOT (which I 
plan to rename ITOC).  At this point in time, I can't even imagine what 
else we'd want as the index only contains cache entries, extensions and 
the trailing SHA1 and with the TOC we have random access to each of 
those.  If nothing else, it gives another signature to verify to ensure 
we actually have a valid trailing extension. :)

I only added the version because I've learned my ability to predict the 
future is pretty bad and it leaves us that option _if_ something ever 
comes up that we need it _and_ are willing to live with the significant 
negative trade-offs you correctly point out.

> 
> With that plan, what I suspect would happen is that a version of Git
> that understands another optional extension section that wants to be
> findable without scanning the main table and the then-current
> version of IEOT would not be able to use an index file written by a
> new version of Git that enhances the format of the IEOT extension
> bumps its extension version.
> 
> And if that is the case I would have to say that I strongly suspect
> that you would regret the design decision to mix it into IEOT.  That
> is why I keep suggesting that the back pointer extension should be
> on its own, minimizing what it does and minimizing the need to be
> updated across versions of Git.
> 

I understand the risk but the list of offsets into the cache entries is 
pretty simple as well. I prefer the simplicity of a single TOC extension 
that gives us random access to the entire index rather than having to 
piece one together using multiple extensions.  That model has its own 
set of risks and tradeoffs.
