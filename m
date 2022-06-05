Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B2C43334
	for <git@archiver.kernel.org>; Sun,  5 Jun 2022 10:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245533AbiFEKUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jun 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245251AbiFEKUm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jun 2022 06:20:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A014BB82
        for <git@vger.kernel.org>; Sun,  5 Jun 2022 03:20:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x17so16035012wrg.6
        for <git@vger.kernel.org>; Sun, 05 Jun 2022 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WC4MBkvakbV4FbXOL8tlaeiAQZyh+m5agPZgxrfTNUk=;
        b=UkFQkiWWV1lerTs9oM2uk0WLHB2ka/2KBuT+QkOWtZ1xzFl2N6usDjdg8zKPjJdRiW
         wPaVicZaW9MLS4MXSQ/dvviLgFaG2wl7ZAHcARgGO5PwOs8C8jBYFEsWDarG1B0sfTpY
         G9YAVcZBSO/+y+p1fxy9SjSuTqzcjCuxe9S0PPn2UAYq+BpqjsFQSjDNXRHBhGs/ATYP
         NDnLunq2tk0NVOOyis00dkDs05Zs0qJPSfDX8tBLpXvJkwMLgqmg/ft/16kwpbYeKwMs
         PLIxFurMx7QbW2iN1m7+tovidR/2WHO9R8n0/ynjGEO39INzR17YoFP+V+7XtFyLLN79
         tYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WC4MBkvakbV4FbXOL8tlaeiAQZyh+m5agPZgxrfTNUk=;
        b=p6nuzWAM1JTAS0iLrKpZWVeVeVY9XfhK6f/SRbIgBJ2L5JHKS2gVpiXec8Txkhf+3C
         jMNVrnIfJKz71vpWy/bF3CK2W+oOq8fk2IDoF4C/GVmbddreFCV/ZNUxs4u/WYyVakj6
         5yg4DA9G+pX/qkZdyS8aoTuDe3BaUnPXoXA4nhGPJ4etBS+6kalPPAxcNM39ujuNvsDA
         ZwPhW9sXy54XU1w3rh0AegNlYMskFfad1iOIiAJciIXTkaFNJwZVji+YZnrwlJCkHJaV
         6AGi6yNjDQ9xzGKEiy8x93EFMDRgWZ4oPj2r2BplB+R2t2gXdDL3zVjFt73Le0KMT2Wz
         eEwA==
X-Gm-Message-State: AOAM530cX6Z5cB5QHQfEEPoqbdu9vyzCZUksR+y3EFA8mwkf9UJgPVTd
        vMFdpVdTCkaxVYGTc+u8EyM=
X-Google-Smtp-Source: ABdhPJzJy9v1HdYX8apMn6arLtBj+j20g12ZW0mDFkE25tDTld04zS5TrY/DadNonQ2Pj3VIBj4TBg==
X-Received: by 2002:adf:f706:0:b0:20e:6788:c2b6 with SMTP id r6-20020adff706000000b0020e6788c2b6mr16701332wrp.633.1654424439587;
        Sun, 05 Jun 2022 03:20:39 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id t12-20020a5d49cc000000b00210352bf36fsm12171953wrs.33.2022.06.05.03.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 03:20:38 -0700 (PDT)
Message-ID: <bcbdd8db-763e-b910-3fe7-a5f11d3ff39b@gmail.com>
Date:   Sun, 5 Jun 2022 11:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 07/15] strbuf.c: placate -fanalyzer in strbuf_grow()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com>
 <870925774.539833.1654346793623@apps.talktalk.co.uk>
 <220604.86czfowg81.gmgdl@evledraar.gmail.com>
 <8a5cdd7a-13bf-b091-e947-657aeb094c38@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8a5cdd7a-13bf-b091-e947-657aeb094c38@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2022 21:37, René Scharfe wrote:
