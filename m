Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D31202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 04:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756770AbdKOEQr (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 23:16:47 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:53039 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756665AbdKOEQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 23:16:43 -0500
Received: by mail-qt0-f174.google.com with SMTP id 31so31572394qtz.9
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 20:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sjwNMHpDNQiwP67Z3RpH4dc7RHvOYTz6ElnPtQ227qU=;
        b=UafClsDIPk4oehCPBAvhUoq8EmKY4KpE84uG948IAElUKTKqirbKjcZm5OWlOr4tFy
         cUqazl67BA3QTKcr3TVpNQbLxLUpu2Q3vaXv5QgfIUQTC9NmYZhS+MdTlHerjDVddKeF
         a1f621srzs3G4PiX+R4SawCzGTmLDvEoREERq873YPP2ttzPcs5Uk+Aitfjwzkx77Efh
         TZkwkx3G+TIyr1nzSdbbLd54VlpHXx+MkfrFXj4CMAVPvbaHRGgONA0WikRlqgFeS4eP
         ds2dCHkBB6ttRyreehRHslOXVa553hviD7QBVDcc5FhnVcTTJf0FVOYnNCEHkfVcfFGW
         wS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjwNMHpDNQiwP67Z3RpH4dc7RHvOYTz6ElnPtQ227qU=;
        b=qiqF7PapDE+yxhX5MNoBzJvtlPEo0k+skXTt+SMWnx+ERM3L0DwyCyA7CYM2C6EG8V
         zXEpK0uWl9n105Yv2YlaiWXG1sAxW5pscarlZAvHN1MI3U9APSdGNoP0mPKYUZqFnuLx
         7GbpiZdUAcRmInrNrAhwbtYLCdO857mdOO8Hz0+8MTHcqiuIV8QgmkkzPVc2EDhEfBv5
         S56IcLRxgYPxzP5extCCDtp+UP0hGt1qeX2VxqAWwCwSmwy2RXHtxhnWaE6JuldrMWCY
         jdukIo4qa9Obt3EVncWEy0KHJFHVPBT5nXQHjg8E1lHo2s5K/HbEECmYnbYacqedkluV
         yBsw==
X-Gm-Message-State: AJaThX4mDyQw+/br/a7uaz4aPQuri+k9uc7AbTztys1KtJ0MAo2bYGSQ
        JHkZVK5jUEybcL4H/Qk8FdQ=
X-Google-Smtp-Source: AGs4zMYIrbqEzpKPdQu66IJTDfnFYBl44dSnUVIbqfK+9EaZSG+WifprqajdD7GNkK5zr/hal1xGwQ==
X-Received: by 10.55.175.5 with SMTP id y5mr22427757qke.326.1510719401798;
        Tue, 14 Nov 2017 20:16:41 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m6sm13719001qti.14.2017.11.14.20.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 20:16:40 -0800 (PST)
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
 <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
 <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
Date:   Tue, 14 Nov 2017 23:16:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/14/2017 8:12 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> I have no thoughts or plans for changes in the future of IEOT (which I
>> plan to rename ITOC).  At this point in time, I can't even imagine
>> what else we'd want as the index only contains cache entries, ...
> 
> Yeah, but the thing is that this is open source, and the imagination
> of the originator of the initial idea does not limit how the code
> and data structure evolves.
> 
> Back when I added the index extensions to the system, I didn't have
> perfect foresight, and I didn't have specific plans to add anything
> beyond "TREE" to optimize "write-tree" and "diff-index --cached".
> 
> In hindsight, I got one thing right and one thing wrong.
> 
> Even though I didn't have any plan to add a mandatory extension, I
> made the code to ignore optional ones and error out on mandatory
> ones if an index extension section is not understood.  It turns out
> that later (in fact much later---the "TREE" extension dates back to
> April 2006, while "link" came in June 2014) we could add the
> split-index mode without having to worry about older versions of Git
> doing random wrong things when they see this new extension, thanks
> to that design decision.  That went well.
> 
> On the other hand, I didn't think things through to realize that
> some operations may want to peek only the extensions without ever
> using the main table, that some other operations may want to read
> some extensions first before reading the main table, or more
> importantly, that these limitations would start mattering once Git
> becomes popular enough and starts housing a project tree with very
> many paths in the main table.
> 
> I really wish somebody had brought it up as a potential issue during
> the review---I would have defined the extended index format to have
> the simple extension at the end that points back to the tail end of
> the main table back then, and we wouldn't be having this back and
> forth now.  But I was just too happy and excited that I have found a
> room to squeeze extension sections into the index file format
> without breaking existing implementations of Git (which checked the
> trailer checksum matches to the result of hashing the whole thing,
> and read the recorded number of entries from the main table, without
> even noticing that there is a gap in between), and that excitement
> blinded me.
> 
>> I understand the risk but the list of offsets into the cache entries
>> is pretty simple as well. I prefer the simplicity of a single TOC
>> extension that gives us random access to the entire index rather than
>> having to piece one together using multiple extensions.  That model
>> has its own set of risks and tradeoffs.
> 
> I thought that you are not using the "where does the series of
> extensions begin" information in the first place, no?  That piece of
> information is useful independent of the usefulness of "index into
> the main table to list entries where the prefix-compression is
> reset".  So if anything, I'd prefer the simplicity of introducing
> that "where does the series of extensions begin" that does not say
> anything else, and build on other things like ITOC as mere users of
> the mechanism.
> 

OK.  I'll call this new extension "EOIE" ("end of index entries"). Other 
than the standard header/footer, it will only contain a 32 bit offset to 
the beginning of the extension entries.  I'll always write out that 
extension unless you would prefer it be behind a setting (if so, what do 
you want it called and what should the default be)?  I won't add support 
in update-index for this extension.

Since the goal was to find a way to load the IEOT extension before the 
cache entries, I'll also refactor the extension reading loop into a 
function that takes a function pointer and add a 
preread_index_extension() function that can be passed in when that loop 
is run before the cache entries are loaded.  When the loop is run again 
after the cache entries are loaded, it will pass in the existing 
read_index_extension() function.  Extensions can then choose which 
function they want to be loaded in.

The code to read/write/use the IEOT to parallelize the cache entry 
loading will stay behind a config setting that defaults to false (at 
least for now).  I'll stick with "core.fastindex" until someone can 
(please) propose a better name.
