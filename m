Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBFC1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 16:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbdKMQmM (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 11:42:12 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46327 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbdKMQmK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 11:42:10 -0500
Received: by mail-qk0-f193.google.com with SMTP id o6so20483546qkh.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gj7Cryy2Pd7iLWU4VT/r5qSmkic0sIHWNH1ItuGT0qs=;
        b=Z6F4HwaptICg6y8KKdjYhDaTqH9l7G3J3sm1xykv145gWZ4jJqMRQ8MxCl8YXcR+ZM
         mhrUBkZhoip7SPDt1C9EwGJ6MzAK6aHXV1RE4A2ZkYMG4nzXT+3gpz9oLT65bbVY96WS
         VuMzPHFBIOhbaw+nAseen93A+4vrkOTx2yIuNSyiJZLQXTTcYJoNnZzZ+yzcOjZETFSd
         7XNDkoXduV9NOksv/u/yMIk1OC6JnZwl1esLlZuHjFuhbHB6V9F9YtYl61zvHX+qLuHi
         ybIqjVKqC3xrJfc4Cf1T6qcUGig7dAcQJiQkPmw/7Kgk/DL++AET0wOkqR17gNlrVFgB
         CziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gj7Cryy2Pd7iLWU4VT/r5qSmkic0sIHWNH1ItuGT0qs=;
        b=sxbTKk88aw/PvQRlaB3wnyRE97M/1OQzL91s2kU7kgF5fPANw0WS/RjgmBOBbolZ38
         gYNSX/lk7YLED26j7PK60DpqtXN2KqLqhP4rj1jisHMILr5qmDbu9pGJmZ2rN0SrBkmD
         X5j2whbI8mEz1LJlP4BZyqUVUZNZoY1RmKXuAV+PklHn/oJXnFDxNA6AHS+bKe3HYTjx
         DaA8gXNf2CRolHCoiS2w2h0vRUDrIA/bcapUx0HL9fKqSriZYaAhne5+4NHHfBGi9EoU
         a13w+tBLnDTHo96IDe5/iYf5Rj2ogwza+VFCV2Cy+e75cIqixk+JsHcAe1BOo+8DjrWq
         yWKQ==
X-Gm-Message-State: AJaThX7ikkLJjn41kIdGweHsE9qlCBxhtRGKmhxAcXAILh7XzVn5XVQ4
        WXtCGza3dLSVomfBjF6RdTk=
X-Google-Smtp-Source: AGs4zMbFUcz7u3UBDtHeJMFbaQRfC0lWeU86ACvFG+s+EZj5bcZlReKrgagd8+mC/+/Zws0CVmUQNA==
X-Received: by 10.55.19.93 with SMTP id d90mr14046098qkh.271.1510591328767;
        Mon, 13 Nov 2017 08:42:08 -0800 (PST)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y62sm10837653qkb.92.2017.11.13.08.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 08:42:07 -0800 (PST)
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
References: <20171109141737.47976-1-benpeart@microsoft.com>
 <20171109141737.47976-2-benpeart@microsoft.com>
 <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
Date:   Mon, 13 Nov 2017 11:42:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/9/2017 11:46 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> To make this work for V4 indexes, when writing the index, it periodically
>> "resets" the prefix-compression by encoding the current entry as if the
>> path name for the previous entry is completely different and saves the
>> offset of that entry in the IEOT.  Basically, with V4 indexes, it
>> generates offsets into blocks of prefix-compressed entries.
> 
> You specifically mentioned about this change in your earlier
> correspondence on this series, and it reminds me of Shawn's reftable
> proposal that also is heavily depended on prefix compression with
> occasional reset to allow scanning from an entry in the middle.  I
> find it a totally sensible design choice.
> 

Great! I didn't realize there was already precedent for this in other 
patches.  I guess good minds think alike... :)

