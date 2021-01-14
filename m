Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC841C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EBD23A53
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 12:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbhANMAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbhANMAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 07:00:53 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BFC061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:00:12 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 143so7186197qke.10
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 04:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ko98ZqghKW5sfPpaUyWJ+gaHWhBNCCfDTTGpRSPYqfQ=;
        b=lxxVSe/SDKgD9UBl2AoohAzVbFzNlzDokASnyfm4SXxDcG8xrYex4AWZH1hJZUc3AP
         zBDahGDgSmysWjf3YVQ20ZMXKHj5Wc7IiRoBqqTsVVaEOHWSr8srA+iMZRaP5VfDPUz0
         dTIJ1MFZ/Jv78+B+spObI85+a9b99ImI7VosEZdz23cuFgackljtThHVHZjkh6pPyoIG
         rAhRepwodtc6AiM/EORQyI3ITBUdlAMUjRV37fjDdxg8bkRS9Cx573iBdhU3ehWRgckg
         t5Y1ALxzjVMoBiM1IsHToha1GKceMDpn2iohpkCOd0tMz3lVdlO4Bn6/dj2unuskn9jg
         sy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ko98ZqghKW5sfPpaUyWJ+gaHWhBNCCfDTTGpRSPYqfQ=;
        b=Q+Nqd+y6crfoDNfxyBs9kQdTC5UJ9vaN8jdN290IFuVomjAKp0rLpYazG2ZWAIkgsI
         dddmsnUNdfn749tkdWvuIvYPjaEk91M3UwIN11VKHiFCko7iAGQK2tYSvZuGc61NWxYo
         O5/s6AugeJv8nX6hKXqnx34GrS9v1F1bvZabO2PA/l0qLOc3lda+MsACBuJwv2GkINs1
         uBsukXkmTJnqCDA9fC5XCyGwk6eXbTXGCKYxPtsWeJm6MdyO1voxAVbX00aAy5uNOFeg
         TyJUP6ZuJfgVfuRRgfytDYRM/TeFQj3xpviXICcIXTO2vwt6Xay+mfqEA9KWuWpMB5Zs
         RWhA==
X-Gm-Message-State: AOAM530tIx+fs9GrShfBu48B/sSA9h3VEd8jnIipaA9afoPgpvd6Y/nE
        RDFvS6LwdJL1U+OOORfxbAI=
X-Google-Smtp-Source: ABdhPJw4MiVnUK4aBC0yOBg9aQRLoOdQetEIKjyBrzAxqyAKRwDa5tFQ+2R5p3R2oo/XUKvI3a7hdQ==
X-Received: by 2002:a37:ad5:: with SMTP id 204mr6589643qkk.323.1610625612104;
        Thu, 14 Jan 2021 04:00:12 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:81b0:4431:6d9:fc9e? ([2600:1700:e72:80a0:81b0:4431:6d9:fc9e])
        by smtp.gmail.com with UTF8SMTPSA id c20sm2662364qtj.29.2021.01.14.04.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 04:00:11 -0800 (PST)
Subject: Re: [PATCH v2 01/20] pack-revindex: introduce a new API
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e1aa89244ad3edb52aaeb28d6934cb2b0a0dc65a.1610576604.git.me@ttaylorr.com>
 <xmqq1reoypzy.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <685081d3-0cca-4c61-52b2-e9a8006803b1@gmail.com>
Date:   Thu, 14 Jan 2021 07:00:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq1reoypzy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2021 1:46 AM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> +/*
>> + * offset_to_pack_pos converts an object offset to a pack position. This
>> + * function returns zero on success, and a negative number otherwise. The
>> + * parameter 'pos' is usable only on success.
>> + *
>> + * If the reverse index has not yet been loaded, this function loads it lazily,
>> + * and returns an negative number if an error was encountered.
> 
> It is somewhat strange to see a function that yields a non-negative
> "position" on success and a negative value to signal a failure to
> have a separate pointer to the location to receive the true return
> value.  Do we truly care the upper half of "uint32_t" (in other
> words, do we seriously want to support more than 2G positions in a
> pack)?
> 
> What I'm trying to get at is that
> 
> 		int pos = offset_to_pack_pos(...);
> 		if (pos < 0)
> 			error();
> 		else
> 			use(pos);
> 
> is more natural than

I agree that this is used commonly, but usually in the case that
we are finding a position in the list _or where such an item would
be inserted_. For example:

	pos = index_name_pos(istate, dirname, len);
	if (pos < 0)
		pos = -pos-1;
	while (pos < istate->cache_nr) {
		...

But that does not apply in this case. Knowing that the requested
offset lies between object 'i' and object 'i + 1' isn't helpful,
since the offset still does not correspond to the start of an
object.

> 		uint32_t pos;
>                 if (offset_to_pack_pos(..., &pos) < 0)
> 			error();
> 		else
> 			use(pos);
> 
> but now I wrote it down and laid it out in front of my eyes, the
> latter does not look too bad.
> 
> 	... later comes back after reading through the series ...
> 
> 	The new callers all looked quite nice to eyes.  Because we
> 	discourage assignment inside if() condition, the converted
> 	result does not make the code more verbose than the
> 	original.  In fact, it makes it even clearer that we are
> 	checking for an error return from a function call.  
> 
> 	Quite nice.

As someone who spends a decent amount of time working in C#, I
also like this pattern. The APIs in C# work this way, too, such
as:

	if (!set.TryGetValue(key, out value))
		return false;

	// Use 'value', which is initialized now.

Thanks,
-Stolee
