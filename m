Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A6C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC57C61462
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhD3Pdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3Pdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 11:33:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C824C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 08:33:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id p12so49645800pgj.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1XoC6cnmSFX1ij1sKAR/UccTSYgHu6Tl8LT0iqgHDA=;
        b=dK8FxBPAYNFCwqChht1pwhEd9AM5Mrhii4q3iHgKHVQdEnnCy2g5FQbrY7BweJiF4g
         OpBjApYVv+gi89r++naHAODS/3JVjRFsyi2Xvc8gzL9HQXz8l6WkA2jxkkybQMd4LnlF
         CZiog0jRUBDcU3boZeez40in0DhixQzYf5EoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1XoC6cnmSFX1ij1sKAR/UccTSYgHu6Tl8LT0iqgHDA=;
        b=YPJc42gb+9hE9V0hm/fR/zHZ0dHM6c2C2NiSPcTwrQMcqI0tV9A5kdk2n2nJuKrpeo
         YIzn/5Sn6jt5E5ZCtFBYU7TKqwpnyER88C3JZRt62UZK5DZjVTSPEQ72t2zDexfREOnW
         /CA4e3ZCewcJ6j1ZeCvjxaYfZMhrJmnF4PsxY+EP4bTZZ/0x1I66sfX5T4kB2uOkDKFT
         pQcxLFoUEuphXfq/mUSFfvVmreIg7ipOgGPJF8kXsVa6xYmY2juCNL3VsoCrI3xOJ7JJ
         KWpRii7EW0bSuGhe+EN/f3INZn44sYp8ygjOf0Okw882uIGR+hwbZMeZb2nIwhFc/joH
         BVmA==
X-Gm-Message-State: AOAM533OebGDu8jSKsfIlM5txkq9uNt7MnhK4ZORjxM/Gy9+MzCyMNMh
        u8hetrO5GmCjHRpQuu4jcxjCf7chxRIRkA==
X-Google-Smtp-Source: ABdhPJxsUDylY9q76DjFdSa4k3pFjxYYRFq6VNLv3cC2ndQ2gYNEd+rtfP7EboXW/NmvrT56bacQmA==
X-Received: by 2002:a63:ff15:: with SMTP id k21mr5383595pgi.28.1619796786644;
        Fri, 30 Apr 2021 08:33:06 -0700 (PDT)
Received: from [192.168.245.142] (cpc108961-cmbg20-2-0-cust748.5-4.cable.virginm.net. [80.5.130.237])
        by smtp.gmail.com with ESMTPSA id r63sm11423679pjg.46.2021.04.30.08.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 08:33:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
To:     Andrew Oakley <andrew@adoakley.name>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
References: <20210412085251.51475-1-andrew@adoakley.name>
 <20210412085251.51475-3-andrew@adoakley.name>
 <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
 <20210430095342.58134e4e@ado-tr>
From:   Luke Diamand <luke@diamand.org>
Message-ID: <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
Date:   Fri, 30 Apr 2021 15:33:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210430095342.58134e4e@ado-tr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/04/2021 08:53, Andrew Oakley wrote:
> On Thu, 29 Apr 2021 03:00:06 -0700
> Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> wrote:
>> However, on Windows, UTF-8 strings passed to "p4 submit -d" are
>> somehow converted to the default Windows code page by the time they
>> are stored in the Perforce database, probably as part of the process
>> of passing the command line arguments to the Windows p4 executable.
>> However, the "code page" data is *not* converted to UTF-8 on the way
>> back from p4 to git-p4.py.  The only way to get it into UTF-8 is to
>> call string.decode().  As a result, this patch, which takes out the
>> call to string.decode() will not work on Windows.
> 
> Thanks for that explanation, the reencoding of the data on Windows is
> not something I was expecting.  Given the behaviour you've described, I
> suspect that there might be two different problems that we are trying
> to solve.
> 
> The perforce depot I'm working with has a mixture of encodings, and
> commits are created from a variety of different environments. The
> majority of commits are ASCII or UTF-8, there are a small number that
> are in some other encoding.  Any attempt to reencode the data is likely
> to make the problem worse in at least some cases.
> 
> I suspect that other perforce depots are used primarily from Windows
> machines, and have data that is encoded in a mostly consistent way but
> the encoding is not UTF-8.  Re-encoding the data for git makes sense in
> that case.  Is this the kind of repository you have?
> 
> If there are these two different cases then we probably need to come up
> with a patch that solves both issues.
> 
> For my cases where we've got a repository containing all sorts of junk,
> it sounds like it might be awkward to create a test case that works on
> Windows.
> 


https://www.perforce.com/perforce/doc.current/user/i18nnotes.txt

Tzadik - is your server unicode enabled or not? That would be 
interesting to know:

     p4 counters | grep -i unicode

I suspect it is not. It's only if unicode is enabled that the server 
will convert to/from utf8 (at least that's my understanding). Without 
this setting, p4d and p4 are (probably) not doing any conversions.

I think it might be useful to clarify exactly what conversions are 
actually happening.

I wonder what encoding Perforce thinks you've got in place.





