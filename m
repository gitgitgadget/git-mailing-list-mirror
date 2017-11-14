Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935A91F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbdKNObJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 09:31:09 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:49658 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdKNObI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 09:31:08 -0500
Received: by mail-qk0-f177.google.com with SMTP id w125so13428241qkb.6
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kh94kQwAlf2dHV9elZhQozGAtsM6hToedLNLY9/7bqA=;
        b=vIsPrWDT5slzbHRFgAwpgxCWQzBN+zsnpzNTbL1Yml+7Fo/eTQj2ZvGczjf9ipisi4
         qP0YwO5j4dlmfwZXHWyd1pl7oRSHAvBPPDt+XfQw5pluXwMTZFkfcMwEWqZrH/HLOk2u
         czuEteCrgcZU4Ya6G/rid8RJal9b+UJpEdjTDFH9wvZwTl7QH6PnBDth2AwzGGHjX4uS
         jduw+qy5yqYGXdR3VLVQcOl3OwNEh6e2HcDh9aE9EYzAdQz7Z9jnUG2QYuGPBSogIMKx
         fVIWBmzbdL9Xou9/oawPUf+EMMl3NOjpC74V35ePoempyCWv8C3kHcyWQtISkuYemra4
         zS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kh94kQwAlf2dHV9elZhQozGAtsM6hToedLNLY9/7bqA=;
        b=QR0BzRyIPjs20N1oBWJeFrbqW/QkTj/8sRPm5WsmJgScLA1O5MFCqByamGCSytgLzC
         HDUexBAMBdtMrlb6Pq1l3Tt8U6CBgJ+d42LqF+FW4/wp+qduQw/YJrruXte+6bjZba3O
         buNls2SJVNicij+DgDOAkZcL9x4Fwn48PS966kBsB1A8cH41ZBpVN1d/emavqbzZ4AUr
         QZe7BKoAz7/yvDd0xPmTexmJB97VqxzgSMS+Bao4cjkCBmH0yVjgACTz7ZS/LKqXh1a3
         Q/EWXatQFegg7GB5Jctz2g/OMwVPQoKRPSIVKsshx7xXA4/p5mLWtmhwxIupfh6cQBDM
         5kYg==
X-Gm-Message-State: AJaThX740lYCW4RF2SRVi4R734psSTtTCEw21KGpm+QmSPocY+RtyI/9
        EN4ZO7NzwGwBZdHNU7TirnY=
X-Google-Smtp-Source: AGs4zMbMWexQhczw6ODGK9OD1fJ5JvqO6un58eKji4F4rEhtt54ANwTX3H1U8mZaPNVL1WTDUB8nog==
X-Received: by 10.55.12.199 with SMTP id 190mr20098487qkm.315.1510669866889;
        Tue, 14 Nov 2017 06:31:06 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x35sm12418324qte.26.2017.11.14.06.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 06:31:05 -0800 (PST)
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
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
Date:   Tue, 14 Nov 2017 09:31:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/13/2017 8:10 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> The proposed format for extensions (ie having both a header and a
>> footer with name and size) in the current patch already enables having
>> multiple extensions that can be parsed forward or backward.  Any
>> extensions that would want to be parse-able in reverse would just all
>> need to be written one after the other after right before the trailing
>> SHA1 (and of course, include the proper footer).
> 
> In other words, anything that wants to be scannable from the tail is
> welcome to reimplement the same validation structure used by IEOT to
> check the section specific sanity constraint, and this series is not
> interested in introducing a more general infrastructure to make it
> easy for code that want to find where each extension section in the
> file begins without pasing the body of the index.
> 
> I find it somewhat unsatisfactory in that it is a fundamental change
> to allow jumping to the start of an extension section from the tail
> that can benefit any future codepath, and have expected a feature
> neutral extension whose sole purpose is to do so [*1*].
> 
> That way, extension sections whose names are all-caps can stay to be
> optional, even if they allow locating from the tail of the file.  If
> you require them to implement the same validation struture as IEOT
> to perform section specific sanity constraint and also require them
> to be placed consecutively at the end, the reader MUST know about
> all such extensions---otherwise they cannot scan backwards and find
> ones that appear before an unknown but optional one.  If you keep an
> extension section at the end whose sole purpose is to point at the
> beginning of extension sections, the reader can then scan forward as
> usual, skipping over unknown but optional ones, and reading your
> IEOT can merely be an user (and the first user) of that more generic
> feature that is futureproof, no?
> 
> 

How about I add the logic to write out a special extension right before 
the SHA1 that contains an offset to the beginning of the extensions 
section.  I will also add the logic in do_read_index() to search for and 
load this special extension if it exists.

This will provide a common framework for any future extension to take 
advantage of if it wants to be loaded/processed before or in parallel 
with the cache entries or other extensions.

For all existing extensions that assume they are loaded _after_ the 
cache entries, in do_read_index() I'll add the logic to use the offset 
(if it exists) to adjust the src_offset and then load them normally.

Given the IEOT extension is just another list of offsets into the index 
to enable out of order processing, I'll add those offsets into the same 
extension so that it is a more generic "table of contents" for the 
entire index.  This enables us to have common/reusable way to have 
random access to _all_ sections in the index while maintaining backwards 
comparability with the existing index formats and code.

These additional offsets will initially only be used to parallelize the 
loading of cache entries and only if the user explicitly enables that 
option but I can think of other interesting uses for them in the future.
