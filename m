Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8612320188
	for <e@80x24.org>; Mon,  8 May 2017 00:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbdEHAlq (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:41:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35304 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdEHAlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:41:45 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so7715353pfd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xy/Hqn/WKfouToNS1/3MsXLepdHq6a2Uft4XzzInbXw=;
        b=TjS5Oi9S/bq9eTrJ7q+mSdCe0vEABI1yMYzMByEfvnr5H1LSxf/RURKvYSGx1zBnbh
         UhPuDi1eJM5D13WZjv+OPzW55a3Kg4YIFWmYc47qBjzhsZyEUJVH4X0bSALdW+BKFsHY
         k5X/asxtqrdEf9xv8jnMP3sPDeAj6ULww9y0yziSG1+hXI1+F/VWYlgE5lS0FAGi2aWe
         3r2JhaVxcPO0KKhwLCln79ZDSzIp0bEfWAWwLVImY+lgxVFd1ah8rQEMiVIaj8zLrZNd
         mtoz32hlExWF8m6fiY0M2r34d+d0ewOcKy+nwHn9It7bv1sQnAgLbGXfCzQXnCco9JGJ
         yTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xy/Hqn/WKfouToNS1/3MsXLepdHq6a2Uft4XzzInbXw=;
        b=oJWCgsHGw6QZ/dS3lA4uOZZzvC5zqLMuXjTzPntewll37R0YNqITIsg8lEYAZAQWiJ
         nb/QCBqvp98pF+DElbzUj++SKMg3dBh2XvryVJp31XNdYs38dyU4DxPdPoCiDH8OmAQt
         6gYce2SimsxOg6X+ttLuqjiAuXTs3ajoxav5vJ6iB8sV8wc6ptdA7vljml87TZETm7p4
         qCWAkGeXEZLqyV+/L4yzZ8TS3U5vSMZulipLSWqaM1W5N3+ok6p5S1BIqHzQBN0ZUun/
         qMpE0FpwcHmCsrsrQALVl2+MiCe+tiOrDJ3NY+wgHVB+v95d32YrrKF394twr121qj7u
         aoJw==
X-Gm-Message-State: AN3rC/6oCKRL8ArJ/pGBG6Onfnq5t/Q53yMrTP7/qzkW+9U74/paEC1b
        qvE7SVWqWj0+3w==
X-Received: by 10.99.55.65 with SMTP id g1mr15836459pgn.208.1494204104440;
        Sun, 07 May 2017 17:41:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id s62sm21002620pfk.26.2017.05.07.17.41.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:41:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/25] checkout: fix memory leak
References: <cover.1493740497.git.johannes.schindelin@gmx.de>
        <cover.1493906084.git.johannes.schindelin@gmx.de>
        <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>
        <36a581f6-077e-ca89-49d0-ad487ff222a3@web.de>
Date:   Mon, 08 May 2017 09:41:42 +0900
In-Reply-To: <36a581f6-077e-ca89-49d0-ad487ff222a3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 6 May 2017 19:14:01 +0200")
Message-ID: <xmqqk25sch89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>>   	/*
>>   	 * NEEDSWORK:
>>   	 * There is absolutely no reason to write this as a blob object
>> -	 * and create a phony cache entry just to leak.  This hack is
>> -	 * primarily to get to the write_entry() machinery that massages
>> -	 * the contents to work-tree format and writes out which only
>> -	 * allows it for a cache entry.  The code in write_entry() needs
>> -	 * to be refactored to allow us to feed a <buffer, size, mode>
>> -	 * instead of a cache entry.  Such a refactoring would help
>> -	 * merge_recursive as well (it also writes the merge result to the
>> -	 * object database even when it may contain conflicts).
>> +	 * and create a phony cache entry.  This hack is primarily to get
>> +	 * to the write_entry() machinery that massages the contents to
>> +	 * work-tree format and writes out which only allows it for a
>> +	 * cache entry.  The code in write_entry() needs to be refactored
>> +	 * to allow us to feed a <buffer, size, mode> instead of a cache
>> +	 * entry.  Such a refactoring would help merge_recursive as well
>> +	 * (it also writes the merge result to the object database even
>> +	 * when it may contain conflicts).
>>   	 */
>>   	if (write_sha1_file(result_buf.ptr, result_buf.size,
>>   			    blob_type, oid.hash))
>
> Random observation: Using pretend_sha1_file here would at least avoid
> writing the blob.

Yup, you should have told that to me back in Aug 2008 ;-) when I did
0cf8581e ("checkout -m: recreate merge when checking out of unmerged
index", 2008-08-30); pretend_sha1_file() was available since early
2007, and there is no excuse that this codepath did not use it.
>
>> @@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct checkout *state)
>>   	if (!ce)
>>   		die(_("make_cache_entry failed for path '%s'"), path);
>>   	status = checkout_entry(ce, state, NULL);
>> +	free(ce);
>>   	return status;
>>   }
>
> I wonder if that's safe.  Why document a leak when it could have been
> plugged this easily instead?
>
> A leak is better than a use after free, so
> let's be extra careful here.  Would it leave the index inconsistent?  Or
> perhaps freeing it has become safe in the meantime?
>
> @Junio: Do you remember the reason for the leaks in 0cf8581e330
> (checkout -m: recreate merge when checking out of unmerged index).

Yes.

In the very old days it was not allowed to free(3) contents of
active_cache[] and this was an old brain fart that came out of
inertia.  We are manufacturing a brand new ce, only to feed it to
checkout_entry() without even registering it to the active_cache[]
array, and the ancient rule doesn't even apply to such a case.

So I think it was safe to free(3) even back then.

> And result_buf is still leaked here, right?

Good spotting.  It typically would make a larger leak than a single
ce, I would suppose ;-)
