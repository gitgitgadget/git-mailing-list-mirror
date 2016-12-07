Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270961FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933124AbcLGWGL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:06:11 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34301 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbcLGWGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:06:10 -0500
Received: by mail-qt0-f170.google.com with SMTP id n6so394991711qtd.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6jkgM4LJtpHQHXRamkEWYlPkV7roCEXMPczUhEsC4JA=;
        b=Ox0doltWc9zTzOFZ0SdO6H8tz1ce7w8c6TjpI8ow6ARdDrSgXpW4QpmOrypjfJxPfA
         fFjYuBicjgQFbDZJdc6jSSx/wpm8BUeF9FRbaMDGHYU870eb/wQR4UfR1OUt1xYfY3L5
         /Cxmt88EWvQFyPU7CcFbEMq14I4CpuiQgQfbwi9CFTFb79AMRmWFeYxXg8mCIzSGBMQW
         uqMn3of8hVGbFK1jeIXIh6CZDl1mgaMD2Rur98c/2LulUA2TMxgUla+F3RYdkgjw/2FD
         yKvK7aLryCMWEOf+wJXOMcFLZ/EbE1LnqhTG4v8dGLx2iFZWDWaLgypzI5y74Nxc54QS
         3efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6jkgM4LJtpHQHXRamkEWYlPkV7roCEXMPczUhEsC4JA=;
        b=SArEFmxPeiK1eUjrYbSCB8MccIa5w0hkuMj+wxuKcBRaLkx3wDtLOBD3HLZDxY7m/D
         UQAsaGB92EwPRzZzyBdcG2mAOHKZshEkkEjMsXbCDC/cg0imjr6ggM7QQYf9AWGmh5CR
         yWp0wwYUDkX2Q5drgA61yuDog9tMSWLEg0YSufzGE4HBLL2gwFL5vG3lICVrwfXFU5eE
         CiWdhq+0dcMuW3VJx8s02wB3HjCcODzpc7UtAIcutqtCpd8UNn3jlncHCmhgqyjgy2kL
         1lafnzCqacFbxCAnhgb7r7yM05k/yCaeeH4Y4ddkygGPl+7GQkpcpZ2etFsj8KyPiBXb
         oM6w==
X-Gm-Message-State: AKaTC03+liNeeeBHTVb2QPXIkMfHwyZTeZWJb/QMZdLftRLUOPLWmkOwfqjkt9/2cWNClMhxKAQekJC6o1zElGWi
X-Received: by 10.200.37.221 with SMTP id f29mr68592990qtf.123.1481148369098;
 Wed, 07 Dec 2016 14:06:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 14:06:08 -0800 (PST)
In-Reply-To: <xmqqmvg7wips.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-2-gitster@pobox.com> <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
 <xmqqmvg7wips.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 14:06:08 -0800
Message-ID: <CAGZ79ka_Sh7jppCVkAhFWkXNffEg_SxUGN9VULseJBpQkDSyww@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 1:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So my first question I had to answer was if we do the right thing here,
>> i.e. if we could just fail instead. But we want to continue and just
>> not write back the index, which is fine.
>>
>> So we do not have to guard refresh_cache, but just call
>> update_index_if_able conditionally.
>
> An explanation with stepping back a little bit may help.
>
> You may be asked to visit a repository of a friend, to which you do
> not have write access to but you can still read.  You may want to do
> "diff", "status" or "describe" there.
>
> In order to avoid getting fooled into thinking some paths are dirty
> only because the cached stat information does not match, these need
> to refresh the in-core index before doing their "comparison" to
> report which paths are different (in "diff"), what are the modified
> but not staged paths (in "status"), and if there is a need to add
> the "-dirty" suffix (in "describe").
>
> Since we are doing the expensive "bunch of lstat()" anyway, if we
> could write it back to the index, it would help future operations in
> the same repository--that is the reasoning behind the opportunistic
> updates.  It is perfectly OK if we do not have write access to the
> repository and cannot write update the index.
>

Thanks for that explanation!
So I agree that we should not call it _if_needed, but the _if_able
part is still confusing, as we check for different parts here.

The case of not being able to write (read only) sounds similar to
the case of not being able to write (a concurrent lock),
I'll think about it more.

Thanks,
Stefan
