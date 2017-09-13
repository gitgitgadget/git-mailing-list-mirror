Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A6E20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdIMR7e (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:59:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34122 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdIMR7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:59:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so382563pfe.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObBlnjE8q7ixzSXgC4zmQ3MZ6jOKFn4mKoQ24s3X9ZE=;
        b=JNZI8Jg/reVPEJp+79VExJxrENCGB1hCLBYGpqTogTO86/n2NiZ3FbbrA5XZFe0gLe
         tDxKQknXT5ak94Q5Cmo9CkHoyqtQnlLZEmNM2pmyrkdsunox6eeHeIJAak37nrairV+t
         rfqZPkeyoVRPAVuEWOg/PNjXuP8K7l10pXGfi3EugyhLF1JyNn6vrMNLsogT0zoaY04K
         2ZMtngo7tlaR/eDusWHLynoOHFUhBsCdSbMlK6qYyjBXx5bc0HA9SxbUqt5rOPAf07Ig
         RPTrjwgdDVTPlWIZAbva4+MwTmhjR7loRNRgh158LqdXBUWv2gZDK1Cgyv41xRfiJ41k
         PXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObBlnjE8q7ixzSXgC4zmQ3MZ6jOKFn4mKoQ24s3X9ZE=;
        b=ppStDFgjfg4VxbA5UZ3l9zXyVtGLCFESFH0WLQbo5uXODNwM2rdVxRhNXdMJqF6nwB
         i7Dj1aE9EpqY8r/PHwgSl8E7taj8ZohDzSgrF6gyogrPGgi/iFb5uwD8KMjEojNgkZxS
         rXOcrCs9e+mOBV1AEHSE+KG8dodVYcZMsO9FaY4ILSF9/3gPdGRCCZdZuiZ+rlrAjWGa
         JmiSkpZM99NIZIyYuOnJ5Hetdi++5u+q4bQmUzOWPBTKhnj0rk3BDQw816EahyCHSwa2
         Tzf+S6lots1DhpGGgrTxO9HbXZ93y94cVN3FplMUTicqrhYA/KZ3QXBGfkNv0ov/ZrZD
         jHtw==
X-Gm-Message-State: AHPjjUj0TQK5eBK+PfCiixNiJCaMoD8Uu4+T5lpEKvow/mISObRfqmcy
        pzhV0YXCzGXV0g==
X-Google-Smtp-Source: ADKCNb6xO4oar3nTohBatnuv+7b/O6nAZPdlrE9nNL4ogGYNJ38ppC+8xz4Vt5VQAko8+HSJDqvocg==
X-Received: by 10.99.180.7 with SMTP id s7mr18155634pgf.171.1505325573038;
        Wed, 13 Sep 2017 10:59:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id e27sm16738763pfk.41.2017.09.13.10.59.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 10:59:32 -0700 (PDT)
Date:   Wed, 13 Sep 2017 10:59:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/7] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913175930.GD27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913174728.GB27425@aiede.mtv.corp.google.com>
 <20170913175338.tsq4hmgmmybp43dw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913175338.tsq4hmgmmybp43dw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Sep 13, 2017 at 10:47:28AM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> I scoured the code base for cases of this, but it turns out
>>> that these two in git_config_set_multivar_in_file_gently()
>>> are the only ones. This case is actually quite interesting:
>>> we don't have a size_t, but rather use the subtraction of
>>> two pointers. Which you might think would be a signed
>>> ptrdiff_t, but clearly both gcc and clang treat it as
>>> unsigned (possibly because the conditional just above
>>> guarantees that the result is greater than zero).
>>
>> Do you have more detail about this?  I get worried when I read
>> something like this that sounds like a compiler bug.
>>
>> C99 sayeth:
>>
>> 	When two pointers are subtracted, both shall point to elements
>> 	of the same array object, or one past the last element of the
>> 	array object; the result is the difference of the subscripts
>> 	of the two array elements. The size of the result is
>> 	implementation-defined, and its type (a signed integer type)
>> 	is ptrdiff_t defined in the <stddef.h> header.
>
> I'm not sure if it's a compiler bug or not. I read the bits about
> ptrdiff_t, and it wasn't entirely clear to me if a pointer difference
> _is_ an actual ptrdiff_t, or if it can generally be stored in one. Right
> below that text it also says:
>
>   If the result is not representable in an object of that type, the
>   behavior is undefined.

I can confidentally say the intent in C99 in that passage is to
describe the type of the expression, not just the type of a variable
that can hold it.

> That said, I might be wrong that unsigned promotion is the culprit. I
> didn't look at the generated assembly. But I also can't see what else
> would be causing the problem here. We're clearly returning "-1" and the
> condition doesn't trigger.
>
>> How can I reproduce the problem?
>
> I gave a recipe in the commit message, which is the best I came up with.
> You could probably use a fault-injection library to convince write() to
> fail. Or just tweak the source code to have write_in_full() return -1.

I wonder if a new test helper in t/helper/ would be able to do it (since
then it could e.g. control the filename that write_in_full writes to).

>>> There's no addition to the test suite here, since you need
>>> to convince write() to fail in order to see the problem. The
>>> simplest reproduction recipe I came up with is to trigger
>>> ENOSPC (this only works on Linux, obviously):
>>
>> Does /dev/full make it simpler to reproduce?
>
> I don't think so, because the write() failure is to the lockfile, which
> is created with O_EXCL. So even if you could convince "config.lock" to
> be the right device type, the open() would fail.

Hm, you're convincing me that it would indeed be worth hooking into a
fault injection framework (that e.g. uses LD_PRELOAD), but that's a
topic for another day.

Thanks,
Jonathan