> Am 04.06.22 um 18:21 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Sat, Jun 04 2022, Phillip Wood wrote:
>>
>>> Hi Ævar
>>>
>>> [This is an old address that I only have webmail access to, please use
>>> phillip.wood@dunelm.org.uk when cc'ing me]
>>
>> Hrm, I just grabbed it from an old commit of yours I found. Consider
>> sending in a patch to update .mailmap :)
>>
>>>> On 03 June 2022 at 19:37 Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>>>
>>>>
>>>> Change the strbuf_grow() function so that GCC v12's -fanalyze doesn't
>>>> yell at us about sb->buf[0] dereferencing NULL, this also makes this
>>>> code easier to follow.
>>>>
>>>> This BUG() should be unreachable since the state of our "sb->buf" and
>>>> "sb->alloc" goes hand-in-hand, but -fanalyzer isn't smart enough to
>>>> know that, and adding the BUG() also makes it clearer to human readers
>>>> that that's what happens here.
>>>>
>>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>>> ---
>>>>   strbuf.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/strbuf.c b/strbuf.c
>>>> index dd9eb85527a..61c4630aeeb 100644
>>>> --- a/strbuf.c
>>>> +++ b/strbuf.c
>>>> @@ -97,6 +97,8 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
>>>>   	if (new_buf)
>>>>   		sb->buf = NULL;
>>>>   	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
>>>> +	if (new_buf && !sb->buf)
>>>> +		BUG("for a new buffer ALLOC_GROW() should always do work!");
>>>
>>> This is a bit ugly, have you tried adding
>>> __attribute__((malloc (free), returns_nonnull))
>>> to xmalloc() and xrealloc() ?
>>>
>>
>> Will try to experiment with that, perhaps GCC can be massaged to grok
>> this somehow.
>>
>> I do vaguely remember (but couldn't track down where it was) that we
>> have some config for coverity for this function, due to it also having
>> trouble with it.
> 
> Good idea, but this attribute doesn't seem to help here.

Indeed, I was tricked by the misleading BUG message, the analyzer is not 
complaining that xrealloc() may return NULL, it is taking a path where 
it does not reallocate the buffer. I've copied the full output at the 
end of the message if anyone wants to see the whole thing but the 
relevant part is

            |cache.h:727:20:
            |  727 |                 if ((nr) > alloc) { \
            |      |                    ^
            |      |                    |
            |      |                    (10) following ‘false’ branch...
strbuf.c:99:9: note: in expansion of macro ‘ALLOC_GROW’
            |   99 |         ALLOC_GROW(sb->buf, sb->len + extra + 1, 
sb->alloc);
            |      |         ^~~~~~~~~~

> The following helps, but I don't know why it would be needed -- if alloc
> is 0 then any strbuf_grow() call will give a nr of at least 1 (for the
> NUL character):

Yes it seems to be ignoring the result of our overflow checks and 
assuming that sb->len + extra + 1 can overflow to zero. Having seen the 
number of false positives I'm inclined to think we should take the bug 
fixes and punt the rest of these patches. Maybe after a couple more gcc 
releases the false positive rate will be more manageable. (I tired 
running gcc 11 with -fanalyzer a few months ago and gave up looking at 
the output before I found a single real bug so it has certainly improved 
in gcc 12)

Best Wishes

Phillip

strbuf.c: In function ‘strbuf_grow’:
strbuf.c:101:28: warning: dereference of NULL ‘0’ [CWE-476] 
[-Wanalyzer-null-dereference]
   101 |                 sb->buf[0] = '\0';
       |                 ~~~~~~~~~~~^~~~~~
   ‘strbuf_normalize_path’: events 1-2
     |
     | 1156 | int strbuf_normalize_path(struct strbuf *src)
     |      |     ^~~~~~~~~~~~~~~~~~~~~
     |      |     |
     |      |     (1) entry to ‘strbuf_normalize_path’
     |......
     | 1160 |         strbuf_grow(&dst, src->len);
     |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
     |      |         |
     |      |         (2) calling ‘strbuf_grow’ from ‘strbuf_normalize_path’
     |
     +--> ‘strbuf_grow’: events 3-4
            |
            |   91 | void strbuf_grow(struct strbuf *sb, size_t extra)
            |      |      ^~~~~~~~~~~
            |      |      |
            |      |      (3) entry to ‘strbuf_grow’
            |......
            |   94 |         if (unsigned_add_overflows(extra, 1) ||
            |      |            ~
            |      |            |
            |      |            (4) following ‘false’ branch (when 
‘extra != 18446744073709551615’)...
            |
          ‘strbuf_grow’: event 5
            |
            |   95 |             unsigned_add_overflows(sb->len, extra + 1))
git-compat-util.h:128:7: note: in definition of macro 
‘unsigned_add_overflows’
            |  128 |     ((b) > maximum_unsigned_value_of_type(a) - (a))
            |      |       ^
            |
          ‘strbuf_grow’: events 6-9
            |
            |strbuf.c:94:46:
            |   94 |         if (unsigned_add_overflows(extra, 1) ||
            |......
            |   97 |         if (new_buf)
            |      |         ~~ ~
            |      |         |  |
            |      |         |  (8) following ‘true’ branch...
            |      |         (7) ...to here
            |   98 |                 sb->buf = NULL;
            |      |                 ~~
            |      |                 |
            |      |                 (9) ...to here
            |
          ‘strbuf_grow’: event 10
            |
            |cache.h:727:20:
            |  727 |                 if ((nr) > alloc) { \
            |      |                    ^
            |      |                    |
            |      |                    (10) following ‘false’ branch...
strbuf.c:99:9: note: in expansion of macro ‘ALLOC_GROW’
            |   99 |         ALLOC_GROW(sb->buf, sb->len + extra + 1, 
sb->alloc);
            |      |         ^~~~~~~~~~
            |
          ‘strbuf_grow’: event 11
            |
            |cache.h:726:12:
            |  726 |         do { \
            |      |            ^
            |      |            |
            |      |            (11) ...to here
strbuf.c:99:9: note: in expansion of macro ‘ALLOC_GROW’
            |   99 |         ALLOC_GROW(sb->buf, sb->len + extra + 1, 
sb->alloc);
            |      |         ^~~~~~~~~~
            |
          ‘strbuf_grow’: events 12-15
            |
            |  100 |         if (new_buf)
            |      |            ^
            |      |            |
            |      |            (12) following ‘true’ branch...
            |  101 |                 sb->buf[0] = '\0';
            |      |                 ~~~~~~~~~~~~~~~~~
            |      |                 | |        |
            |      |                 | |        (15) dereference of NULL 
‘*sb.buf’
            |      |                 | (14) ‘dst.buf’ is NULL
            |      |                 (13) ...to here