>> To enable reading the IEOT extension before reading all the variable
>> length cache entries and other extensions, the IEOT is written last,
>> right before the trailing SHA1.
> 
> OK, we have already closed the door for further enhancements to
> place something other than the index extensions after this block by
> mistakenly made it the rule that the end of the series of extended
> sections must coincide with the beginning of the trailing checksum,
> so it does not sound all that bad to insist on this particular one
> to be the last, I guess.  But see below...
> 
>> The format of that extension has the signature bytes and size at the
>> beginning (like a normal extension) as well as at the end in reverse
>> order to enable parsing the extension by seeking back from the end of
>> the file.
> 
> I think this is a reasonable workaround to allow a single extension
> that needs to be read before the main index is loaded.
> 
> But I'd suggest taking this approach one step further.  Instead,
> what if we introduce a new extension EOIE ("end of index entries")
> whose sole purpose is to sit at the end of the series of extensions
> and point at the beginning of the index extension section of the
> file, to tell you where to seek in order to skip the main index?
> 
> That way, you can
> 
>   - seek to the end of the index file;
> 
>   - go backward skiping the trailing file checksum;
> 
>   - now you might be at the end of the EOIE extension.  seek back
>     necessary number of bytes and verify EOIE header, pick up the
>     recorded file offset of the beginning of the extensions section.
> 
>   - The 4-byte sequence you found may happen to match EOIE but that
>     is not enough to be sure that you indeed have such an extension.
>     So the following must be done carefully, allowing the possibility
>     that there wasn't any EOIE extension at the end.
>     Seek back to that offset, and repeat these three steps to skip
>     over all extensions:
> 
>     - read the (possible) 4-byte header
>     - read the (possible) extsize (validate that this is a sane value)
>     - skip that many bytes
> 
>     until you come back to the location you assumed that you found
>     your EOIE header, to make sure you did not get fooled by bytes
>     that happened to look like one.  Some "extsize" you picked up
>     during that process may lead you beyond the end of the index
>     file, which would be a sure sign that what you found at the end
>     of the index file was *not* the EOIE extension but a part of
>     some other extension who happened to have these four bytes at the
>     right place.
> 

I'm doing this careful examination and verification in the patch 
already.  Please look closely at read_ieot_extension() to make sure 
there isn't a test I should be doing but missed.

> which would be a lot more robust way to allow any extensions to be
> read before the main body of the index.
> 
> And a lot more importantly, we will leave the door open to allow
> more than one index extensions that we would prefer to read before
> reading the main body if we do it this way, because we can easily
> skip things over without spending cycles once we have a robust way
> to find where the end of the main index is.  After all, the reason
> you placed IEOT at the end is not because you wanted to have it at
> the very end.  You only wanted to be able to find where it is
> without having to parse the variable-length records of the main
> index.  And there may be other index extensions that wants to be
> readable without reading the main part just like IEOT, and we do not
> want to close the door for them.
> 

The proposed format for extensions (ie having both a header and a footer 
with name and size) in the current patch already enables having multiple 
extensions that can be parsed forward or backward.  Any extensions that 
would want to be parse-able in reverse would just all need to be written 
one after the other after right before the trailing SHA1 (and of course, 
include the proper footer).  The same logic that parses the IEOT 
extension could be extended to continue looking backwards through the 
file parsing extensions until it encounters an unknown signature, 
invalid size, etc.

That said, the IEOT is essentially a table of contents into the index (I 
hesitate to call it an index of the index as that could get confusing 
:)).  While in the current iteration of this patch it only contains 
offsets into blocks of cache entries that are independently parse-able, 
I had initially considered including an offset into the index where the 
extensions start just as you suggest above.

When I looked at the existing extensions to see if they could be sped up 
by loading them on parallel threads I found that some of them 
assume/require they are processed in a specific order so there was no 
real benefit to loading them in parallel threads.

I ended up removing the offset to the first extension because I've found 
that trying to speculatively design a feature for a potential future 
need often doesn't result in what you actually need once you get there. 
:)  Instead, I made sure there was a version number in the IEOT 
structure so if we actually needed a way to extend the table of contents 
at some point in the future (like to include an offset to the 
extensions), we could easily add it and increment the IEOT version.

I could add the offset back in but currently nothing would use it so 
we're just adding additional complexity to calculate and parse it with 
with no (current) benefit.

How about I rename this the "Index Table of Contents" (ITOC) to make 
it's potential more clear and if/when we need to enhance it with an 
offset to the extensions, we do so at that point in time?

> Hmm?
> 
